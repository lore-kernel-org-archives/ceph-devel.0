Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517152848A1
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813180; cv=none; b=hvIXy2ZKH/SSNqEwVQkS0V3f3N+x+nqzN9K4FfhShD9dzjm9s8wdYoHW8fGQr24K2pkLbH6tRs6wuapLWc78e8vhS/4O9O42nQVVSO7slTJ1ahl0Q4CZGl+r0l5oaWSa4j74LZ68R+Vz+g/iQ/RwA1Qy3KgBR50XlGLR82m+PnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813180; c=relaxed/simple;
	bh=poZsfj/UwUb2WLbLR3S2QQZCQt9woHNmN3GQx9bCnD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bo/6/WW28QRgjuMMaXpMNtuVZ/a8TGc16aDu93SCd7XyLbph/8Cx1/Savdyq8WiAw7CJIfQKzFA4ZVFsUixxZQEks5o3B/a0IMBZyb/bxlpAgGW+u5NZ34BHIYAj0nUpZBPhbEoHj/Bm5b0pSP6S9ILmsK7/qcb74twYr+a26uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=YsidaHuE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="YsidaHuE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7c5d8f45465so104955457b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779813178; x=1780417978; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vz833UBNpvGkocryyLDxNEOOUpVoX0GySBSEyjg3XUA=;
        b=YsidaHuETWna0Y+7mlC/K7aqe4Xv1tlv2szpcK1iKKpSkXDfoOudteq8V6kH+pwHmr
         rqjR17UCu5vR5C1mnTUFZn2S/VqFZCjSFoLW0YgeAtIiw7slVVG66QJAT0Rh72iuqXjm
         STNGKVPj0uwUBJKpfC0DsZHLeRfzf9B5QfpKLLdCiaqVizLWoAl/nXPkR3ar56+eoO/J
         UVhs7XUE9rZJJpgkMgQWNlYCRsB+/kFZ1e9XPrmaPIIcc8Pjx9tkAk/Gnwi02dsN/m3F
         endxjZUvt19B982sSKRAjDiTm86V3aHlBDRlLr5HR2OFBysO/TpkPEIyll5Ok/y+XqYG
         c6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813178; x=1780417978;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz833UBNpvGkocryyLDxNEOOUpVoX0GySBSEyjg3XUA=;
        b=OOOy+cayuaHcvJxvLb3ly+x3plqlxlRSCqZq4fOS9nwTnQgvsD6fNr30Dd9F7MiB2q
         +V5A4JTsVgfbN+tHBDFF7R0bhVDonIrhM9Ga4pI0AYVn++Q4QdRj81gRA5ZyUAqWapq5
         t99kblU+KKgZuVRMQuyQh1orHDOq/mj3APxQ96JbnKT0KFTAFH/2FZas1jRXLANZ4+g5
         fDBEIrhWmxZkyZZVV5qjt90KTN+T6IZJs7HWDxyRfCyIYLoxQqgHc8q6NRdW1dSU4JY0
         WtP8tEc0udfPZ60h46zgMMDntEXok7oRrb4a3VMDXksWrpS+XXbFyhLhx22gxz0TUqrc
         q5UA==
X-Forwarded-Encrypted: i=1; AFNElJ91dFdeeJLBgedqKLrWG7Y83xo6QS1pecQRNOij9AVVDjY8Hld1YtprWTOYdFXxDkigPjIA0HthbSgr@vger.kernel.org
X-Gm-Message-State: AOJu0YygGvDIF+Y5ebQg2bKnbDowQc7SRSxx3UzJ3GYznO7aFHSqOpg7
	hHwzmyf83MSmAF/iW9PYkZ1SwkknMDIUkJNpzWrbQ3OJfL5RRw938pb5VV9IgCd6umc=
X-Gm-Gg: Acq92OHhnUSdKkT69CGa+7DHJR+lqhJRzI94pLWuvQsyDd7nI9RPqmFQRmT5V6F3NZO
	Hqi0mNh8LkfKYpV7p+e40ouQDIfFZ5OBvD4TBLnQNzgbW5Bg+DCxl5bsFteKdYPnMU7c6cKXgzN
	66YLaujV72X1mvDOXNh1/1p8/4Tis8Uj7Um4vXRLjYSn/4YL5riWzXG1eXxciWryQOgLdTgeiOP
	TZN7/Zp2ca4boiQkF2iMh+nm7jbTbLlIvmYAjU6C56906aknjU36JQmhxNpi8YAuFIs0jlAqSSj
	CuhEqsACqrYY+PuIvdGSJtij9fbkpETI/Ioc5oBgKDyQsYZfFVcJBl2c7LH5GWZe/oF5lkwJejK
	7i8RoJCcPTGJ9hBVV3tNWZyivWHCFMSia/48FNsvVmR2R3YdkEFvybHG7qLO4G/i3zYHEQNSczb
	93V/6h7wKRjfy7k1P9SxbHIcI8J0WQnBR5Ni6FeURKMyENzZ0oWacXfEr107oy1zCkZW+25My0E
	38Vc8Y9W9RiY2gE2La/wBtyFqPSaWm/ihu55evB0vGYpIxFdFmankTMJIDhf22oEihFhH4=
