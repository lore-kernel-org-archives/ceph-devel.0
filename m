Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2615B135
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423909; cv=none; b=btV7xq5LKD0aSsTfISjKSJSwMaWQYlCFhrUd7VAk25kN7ok6omTwVPfy1orOPWVXN6nZaaCGwABslUFqwCBYyUiNBti4l8x811JnZynFHDq10t+Af1Wt2wPuKHnY33zAVsEbWW1AnYumym9qKBjjPsHF1k8YXDuNCepUK0LVtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423909; c=relaxed/simple;
	bh=AdePDjX4sfbhq7tLSTu8Am9kCDJUZREBYbOVytdFS5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrdXk/QsE1vT0ng78L6BV/fOesEWuR/C0IRZW7ELI+Gna01+wWXhR2kFZUyhzk+s3MdUI6+HTB4qBEsNjgzRX+lZoHiEHsSbqwKVdSD5ecxEbuRqSX6vvHQXUaseyy6itCpjWJvJpbZgm8DkgG+4Z9qCH9bLsoXUpZ75Dp6fGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU2RpJ5p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lwqEDXBZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU2RpJ5p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lwqEDXBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777423906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S2sZcVVH4w8tWT5RUEftCmv62e2CdhaVi7wThP/XwQ=;
	b=hU2RpJ5pat/ojlEE0U9dEJb2Ede7NaIV5fBngi8tNVmWw1JeJRxNQhPDGf1lBjgHPZz9bV
	JIesnl/jOHT697YjQSPa0v9r9HGriUo4DB7nZhoPSxg/Y/dVkUgLelPRu/ZQbSSdz4prmH
	fHSf7cNfMAT8xTDLYzrCx9i98Dgjdzk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-fRpR-4KtOsSGjyOst4a1lg-1; Tue, 28 Apr 2026 20:51:44 -0400
X-MC-Unique: fRpR-4KtOsSGjyOst4a1lg-1
X-Mimecast-MFC-AGG-ID: fRpR-4KtOsSGjyOst4a1lg_1777423903
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b458add85aso28053455ad.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 17:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777423903; x=1778028703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4S2sZcVVH4w8tWT5RUEftCmv62e2CdhaVi7wThP/XwQ=;
        b=lwqEDXBZP+qPfZTc18o5Lg3h8RGGb+Oh/JNov/3U4A0pvrX0EeG6I6cUVuhyifCC6j
         3xY5yQMKXVWZbqEEQ0JDam1/TdetrJjJyACgo7+0GPoliV7K2hOS7okhNJ4x+MxcC2HC
         i0B72AYeJysh0deBdcWG138A0HI2zDnbGHaNnr1fahrzgM8aTNyFqRO6VKNw6UBFv5at
         xmpQxg9YG5jLPLSiAv/YnEHJgc/0K6T2PbRAio/lCaid7H1rj8LIAOvM1EenCp/yC6km
         nPp2FIVs7lUlA8zPcokU3IWyq4TIq7Wf+G1TQP0uusZenc5FAt06d1AVXmmaSM9vJ2Ef
         9CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777423903; x=1778028703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S2sZcVVH4w8tWT5RUEftCmv62e2CdhaVi7wThP/XwQ=;
        b=A8XrtTrP8rfQlDSubG+j1qvaqw/kOtfbSCVrs5r+s9ACy6GWGf3BJ4fx7auZk1n+YI
         YmpCW2t1JmGhzKd2Z2k/XwYq7myBdLDb6Z9FnMcjoWLF8hfFU2ZkCs4gLQMNdQtoVjSJ
         U4YLBJqDh+TY/tFEHrTHF9DJFLTe/WDvBjiGM4YLE8VYDfBj2UdEJwshWgzGOb8r/HhQ
         AnIj1jGXFU0ROS+XlW59xmRrB0GfSKXy6REuApHx1L7jugWQSAsSq4YYnRjB1KANb+8O
         59ipdDuY+7zE14ExSkVb7+9OoEmPus4zRV4U3q6ntqsMPeeGSQTDOct2XZiotmw448YT
         y66g==
