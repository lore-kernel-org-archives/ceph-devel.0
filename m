From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Question about IoCtx::aio_exec semantics
Date: Thu, 19 Apr 2012 12:34:46 -0700
Message-ID: <CAC-hyiEtTkrY7N+8hLxM=zZWUcH=Vi0dMGxwnTHc-6BERk7T3w@mail.gmail.com>
References: <1CD68FE4-74EB-4599-B7F8-309C0DD92D34@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63510 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab2DSTer convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 15:34:47 -0400
Received: by bkcik5 with SMTP id ik5so6664423bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 12:34:46 -0700 (PDT)
In-Reply-To: <1CD68FE4-74EB-4599-B7F8-309C0DD92D34@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 19, 2012 at 12:04 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
> I've had a lot of success using rados_exec(), but I need to graduate =
the implementation to use IoCtx::aio_exec for increased concurrency. I'=
m a little confused about how aio_exec should be used:
>
> Here is aio_exec:
>
> =A0 int aio_exec(const std::string& oid, AioCompletion *c, const char=
 *cls, const char *method, bufferlist& inbl, bufferlist *outbl);
>
> I'd like to have many outstanding competitions, one for each call of =
aio_exec. Once @c has completed, I'd like to have access to the @outbl =
bufferlist. So, is the intended use here to allocate an empty bufferlis=
t for each submitted completion?

Yes, you'll need to have a bufferlist for each request sent if your
exec is expected to return data. Note that only read operations should
return data.
>
> In rgw/rgw_rados.cc a use is:
>
> =A0AioCompletion *c =3D librados::Rados::aio_create_completion(NULL, =
NULL, NULL);
> =A0r =3D io_ctx.aio_exec(oid, c, "rgw", "dir_suggest_changes", in, NU=
LL);
> =A0c->release();
>
> To clarify, are the semantics here that an asynchronous aio_exec is m=
ade without checking for completion or return values.

Right. We send the "dir_suggest_changes" request and dropping the
reference, so that we can't get the return value once it's done.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
