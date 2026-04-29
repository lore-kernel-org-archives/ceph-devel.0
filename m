Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8652331220
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777505553; cv=none; b=Xy47PyZczNiaTXBHtSjFlL8OiLXS/pz3akbnlTKhuuyCsrEB2uUQeZjEoQNR9hjTBRgTFaKin3dZg9AG5P77OZ7Fn1hiY6opyTS2dTPqrXca7iRJytTGuwg4g37SmCY2e81Hh0BvuvekvkADOjEJ08Nk8oUwUcTyyY6I7tMBHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777505553; c=relaxed/simple;
	bh=7yj8W2axwxMcAO8EFDlP15K5ClAE05bTEp2Pnw1j3Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIQgpgk9RMhQ6L2c4sqJrrZhQ2x5c5avq7VD2fhA4hns4rAcjTnkeDAHWxmRlQUvQQiefXJyF9Aoyu8dJ88aqZ/thl23iJ8FgbUO1iJj85Ht1xHullGtxNFmlU2dMksqbdp0RwerGO9RLv7btYIUDP/u9HDiQf1BdgCK2JXhx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i59PQj7V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/7xHbRz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i59PQj7V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/7xHbRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777505550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFqZyyvwZ84P04bruJBGdR7fbYVGZuA8M1aUaFc3N8M=;
	b=i59PQj7VnfUmeww6bbXwGbDUfBNaNPsKllWyfe5jYmY5TsRh0tFrWadBInABahbe937bXJ
	sVsjC7TMiHuQd4SqSHYvMhloNpf5BiGra5AcTv2WCx0uyXnA4JKtgfxarYFKoz4Am7M5GI
	1WcrWdhuGxLMVdQxZ92JvaqL3JH2EL4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-HEq0MrF7PXym8cSjp0qd-Q-1; Wed, 29 Apr 2026 19:32:29 -0400
X-MC-Unique: HEq0MrF7PXym8cSjp0qd-Q-1
X-Mimecast-MFC-AGG-ID: HEq0MrF7PXym8cSjp0qd-Q_1777505548
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35e59791605so284867a91.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777505548; x=1778110348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFqZyyvwZ84P04bruJBGdR7fbYVGZuA8M1aUaFc3N8M=;
        b=h/7xHbRzXj3iDyeo8vSOKj/6mesUHHHpZ/T+7kcmnamYkQ0F5rICDgEwn8Vi6A3FqQ
         FOI84KqgWqyGAHufw2gJk7ejWzzsg4GKXzo2ZFkC+POWduoBJ1HfApMu8vNBolijV+Oq
         gzLdn2cRIgRibGu4WGoP8/B9XCqw5kA77uANGgmmaYe9hquwFc32+PUeiuM4f8ioaxrI
         lcPbJBY4f/5yW/JTHAINZDauQtz8zKLglEuFH/xLvdd9RcTnGx8eHEDlIsTujFArf9oX
         jugmoAHwQ8R+JJeVI8+jxYMv8uzqnvDCB28X9KvjZNKmQ/LIG2+yb3yahFxv6mRTLSgH
         ZhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777505548; x=1778110348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFqZyyvwZ84P04bruJBGdR7fbYVGZuA8M1aUaFc3N8M=;
        b=i0MzrLks7uS2FmVrtaWpUnCge+XbGIR3avNrJBN/QhCLjlAaLOnvxxf9SiqhrKu//6
         zC1SwuVIWSD39SzTyS9+lz2WDt3b6gcPc0kqHp+JtPjboaWHvqGw1vrvFOhLOZbFcGIO
         A0qyMX8Zl9BWEiU/YEtaU38Zu6foz7bCmtrq8PyErU4sQ6vp2MZE28T1W0GMpHkowcaG
         9xSvoH4n4uzCGRtFIrjN4IRrD1eoAHzK4db4zD9G20UySjb3nd0qqMcYMJ0ndQX02/TS
         LUoZnXBNlud1o6Pq9cCjAOfW0Q6Jy2r1zUyFGz/FOlXm1EGrwAUVIyzJ+x8UFfQIGETn
         20iw==
X-Forwarded-Encrypted: i=1; AFNElJ/Tf5mW5NJZbsbjVadho6eiwEl6gdXCpKkyHH4QMpfPFsKHZDyT8GoTI3CN5OF8qjN4COoCtNkPnVZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyvyXAIIz/aPmFoXj+YHkAxLOvid5xzfu5qBGc2Xcb3qsOHz0yz
	yRX4wfi3XfggMuEvhkAgJ4WurehnK8icksPiS+troqbrXQeQaMk6ZtRXVJARPD0UvtecVtHphmu
	NrF851POiM4j9KVeywhy30Wmtsck/P1dkmOfneT3exPDisOJwpUKM8BNFm51SSik=
X-Gm-Gg: AeBDievETapm8ncCnpwVveVzrIjNl4L9WSNRgEfPEyq6QJcTQZOPWmEPp5M3Hlg56pC
	kZJePwF0rae7UVIBDeEFnumrmfrsq7/hRwtBeuN93P51SSNMYCu5mWB7UE39Kb/mVF50bvEHSBZ
	ercnie09A/DDgreraOrk0staJ6/4/SNoUHrGajH8A53KciDsAY2JXR5FIwSxFoKaQkhsLeFERyQ
	hu+926+3fDYLHmUoB3biP+guuHdHRRwrXyW865NaOobUtsbtatT7FFl4Ub2qbjgz/R/ya82rOsk
	R5yL7sIZvfw9fAeh9BoIN/p9hfqY5bv/u28HV8tC6dLH4NL35RCmqF99Fc7G18RZ7p+qNN2lTIE
	pCH2pKTONWrBoNMB62gNxM2rIAyf52vW2+w==
