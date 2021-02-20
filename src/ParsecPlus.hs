{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE RankNTypes        #-}
{-# LANGUAGE UnicodeSyntax     #-}
{-# LANGUAGE ViewPatterns      #-}

{- | Add simple file-handling on top of Base Parsecable class -}
module ParsecPlus
  ( AsParseError(..), Parsecable(..), ParseError
  , parsecFileUTF8L, parsecFileUTF8
  , module ParsecPlusBase
  )
where

-- fpath -------------------------------

import FPath.AsFilePath  ( filepath )
import FPath.File        ( FileAs( _File_ ) )

-- lens --------------------------------

import Control.Lens.Review  ( review )

-- monaderror-io -----------------------

import MonadError.IO.Error  ( AsIOError )

-- monadio-plus ------------------------

import MonadIO       ( MonadIO )
import MonadIO.File  ( readFileUTF8, readFileUTF8Lenient )

-- more-unicode ------------------------

import Data.MoreUnicode.Lens   ( (⫥) )
import Data.MoreUnicode.Monad  ( (≫) )

-- mtl ---------------------------------

import Control.Monad.Except  ( MonadError )

-- parsec-plus-base --------------------

import ParsecPlusBase
import Parsec.Error  ( ParseError )

--------------------------------------------------------------------------------

{- | Parse a file whose contents are UTF8-encoded text. -}
parsecFileUTF8 ∷ ∀ χ ε μ γ . (MonadIO μ, Parsecable χ, FileAs γ,
                            AsIOError ε, AsParseError ε, MonadError ε μ) ⇒
                 γ → μ χ
parsecFileUTF8 (review _File_ → fn) = readFileUTF8 fn ≫ parsec (fn ⫥ filepath)

----------------------------------------

{- | Parse a file whose contents are UTF8-encoded text; with lenient decoding
     (see `readFileUTF8Lenient`. -}
parsecFileUTF8L ∷ ∀ χ ε μ γ . (MonadIO μ, Parsecable χ, FileAs γ,
                            AsIOError ε, AsParseError ε, MonadError ε μ) ⇒
                  γ → μ χ
parsecFileUTF8L (review _File_ → fn) =
  readFileUTF8Lenient fn ≫ parsec (fn ⫥ filepath)

-- that's all, folks! ----------------------------------------------------------
