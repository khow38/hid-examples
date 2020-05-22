{-# LANGUAGE OverloadedStrings #-}

import Data.List
import TextShow
import qualified Data.Text as T
import System.Exit
import Control.Monad (unless)

import Expr
import ShuntingYard

strs = ["42", "12 + 13", "(2+3*3)*5", "1+(1+2)*(2+2*(1+2))+1+3*2",
        "13+2+12+2+1+2+13+2", "1*2*132*22*1*22*0*2", "10*(1+2)*2*(2+1*2)+1+3+2"]

exprs = map convertToExpr strs
exprs' = map (convertToExpr . T.unpack . showt) exprs

correct = and $ zipWith (\e1 e2 -> myeval e1 == myeval e2) exprs exprs'

main = unless correct exitFailure
