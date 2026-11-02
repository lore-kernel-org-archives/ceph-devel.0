Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654904;
	b=IwJv9yziE/f2uIEC+W/gA10I9f5iQ2D0C15Y4nVdEi0z6tT5zfyEj9Vd8jpr/cT1ZIKe
	 2OmtjEo6fKCVDL9NMRmK2MsCQGHSkJyTYfDHOaEoSkmiBBgUkxdyIzEc/AN1qAVTj8bWh
	 doRm23Ir6z5YVaZ+u1xnOeTDSNnCwrPsRzLo+pi6/NHiU9AkHQ6rvPGwhE65RuwSypKyC
	 51rxs39L/Hk/ixkrOpcXVrfp/jtI98BiP7wZttqfZUaKd2jAQFPPTXZHPxNJwckcxwJuW
	 RVzyPbBFrfJykI3J2Wn/f/Wt/NkaHG06Ia+2zsszvc3fh/zyIwJaFqddwT5DrWh6/cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
	b=Q2S99xBzqdQe2+ZpW7Iwq4RSNl8De5NNentxCJgdy17TutvR7vEJmW54dCURN8wyM9gb
	 wwT+vyiBitgtDW4AwOXR6vznWhNGVXya8j9UBUdNV7OmbrZWWpyTUIFHPSbDXyaU/PgNd
	 RnrJYPmJiV4FQODQ+BT1I31UiqpM139yTOgWz7XqVD8TLHhY6wubejWtI/tevgXUhE7Dk
	 K6JxhZjS0goKkY40Hwb4IO4PqqyllGZY4+JNbisiqnff4U8UV1NkZrmBSlbu4d+pvqOAU
	 rq4QQLu22KFjjeg+nOj2quWwxWpEoOseHEbOBIe7eKz5MzRRimsEgw2/gsry9C0Vp+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YGUDwrm4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC432606A327
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2026 21:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC432606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=YGUDwrm4
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c414e5d282eso419085766b.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 13:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793654902; cv=none;
        d=google.com; s=arc-20260327;
        b=lWR/ct+RH1o4TzdxoBxH3ohiIK9UZYFYwRX/KC/jdFm2scKiY+EOSdrp+nycRd5LAG
         s5Sga/SljmjDqNIAi8WvwtpQxVUBBTWDdMv+8fEErRyRzx8LRYP69PNx4MDtkesFzYI0
         LUqJf0uC/firDciXKtR5/wrpNrtafLpS8SEZUKC9JsbIYZM0NpNJW34OwPaAobwFG29V
         7suDHDSOt4Lgy4DZCT5BfIc/h851uArt5UhRblCetg3boENaZJHrWaHY0rUK0C1nhEZ1
         1AF1qjyMbTtEBZl5sozl8p9EvzY4CC0ZAA+/cyYDCuZbckDlpCTDZLM7zZk1XS37eKKO
         xVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
        fh=EmMtUIftyl14wDwXe8y6/H1rzIWd3VZmViaYLT5k/lk=;
        b=nMrWmZIidhKv9PS73QUSCk58xyEaxSplYZd8tHZrQbOiyZg5yW2A67UR5Kq+B9DV+F
         kzFooRqAY/Dz55Mt4wv12kNIZce56soVgmB09//knwTayRMGiVB356tETOI9iqEX3cJn
         Yh37avA9eUkRFonP2OMknvX2/XS/LRFyDiDlu+oHwA1F8/HwGU88tsfkHaQZge22M/Ub
         o/mbOAvW4RkCWXJSbSGVk4XNg/Uo4DfkUIns933cVmhP1WmPD9TpAKoCUTdMcfnrNpmi
         vo+51DTsosIbC0vXdr9rF0PCPpnG0DVyZheFtDtuAkSD+4/VJ4pPJslkveBcURApzFDe
         UmvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1793654902; x=1794259702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
        b=YGUDwrm4caqQiyVq1i9Nlg7kypsuHhbEdhFqMYOUXfQ4x4ZCwo+SK1/z2fXrUSo4v6
         iIeLT6Tdc1RQlZWPp3vjNV3k7EPIqX2I5e6U7zE9RtNU9XaNw/SOb2DwNtGXNeYZ8a3W
         JTtzEldhuLQ4GjgXnRM3VuxEhfU3BodEo6iiLA5ImTPflK0PyO6zvI/wBjlasONFZ2YM
         JyFHbbMNWO0sG8Re7Jvy6tuJMdhQ+Zp4EVh6L16IAPlda2f8OBZCqbZizkfFBuQi9rLP
         VmIK5OT0/sxP80xZ+bmbBhXYsos01PTS55mJaPdOl+QxZegxioZVbEq65g9svGPs3k/w
         WPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654902; x=1794259702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37I37kxjnkpufv60nnFSmrcC2M8I5JiI7AMLkywezlY=;
        b=gSZjGaFO1/IvniuqzlI/8nc4aOc0s41iBkXqsjchlo36t2wncbgkAQ9i/hjzJLaLoz
         FM1tB4u39Nw1HRSHR+KsgpTy9FbsiKquTqlBeqvVBPkAP2f/bfc2qJ67O3B9ruH0RhjT
         P5P4RVrTYqzK8F5ZnKsdGUetjph9jPnS8za9vsuWjgGEbNl6Z0dleWuxggwJD4j/ZkkH
         JxV60G9CrLBRH5/vJ74ukJUn8vcih/rkOxTX2pQe4aS9CCLV43HnYUpGTvhLtBjYceoj
         MLnOtFYRJu3bp8mtxCZr7cHfVTt8g7gjyHLZvrgGwUm255hNHLgz35lsUx/DL9kcSW47
         OW3w==
