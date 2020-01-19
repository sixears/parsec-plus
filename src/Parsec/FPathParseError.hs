{-# LANGUAGE InstanceSigs      #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE UnicodeSyntax     #-}

module Parsec.FPathParseError
  ( FPathIOParseError )
where

-- base --------------------------------

import Control.Exception  ( Exception )
import Data.Eq            ( Eq )
import Data.Maybe         ( Maybe( Just, Nothing ) )
import Text.Show          ( Show )

-- base-unicode-symbols ----------------

import Data.Function.Unicode  ( (∘) )

-- data-textual ------------------------

import Data.Textual  ( Printable( print ) )

-- fpath -------------------------------

import FPath.Error.FPathError  ( AsFPathError( _FPathError ), FPathError
                               , FPathIOError, _FPIO_IO_ERROR,_FPIO_PATH_ERROR )

-- lens --------------------------------

import Control.Lens.Prism   ( Prism', prism' )

-- monaderror-io -----------------------

import MonadError.IO.Error  ( AsIOError( _IOError ) )

-- parsec-plus-base --------------------

import Parsec.Error  ( AsParseError( _ParseError ), ParseError )

--------------------------------------------------------------------------------

data FPathIOParseError = FPIOP_FPATHIOERROR FPathIOError
                       | FPIOP_PARSEERROR   ParseError
  deriving (Eq, Show)

_FPIOP_FPATHIOERROR ∷ Prism' FPathIOParseError FPathIOError
_FPIOP_FPATHIOERROR = prism' (\ e → FPIOP_FPATHIOERROR e)
                             (\ case FPIOP_FPATHIOERROR e → Just e; _ → Nothing)

_FPIOP_PARSEERROR ∷ Prism' FPathIOParseError ParseError
_FPIOP_PARSEERROR = prism' (\ e → FPIOP_PARSEERROR e)
                           (\ case FPIOP_PARSEERROR e → Just e; _ → Nothing)

instance Exception FPathIOParseError

instance AsIOError FPathIOParseError where
  _IOError = _FPIOP_FPATHIOERROR ∘ _FPIO_IO_ERROR

instance AsFPathError FPathIOParseError where
  _FPathError ∷ Prism' FPathIOParseError FPathError
  _FPathError = _FPIOP_FPATHIOERROR ∘ _FPIO_PATH_ERROR

instance AsParseError FPathIOParseError where
  _ParseError ∷ Prism' FPathIOParseError ParseError
  _ParseError = prism' FPIOP_PARSEERROR
                       (\ case FPIOP_PARSEERROR e → Just e; _ → Nothing)

instance Printable FPathIOParseError where
  print (FPIOP_FPATHIOERROR e) = print e
  print (FPIOP_PARSEERROR   e) = print e

-- that's all, folks! ----------------------------------------------------------
