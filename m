Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE4367F4D
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751402; cv=none; b=ctikLdwZU+p4HjGrUFVdYit+uKJwMCJ1UUtGLFWackbGwwKhpaZH8qBevZrNlJbmexwbQEfpZPnBe8/63SeJoewBXnHU9l+qaZ9Uce4gfmNdY25Dxj9NpIOYwNokHSBEq5mJe3wUz+t253XyWtm5gNxzpLw7V42vFjBBltSCNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751402; c=relaxed/simple;
	bh=KsIVvTEaUvQaCGI+MeAEGa3cwY5ez/ijItn1gy5rZKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUYa1lG65M7ew45FRaQ3zT5gFJ+51fKipFLFhgEaj0yCPVB94u2I+QVr7kyluDCP06CTjTDJeEjAGGB+42WLv/lS9880lV4D3jnOj1t6DBxbqTZzRy7oeCJUL/RoBo4euw6CB+9y0zXoc0fXL1zctt1Te+e7pXQs0wr6UQW8ac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=HpfELuNy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="HpfELuNy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-806449d108aso42938627b3.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782751400; x=1783356200; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PjuWyJs97/n/AoKyfHoFO4Rl7Pl5Ihp64h84qoFLOME=;
        b=HpfELuNy/ni/GW8/ezPPXTCr8ca2KydHb7sZxMrvJfJGCZ/sfZ9RbsWYiIK6ykbCtT
         aij3lPdOvfVXUBQ3ubNdZDwbQzfYfrR4byuVWxxBDl2SXv5FUvBJGNoKRF/10vCjRw/G
         GUP2wawcLIxDsPjzjm6Ar/JOIKYnHMETWFBSbQHGljntBPWTltghSe5+Hml2/7df1Kf5
         s7mqQdR4+fyGd+/aZfN5emuUcrXcXO1tvqwt+hYlD6cY1AsHmZuvt3mNX5EZKMK4i6r7
         apoT+3Tx1GGtLCPGQQsjpxe6kR6mdCSWxw9R9xziCQVndzMYsCcj+sR62nfnF8F/KQHC
         xqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751400; x=1783356200;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjuWyJs97/n/AoKyfHoFO4Rl7Pl5Ihp64h84qoFLOME=;
        b=AYMRqtCtoFqpMsa6Ym6PMhO1HlvECt3DRuxS3ZqyN2wOmahlc6KR2wKRE3P9NACDLh
         fYkLsypZlgVUacvQHe93305u+RoVUz6IID4wU1QuroBVwjvvYnV4oxrBEYkAGjnrcTYr
         PeNfA8KOgU1A+MUiPHjJ5jLukHi3In1Wv9ouZ6GZYBjxbiuuzg6t3ncwDDeohLmt9mvY
         hyc5RSmGgA0ukPkWTsLvurH1v7yxvYyexeM9aznv9yfvKB32JPtJ0v9FUiesvdRKi8l5
         l10939pp4WVcH9ODA6gteMuXVZYFDHdwY2VMd6EmeKOBkiHrFDMJsAlHR3KLHk5kVgDV
         Giyg==
X-Gm-Message-State: AOJu0Yzu4hgeg8WQBt1VM6jkfvZFi1y4FfCTiUDYM9+g/px+vojR3n72
	SJgwoP7zDvtYbgy94eOBRXSNPJyE2rCB9A1N1iAwWrRfyTgJ2nohV7XNtI1rrZKaTFHWRYybZba
	q8eIYveI=
X-Gm-Gg: AfdE7cn+BOfBF7rEWhWpUHjKeIxgYB88ycaUCRQRcTrCQP12GoFYTGdhjezAsMvH7bc
	xnuTapNtxa/cAqxHYea0H9K7318k7P7y7HkN+FGGQIQZhXq0a+dy0dBNgKxY1iv88/V1kudDX17
	cRRgjguGTil++F6J8NIZhmtq/DdOlxYDBG+0zdw+7s5JovMSRiNI2wsgL2enX2e8XWTN3p0Njpp
	ZHM8f86+bKxA2YCSaTZviftPMweaqyWTvX6DGFjOS5/VIBr6JJcmnu0bMiRa4jTF0Ycyv0MDKkC
	o8wXbjtbKPGUGabFXhrdBP3pxkfMbyQF+NRou4KbonDv9ueIufLfM82sVi49TmBfxbYRj6dVzRW
	bGR32hJSZRIgZ4jTDgghryHhR8VLdLSvubOAIFIgJJ2OHPaF/lHgcAVe8mCj1RzE1xiwd3tH19t
	S6/oNSloFYWj6xBo/f9PT3nkT4yBYfXvzawucXEFYnJp88YbOKOyRwdbBQIuOvXueh1TW5ULZZx
	oaWhF8FkUWQ4t59F83/cBYydf9U3lt4/2XQhvSUSz+vGcHgOyd5ZT249vIyS/+lWGPLg5Fy0f0X
	L2+mNDg=
X-Received: by 2002:a05:690c:f0e:b0:7f8:7e02:248 with SMTP id 00721157ae682-810da20c9camr3073357b3.48.1782751399495;
        Mon, 29 Jun 2026 09:43:19 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e787db96sm218267b3.12.2026.06.29.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:43:19 -0700 (PDT)