X-Forwarded-Encrypted: i=1; AKwUvBxQ7zfFlSz0IDNHjzS4LYIGAbqwFA9wlMZCpWGVnjJSM0RE/gvYV5ykUgWNj3ONyo3t5QHvP0YT3lr+@vger.kernel.org
X-Gm-Message-State: APuU4Z83tS7gYcwW3+W7txy1WDTEUwNFYEuO2hlwpfOdd5GLX1SxJvvl
	DJBLei7l+fbbNk7j0+Sho9LdTuNVzT9x7D/flWtO1hN/qS8Gvx0geGdTK+HFY0gfZ6R48RCRJfM
	AJycofnAV7ehw31HLvdw+KM0Y6lBBCxJlUp1I2t3VBQ==
X-Gm-Gg: AYBFou2mK/jU8OZJABa54suR4dIdHruJ6Z/FJRv9WrtZj1uYy8S1c/eN6Z0jXAnvPOK
	2VUXPIPIox6Vs0on2E5MKkAmaaC0k8eMDsW/+giUitQL2rrxejx/g2GecWx/7aOYBfYG5axzP2B
	+Fn16eAdWA5QPyzmE0Z5ubGQFCCcnFuZkps18cA61agFbiQF8vejdMjTczi64J5zhV6RPkFeHhh
	Ab18hSYfqG8mfEApnvzXuYfZi/BE9OeA5DZOztYQihF6YoBpimFoGBZaKrZpZ+pYoEVcho2U/+T
	ZgJJXa1gXxa0AZdt6CDKO/VTShCkmJ+NMy+4/94aildVJb/6j8jO/uAc+d5kY18lgEQfuQGCVHo
	AAPGvFfVG4TWTS4BlH3hZ3CNOYcG2v0kYgFxTLzOjKSUKocPRr7Zw7m3ttqjhCTFDYmXcOZpp33
	cvuhnMGbI1R20=
X-Received: by 2002:a17:906:99c9:b0:c2d:c247:5400 with SMTP id
 a640c23a62f3a-c4ca7b405c5mr892947966b.27.1793654902069; Mon, 02 Nov 2026
 13:28:22 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902124026.1774575-1-max.kellermann@ionos.com>
 <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com> <CAOi1vP-yKSeBwA=269uACaXmmfX+Bpjwk_x_uJNOtRtohH=ybQ@mail.gmail.com>
In-Reply-To: <CAOi1vP-yKSeBwA=269uACaXmmfX+Bpjwk_x_uJNOtRtohH=ybQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 2 Nov 2026 22:28:09 +0100
X-Gm-Features: AclHuK8Fp7ROZ027fzJ_D30OkjRV4Gj_9sSayx7R-Ne65Fcxlkky1UZTTEAAqpQ
Message-ID: <CAKPOu+9=4MUMvZt80T+Kxt_+B3MEpWUTZRnW=LJShBJyNTw79Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: acquire caps for read_folio requests without an rw context
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubo.li@clyso.com>, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:01=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Did you get a chance to follow up on Xiubo's comments?  Particularly on
> whether the data corruption aspect is indeed gone with EROFS switching
> away from read_mapping_folio() in the upcoming release:

No, I didn't take the time to verify Xiubo's reply, and since this
data corruption bug never occurred again with my fix (and I had
stopped submitting Ceph kclient patches), I had no urgent reason to
revisit it.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
