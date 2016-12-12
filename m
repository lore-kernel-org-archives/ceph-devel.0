From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 04/15] libceph: introduce ceph_crypt() for in-place en/decryption
Date: Mon, 12 Dec 2016 22:15:13 +0100
Message-ID: <CAOi1vP_4vEygrs6LN+dM8KJTiiFNUfO9jQ3hfzO5qStP0n=L0w@mail.gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
 <1481575740-1834-5-git-send-email-idryomov@gmail.com> <alpine.DEB.2.11.1612122111360.27603@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34684 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcLLVPO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 16:15:14 -0500
Received: by mail-vk0-f65.google.com with SMTP id p9so5062061vkd.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 13:15:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612122111360.27603@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 12, 2016 at 10:11 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 12 Dec 2016, Ilya Dryomov wrote:
>> Starting with 4.9, kernel stacks may be vmalloced and therefore not
>> guaranteed to be physically contiguous; the new CONFIG_VMAP_STACK
>> option is enabled by default on x86.  This makes it invalid to use
>> on-stack buffers with the crypto scatterlist API, as sg_set_buf()
>> expects a logical address and won't work with vmalloced addresses.
>>
>> There isn't a different (e.g. kvec-based) crypto API we could switch
>> net/ceph/crypto.c to and the current scatterlist.h API isn't getting
>> updated to accommodate this use case.  Allocating a new header and
>> padding for each operation is a non-starter, so do the en/decryption
>> in-place on a single pre-assembled (header + data + padding) heap
>> buffer.  This is explicitly supported by the crypto API:
>>
>>     "... the caller may provide the same scatter/gather list for the
>>      plaintext and cipher text. After the completion of the cipher
>>      operation, the plaintext data is replaced with the ciphertext data
>>      in case of an encryption and vice versa for a decryption."
>>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  net/ceph/crypto.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  net/ceph/crypto.h |  2 ++
>>  2 files changed, 89 insertions(+)
>>
>> diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
>> index db2847ac5f12..32099c5c4c75 100644
>> --- a/net/ceph/crypto.c
>> +++ b/net/ceph/crypto.c
>> @@ -526,6 +526,93 @@ int ceph_encrypt2(struct ceph_crypto_key *secret, void *dst, size_t *dst_len,
>>       }
>>  }
>>
>> +static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encrypt,
>> +                       void *buf, int buf_len, int in_len, int *pout_len)
>> +{
>> +     struct crypto_skcipher *tfm = ceph_crypto_alloc_cipher();
>> +     SKCIPHER_REQUEST_ON_STACK(req, tfm);
>> +     struct sg_table sgt;
>> +     struct scatterlist prealloc_sg;
>> +     char iv[AES_BLOCK_SIZE];
>> +     int pad_byte = AES_BLOCK_SIZE - (in_len & (AES_BLOCK_SIZE - 1));
>
> nit: pad_bytes?

It's also used as a PKCS7 pad *byte*

>
>> +     int crypt_len = encrypt ? in_len + pad_byte : in_len;
>> +     int ret;
>> +
>> +     if (IS_ERR(tfm))
>> +             return PTR_ERR(tfm);
>> +
>> +     WARN_ON(crypt_len > buf_len);
>> +     if (encrypt)
>> +             memset(buf + in_len, pad_byte, pad_byte);

here, so I went with byte.

Thanks,

                Ilya
