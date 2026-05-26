Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694D3B38AB
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813205; cv=none; b=lbW8WA8ihaSG2vzlPVOZRiUNMw9b1vb0Y/XTRwlIFKCQjDSIBQHCg81SAyeYbsljvR0WyBBqGlY2zV+Y2q3fMzR3TrmLdXrQtQIx6++nANeSCboI9SrKoQoQYzwFqWFBTlh/4BGqdsjU8u+xSUCzeB6bsGGCqaqvmYN0iqoZJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813205; c=relaxed/simple;
	bh=NQOe+UjWdGnVmxzEkYjltdvt9gXONMQhZwwsb4lN7B4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuiDzJwbL3jdzSBy29q4NA7O8w0s/IHaB69+Vv6AMK9INpqiRdCjmnjG8amkrYvJsTLP5fiAshvr6lpvbg7rHOviC20LGie7P+Yt5X/vYSNxQI6f6jaKVtSDTC1kN0BCNL2R8brNMUo7a6AlqE1Cb48mGE07heaiQhl5F705DYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=m45F4RQM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="m45F4RQM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bdf83185bbso105904887b3.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779813203; x=1780418003; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P6VodZMHHDEo/2rU5Zr5IuL2TP0ijXOb7QcnvRQEv4o=;
        b=m45F4RQMKjOb6gVCHJrpQgeonJ0NuBcAQ7rhVL8nPw7Y3iWp48DHC5k967FwOurgGp
         L6bx8mYYvFmwKRNPI6bjwYc00Hzwlxo+dgcw2UvnH3hRolb21aUapaLXldUCHqu4LQcW
         FyXirU5xQXyhOj42ZeWraL57CNwS5Krft24BQW6fwxxoy0NbHEKna0fOhIEy0sKTa0TN
         nAHVkhWHOe3eWlvAEJr1Z+xuzvvawDieK0EJZ9Kx6VsQm/x1OZabGRampu/rJgeZ80S6
         72bbW+sMlI03THc7vssEhdJL3pPBlX01K5DU0xvJ2SL9GYtCx8CCS2UX/Ee8dfVc9QCe
         /YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813203; x=1780418003;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6VodZMHHDEo/2rU5Zr5IuL2TP0ijXOb7QcnvRQEv4o=;
        b=cugYK414K0RRuRo+1cqvKS5P5+vYlo0w8h4MIoQ+XYadds6NavUGOwzc6vVg0wi4i6
         Rt66uBZv8hSqwfL2OMDJ1bvf388D7mpWpI5ZIVAEdR0dFCOWxaV5qTiq1KlBREKvjjF3
         +En72x+JH4ZOyLKroe6mShsFXB93Ord7Tu5NrhKCAAYvf1h8C+4jeoI9qdEl8V5DIpTV
         jnGnZ1Bnouf17oXiR3P1HVwXpXMvHPwQ1z97kOdwdCBH1R382Wphijj0jXTx+ST04HEE
         wksQIbZxnjulzzK8ou2PlCMvcPMv9SHtUb9yrPINbTDnnM0HPs0rvgdDPrzxM6cUxGGW
         XTug==
X-Forwarded-Encrypted: i=1; AFNElJ+zjQbxwb6zqs0DHNzv13epVHjnfp9pWse/Kf2chkhoRMhnuoQFInmtNjSBViFXozXTn9MFevG5Mnpl@vger.kernel.org
X-Gm-Message-State: AOJu0YzEU3j/14bWkGfS2jVQqFLcdMz57QqTN8Fx05D5kZQUsUVR6NaG
	+a9XoasKbxbUacmhFV0/pqjET4yaknqaMYmblHEbwX4c/n61xIcOGit9AtgdA0QE9J4=