X-Gm-Message-State: AOJu0YzjK6l0BqQAjBm1f7A2kEnIQufJwzk3wJa/iaTscXrNVBvtjwyb
	MTkDj6aJtKCHyjVdoni3Yn/c2E20x0Vf6tMh0oXG9QgiBINcdOedL/d4TY3zlZNcjA1xrMpDma+
	Ddt49D2bm3W0nJ/bUlItsMgwHADNEK0+qX/ejiVSBJBpSE0Q/5fuJnb/8lTxM4Q4=
X-Gm-Gg: AeBDiesGe+MFY2aIzrkIUs/q6R+gP33q5DVFitdmF+XrxczInYpbM7qkorLjADnReM/
	Iwi9yIDuZnclncVbxKdH6s3S1DHlZmoayd0bl1AbQlIdnOReSi665gZS0YJ9DEj9gGRVppRtBzA
	siRkJhf+hycJ2TKYN55Cr9wFFhtStQXTd4dLhjueNDf6ayZwyd7QZknwTBbW+64vBjZFgiel3wy
	B7ITluxKb7Tek/vG0rf7cpqmFempjdvTfnn/tk6PY11FFc7E+xJruwyMFYtXFww/mkrSOpZjSv9
	qhb8eL8o7oMK1ZiaEAgPnreUhdu69HakJ/h4lfblpzA+oTV50h01XyuzANNIRyVTA5oeYiX0XBz
	iMtaFQeS8lH24zhFHMCYdYlgRxRw2uPp0cg==
X-Received: by 2002:a17:903:b83:b0:2b7:ab8e:53b7 with SMTP id d9443c01a7336-2b9874078a2mr15263755ad.20.1777423903350;
        Tue, 28 Apr 2026 17:51:43 -0700 (PDT)
X-Received: by 2002:a17:903:b83:b0:2b7:ab8e:53b7 with SMTP id d9443c01a7336-2b9874078a2mr15263445ad.20.1777423902853;
        Tue, 28 Apr 2026 17:51:42 -0700 (PDT)
Received: from [10.72.112.70] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772cb6sm4193885ad.4.2026.04.28.17.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 17:51:42 -0700 (PDT)
Message-ID: <58f52c8a-54ae-4982-ba68-a9a9d138f484@redhat.com>
Date: Wed, 29 Apr 2026 08:51:37 +0800
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
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
References: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Raphael,

On 4/28/26 20:15, Raphael Zimmer wrote:
> In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
> ceph_x_encrypt_header, and the magic field of this struct is accessed.
> This happens without any guarantee that the buffer is large enough to
> hold this struct. The function parameter ciphertext_len represents the
> length of the ciphertext to decrypt and is guaranteed to be at most the
> remaining size of the allocated buffer p. However, this value is not
> necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
> frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
> the ciphertext at its end with a ciphertext_len of 8 or less, can
> trigger an out-of-bounds memory access when accessing hdr->magic.
>
> This patch fixes the issue by adding a check to ensure that the
> decrypted plaintext in the buffer is large enough to represent at least
> the ceph_x_encrypt_header.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>   net/ceph/auth_x.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 692e0b868822..9e64e82d0b63 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
>   	if (ret)
>   		return ret;
>   
> +	if (plaintext_len < sizeof(*hdr)) {
> +		pr_err("%s plaintext too small %d\n", __func__, plaintext_len);
> +		return -EINVAL;
> +	}
> +

You just check the AES/NONE case, which the plaintext_len >= 0 + 
sizeof(struct ceph_x_encrypt_header). While for AES256KRB5 the 
plaintext_len >= 16 + sizeof(struct ceph_x_encrypt_header).

I think we should also check the AES256KRB5 case ?

Possible it should be :

   if (plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr)) {
       pr_err("%s plaintext too small %d, need at least %d\n",
              __func__, plaintext_len,
              (int)(ceph_crypt_data_offset(key) + sizeof(*hdr)));
       return -EINVAL;
   }


Thanks

- Xiubo


>   	hdr = p + ceph_crypt_data_offset(key);
>   	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
>   		pr_err("%s bad magic\n", __func__);

