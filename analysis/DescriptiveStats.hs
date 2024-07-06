module DescriptiveStats where

import Data.List
import Data.Ord
import Data.Maybe

range :: Ord a => [a] -> Maybe (a, a)
range [] = Nothing
range [x] = Just (x, x)
range xs = Just (minimum xs, maximum xs)

mean :: Real a => [a] -> Maybe Double
mean [] = Nothing
mean [x] = Just $ realToFrac x
mean xs = Just $ realToFrac (sum xs) / fromIntegral (length xs)

stdev :: Real a => [a] -> Maybe Double
stdev [] = Nothing
stdev [_] = Nothing
stdev xs = Just $ sqrt (sumsquares / n_m1)
    where
        n_m1 = fromIntegral (length xs - 1)
        meanxs = fromJust (mean xs)
        sumsquares = sum $ map (diffsquare . realToFrac) xs
        diffsquare x = (x - meanxs) * (x - meanxs)

median :: Real a => [a] -> Maybe Double
median [] = Nothing
median list
    | odd (length list) = Just middleValue
    | otherwise = Just middleEven
    where
        sorted = sort list
        middleIndex = length list `div` 2
        middleValue = realToFrac $ sorted !! middleIndex
        beforeMiddle = realToFrac $ sorted !! (middleIndex -1)
        middleEven = 0.5 * (middleValue + beforeMiddle)

runLengthEncoding :: Ord a => [a] -> [(a, Integer)]
runLengthEncoding = map (\xs -> (head xs, genericLength xs)) . group

mode :: Ord a => [a] -> Maybe (a, Integer)
mode [] = Nothing
mode list = Just $ maximumBy (comparing snd) pairs
    where
        sorted = sort list
        pairs = runLengthEncoding sorted