X-Gm-Gg: Acq92OEbAy1RsswAmaAC5Xpcfx4IElVEWXNFzXPTo8ie4qOR3nZNF/6hRMMNHSLeGqH
	sEICX8YZCom1Pn8gvBttuEAZm28esgru7dOpfePFbUvw0Y7HoV98+uDsJLneMXbW+Fg6tesJXqD
	DEa+jmDhq7o/LH4e0B3zL8Z1JsaB/yvZiSvgLD1HOa6tq7SqD2nv5G8LYdQv0QQVixQ9qW6PBHJ
	aMzo+qfCagZFgwqGOS9WiCUSuCmG0OZ8YjF5HcRw1oiCoduf0hfj3PqveI+gLHzp3c6cDEFW3FV
	rNbZCzXS2X9ow2gADNEBGIcZpCjU9hYQzWvNQIxrDMgjjYOfmV/BF9QWIviFePZmKIfRPU4mvG6
	z8ctPqDAg+tA+HQnY8sek1L6PveUX4OXH0qmm+4x5I0ijuONh/mH19imrY4WMtkEQhR86aoclnj
	h9qP1bCJy1jr/1x/qrBlBSsXwKPFA1oJP3XrbwLMUsi/y5Kpk2WAYm8uDT0E+Jvhi8nXWDWju7q
	3Tj35RENxJrKFLRmppX9M3qAvTUy5AjDuxWVCqbZL3/0h90m7QttGsceU9mTP+KBkR17mI=
X-Received: by 2002:a05:690c:3686:b0:7c8:615c:7b55 with SMTP id 00721157ae682-7d33a158d60mr209140077b3.23.1779813203354;
        Tue, 26 May 2026 09:33:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:569d:a84b:2a39:6537? ([2600:1700:6476:1430:569d:a84b:2a39:6537])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c8396basm63604767b3.44.2026.05.26.09.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:33:22 -0700 (PDT)
Message-ID: <47b69468215fd0748aa4ce95034b0a19ee8ccc15.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Fix multiplication overflow in
 decode_new_up_state_weight()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: security@kernel.org, ceph-devel@vger.kernel.org
Date: Tue, 26 May 2026 09:33:21 -0700
In-Reply-To: <20260526154443.3467352-1-raphael.zimmer@tu-ilmenau.de>
References: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
	 <20260526154443.3467352-1-raphael.zimmer@tu-ilmenau.de>
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

On Tue, 2026-05-26 at 17:44 +0200, Raphael Zimmer wrote:
> If a message of type CEPH_MSG_OSD_MAP contains a (maliciously)
> corrupted
> osdmap, out-of-bounds memory accesses may occur in
> decode_new_up_state_weight(). This happens because the bounds check
> for
> the new_state part is based on calculating its length depending on a
> len
> value read from the incoming message. This calculation may overflow
> leading to an incorrect bounds check. Subsequently, out-of-bounds
> reads
> may occur when decoding this part.
>=20
> This patch adds a check that catches large values for len that would
> result in a multiplication overflow to treat such osdmaps/messages as
> invalid.
>=20
> Fixes: 930c53286977 ("libceph: apply new_state before new_up_client
> on incrementals")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osdmap.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 076763420b1d..4638df7ad231 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1846,6 +1846,7 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0	void *new_state;
> =C2=A0	void *new_weight_end;
> =C2=A0	u32 len;
> +	const u32 new_state_len =3D sizeof(u32) + (struct_v >=3D 5 ?
> sizeof(u32) : sizeof(u8));
> =C2=A0	int ret;
> =C2=A0	int i;
> =C2=A0
> @@ -1865,7 +1866,9 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0
> =C2=A0	new_state =3D *p;
> =C2=A0	ceph_decode_32_safe(p, end, len, e_inval);
> -	len *=3D sizeof(u32) + (struct_v >=3D 5 ? sizeof(u32) :
> sizeof(u8));
> +	if (len > U32_MAX / new_state_len)
> +		goto e_inval;
> +	len *=3D new_state_len;
> =C2=A0	ceph_decode_need(p, end, len, e_inval);
> =C2=A0	*p +=3D len;
> =C2=A0
