{-# LANGUAGE DataKinds #-}

module Network.Classic.Neurons where

import           GHC.TypeLits
import           Prelude                hiding (sum, zipWith)

import           AutoDiff
import           Network.Classic.Neuron
import           Network.Classic.Types
import           Network.CommonTypes

standartSum :: Num a => Vector n (Dual a) -> (Dual a) -> Vector n a -> Dual a
standartSum ws b a = (+ b) $ sum $ zipWith (*) ws $ constDual <$> a

zeros :: KnownNat n => (Weights n -> Bias -> Neuron n) -> Neuron n
zeros f = f (generate $ const 0) 0

sigmoid :: Floating a => a -> a
sigmoid x = 1 / (1 + exp (-x))

newSigmoidNeuron :: Vector n Number -> Number -> Neuron n
newSigmoidNeuron = Neuron standartSum sigmoid

sigmoidNeuron :: KnownNat n => Neuron n
sigmoidNeuron = zeros newSigmoidNeuron

newLinearNeuron :: Weights n -> Bias -> Neuron n
newLinearNeuron = Neuron standartSum id

linearNeuron :: KnownNat n => Neuron n
linearNeuron = zeros newLinearNeuron

newTanhNeuron :: Weights n -> Bias -> Neuron n
newTanhNeuron = Neuron standartSum tanh

tanhNeuron :: KnownNat n => Neuron n
tanhNeuron = zeros newTanhNeuron

relu :: Dual Number -> Dual Number
relu x = if x <= 0 then Dual 0 0 else x

newReluNeuron :: Weights n -> Bias -> Neuron n
newReluNeuron = Neuron standartSum relu

reluNeuron :: KnownNat n => Neuron n
reluNeuron = zeros newReluNeuron

softplus :: Floating a => a -> a
softplus x = log $ 1 + exp x

newSoftplusNeuron :: Weights n -> Bias -> Neuron n
newSoftplusNeuron = Neuron standartSum softplus

softplusNeuron :: KnownNat n => Neuron n
softplusNeuron = zeros newSoftplusNeuron
