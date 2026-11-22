Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380358;
	b=yPYrl4Tu9SKQx53Dn+b7NuWVaijmjSu4CFvvr0+z221eJQnqUAH3aiCKIrIzBDPorWnQ
	 fGj3AjbRD2P7d03iWAvE7JP1Z/wxO0anKjtMssSzJlKLTQM00+mopb2zTV2AaWy/f1yJj
	 UvwOKN11aHuxTzaaDPpPRfr89SSlnR8Da58KTN5PFh4iDO7Eo3PQs/vUEmct5diH2QBtx
	 dgab7FWr4//IMLcE8RLlWK/Y9G1WyHc1dUU6E+YGwYPFqxNL9g7A5UWYh9VInwcDebIEj
	 nUdScqKpGXUiijx9ObOKxNNupvOgRpjWjR3OWHoP86YBnPhSS0lz5hpJ/CyGryKRaMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380358;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4nWzdIaJompPpjPxzX1Uzez3tR4aHod+CrgwBgECgj8=;
	b=IiLAOAZs+vVC47IRf+suHSG+MuQ9oD7zWIvmjBcDNGhcHeKtCHTBuU4cyCJKg3iYl16v
	 aeD8xs059LRMgarpfRn+nHd5DOOauliLPPOhKmd38TVTRC7IUY2Q1pWRc42QI2ZpV4x7m
	 QPZHT3Ov/vbS86rWiOkWom7MEbPDKiou1qAtiY60EuwjsU7gH8eE/NB+Xed+Mmc6T/KK2
	 FTR/gsgQIwSUXJnJK5iFORBx13oXHC/GH+tjrQwNtUOxTmlvc/Bb+QbIR7rXdil4upHl3
	 jrAWBcHQcfFN2lkOgIDfdPzHIz2rx3w+kiEPIwNyIhMvMTUn4eocbR+0ZEFedwi3qjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bKjx1bUt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AAWNJ+UK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB10606A31D
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 20:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB10606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bKjx1bUt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AAWNJ+UK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795380356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nWzdIaJompPpjPxzX1Uzez3tR4aHod+CrgwBgECgj8=;
	b=bKjx1bUtp4x9mBLoMXQtsxnqkOWyoBtYl6tx6sAe7rbuhoL6A8FisL+ZaVt5ZfawPYfIGp
	E9m+9C9LMGHu8kxGciqJOekymW63OQhauU6TkBmHHIY8E572sXE5MyFZ5K84jiM0OLskwp
	0xaCXhBWSF5qyQLReI/8JfpJFc31f0M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-_Hm5mlD-M163Jk_p14Ijbw-1; Sun, 22 Nov 2026 20:45:54 +0000
X-MC-Unique: _Hm5mlD-M163Jk_p14Ijbw-1
X-Mimecast-MFC-AGG-ID: _Hm5mlD-M163Jk_p14Ijbw_1795380354
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-949dc497896so66995685a.0
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 12:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795380354; x=1795985154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nWzdIaJompPpjPxzX1Uzez3tR4aHod+CrgwBgECgj8=;
        b=AAWNJ+UKWSXCKKvCrsonyp/RNscM7iNIklEgw/e0AjxhExnTLicgiTpZJUCUMG/Yj9
         d6lS1/SUxbBsXdCEv8kCMc0+eTxx2ypO+UT3zwdTdFc6gzLQD1Nl9pG1CBRFcrIN7w0v
         dgzs+pTEa7q7Xg9QfswQvZdjI1gvpdjrxibL1/Tik9jCRKdlSE9HDWr4xx0sTus8nHAd
         jkyo5zaHKkCYa+BvFSxRu5AH2cQ0ZSSEG+elMn26BMO0KKZh2F54/cu/s8Zy9osRiApV
         IrZ254BuWICLMK90OUGQ/ROdRZXq3dUAD2InRaodUZphsxnkrXi4eyFySxlTvGkSBTFA
         7Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380354; x=1795985154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4nWzdIaJompPpjPxzX1Uzez3tR4aHod+CrgwBgECgj8=;
        b=KpJAiQB5vlqi1FNmwJBunds3EPKvH5IoaeHpBJa3lbQnPBRVwSarWJX2IlzsYz3nCs
         hBGifGBU1FHLxjrcCHglZB4nBEmZDeL/+wj/X3pyVfzUXDm2veMwKE1TWohtCHAg/m2y
         FWLCnkdP2YBHMroQiZGRTGrLYZgFdTEtF1QeSGxF7hY8Dhu2P8tU6Ra2613DXQYPFAmX
         mU/iW1YwgbcFfsmZhhx4+CDmcLDf41iXlcopBVwp9fY3Q5NNwGakNPEKkfl6A+VKBKPy
         sYt02nc9DG/PC6300EM8sEhLba7w8OjjBGdG1b2NFFarb5y7AFNv/BDEdGd/QEb35HvT
         l71g==
