{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes       #-}
{-# LANGUAGE UnicodeSyntax    #-}

{- | Add simple file-handling on top of Base Parsecable class -}
module ParsecPlus
  ( AsParseError(..), IOParseError, Parsecable(..)
  , digits, parens, parsecFileUTF8, __parsecN__ )
where

-- base --------------------------------

import Control.Monad.IO.Class  ( MonadIO )

-- fpath -------------------------------

import FPath.AsFilePath  ( filepath )
import FPath.File        ( File )

-- monaderror-io -----------------------

import MonadError.IO.Error  ( AsIOError )

-- monadio-plus ------------------------

import MonadIO.File  ( readFileUTF8 )

-- more-unicode ------------------------

import Data.MoreUnicode.Lens          ( (⫥) )
import Data.MoreUnicode.Monad         ( (≫) )

-- mtl ---------------------------------

import Control.Monad.Except  ( MonadError )

-- parsec-plus-base --------------------

import ParsecPlusBase

import Parsec.Error  ( AsParseError( _ParseError ), IOParseError )

--------------------------------------------------------------------------------

parsecFileUTF8 ∷ ∀ χ ε μ . (MonadIO μ, Parsecable χ,
                            AsIOError ε, AsParseError ε, MonadError ε μ) ⇒
                 File → μ χ
parsecFileUTF8 fn = readFileUTF8 fn ≫ parsec (fn ⫥ filepath)

----------------------------------------

-- that's all, folks! ----------------------------------------------------------
