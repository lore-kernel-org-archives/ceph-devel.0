From: Samuel Just <sam.just@inktank.com>
Subject: Re: Deferred deletion of ObjectContext
Date: Thu, 15 Aug 2013 09:54:41 -0700
Message-ID: <CA+4uBUa7aMkATQFykWxjGKEJTfNJY58vfaJ=xpU+z-fsh2+xRw@mail.gmail.com>
References: <520CE1E7.8070301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:35917 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab3HOQyn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Aug 2013 12:54:43 -0400
Received: by mail-ve0-f169.google.com with SMTP id db10so746530veb.14
        for <ceph-devel@vger.kernel.org>; Thu, 15 Aug 2013 09:54:42 -0700 (PDT)
In-Reply-To: <520CE1E7.8070301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Commented on the commit.
-Sam

On Thu, Aug 15, 2013 at 7:12 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> I've amended https://github.com/ceph/ceph/pull/414 with
>
> https://github.com/dachary/ceph/commit/66e42d0ec29ffdd2edc225f4090a13=
2a50d9665b#L0R4668
>
>   bool locked =3D is_locked();
>   if (!locked)
>     lock();
>
>   if (obc->ssc)
>     put_snapset_context(obc->ssc);
>
>   if (object_contexts.empty())
>     kick();
>
>   if (!locked)
>     unlock();
>
> This callback may be called at any time and it is not possible to ass=
ume the PG is locked when it happens. With manual reference counting, t=
his part of code was guaranteed to be called when the PG was locked. PG=
::lock() is called at the beginning and PG::unlock() at the end to prov=
ide the same guarantee.
>
> It runs ok with https://github.com/ceph/ceph/pull/414#issuecomment-22=
705040 and https://github.com/ceph/ceph/pull/414#issuecomment-22705040 =
=2E If it sounds reasonable to you I'll schedule another rados suite.
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
