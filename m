Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E64C77D9
	for <ceph-devel@vger.kernel.org>; Wed, 13 May 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690456; cv=none; b=JVAJppvvGTpSK/GUuiwMGl2HuOJuLdSlLTgWH4akjuakSNOsiBvunj+wsmxLy+s0CmJ77LxBD04ar0Fhx3G6ihT3zowJSOVJ1VpZYc/+beiMTbaWxeDZOsKO2MruMOR9LxM67zoT4SJpHy4f8/Yv/9ndgzV4FY6i2i6nX4TawKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690456; c=relaxed/simple;
	bh=cn2w2/ThmERdLnAwpsFfljyXVHmWkPp04bP3ZlX8dt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYwrJVaZmN74xmzOyaCFpHVeas3brhJZChzQ1whlNhsn6u3GG/n6tVZYX/Kn0GlWK3Dy/7X1JeqU5A0JyRV3tSl+C+5cyMm8uA57qIQd5Z0ZYhfNaX8iET1OgZT2oGmXQkGiqE2xXRRqhkd5zdfB4xHdR3pd1xQdZWWn49DXNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0wLT8xmB; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0wLT8xmB"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c21049dafso6650390d50.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 May 2026 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778690452; x=1779295252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TMlnUQ5E7rjsRRONKThFQebpJF9AGTukipGJxxo/QeQ=;
        b=0wLT8xmB9wom/XukuKqUmIeLwIiztpYp1k5FfoJb454sTRHaIVCllChNhVINCZUlC4
         bJCkXoJnk7bkMP6vJ+92Fx3YwV70xIkPcf994B6+ebmMv4+i2Vq7r5qmKJUVmcO+eI26
         airl4juQRqnxbnSwLRWKZpP0HE+41ovT7e3s4xXc05TzSd6Eq/BaiML6VXR378j1+vrW
         ytndgReMt+sHjnU/TvUpY7RBma1sWUBV/ugEeiPQXLz9YeAtCVLF5KkIOFXMshuqZChy
         cSZ0i3HBY97XMt2wZMACohWlFMPmhnxLrJYLSWwImg4VvfrhSNusigcs8uiicbe3V013
         BD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690452; x=1779295252;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMlnUQ5E7rjsRRONKThFQebpJF9AGTukipGJxxo/QeQ=;
        b=VIV0XCYJGPdnRBtxLN+vZq8EOA+Q2oq7AGhTuJcLRxryw1HRjN0Q/KW0lGK7ogMttH
         5Rto3zP3H/PbzPIsdiMZT02xE+MAoKmew/OGKMHTKkkz3cNvjoAvzBpxlQj3U2frYoqP
         pImhxxH/sGKhixpmU65nbgwTnSqq4ytHNcAvv9QvszxXRy5Ven5y3oVczXQ+81TFTGtC
         n/vx1IoTFcluEf/rlchaelkQqedM6bqLcAh5m418gkCuaB0MHEuhYg6LYXN2XdOms3Xr
         1saJJQohI+EBx/I0y85MSk8RfZRZbF3EB4Ftv/tup/ER2NUArWq8Hy0coV8dPSiXz8SC
         I9Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9ssxwIceOjV7T/ZzdAvyHkW7k1YIVGt6HfzR6+eqsUtwNoSMLtKA/ZuLey44OOY1oEA8hcbNbtq9Qn@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPfdn3UqtgQEB90Z5H99IiiHnXTeT7UTkovrYv23F1wBZVqfP
	ar8esKikobyGJHNpKSShYNUaf8pkoh+0qLtMXoGtwCwzhfOvjlF162gFdSO18jDWyNY=
X-Gm-Gg: Acq92OEeq/hWFvG5r6mpDabtzvulx7FYywT+BoxqlbuC8wvyoculV8/pPAglbt0xbVQ
	RPbjJ58i2ObwWtITST/RuvPWD0+jh7N8b6Y62NJgvOuIc/XqfF9vUfHXLDyo64fZQeUdu68Fle6
	M+PPBxGT+jJ6fjg5f8iwUEKbEy9xwNuSZYB9wQy436B5DFsD8tDgICv1/SxFdcutiguoHZ4/PCb
	iJ+Nf+/iO2Mp5wjWJClo9+KUdyTOp5cBDWVbeOJWh0uYe0lA6CSrfC/hWlT864kTHyl0qJhmOlN
	y7w6p6qcVEQzWzLUqpvFJsU+y4FJ99Gcl0tJ4SAAPX4tORP1M/onC+hSEBGhjuspt/9ObRflTl7
	gtEmrj8UTvYQUWlY9EzuvyQ7X1WETIdPRvHe9Hs2xseUE2BVY1YFh83MU2dg8HVajMjJoNQmlwu
	jGslqGcNBFHW899gS2oN32s9j/IfHX3WlRWEzpwy6c6L6A34AcWd4dRadpT3ata9HQ7BPhpd6FD
	AYweaJptN5+6Bye+VCvvfU0muLIG5/yecvfxMyC8kj+SdPmF75FikD+hgAL
X-Received: by 2002:a05:690e:150d:b0:650:5316:175b with SMTP id 956f58d0204a3-65df638321bmr3458829d50.52.1778690451692;
        Wed, 13 May 2026 09:40:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9ff5:f08a:b03d:3394? ([2600:1700:6476:1430:9ff5:f08a:b03d:3394])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96c5719dsm9066436d50.21.2026.05.13.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:40:51 -0700 (PDT)
Message-ID: <7f1c956b984f9524977bf6269c2c82947f72fb4d.camel@dubeyko.com>
Subject: Re: [bug report] libceph: Multiplication overflow that leads to
 out-of-bounds writes in __decode_pg_upmap_items()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>, ceph-devel@vger.kernel.org
Date: Wed, 13 May 2026 09:40:49 -0700
In-Reply-To: <8edcef9c-0b7c-46dc-8094-dc55b62567d3@tu-ilmenau.de>
References: <8edcef9c-0b7c-46dc-8094-dc55b62567d3@tu-ilmenau.de>
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

cc: ceph-devel@vger.kernel.org

On Wed, 2026-05-13 at 10:13 +0200, Raphael Zimmer wrote:
> Hi,
> I encountered a bug in the libceph module, specifically in the
> function
> __decode_pg_upmap_items() in net/ceph/osdmap.c. It can be triggered
> by a
> message of type CEPH_MSG_OSD_MAP arriving on an open connection to a
> Ceph monitor or OSD.
>=20
> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
> contains a pg_upmap part at its end. When decoding this part,
> __decode_pg_upmap_items() is called. In this function, a len value is
> decoded from the message. It is used to determine the number of items
> and the size of the allocation needed for them. If the len value is
> greater than or equal to 2^31, an overflow occurs in the
> multiplication
> that is performed to determine the needed size of the incoming buffer
> to
> decode, as well as for the length of the allocation for the
> ceph_pg_mapping struct. The performed multiplication is "2 * len *
> sizeof(u32)" where len is of type u32. Subsequently, the len
> parameter
> is used as the upper bound of a loop that decodes the incoming
> message
> fields into the ceph_pg_mapping struct. This results in out-of-bounds
> memory accesses in case of a previous overflow. The len field can be
> set
> arbitrarily by a (maliciously acting) Ceph monitor or OSD and allows
> writing data received over the network beyond the end of the
> allocated
> buffer. Furthermore, I observed that it can ultimately result in a
> kernel panic because of general protection faults when attempting to
> access the memory.
>=20
> The issues can be reproduced on the recent stable release 7.0.6 when
> injecting a specifically crafted message into an open Ceph
> connection.
> However, 32-bit systems are probably not affected, as the previous
> check
> for:
> if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> 		return ERR_PTR(-EINVAL);
> would not allow a value this large for len on these systems.
>=20
> The bug can be fixed by explicitly performing the multiplication in
> 64
> bit on 64-bit systems by switching to "2UL * len * sizeof(u32)" or
> changing the evaluation order of the multiplication. This would
> suffice
> as the mentioned check catches such values already beforehand on 32-
> bit
> systems, so that an additional check is not necessary. However, I
> would
> also be open to adding an additional check instead if it seems more
> appropriate.
>=20
> I will send the proposed fix in reply to this email.
>=20
>=20
> Best regards,
> Raphael
