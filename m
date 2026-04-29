Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1B372EF3
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460666; cv=none; b=M9lJExGMSDHT5GXiMF83XyaQJo0Hzw+E82oDr5O+Ue/rbqRwywtju1Zfi4nSVvj/Sl5hNA8/q8yhMgCjvx90F5OMuiCOtUkptEKbw4KyizXszdyeWFoqFRpEvwROUmCdkjQli9t7d3qKBUBxCHuSizTM3EWOnReV8QJ1tD96SiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460666; c=relaxed/simple;
	bh=A3MbEVvqVNQUdK3soBAp8AtTz8ruucIvgsSE07avi2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu0ITpZKax2BosYqnNlS5BU8U7nU/6FMeytYpDack/LXgZYINmIZfO90oxnmHg8QHPEqv2iwSBBzUynNtQpdf1domd/AoWAxg0C6kq9Jc10Oog4jfADCidHtiBUQvtb4G/Lu1X7Dw+UfnjtcfymsfIkBBcQp2ZviBbrpLWRrOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=PR7ucabj; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="PR7ucabj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1777460655; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=A3MbEVvqVNQUdK3soBAp8AtTz8ruucIvgsSE07avi2M=;
 b=PR7ucabjgSWUMvKC9Y9VVlzkqTAH1SbWgEAW9GLg5ABNYSbLVXzglCzEBihv1YdkjU396
 iV0FvO4tu7WOjgDZSeCaZ9CsmKy0ybhuggWsK9+1YaREgIXHPgrwimZVxo78r7atSC2DhMD
 MrPR6sCMq2LjrXAHgLJVAzPEXbIBVSxYoIBau2FpzJfMB4rwQc9dLnLNXUge1RPD/zxnG8f
 3Fka3SBdGNNkClt956cX9A/i5DnNuPLesWS6Jwfm86yEAT0rXTLAinYqUUJ/H6BMJWBg7Dd
 uLB6Awsnw4ECrGSv16lo2oPShUCeJE5/2pWk6pTR9sc4qHCnRf8J9Qx3n1qg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 5DDDE5FD41;
	Wed, 29 Apr 2026 13:04:15 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 27F1B5FC56;
	Wed, 29 Apr 2026 13:04:14 +0200 (CEST)
Message-ID: <ad0638ff-6591-4732-996f-73f15aaeb9fd@tu-ilmenau.de>
Date: Wed, 29 Apr 2026 13:04:14 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in
 __ceph_x_decrypt()
To: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
 <58f52c8a-54ae-4982-ba68-a9a9d138f484@redhat.com>
 <CAOi1vP8NgWN3LseLR9ynP+gEWQ8E_0_e=CZAOCpwBpPQr_Y+wQ@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <CAOi1vP8NgWN3LseLR9ynP+gEWQ8E_0_e=CZAOCpwBpPQr_Y+wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.04.26 10:41 AM, Ilya Dryomov wrote:
> On Wed, Apr 29, 2026 at 2:51 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> Hi Raphael,
>>
>> On 4/28/26 20:15, Raphael Zimmer wrote:
>>> In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
>>> ceph_x_encrypt_header, and the magic field of this struct is accessed.
>>> This happens without any guarantee that the buffer is large enough to
>>> hold this struct. The function parameter ciphertext_len represents the
>>> length of the ciphertext to decrypt and is guaranteed to be at most the
>>> remaining size of the allocated buffer p. However, this value is not
>>> necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
>>> frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
>>> the ciphertext at its end with a ciphertext_len of 8 or less, can
>>> trigger an out-of-bounds memory access when accessing hdr->magic.
>>>
>>> This patch fixes the issue by adding a check to ensure that the
>>> decrypted plaintext in the buffer is large enough to represent at least
>>> the ceph_x_encrypt_header.
>>>
>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>> ---
>>>   net/ceph/auth_x.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
>>> index 692e0b868822..9e64e82d0b63 100644
>>> --- a/net/ceph/auth_x.c
>>> +++ b/net/ceph/auth_x.c
>>> @@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
>>>       if (ret)
>>>               return ret;
>>>
>>> +     if (plaintext_len < sizeof(*hdr)) {
>>> +             pr_err("%s plaintext too small %d\n", __func__, plaintext_len);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>
>> You just check the AES/NONE case, which the plaintext_len >= 0 +
>> sizeof(struct ceph_x_encrypt_header). While for AES256KRB5 the
>> plaintext_len >= 16 + sizeof(struct ceph_x_encrypt_header).
> 
> Hi Xiubo,
> 
> I don't think that is the case.  plaintext_len is the length of the
> payload that was encrypted, it doesn't vary depending on the encryption
> scheme (only AES vs AES256KRB5 -- __ceph_x_decrypt() wouldn't ever get
> called for NONE).  For both AES and AES256KRB5 that payload is whatever
> the original caller actually wanted to encrypt prepended by hdr (struct
> ceph_x_encrypt_header).  See the comment on ceph_x_encrypt_buflen():
> 
>   AES: ciphertext_len | hdr | data... | padding
>   AES256KRB5: ciphertext_len | confounder | hdr | data... | hmac
> 
> plaintext_len covers hdr | data... and nothing else.  Anything extra
> like padding in AES case or confounder and hmac in AES256KRB5 case gets
> added during encryption and subtracted during decryption and is never
> surfaced by ceph_crypt().
> 
> Thanks,
> 
>                 Ilya
> 

Hi Xiubo, Ilya,
I agree with Ilya that AES256KRB5 doesn't require a different handling
as explained and it would in fact be incorrect to check for
plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr).
But I wouldn't say that it can't be called for NONE. It may never happen
in a normal/correct authentication dialog. But with a peer sending some
weird message sequence, you can absolutely end up in __ceph_x_decrypt()
with a key of type NONE. However, in this case plaintext_len <
sizeof(*hdr) will also be a valid check preventing hdr->magic from
accessing out-of-bounds memory.

Best regards,
Raphael

>>
>> I think we should also check the AES256KRB5 case ?
>>
>> Possible it should be :
>>
>>    if (plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr)) {
>>        pr_err("%s plaintext too small %d, need at least %d\n",
>>               __func__, plaintext_len,
>>               (int)(ceph_crypt_data_offset(key) + sizeof(*hdr)));
>>        return -EINVAL;
>>    }
>>
>>
>> Thanks
>>
>> - Xiubo
>>
>>
>>>       hdr = p + ceph_crypt_data_offset(key);
>>>       if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
>>>               pr_err("%s bad magic\n", __func__);
>>