Message-ID: <d3f84eaf1a45e3f6a4852504222ed909928d1332.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Always remove requests from
 ceph_osdc_handle_map() structures
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:43:17 -0700
In-Reply-To: <76f6bf19173ad8b5af3c0a86e21ef8014fbac542.camel@dubeyko.com>
References: <34799e8f-a24d-4967-beb6-4b7f51c3efc5@tu-ilmenau.de>
		 <20260617131344.2325324-1-raphael.zimmer@tu-ilmenau.de>
	 <76f6bf19173ad8b5af3c0a86e21ef8014fbac542.camel@dubeyko.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-29 at 09:12 -0700, Viacheslav Dubeyko wrote:
> CC: ceph-devel@vger.kernel.org
>=20
> On Wed, 2026-06-17 at 15:13 +0200, Raphael Zimmer wrote:
> > ceph_osdc_handle_map() creates two local stack variables that track
> > (linger) requests that need to be resent. For requests, this is an
> > rb_root, and for linger requests, a list_head. Subsequently,
> > handle_one_map() is called, which calls scan_requests() for each
> > osd.
> > In scan_requests, the new target is calculated for each (linger)
> > request, and, in case of CALC_TARGET_NEED_RESEND, they are inserted
> > into
> > the previously created list/rbtree. All requests in these
> > structures
> > are
> > kicked off to their new target osd after processing all osdmaps. If
> > an
> > error occurs during processing, e.g., because an osdmap is
> > corrupted,
> > ceph_osdc_handle_map() jumps to the bad label and doesn't call
> > kick_requests(). Therefore, the (linger) requests are still
> > inserted
> > in
> > the list/rbtree, which now doesn't have a head/root anymore. This
> > results in requests containing invalid pointers to stack memory.
> > Subsequently, this can have multiple effects, ranging from not
> > being
> > able to insert linger requests again because they still have prev
> > and
> > next pointers or triggering a BUG_ON() assertion when trying to
> > insert a
> > non-empty rb_node again, to overwriting stack memory.
> >=20
> > This patch fixes the issue by making sure all (linger) requests are
> > removed from the list/rbtree in case the osdmap processing returns
> > an
> > error. This is accomplished by adding logic that is executed after
> > a
> > jump to the bad label performing the removal similar to
> > kick_requests.
> >=20
> > Fixes: 5aea3dcd5021 ("libceph: a major OSD client update")
> > Fixes: 922dab613417 ("libceph, rbd: ceph_osd_linger_request,
> > watch/notify v2")
> > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > ---
> > =C2=A0net/ceph/osd_client.c | 21 +++++++++++++++++++++
> > =C2=A01 file changed, 21 insertions(+)
> >=20
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 5fc79c29aab0..a4d3cbfd27a3 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -4129,6 +4129,26 @@ static void kick_requests(struct
> > ceph_osd_client *osdc,
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +static void clear_resend_requests(struct ceph_osd_client *osdc,

This function is small enough. So, we can declare the function as
static inline.

As far as I can see, osdc parameter hasn't been used in function at
all. I assume that it is not necessary.

> > +				=C2=A0 struct rb_root *need_resend,
> > +				=C2=A0 struct list_head
> > *need_resend_linger)
> > +{
> > +	struct ceph_osd_linger_request *lreq, *nlreq;
> > +	struct rb_node *n;
> > +
> > +	for (n =3D rb_first(need_resend); n; ) {

This for() declaration looks really weird. I think you need to
implement something like this:

n =3D rb_first(need_resend);

while (n) {
    <execute logic>
};

> > +		struct ceph_osd_request *req =3D
> > +		=C2=A0=C2=A0=C2=A0 rb_entry(n, struct ceph_osd_request, r_node);

I think you need to move the struct ceph_osd_request *req into
declaration section, then you will be able to have assignment on one
line:

req =3D rb_entry(n, struct ceph_osd_request, r_node);

> > +
> > +		n =3D rb_next(n);
> > +		erase_request(need_resend, req);

The erase_request() has BUG_ON() for empty node:

BUG_ON(RB_EMPTY_NODE(&t->r_node));

Are we sure that we will have not empty node always?

I think that we need to call the erase_request() at first and, then, to
call the rb_next(). It sounds more reasonable for my taste.

I am guessing... Should we re-link these requests to osdc->homeless_osd
so they can be retried? These requests are orphaned and it will be
never resent. It sounds like any waiters will hang until timeout.

Thanks,
Slava.

> > +	}
> > +
> > +	list_for_each_entry_safe(lreq, nlreq, need_resend_linger,
> > scan_item) {
> > +		list_del_init(&lreq->scan_item);
> > +	}
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * Process updated osd map.
> > =C2=A0 *
> > @@ -4243,6 +4263,7 @@ void ceph_osdc_handle_map(struct
> > ceph_osd_client *osdc, struct ceph_msg *msg)
> > =C2=A0bad:
> > =C2=A0	pr_err("osdc handle_map corrupt msg\n");
> > =C2=A0	ceph_msg_dump(msg);
> > +	clear_resend_requests(osdc, &need_resend,
> > &need_resend_linger);
> > =C2=A0	up_write(&osdc->lock);
> > =C2=A0}
> > =C2=A0
