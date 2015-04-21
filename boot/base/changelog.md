# Changelog for [`base` package](http://hackage.haskell.org/package/base)

## 4.8.0.0  *Mar 2015*

  * Bundled with GHC 7.10.1

  * Make `Applicative` a superclass of `Monad`

  * Add reverse application operator `Data.Function.(&)`

  * Add `Data.List.sortOn` sorting function

  * Add `System.Exit.die`

  * Deprecate `versionTags` field of `Data.Version.Version`.
    Add `makeVersion :: [Int] -> Version` constructor function to aid
    migration to a future `versionTags`-less `Version`.

  * Add `IsList Version` instance

  * Weaken RealFloat constraints on some `Data.Complex` functions

  * Add `Control.Monad.(<$!>)` as a strict version of `(<$>)`

  * The `Data.Monoid` module now has the `PolyKinds` extension
    enabled, so that the `Monoid` instance for `Proxy` are polykinded
    like `Proxy` itself is.

  * Make `abs` and `signum` handle (-0.0) correctly per IEEE-754.

  * Re-export `Data.Word.Word` from `Prelude`

  * Add `countLeadingZeros` and `countTrailingZeros` methods to
    `Data.Bits.FiniteBits` class

  * Add `Data.List.uncons` list destructor (#9550)

  * Export `Monoid(..)` from `Prelude`

  * Export `Foldable(..)` from `Prelude`
    (hiding `fold`, `foldl'`, `foldr'`, and `toList`)

  * Export `Traversable(..)` from `Prelude`

  * Set fixity for `Data.Foldable.{elem,notElem}` to match the
    conventional one set for `Data.List.{elem,notElem}` (#9610)

  * Turn `toList`, `elem`, `sum`, `product`, `maximum`, and `minimum`
    into `Foldable` methods (#9621)

  * Replace the `Data.List`-exported functions

    ```
    all, and, any, concat, concatMap, elem, find, product, sum,
    mapAccumL, mapAccumR
    ```

    by re-exports of their generalised `Data.Foldable`/`Data.Traversable`
    counterparts.  In other words, unqualified imports of `Data.List`
    and `Data.Foldable`/`Data.Traversable` no longer lead to conflicting
    definitions. (#9586)

  * New (unofficial) module `GHC.OldList` containing only list-specialised
    versions of the functions from `Data.List` (in other words, `GHC.OldList`
    corresponds to `base-4.7.0.2`'s `Data.List`)

  * Replace the `Control.Monad`-exported functions

    ```
    sequence_, msum, mapM_, forM_,
    forM, mapM, sequence
    ```

    by re-exports of their generalised `Data.Foldable`/`Data.Traversable`
    counterparts.  In other words, unqualified imports of `Control.Monad`
    and `Data.Foldable`/`Data.Traversable` no longer lead to conflicting
    definitions. (#9586)

  * Generalise `Control.Monad.{when,unless,guard}` from `Monad` to
    `Applicative` and from `MonadPlus` to `Alternative` respectively.

  * Generalise `Control.Monad.{foldM,foldM_}` to `Foldable`

  * `scanr`, `mapAccumL` and `filterM` now take part in list fusion (#9355,
    #9502, #9546)

  * Remove deprecated `Data.OldTypeable` (#9639)

  * New module `Data.Bifunctor` providing the `Bifunctor(bimap,first,second)`
    class (previously defined in `bifunctors` package) (#9682)

  * New module `Data.Void` providing the canonical uninhabited type `Void`
    (previously defined in `void` package) (#9814)

  * Update Unicode class definitions to Unicode version 7.0

  * Add `Alt`, an `Alternative` wrapper, to `Data.Monoid`. (#9759)

  * Add `isSubsequenceOf` to `Data.List` (#9767)

  * The arguments to `==` and `eq` in `Data.List.nub` and `Data.List.nubBy`
    are swapped, such that `Data.List.nubBy (<) [1,2]` now returns `[1]`
    instead of `[1,2]` (#2528, #3280, #7913)

  * New module `Data.Functor.Identity` (previously provided by `transformers`
    package). (#9664)

  * Add `scanl'`, a strictly accumulating version of `scanl`, to `Data.List`
    and `Data.OldList`. (#9368)

  * Add `fillBytes` to `Foreign.Marshal.Utils`.

  * Add new `displayException` method to `Exception` typeclass. (#9822)

  * Add `Data.Bits.toIntegralSized`, a size-checked version of
    `fromIntegral`. (#9816)

  * New module `Numeric.Natural` providing new `Natural` type
    representing non-negative arbitrary-precision integers.  The `GHC.Natural`
    module exposes additional GHC-specific primitives. (#9818)

  * Add `(Storable a, Integeral a) => Storable (Ratio a)` instance (#9826)

  * Add `Storable a => Storable (Complex a)` instance (#9826)

  * New module `GHC.RTS.Flags` that provides accessors to runtime flags.

  * Expose functions for per-thread allocation counters and limits in `GHC.Conc`

        disableAllocationLimit :: IO ()
        enableAllocationLimit :: IO ()
        getAllocationCounter :: IO Int64
        setAllocationCounter :: Int64 -> IO ()

    together with a new exception `AllocationLimitExceeded`.

  * Make `read . show = id` for `Data.Fixed` (#9240)

  * Add `calloc` and `callocBytes` to `Foreign.Marshal.Alloc`. (#9859)

  * Add `callocArray` and `callocArray0` to `Foreign.Marshal.Array`. (#9859)

  * Restore invariant in `Data (Ratio a)` instance (#10011)

  * Add/expose `rnfTypeRep`, `rnfTyCon`, `typeRepFingerprint`, and
    `tyConFingerprint` helpers to `Data.Typeable`.

  * Define proper `MINIMAL` pragma for `class Ix`. (#10142)

## 4.7.0.2  *Dec 2014*

  * Bundled with GHC 7.8.4

  * Fix performance bug in `Data.List.inits` (#9345)

  * Fix handling of null bytes in `Debug.Trace.trace` (#9395)

## 4.7.0.1  *Jul 2014*

  * Bundled with GHC 7.8.3

  * Unhide `Foreign.ForeignPtr` in Haddock (#8475)

  * Fix recomputation of `TypeRep` in `Typeable` type-application instance
    (#9203)

  * Fix regression in Data.Fixed Read instance (#9231)

  * Fix `fdReady` to honor `FD_SETSIZE` (#9168)

## 4.7.0.0  *Apr 2014*

  * Bundled with GHC 7.8.1

  * Add `/Since: 4.[4567].0.0/` Haddock annotations to entities
    denoting the package version, when the given entity was introduced
    (or its type signature changed in a non-compatible way)

  * The `Control.Category` module now has the `PolyKinds` extension
    enabled, meaning that instances of `Category` no longer need be of
    kind `* -> * -> *`.

  * There are now `Foldable` and `Traversable` instances for `Either a`,
   `Const r`, and `(,) a`.

  * There are now `Show`, `Read`, `Eq`, `Ord`, `Monoid`, `Generic`, and
    `Generic1` instances for `Const`.

  * There is now a `Data` instance for `Data.Version`.

  * A new `Data.Bits.FiniteBits` class has been added to represent
    types with fixed bit-count. The existing `Bits` class is extended
    with a `bitSizeMaybe` method to replace the now obsolete
    `bitsize` method.

  * `Data.Bits.Bits` gained a new `zeroBits` method which completes the
    `Bits` API with a direct way to introduce a value with all bits cleared.

  * There are now `Bits` and `FiniteBits` instances for `Bool`.

  * There are now `Eq`, `Ord`, `Show`, `Read`, `Generic`. and `Generic1`
    instances for `ZipList`.

  * There are now `Eq`, `Ord`, `Show` and `Read` instances for `Down`.

  * There are now `Eq`, `Ord`, `Show`, `Read` and `Generic` instances
    for types in GHC.Generics (`U1`, `Par1`, `Rec1`, `K1`, `M1`,
    `(:+:)`, `(:*:)`, `(:.:)`).

  * `Data.Monoid`: There are now `Generic` instances for `Dual`, `Endo`,
    `All`, `Any`, `Sum`, `Product`, `First`, and `Last`; as well as
    `Generic1` instances for `Dual`, `Sum`, `Product`, `First`, and `Last`.

  * The `Data.Monoid.{Product,Sum}` newtype wrappers now have `Num` instances.

  * There are now `Functor` instances for `System.Console.GetOpt`'s
    `ArgOrder`, `OptDescr`, and `ArgDescr`.

  * A zero-width unboxed poly-kinded `Proxy#` was added to
    `GHC.Prim`. It can be used to make it so that there is no the
    operational overhead for passing around proxy arguments to model
    type application.

  * New `Data.Proxy` module providing a concrete, poly-kinded proxy type.

  * New `Data.Coerce` module which exports the new `Coercible` class
    together with the `coerce` primitive which provide safe coercion
    (wrt role checking) between types with same representation.

  * `Control.Concurrent.MVar` has a new implementation of `readMVar`,
    which fixes a long-standing bug where `readMVar` is only atomic if
    there are no other threads running `putMVar`.  `readMVar` now is
    atomic, and is guaranteed to return the value from the first
    `putMVar`.  There is also a new `tryReadMVar` which is a
    non-blocking version.

  * New `Control.Concurrent.MVar.withMVarMasked` which executes
    `IO` action with asynchronous exceptions masked in the same style
    as the existing `modifyMVarMasked` and `modifyMVarMasked_`.

  * New `threadWait{Read,Write}STM :: Fd -> IO (STM (), IO ())`
    functions added to `Control.Concurrent` for waiting on FD
    readiness with STM actions.

  * Expose `Data.Fixed.Fixed`'s constructor.

  * There are now byte endian-swapping primitives
    `byteSwap{16,32,64}` available in `Data.Word`, which use
    optimized machine instructions when available.

  * `Data.Bool` now exports `bool :: a -> a -> Bool -> a`, analogously
    to `maybe` and `either` in their respective modules.

  * `Data.Either` now exports `isLeft, isRight :: Either a b -> Bool`.

  * `Debug.Trace` now exports `traceId`, `traceShowId`, `traceM`,
    and `traceShowM`.

  * `Data.Functor` now exports `($>)` and `void`.

  * Rewrote portions of `Text.Printf`, and made changes to `Numeric`
    (added `Numeric.showFFloatAlt` and `Numeric.showGFloatAlt`) and
    `GHC.Float` (added `formatRealFloatAlt`) to support it.  The
    rewritten version is extensible to user types, adds a "generic"
    format specifier "`%v`", extends the `printf` spec to support much
    of C's `printf(3)` functionality, and fixes the spurious warnings
    about using `Text.Printf.printf` at `(IO a)` while ignoring the
    return value.  These changes were contributed by Bart Massey.

  * The minimal complete definitions for all type-classes with cyclic
    default implementations have been explicitly annotated with the
    new `{-# MINIMAL #-}` pragma.

  * `Control.Applicative.WrappedMonad`, which can be used to convert a
    `Monad` to an `Applicative`, has now a
    `Monad m => Monad (WrappedMonad m)` instance.

  * There is now a `Generic` and a `Generic1` instance for `WrappedMonad`
    and `WrappedArrow`.

  * Handle `ExitFailure (-sig)` on Unix by killing process with signal `sig`.

  * New module `Data.Type.Bool` providing operations on type-level booleans.

  * Expose `System.Mem.performMinorGC` for triggering minor GCs.

  * New `System.Environment.{set,unset}Env` for manipulating
    environment variables.

  * Add `Typeable` instance for `(->)` and `RealWorld`.

  * Declare CPP header `<Typeable.h>` officially obsolete as GHC 7.8+
    does not support hand-written `Typeable` instances anymore.

  * Remove (unmaintained) Hugs98 and NHC98 specific code.

  * Optimize `System.Timeout.timeout` for the threaded RTS.

  * Remove deprecated functions `unsafeInterleaveST`, `unsafeIOToST`,
    and `unsafeSTToIO` from `Control.Monad.ST`.

  * Add a new superclass `SomeAsyncException` for all asynchronous exceptions
    and makes the existing `AsyncException` and `Timeout` exception children
    of `SomeAsyncException` in the hierarchy.

  * Remove deprecated functions `blocked`, `unblock`, and `block` from
    `Control.Exception`.

  * Remove deprecated function `forkIOUnmasked` from `Control.Concurrent`.

  * Remove deprecated function `unsafePerformIO` export from `Foreign`
    (still available via `System.IO.Unsafe.unsafePerformIO`).

  * Various fixes and other improvements (see Git history for full details).
