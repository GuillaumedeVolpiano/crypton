{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE TypeFamilies #-}

-- |
-- Module      : Crypto.Hash.MD2
-- License     : BSD-style
-- Maintainer  : Vincent Hanquez <vincent@snarc.org>
-- Stability   : experimental
-- Portability : unknown
--
-- Module containing the binding functions to work with the
-- MD2 cryptographic hash.
module Crypto.Hash.MD2 (MD2 (..)) where

import Crypto.Hash.Types
import Data.Data
import Data.Word (Word32, Word8)
import Foreign.Ptr (Ptr)

-- | MD2 cryptographic hash algorithm
data MD2 = MD2
    deriving (Show, Data)

instance HashAlgorithm MD2 where
    type HashBlockSize MD2 = 16
    type HashDigestSize MD2 = 16
    type HashInternalContextSize MD2 = 96
    hashBlockSize _ = 16
    hashDigestSize _ = 16
    hashInternalContextSize _ = 96
    hashInternalInit = c_md2_init
    hashInternalUpdate = c_md2_update
    hashInternalFinalize = c_md2_finalize

foreign import ccall unsafe "crypton_md2_init"
    c_md2_init :: Ptr (Context a) -> IO ()

foreign import ccall "crypton_md2_update"
    c_md2_update :: Ptr (Context a) -> Ptr Word8 -> Word32 -> IO ()

foreign import ccall unsafe "crypton_md2_finalize"
    c_md2_finalize :: Ptr (Context a) -> Ptr (Digest a) -> IO ()