X-Received: by 2002:a05:690c:4a13:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7d3337e7e1fmr223095557b3.4.1779813178270;
        Tue, 26 May 2026 09:32:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:569d:a84b:2a39:6537? ([2600:1700:6476:1430:569d:a84b:2a39:6537])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c8c5sm62721467b3.38.2026.05.26.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:32:57 -0700 (PDT)
Message-ID: <9468ab69783d8063a48196cb26526e3cfe9990a2.camel@dubeyko.com>
Subject: Re: [bug report] libceph: out-of-bounds accesses in
 decode_new_up_state_weight()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>, ceph-devel@vger.kernel.org
Date: Tue, 26 May 2026 09:32:56 -0700
In-Reply-To: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
References: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Tue, 2026-05-26 at 17:43 +0200, Raphael Zimmer wrote:
> Hi,
>=20
> I encountered two bugs in the libceph module. Both occur in the
> function
> decode_new_up_state_weight() in net/ceph/osdmap.c and may result in
> accessing out-of-bounds memory. They can be triggered by a corrupted
> message of type CEPH_MSG_OSD_MAP received over a connection to a Ceph
> monitor or OSD.
>=20
> When the received message of type CEPH_MSG_OSD_MAP contains an
> incremental osdmap, decode_new_up_state_weight() is called as part of
> its decoding.
>=20
> The first problem is a potential multiplication overflow when
> calculating the needed decoding length based on a value read from the
> incoming message.
> The function decodes new_weight, new_state, and new_up_client, but in
> a
> different order than they appear in the message. Therefore, the
> lengths
> of new_up_client and new_state are calculated first, and they are
> skipped to decode them later. When calculating the length of the
> new_state part, the following logic is used:
> 	ceph_decode_32_safe(p, end, len, e_inval);
> 	len *=3D sizeof(u32) + (struct_v >=3D 5 ? sizeof(u32) :
> sizeof(u8));
> 	ceph_decode_need(p, end, len, e_inval);
> If a large len value is decoded from the incoming message, an
> overflow
> occurs in the multiplication. This may result in having enough room
> for
> the calculated length and skipping this value.
> When decoding new_state later, len is read again from the message
> buffer
> and used as iteration count for the subsequent decoding loop. In this
> case, no overflowing multiplication is performed, and the decoding
> exceeds the previously skipped part of the message buffer and very
> likely also the end of the total buffer, resulting in out-of-bounds
> reads.
>=20
> The second problem concerns possible negative values decoded from the
> osd fields, present in each of the three aforementioned parts.
> The values are decoded from a 32-bit message field and stored in a
> variable of type s32. Subsequently, a check using if (osd >=3D
> map->max_osd) is performed to not allow values that exceed the number
> of
> OSDs. This only catches values that are too large. A negative value
> will
> pass this check and lead to indexing into an array with a negative
> value. This can happen at multiple positions in the code and lead to
> out-of-bounds reads and writes. For example, a maliciously crafted
> message containing osd fields with values interpreted as negative
> numbers in the new_weight part allows writing arbitrarily chosen 32-
> bit
> values to arbitrarily chosen (32-bit-aligned) relative indices
> located
> prior to the memory buffer allocated for map->osd_weight.
>=20
> The first issue can be fixed by adding a check that catches large
> values
> for len that would result in a multiplication overflow, and treat
> such
> osdmaps/messages as invalid.
> The second problem can be prevented by changing the data type of the
> osd
> variables to u32. This would prevent values read from these message
> fields from being interpreted as negative numbers. This choice of
> data
> type also matches the type of map->max_osd with which the comparison
> to
> filter out high values is performed.
>=20
> I will send a suggested patch that addresses each of the issues in
> reply
> to this email. However, if it would be preferred to have both fixes
> combined in a single patch, I can do this as well.
>=20
>=20
> Best regards,
> Raphael
