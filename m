Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FB336EC2
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597651; cv=pass; b=kvd78/G8vH+uiAeuy/1+0aMuA0AlpSzWG3oO/CdibCMC/v2yiKbsy4m8n45ODuShIZM8ZvoIgJ3gw5gD+IrksBklD2zyHxx+hlGkN0o3VG6DTIrVVC/O8118cXoZTPCxuYvqAj/VAmVQl1lCdaYvVqQcS1yReDiFlJ5nOKcRpzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597651; c=relaxed/simple;
	bh=+i/QvqiNf1SgnIt1SO4Aohco9SwuioLlCwN42QKAE9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2QTA7NsBI5T8hvxqteldGM7IeAQrDp0K69BoZzI6vmUkMTvHSuKhYLskZ9kzXN8Zj9hnnE2KxslUxE9xwUwHaq64bK5h4UDqAHm+E4OtDh9vtcSdR5U2RKKQ5vrcahbhlpMFOjvYcze0pWuqF4zpkZetQyRI4a6z0oQsXJKHis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNnKyuK0; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNnKyuK0"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12336c0a8b6so2329640c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 02:54:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769597649; cv=none;
        d=google.com; s=arc-20240605;
        b=SSt+H+Wa4GY3S5MisUYMYxmHIUx99qdgFZG4aGv6+Q/BlijjiiBd+Li6efyuDKrZaK
         sRczcri5X4v7Ss9TbscSpHCSrE1WJ94xnEmkYPA82EsnfEh6XTiOW/Wt79pJDr7+Rbfc
         t7kf1XGGopC/xAfltqKcvid0ZZ95tJLBo5DkrMyiS3rBPVDW9U4ybtZVGANfeBO3Fqhw
         oTa1mxcvF4gCzjri6+0SiBHN/nKwd9gyxix7OFavgW0p5Ja+eKFs63f29g+fTxsev5WV
         9o6o9mPvYES04ph/pfRMNIOVBHtn6+InDqK/YIZRpIuGllM2SI0sCF709L/j2Na6O1Lw
         yeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2p5whNgg7Wi8/XagA899J06zyXCnxO8sVAOOz9pC00=;
        fh=qRHVn4YWLV5ka8wlyBXVswyhP5ChimidqL60uAjCDMQ=;
        b=BMwlCH7M79rFk3sholzR7TuvOWw/2T3bHpUR9o1ri7+x+Vua0AH32YU9PuV/jQUuWb
         3FnyduaS/w2othZFkpMlQFVnfBEuJW7TzRWvmjrzBywq5cmMxbSIcWNIkMSj0jZpU3b+
         0xKdI4QApgK+p7q0nClG9NffJhsEk6Qt9NCsOs9Rj2bs5Q8/DNdO1WQMM29m69jrSYjq
         ySkTx9X4fWFQg0nQFfln1aFns6rCaULsvFabtQyo/PWECBbwE/MVgpJq/Tth1EbLuIbM
         AAwne0DbLqJbKZcp8dw6oUy5KmmJuV16kOBrXqKqrw8t0KfwU1+gFTwOetZvY9osyDd7
         w3mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769597649; x=1770202449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2p5whNgg7Wi8/XagA899J06zyXCnxO8sVAOOz9pC00=;
        b=WNnKyuK0yzkqUM20zStUzM/Hkk2ZVSvkSrsfw7ZHgA5E2+lcekQy9uy4Wk8JH9RyUG
         O85UoQ/b+q21BAVgfbFVIWgfIstabv7XlqffEQxXYVxJLENftt1zqQn5kuO5kqp7X0oo
         oWxVBvQFxnuoNL6LrZ+MgnQ+z55PI9QR0LNbR7xo66PogGYHSFbooyWGMltel1k4KrDX
         WSFyFQHlsBczLZmwCzOwsgCpIrNsW/pGXBBsRKOmIuUlY5bnkg/5K0kbMgnauinuqrYx
         UofvhTfaObuoan+dWF89AeN1XCMAGVXBpmjCwGMYHuuJdFXu/+qfvpfMDqQCkmM+QqpB
         wopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597649; x=1770202449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2p5whNgg7Wi8/XagA899J06zyXCnxO8sVAOOz9pC00=;
        b=e/xFJroNZtbxMujCVz/MucLm9TwXBeq9rGEey92GEv/me+KfLomAtrOzLtWTpUTJoj
         yAONLSIHvgPsQjVdfxrHMZn6LfX0XDGm6JnpWm059DkGREWGEvC5i5tdDlJkPdlz2NLv
         bcq3Vp4ZrBOiv2Dn4sYxseohbthARYT+OBDEjiXtSAYrzwr4MHZb0P/dEVp0gF25beAb
         VpHM9N/aFVFpruTSefQ7yIFgDY2e799egDufSdG6Qpui0nav3KetYJTgIr983vZA4tgw
         /3xr9a4RdTkQFR+TXn5Y6+rGbqQm09EGbUwer6kngP2aAoJLDJMI/O04A2F46jvqhcNP
         vWuA==