X-Received: by 2002:a17:90b:3c10:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-364c30efa39mr332104a91.13.1777505548395;
        Wed, 29 Apr 2026 16:32:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3c10:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-364c30efa39mr332065a91.13.1777505547948;
        Wed, 29 Apr 2026 16:32:27 -0700 (PDT)
Received: from [10.72.112.70] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf26a64sm697181a91.2.2026.04.29.16.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 16:32:27 -0700 (PDT)
Message-ID: <1dbe426d-1097-4263-90ca-a2866d992563@redhat.com>
Date: Thu, 30 Apr 2026 07:32:22 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in
 __ceph_x_decrypt()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
 Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
 <58f52c8a-54ae-4982-ba68-a9a9d138f484@redhat.com>
 <CAOi1vP8NgWN3LseLR9ynP+gEWQ8E_0_e=CZAOCpwBpPQr_Y+wQ@mail.gmail.com>
 <ad0638ff-6591-4732-996f-73f15aaeb9fd@tu-ilmenau.de>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <ad0638ff-6591-4732-996f-73f15aaeb9fd@tu-ilmenau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/29/26 19:04, Raphael Zimmer wrote:
> On 29.04.26 10:41 AM, Ilya Dryomov wrote:
>> On Wed, Apr 29, 2026 at 2:51 AM Xiubo Li <xiubli@redhat.com> wrote:
>>> Hi Raphael,
>>>
>>> On 4/28/26 20:15, Raphael Zimmer wrote:
>>>> In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
>>>> ceph_x_encrypt_header, and the magic field of this struct is accessed.
>>>> This happens without any guarantee that the buffer is large enough to
>>>> hold this struct. The function parameter ciphertext_len represents the
>>>> length of the ciphertext to decrypt and is guaranteed to be at most the
>>>> remaining size of the allocated buffer p. However, this value is not
>>>> necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
>>>> frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
>>>> the ciphertext at its end with a ciphertext_len of 8 or less, can
>>>> trigger an out-of-bounds memory access when accessing hdr->magic.
>>>>
>>>> This patch fixes the issue by adding a check to ensure that the
>>>> decrypted plaintext in the buffer is large enough to represent at least
>>>> the ceph_x_encrypt_header.
>>>>
>>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>>> ---
>>>>    net/ceph/auth_x.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
>>>> index 692e0b868822..9e64e82d0b63 100644
>>>> --- a/net/ceph/auth_x.c
>>>> +++ b/net/ceph/auth_x.c
>>>> @@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
>>>>        if (ret)
>>>>                return ret;
>>>>
>>>> +     if (plaintext_len < sizeof(*hdr)) {
>>>> +             pr_err("%s plaintext too small %d\n", __func__, plaintext_len);
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>> You just check the AES/NONE case, which the plaintext_len >= 0 +
>>> sizeof(struct ceph_x_encrypt_header). While for AES256KRB5 the
>>> plaintext_len >= 16 + sizeof(struct ceph_x_encrypt_header).
>> Hi Xiubo,
>>
>> I don't think that is the case.  plaintext_len is the length of the
>> payload that was encrypted, it doesn't vary depending on the encryption
>> scheme (only AES vs AES256KRB5 -- __ceph_x_decrypt() wouldn't ever get
>> called for NONE).  For both AES and AES256KRB5 that payload is whatever
>> the original caller actually wanted to encrypt prepended by hdr (struct
>> ceph_x_encrypt_header).  See the comment on ceph_x_encrypt_buflen():
>>
>>    AES: ciphertext_len | hdr | data... | padding
>>    AES256KRB5: ciphertext_len | confounder | hdr | data... | hmac
>>
>> plaintext_len covers hdr | data... and nothing else.  Anything extra
>> like padding in AES case or confounder and hmac in AES256KRB5 case gets
>> added during encryption and subtracted during decryption and is never
>> surfaced by ceph_crypt().

Hmm, I think I just misunderstood the logic.

Thanks for clarifying this.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

- Xiubo


>> Thanks,
>>
>>                  Ilya
>>
> Hi Xiubo, Ilya,
> I agree with Ilya that AES256KRB5 doesn't require a different handling
> as explained and it would in fact be incorrect to check for
> plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr).
> But I wouldn't say that it can't be called for NONE. It may never happen
> in a normal/correct authentication dialog. But with a peer sending some
> weird message sequence, you can absolutely end up in __ceph_x_decrypt()
> with a key of type NONE. However, in this case plaintext_len <
> sizeof(*hdr) will also be a valid check preventing hdr->magic from
> accessing out-of-bounds memory.
>
> Best regards,
> Raphael
>
>>> I think we should also check the AES256KRB5 case ?
>>>
>>> Possible it should be :
>>>
>>>     if (plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr)) {
>>>         pr_err("%s plaintext too small %d, need at least %d\n",
>>>                __func__, plaintext_len,
>>>                (int)(ceph_crypt_data_offset(key) + sizeof(*hdr)));
>>>         return -EINVAL;
>>>     }
>>>
>>>
>>> Thanks
>>>
>>> - Xiubo
>>>
>>>
>>>>        hdr = p + ceph_crypt_data_offset(key);
>>>>        if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
>>>>                pr_err("%s bad magic\n", __func__);

