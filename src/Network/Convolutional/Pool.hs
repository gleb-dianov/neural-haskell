{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE GADTs         #-}
{-# LANGUAGE RankNTypes    #-}
{-# LANGUAGE TypeOperators #-}

module Network.Convolutional.Pool where

import           Data.Vector.Sized
import           GHC.TypeLits

import           Control.Lens

import           AutoDiff
import           Network.CommonTypes
import           Network.Convolutional.Types

type Pool w h = Vector h (Vector w (Dual Number)) -> Dual Number