X-Gm-Message-State: AOJu0YwaOP77gOr/t133ZTLF7IOUqsox5Qh310Lnud/G1AvN5vhWDfHM
	30COcFuARIAoPJTVg4pLewi4S65r5hGs/xbU8fpE/2+oTo7P91II87G7p2Skvo/f2v4kY3Wy1K3
	J6XALGug9s8f7pPbyswrLTKnRZPrlELRYuvTs
X-Gm-Gg: AZuq6aIdK8tFGIS+eG68N9gym/KRm5OC5yMMnXaGeRFCMMnV/TyIjCn+ZLQLzJkDcaJ
	xCWaFn0bpoH1k0NhgE9+T3s9ouRi/cNgMa7Ou9xstbFg7g1uE2JLAOgKnZ6UIOt6yoOXlDZrkAB
	8rDENDdBbQQB9bXtujXnaMACadnNYhHxvA1ffQ8xU4QxOVwR41ajFhyNq20ehYYOanOg80GaXqv
	T6bvyuOkcKM3DTl9gber5OA1QpAJ9rjNpmNnCaZEhywIYtoddqDZj0VsqitvO15B+IKQbI=
X-Received: by 2002:a05:7022:4389:b0:119:e569:fb9b with SMTP id
 a92af1059eb24-124a0060880mr2909737c88.10.1769597649073; Wed, 28 Jan 2026
 02:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126133729.867488-1-idryomov@gmail.com> <69115424-f57c-4e27-847f-67f0c8b8ef02@linux.dev>
In-Reply-To: <69115424-f57c-4e27-847f-67f0c8b8ef02@linux.dev>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 28 Jan 2026 11:53:57 +0100
X-Gm-Features: AZwV_QjF0z9ys-8b5QtweeTQlkI9Bf1-4WBpr7a7YqdTfvveqZ4-Luu_aRz4kqI
Message-ID: <CAOi1vP_yj8YpsCEx8NjpQwhncpw+O9Niwh6wceoTHvXXckmuyQ@mail.gmail.com>
Subject: Re: [PATCH] rbd: check for EOD after exclusive lock is ensured to be held
To: Dongsheng Yang <dongsheng.yang@linux.dev>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 12:52=E2=80=AFPM Dongsheng Yang
<dongsheng.yang@linux.dev> wrote:
>
>
> =E5=9C=A8 1/26/2026 9:37 PM, Ilya Dryomov =E5=86=99=E9=81=93:
> > Similar to commit 870611e4877e ("rbd: get snapshot context after
> > exclusive lock is ensured to be held"), move the "beyond EOD" check
> > into the image request state machine so that it's performed after
> > exclusive lock is ensured to be held.  This avoids various race
> > conditions which can arise when the image is shrunk under I/O (in
> > practice, mostly readahead).  In one such scenario
> >
> >      rbd_assert(objno < rbd_dev->object_map_size);
> >
> > can be triggered if a close-to-EOD read gets queued right before the
> > shrink is initiated and the EOD check is performed against an outdated
> > mapping_size.  After the resize is done on the server side and exclusiv=
e
> > lock is (re)acquired bringing along the new (now shrunk) object map, th=
e
> > read starts going through the state machine and rbd_obj_may_exist() get=
s
> > invoked on an object that is out of bounds of rbd_dev->object_map array=
.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >   drivers/block/rbd.c | 28 +++++++++++++++++-----------
> >   1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index af0e21149dbc..44f4dd6e98d9 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -3490,16 +3490,31 @@ static void rbd_img_object_requests(struct rbd_=
img_request *img_req)
> >   {
> >       struct rbd_device *rbd_dev =3D img_req->rbd_dev;
> >       struct rbd_obj_request *obj_req;
> > +     u64 mapping_size;
> >
> >       rbd_assert(!img_req->pending.result && !img_req->pending.num_pend=
ing);
> >       rbd_assert(!need_exclusive_lock(img_req) ||
> >                  __rbd_is_lock_owner(rbd_dev));
> >
> > +     down_read(&rbd_dev->header_rwsem);
> > +     mapping_size =3D rbd_dev->mapping.size;
> >       if (rbd_img_is_write(img_req)) {
> >               rbd_assert(!img_req->snapc);
> > -             down_read(&rbd_dev->header_rwsem);
> >               img_req->snapc =3D ceph_get_snap_context(rbd_dev->header.=
snapc);
> > -             up_read(&rbd_dev->header_rwsem);
> > +     }
> > +     up_read(&rbd_dev->header_rwsem);
> > +
> > +     if (!test_bit(IMG_REQ_CHILD, &img_req->flags)) {
> > +             struct request *rq =3D blk_mq_rq_from_pdu(img_req);
> > +             u64 off =3D (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
> > +             u64 len =3D blk_rq_bytes(rq);
> > +
> > +             if (unlikely(off + len > mapping_size)) {
> > +                     rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)"=
,
> > +                              off, len, mapping_size);
> > +                     img_req->pending.result =3D -EIO;
> > +                     return;
> > +
> >       }
>
>
> Hi Ilya,
>
>
> Fix looks good in logic. But one potential concern is that with this
> change all child read requests will also acquire |header_rwsem| for
> reading.
>
> In principle this could be avoided, since child read requests do not
> need to fetch |snapc| and do not need to perform the beyond-EOD check.

Hi Dongsheng,

Good catch, I'll refactor appropriately and post v2 shortly.

Thanks,

                Ilya
