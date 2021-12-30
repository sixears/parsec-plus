{- | Add simple file-handling on top of Base Parsecable class -}
module ParsecPlus
  ( AsParseError(..), Parsecable(..), ParseError
  , parsecFileUTF8L, parsecFileUTF8, testParsecFile
  , module ParsecPlusBase
  )
where

import Base1T

-- fpath -------------------------------

import FPath.AsFilePath  ( filepath )
import FPath.File        ( FileAs( _File_ ) )

-- monadio-plus ------------------------

import MonadIO.File  ( readFile, readFileUTF8Lenient )
import MonadIO.Temp  ( testsWithTempfile )

-- mtl ---------------------------------

import Text.Parsec.Combinator  ( eof )

-- parsec-plus-base --------------------

import ParsecPlusBase
import Parsec.Error  ( ParseError )

--------------------------------------------------------------------------------

{- | Parse a file whose contents are UTF8-encoded text. -}
parsecFileUTF8 ∷ ∀ χ ε μ γ .
                 (MonadIO μ, Parsecable χ, FileAs γ,
                  AsIOError ε, AsParseError ε, MonadError ε μ) ⇒
                 γ → μ χ
parsecFileUTF8 (review _File_ → fn) =
  readFile @_ @𝕋 fn ≫ parse (parser ⋪ eof) (fn ⫥ filepath)

----------------------------------------

{- | Parse a file whose contents are UTF8-encoded text; with lenient decoding
     (see `readFileUTF8Lenient`. -}
parsecFileUTF8L ∷ ∀ χ ε μ γ . (MonadIO μ, Parsecable χ, FileAs γ,
                               AsIOError ε, AsParseError ε, MonadError ε μ) ⇒
                  γ → μ χ
parsecFileUTF8L (review _File_ → fn) =
  readFileUTF8Lenient fn ≫ parse (parser ⋪ eof) (fn ⫥ filepath)

{-| test that `parsecFileUTF8` on a file (of given text) gives expected result -}
testParsecFile ∷ (Eq α, Parsecable α, Show α) ⇒ 𝕋 → α → TestTree
testParsecFile txt exp =
  let prs fn = ѥ @IOParseError $ parsecFileUTF8 fn
      check xp fn = prs fn ≫ \ x → assertRight (xp @=?) x
   in testsWithTempfile txt [("parsecFileUTF8", check exp )]

-- that's all, folks! ----------------------------------------------------------
