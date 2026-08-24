Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F9439F86
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586000; cv=pass; b=UlwHwzoRQJZBa6URUCHAqLsBZ99QqORLwy7dlZValGYmAWCdQC2DXkpUsAS6LTtD2uft3PLG0tgg7tXiCXHxoF5I+b3vA5ccOwO3vcHvJ32+Wg4ljRkJ9BmVmTgRFY+45X+dNxVlFujy+kxDcCCF7TESw+1bSU8T7ls/VmtVayc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586000; c=relaxed/simple;
	bh=TKa+7Rt0HMct/L3Y9OQKcWqR+kqwOl5wJxjs0oMkUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWxr0g7aPnJa7eStHAvJVJmXoX1jwIdWYC8zVH+O/xjPLVTybRaeymtiL8RpwbKGmUv2+taB8xeeW2qvqvwBymnDGy+wPh1bUPmbax9Qb+H78/rxbFkiKLeFV5S9n6NgBkLNSrITlGtTLKw4irMzpI5zSxd7ekaJwU+v7RXtPow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3PgV/+u; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3PgV/+u"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so6893279a12.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585997; cv=none;
        d=google.com; s=arc-20260327;
        b=sMwMPUm4RngEADalp0heqL6OSbj6Nc4rwjMqyD3jxqR7/wq5y96c/DM18zmsv8Gwwj
         m4R4A1XaV86WpGbbCE4hO4xonhJOQS65tQaHqVaJyEFYMmwd45lX6Iz2zI4QGbbNMTjC
         hjC8InyYRxEvYv16BqTknMsAe6EUgPNytZTNj1MmBnWR3d9Oxeh1N/g4QeYum2XTOJ2b
         81GOkbuMS3pITz0gDI094EpChxf0I7f6zETA7QpodIPjD71S4W0LFcND9pnYuzqfQ8v/
         /4yq7wVZuRhjYyO8cPV1rGOMldO5HaYPOKPoqLVjgX/rQemTacQzg2xbFWgykNLr4gue
         z47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        fh=sc1rZHHU8jdzB0W0OAxZa+H3ZQzSV9l5V0znARIcdDA=;
        b=JrNn6XWRbXpdJ2i6+c1ef1KrEOhrUjcBg/NWobufa3lDfo1Xy8ly1hDaWXLm2bg6vw
         6oi4N7U8lsSsiFt+tKYgXzRzoUvwe5Ruku/xuAv2GKFa+SgMoN1nS/63SJGI6yIvcB1X
         VcB2SD+8OzGIxYmwGW/Wt7ufYnJo8ENYTFUdWWPm2zdLFMSEMK7PYTXE+2MH7FarmTtL
         /PwaBa5EcaL6UqkwNeehymN7CpwGUP7TxL9H8nbB+i0ERWre4MeI9UHMFGOkv9jo6DIw
         S/vrL7BcJ2Igv0ZVs9vT0gEaATNfHw1YqR+zPBz05vGhDQkOkCAh4/Jo9naVf2+l+Pxu
         XKlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585997; x=1788190797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=W3PgV/+uOfQUz8pF76YCRrs84UlPEQPXY6HtwG0yI1HdTUh2ba/YB+1YJpUAS8XdXn
         Nx3XJL9Oc00PyQABJxkNHFOgjCSoI/xWe345bzxJ/b+/kz+4kSbygw7HCiQgxjGaaY4w
         sghmbsvrUQl3pnPyXdGdA9OZQnrQ3Opb24oUwzcYrUtP9FEkKTZuwypkY5AjwFbFS7XO
         yXa9rXb/qmJZWLA0UVIlNsn2+ODVi/ShtKx/zqYe1EQzakHcxF5auvyTFihZJF/CcTTj
         7uN/TKfLsHjfnw2WMoiN/6eXZExCjtCWKoYymHKhPSIbWZYRwFyYcpRQTDjzw//We5Rb
         2vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585997; x=1788190797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJCHcWH/H7HoSqeQAsfWyCv2ylIhs9AEwOmpHAgZ6Mo=;
        b=IEntpfbuNuBzRwjiBCgnzAV0KfirlTuH2wVi2hnwcyWMLlUHsDUO99kchQDpUt5JL3
         F+WpGi4HhxIn5GnAf1dcg80NvPvuP2aLUlKka6+FXDJNDmWvkQsiKcxqW5Cxh1aT7DcC
         W3ZkKhG8X6Wqc4TCyMo9u3ImuOntUNzmg/yLZFhW9gEmw/2Utw3Q/gFvkUrCUzTIkALh
         70tnyoWeHGbl6BahB7vkqYOurwJzJXaPG1BFO5fhh+k2udcdY+ufMA6dbvpDQXj2g+6W
         lXqSxssLLe1wq0kEkHRUYL8M2vBfWyGr2RdBvSRccs3HDEp+cgxSBzd8PMfB+nHiz1oq
         osOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrS48p3+BcoXi0hFwqNreUOFPAWgbkz3Ee5ddZDKhRvUxOYVrYC9bVwp5VkytWOxkEnKvEMEswCOBzS@vger.kernel.org