X-Gm-Message-State: APuU4Z8qOgDt+yzs6pyvNyih+vMIU2CYCf1eLFJhfK8YDo6Wc/vMouJG
	toHo2U+hOGAdsqpzay9IRGO2PTT5+NVhYAWH4q5nVTQZF/Yt1GAuXFHoDs0UkxCLdcUboQ6Q+BI
	FN0V9SpnpmZaElZM1F6R03dAtlGhA5llK1yBgDx+qxYqzuWqpx4em5p9+pOyLT5WQO+f91AWbWA
	==
X-Gm-Gg: AZFdTZe5EL89pfqY1UoQ5tDC2Bdtyfqtm6qKa72U8kWcrUO/AEFX2WoXhyCb6dq9Bgz
	lnTz6r0nOltWHVQMUNZxujzIiXL870IXL+5kUVwHSw7TxARznE9BseV7F3r4VNcF70+x0ypf9Xp
	V9OuUuNxhltaiv/c94mRKt/X0aCxO5mXFPrPweFqvxFBit+4KhefKW3PF28jhos5Rr8hx3nYvEZ
	xwIIn2AmV38BPQSB/vJFh4G8NvagApTPiAZTNoeg7tf10EW3TzImtsY8NG0aA8O0Pld3ervmNi0
	Fcs0BblAYwQenQH0wVFCQg8ew4QlVnwxS+n7aDdMAPUUzXzDXJfeUVkvsz0704FqCbTNNCX/weg
	27EZmGR4f8Ma11LsQn4ymVPTMf7dyqywAXhiTY6LtHosodwOuOiRPihHY9WRzouksnqP6C9pg2a
	lPnudPu0HDUfildEkpUQNOC43Uc3E9YTbgZvPn96GCHSlNzn3pUtLEfMOv8N6dpDUhws1TMsWzT
	KrYKjwc1jkQhERDHVZTux0sWs7whu2TPb0D0FEFnkb3fE5D9/Fp
X-Received: by 2002:a05:620a:a012:b0:949:e60b:e0ea with SMTP id af79cd13be357-949e60be137mr142445385a.16.1795380353780;
        Sun, 22 Nov 2026 12:45:53 -0800 (PST)
X-Received: by 2002:a05:620a:a012:b0:949:e60b:e0ea with SMTP id af79cd13be357-949e60be137mr142443085a.16.1795380353374;
        Sun, 22 Nov 2026 12:45:53 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949ca846322sm475017085a.34.2026.11.22.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:45:52 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: ceph-devel@vger.kernel.org
Subject: Re: rbd: Handle overlarge result codes in rbd read replies more gracefully
Date: Sun, 22 Nov 2026 20:45:50 +0000
Message-Id: <20261122204550.1346981-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5a84c2e1-da59-461e-b1ed-f2ea3962f283@tu-ilmenau.de>
References: <20261104153659.1117700-1-raphael.zimmer@tu-ilmenau.de> <20261110115013.3268036-1-amarkuze@redhat.com> <5a84c2e1-da59-461e-b1ed-f2ea3962f283@tu-ilmenau.de>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

You're right that get_reply() rejects an oversized data payload for these
reads. The case I was concerned about is a malformed reply whose result is
larger than the requested extent while its data payload is short or empty.
Those are checked separately: handle_reply() uses a nonzero reply result as
r_result, so the payload can fit the receive buffer while r_result still
exceeds the requested length.

In rbd_obj_advance_read(), that result skips the short-read zero-fill and
is then changed to zero. The request can therefore complete successfully
with part of the read buffer unfilled. A write does not return data to
fill a block read buffer, so normalizing a positive write result does not
have the same consequence.

That's why I suggested returning -EIO for the overlarge read result.

Thanks,
Alex

