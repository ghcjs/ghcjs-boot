{-# LANGUAGE Trustworthy #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Typeable
-- Copyright   :  (c) The University of Glasgow, CWI 2001--2004
-- License     :  BSD-style (see the file libraries/base/LICENSE)
-- 
-- Maintainer  :  libraries@haskell.org
-- Stability   :  experimental
-- Portability :  portable
--
-- The 'Typeable' class reifies types to some extent by associating type
-- representations to types. These type representations can be compared,
-- and one can in turn define a type-safe cast operation. To this end,
-- an unsafe cast is guarded by a test for type (representation)
-- equivalence. The module "Data.Dynamic" uses Typeable for an
-- implementation of dynamics. The module "Data.Data" uses Typeable
-- and type-safe cast (but not dynamics) to support the \"Scrap your
-- boilerplate\" style of generic programming.
--
-- == Compatibility Notes
--
-- Since GHC 7.8, 'Typeable' is poly-kinded. The changes required for this might
-- break some old programs involving 'Typeable'. More details on this, including
-- how to fix your code, can be found on the
-- <https://ghc.haskell.org/trac/ghc/wiki/GhcKinds/PolyTypeable PolyTypeable wiki page>
--
-----------------------------------------------------------------------------

module Data.Typeable
  (
        -- * The Typeable class
        Typeable,
        typeRep,

        -- * Propositional equality
        (:~:)(Refl),

        -- * For backwards compatibility
        typeOf, typeOf1, typeOf2, typeOf3, typeOf4, typeOf5, typeOf6, typeOf7,
        Typeable1, Typeable2, Typeable3, Typeable4, Typeable5, Typeable6,
        Typeable7,

        -- * Type-safe cast
        cast,
        eqT,
        gcast,                  -- a generalisation of cast

        -- * Generalized casts for higher-order kinds
        gcast1,                 -- :: ... => c (t a) -> Maybe (c (t' a))
        gcast2,                 -- :: ... => c (t a b) -> Maybe (c (t' a b))

        -- * A canonical proxy type
        Proxy (..),
        
        -- * Type representations
        TypeRep,        -- abstract, instance of: Eq, Show, Typeable
        typeRepFingerprint,
        rnfTypeRep,
        showsTypeRep,

        TyCon,          -- abstract, instance of: Eq, Show, Typeable
        tyConFingerprint,
        tyConString,
        tyConPackage,
        tyConModule,
        tyConName,
        rnfTyCon,

        -- * Construction of type representations
        -- mkTyCon,        -- :: String  -> TyCon
        mkTyCon3,       -- :: String  -> String -> String -> TyCon
        mkTyConApp,     -- :: TyCon   -> [TypeRep] -> TypeRep
        mkAppTy,        -- :: TypeRep -> TypeRep   -> TypeRep
        mkFunTy,        -- :: TypeRep -> TypeRep   -> TypeRep

        -- * Observation of type representations
        splitTyConApp,  -- :: TypeRep -> (TyCon, [TypeRep])
        funResultTy,    -- :: TypeRep -> TypeRep   -> Maybe TypeRep
        typeRepTyCon,   -- :: TypeRep -> TyCon
        typeRepArgs,    -- :: TypeRep -> [TypeRep]
  ) where

import Data.Typeable.Internal hiding (mkTyCon)
import Data.Type.Equality

import Unsafe.Coerce
import Data.Maybe
import GHC.Base

-------------------------------------------------------------
--
--              Type-safe cast
--
-------------------------------------------------------------

-- | The type-safe cast operation
cast :: forall a b. (Typeable a, Typeable b) => a -> Maybe b
cast x = if typeRep (Proxy :: Proxy a) == typeRep (Proxy :: Proxy b)
           then Just $ unsafeCoerce x
           else Nothing

-- | Extract a witness of equality of two types
--
-- @since 4.7.0.0
eqT :: forall a b. (Typeable a, Typeable b) => Maybe (a :~: b)
eqT = if typeRep (Proxy :: Proxy a) == typeRep (Proxy :: Proxy b)
      then Just $ unsafeCoerce Refl
      else Nothing

-- | A flexible variation parameterised in a type constructor
gcast :: forall a b c. (Typeable a, Typeable b) => c a -> Maybe (c b)
gcast x = fmap (\Refl -> x) (eqT :: Maybe (a :~: b))

-- | Cast over @k1 -> k2@
gcast1 :: forall c t t' a. (Typeable t, Typeable t')
       => c (t a) -> Maybe (c (t' a)) 
gcast1 x = fmap (\Refl -> x) (eqT :: Maybe (t :~: t'))

-- | Cast over @k1 -> k2 -> k3@
gcast2 :: forall c t t' a b. (Typeable t, Typeable t')
       => c (t a b) -> Maybe (c (t' a b)) 
gcast2 x = fmap (\Refl -> x) (eqT :: Maybe (t :~: t'))

