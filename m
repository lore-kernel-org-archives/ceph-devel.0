From: Samuel Just <sam.just@inktank.com>
Subject: Re: PGLog::rewind_divergent_log use case
Date: Mon, 10 Jun 2013 16:02:12 -0700
Message-ID: <CA+4uBUZRPfQKpXodEZnHWH8G=LjpEkcGQxe=qTksRSoA6+ZMtQ@mail.gmail.com>
References: <51B2E84D.6090001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:45350 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3FJXCO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jun 2013 19:02:14 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so2677918eaj.5
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jun 2013 16:02:12 -0700 (PDT)
In-Reply-To: <51B2E84D.6090001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I think that case may be possible, and that the assert may be wrong.
We have probably never seen a problem there due to
osd_min_pg_log_entries.  It's also possible that there is a subtle bug
between there and calc_acting().
-Sam

On Sat, Jun 8, 2013 at 1:16 AM, Loic Dachary <loic@dachary.org> wrote:
> [Note: ceph-devel cc'ed]
>
> Hi Sam,
>
> While trying to create the conditions for the following to happen in =
PGLog::rewind_divergent_log:
>
>     if (p =3D=3D log.log.begin()) {
>       // yikes, the whole thing is divergent!
>       divergent.swap(log.log);
>       break;
>     }
>
> https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L355
>
> I created this ( matching the drawing attached ), and the test case w=
orks.
>
>     {
>       pg_log_entry_t e;
>
>       info.log_tail =3D log.tail =3D eversion_t(1, 1);
>       newhead =3D eversion_t(1, 3);
>       e.version =3D divergent_version =3D eversion_t(1, 5);
>       e.soid.hash =3D 0x9;
>       divergent_object =3D e.soid;
>       e.op =3D pg_log_entry_t::DELETE;
>       e.prior_version =3D prior_version =3D eversion_t(0, 2);
>       log.log.push_back(e);
>       log.head =3D e.version;
>     }
>
> https://github.com/dachary/ceph/commit/d592d7f10968c56139cb470a4111dd=
fbe08a4030#L0R136
>
> But it does not look like a situation that is actually going to happe=
n. I feel something is missing and a hint would be much appreciated :-)
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
