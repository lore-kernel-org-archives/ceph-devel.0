Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A9426D1E
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749557; cv=none; b=uOwZYiWpYzWR0FH01JWDCcJdswyIz8BipX49f51PDFDoNaDsFjhrNzUVln9r67j6cK9AORdGc6FU7NzMRBrMJrUxehDW3x7bRapIE/qYfgf7EKYrYZqZTSFDMk7oF5pz7b6TmZUfYx9gOEn58oDYu2ZIhmBYPjxNrbs6upbpYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749557; c=relaxed/simple;
	bh=2JQCdq4ZBfE/MsZ5SQd/dztXjeAmi5P19dVBS6GPqdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoqBMF2tDufv54IPNDk4n83B/fB1ZfH3YMSEkk3WaG++aLwXpwZITaNXeRAu66HJP3SX2F5TohPD5NmAHw/x21WVvxI5H/2+P1wBmFjy7w0af6zIhy60ykI4Bur41wEOTbcLMdRPZSFUZ4X2PcFf+TVRoJvQEee3QOo7QVGlI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=hGfi4PcQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="hGfi4PcQ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-804e46366d7so28988797b3.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782749555; x=1783354355; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O7ofpsV4Hpx4PY55vgluzRwAeB9VFCQWXdXErlMDcIY=;
        b=hGfi4PcQy5vHXpJKT/zUFnq1SEbeLX17M6QrOZeWwRMIoXXQwla+sGSonOgNyq9iC6
         WBA2JKQHtpcizqJ/ownCQwYWg9RPR+d4xOXEJRiVQWlh6vRsrEkf0/BHtHv3b0Jlb20f
         5CJyazab3fgKvqTVgFzrIGeHAw/TyhJ7PslXWY8Bq708GnHZVdokLyM3BiGAcdLaTSla
         FMt6812FtZYRja0OOYfcoVy7WXhYLoeb/NpS0vVHnQgE56IEKKFBMpQIXkx2dHiOgJaK
         38JNiVZ1aH1eVertJfhg0MJnN29EOeK+C8skfOH/HM7f4ggmKMzU6NYD2pHOJ5sqv1NG
         F5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749555; x=1783354355;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7ofpsV4Hpx4PY55vgluzRwAeB9VFCQWXdXErlMDcIY=;
        b=dvob/eGhN/wnh2zdcg0FBDs0OSUbTxXwB6rZfv9UjAOQ468kCf5DUHWAkjNxx0T6wv
         izAGsRAEhUw/OKqy+mXyHkNEbHfXo53kj9Rz9lPkeGAjHAt8/wGDTOUylJESBEzb/VIV
         INDQ0d9lui7JOp1VCd8OWZJln4XDv5KpgBcg/t5gO9drR3b/j4KEuaXNs/3Y3j7DPss8
         t06raJ1MKBbZQbZxkV0q0zCoRtG3GbOrEmilVQ84pcA+rK/+/FAOBzUVzoVdspy1xyco
         gNJndp9agFS4w4jkn3A4SZ3cjasmhCuJ8jLnIYzEwq2SzD7OiBWjbpGoYJQvF290WOsi
         HVKQ==
X-Gm-Message-State: AOJu0YwftdLiYxviUxa4xAGzaSrIwPo2nifnqXj7p3goo2NgCeywRlHT
	XIzXKT+ic7NBcGtCsTKqfc6qYeDXPggo37WFVZz/w6lWMP0dUjyGCEWwJBcayn1DNmkr9ITBB4L
	xWsh4ELg=
X-Gm-Gg: AfdE7cmkBrhJeVnk6TYqgbSe/jbDP4MUf8FpDLpbTWXFZ+q+PzuK40vj+pRfuQFlEAe
	kW1xAb8pHIVpGFZP8yhovIX12x6F3cN7UwmiRh2xny91cSv9ldW+cordbucxPx0F9cJsZi3Owpx
	ovzS/wrJnpzvzZ0kp+hqhJizj88yE+DqSVXEaJcN86ja9v6FlkJiA3rFIHBCpuADjSxAUwZHhx9
	G5LuQGIen/+Bfvxh0Bd6eiUYhdcXc9rsUiDooPekkEEeThSgVQeujqTDgX0ineZLtBeVHfWjf1H
	rzirct+ys+P5SkC16Rj55G7HMNeeoFan9J3qvqR5c4oLKy2N0v6on1DaDR2QxRVHspVFZgh2DPN
	ZBGX+V2a64Cxn9379LwAj1xwKnWDAHqmKDMns7qN7M0AMBQCWAUPca979IfokTjkyflNMMVpadV
	KT+l4foydElUN1bDcPNO5AKMvG9RNt6YxHfLCY/cqGQHId9jMU0Wur6RPTc2lBCMOBS9TG683Uh
	fWMiCvy3HkTtFFVZqZYDeiWRWegzFaj4Fadm3X3zAtV1Mm7orxIZK3DVbWZhXgU1SlCBVafrhur
	yi8+SvY=
X-Received: by 2002:a05:690c:4c09:b0:80c:39:1d84 with SMTP id 00721157ae682-810d7ca71e8mr2260977b3.1.1782749555589;
        Mon, 29 Jun 2026 09:12:35 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8096af28592sm65100167b3.22.2026.06.29.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:12:34 -0700 (PDT)
Message-ID: <76f6bf19173ad8b5af3c0a86e21ef8014fbac542.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Always remove requests from
 ceph_osdc_handle_map() structures
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:12:33 -0700
In-Reply-To: <20260617131344.2325324-1-raphael.zimmer@tu-ilmenau.de>
References: <34799e8f-a24d-4967-beb6-4b7f51c3efc5@tu-ilmenau.de>
	 <20260617131344.2325324-1-raphael.zimmer@tu-ilmenau.de>
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

CC: ceph-devel@vger.kernel.org

On Wed, 2026-06-17 at 15:13 +0200, Raphael Zimmer wrote:
> ceph_osdc_handle_map() creates two local stack variables that track
> (linger) requests that need to be resent. For requests, this is an
> rb_root, and for linger requests, a list_head. Subsequently,
> handle_one_map() is called, which calls scan_requests() for each osd.
> In scan_requests, the new target is calculated for each (linger)
> request, and, in case of CALC_TARGET_NEED_RESEND, they are inserted
> into
> the previously created list/rbtree. All requests in these structures
> are
> kicked off to their new target osd after processing all osdmaps. If
> an
> error occurs during processing, e.g., because an osdmap is corrupted,
> ceph_osdc_handle_map() jumps to the bad label and doesn't call
> kick_requests(). Therefore, the (linger) requests are still inserted
> in
> the list/rbtree, which now doesn't have a head/root anymore. This
> results in requests containing invalid pointers to stack memory.
> Subsequently, this can have multiple effects, ranging from not being
> able to insert linger requests again because they still have prev and
> next pointers or triggering a BUG_ON() assertion when trying to
> insert a
> non-empty rb_node again, to overwriting stack memory.
>=20
> This patch fixes the issue by making sure all (linger) requests are
> removed from the list/rbtree in case the osdmap processing returns an
> error. This is accomplished by adding logic that is executed after a
> jump to the bad label performing the removal similar to
> kick_requests.
>=20
> Fixes: 5aea3dcd5021 ("libceph: a major OSD client update")
> Fixes: 922dab613417 ("libceph, rbd: ceph_osd_linger_request,
> watch/notify v2")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osd_client.c | 21 +++++++++++++++++++++
> =C2=A01 file changed, 21 insertions(+)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5fc79c29aab0..a4d3cbfd27a3 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4129,6 +4129,26 @@ static void kick_requests(struct
> ceph_osd_client *osdc,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static void clear_resend_requests(struct ceph_osd_client *osdc,
> +				=C2=A0 struct rb_root *need_resend,
> +				=C2=A0 struct list_head
> *need_resend_linger)
> +{
> +	struct ceph_osd_linger_request *lreq, *nlreq;
> +	struct rb_node *n;
> +
> +	for (n =3D rb_first(need_resend); n; ) {
> +		struct ceph_osd_request *req =3D
> +		=C2=A0=C2=A0=C2=A0 rb_entry(n, struct ceph_osd_request, r_node);
> +
> +		n =3D rb_next(n);
> +		erase_request(need_resend, req);
> +	}
> +
> +	list_for_each_entry_safe(lreq, nlreq, need_resend_linger,
> scan_item) {
> +		list_del_init(&lreq->scan_item);
> +	}
> +}
> +
> =C2=A0/*
> =C2=A0 * Process updated osd map.
> =C2=A0 *
> @@ -4243,6 +4263,7 @@ void ceph_osdc_handle_map(struct
> ceph_osd_client *osdc, struct ceph_msg *msg)
> =C2=A0bad:
> =C2=A0	pr_err("osdc handle_map corrupt msg\n");
> =C2=A0	ceph_msg_dump(msg);
> +	clear_resend_requests(osdc, &need_resend,
> &need_resend_linger);
> =C2=A0	up_write(&osdc->lock);
> =C2=A0}
> =C2=A0