X-Gm-Message-State: AFuF++kmuQoFmnYTc95cF1DPEfjguCyI58rpzABrVzwW/sjNcD2UCl5O
	yoOMSRLlBb9Jlluu4i6J2+IWcv+52a8l6Sa3lcyjj40sLb9kRpa8/KeXFfeBheHhwrObb95vqlh
	cMH0Nrh06W89wDuR6VAGPRzdBsM1Cmd4=
X-Gm-Gg: AR+sD12l5z/F9rHT9bTh5maGwsAONL9sGd0BHGFjjACJkwAGCyCmJRakZn//+bERQw5
	gTMU/X0MPXGZV2j2dOzAQ9TuI/z1zUHATDzSTFdVER6f4sntopCLXtx2TsU+HLTYLZfKd9K/A5q
	A++ISqO1GnpUxTYwYsNWUQavI15T2bL3EJwCWUX+FG7crxpuzo03WjHy0SIeYp5V4djI6T/f+nX
	035j4KkpHGsurXX0t2DhISSBP2t7pQijFJC4EcpaoE1FtU9BDEe0nL2dFt4YXZa6NXAZAn6547/
	60QB5XAP9acTdA8CYObIBnwQaiIKF4z96OgikQIchUfV/iLMKAQ5+nuuN7qARViet2MUTYP1kIp
	y
X-Received: by 2002:a05:6402:1ecb:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a42eec0421mr29612154a12.0.1787585996720; Mon, 24 Aug 2026
 08:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824144130.759997-1-dhowells@redhat.com> <20260824144130.759997-31-dhowells@redhat.com>
In-Reply-To: <20260824144130.759997-31-dhowells@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 24 Aug 2026 17:39:20 +0200
X-Gm-Features: AcwNN1UVhOm3jvQyZ6QNY0YG-DuDugP0zSGCGTU-9BV_0e1-yGju4sTdJrlUq5g
Message-ID: <CA+1jF5qPZUhCevwbu7zQDEVWss6gMdoDMhqKqH3k7v=WStRtEA@mail.gmail.com>
Subject: READ_PLUS in NetFS? Re: [PATCH v10 30/35] netfs: Simplify read abandonment
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <christian@brauner.io>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Leon Romanovsky <leon@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ceph-devel@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:04=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Currently, if one or more of the subrequests in a read request fails, the
> read collection algorithm will attempt to salvage folios that are fully
> downloaded but that span multiple subreqs, provided all of the contributo=
ry
> subreqs succeeded, but this makes the algorithm quite complicated as a
> subreq can contribute to multiple folios and a folio can be contributed t=
o
> by multiple subreqs.
>
> Simplify this by just abandoning the rest of a read request once a
> permanently failed subreq is hit.  This is what read_folio, DIO/unbuffere=
d
> read, gap filling, RMW and write preload all need to do; readahead is the
> odd one out as it doesn't have any return other than unlocking folios.
>
> With this change, even for readahead, the rest of the read is simply
> abandoned; read() and suchlike will call ->read_folio() on each
> non-uptodate folio to retry and retrieve the error.
>
> Note that retryable failures still get retried by netfslib as part of the
> request as before.

What about READ_PLUS, i.e. sparse file reads? If you do this kind of
work of handling partial abandonment, can such a work also benefit
READ_PLUS?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast
