From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: scrub loadavg too high
Date: Thu, 7 Jul 2011 09:35:16 -0700
Message-ID: <CAORUGqB2jsmHB4dk9OjgpwNM+YNKXjApZ3tO-r8A-ADd2Y0R+A@mail.gmail.com>
References: <CABAwU-aaJE10=ZtbkXn-OyEmMpO3Nz8BvpS=x39mSr6y0JZQyQ@mail.gmail.com>
 <CAORUGqBVzN2dYdBcPJ8s9qMfYW5GQeLROmwKe2KHRpT9xz4z9w@mail.gmail.com>
 <CABAwU-Yf_oUvKbtbbnDiRB-cXQbOVh+RepAT2XkEjOsErqiauA@mail.gmail.com>
 <CAORUGqAFXOrbRQE5DOUnfr0oVks4VEkVX318LbQkSUNWLkCOLw@mail.gmail.com> <CABAwU-aZMr5FO0h=sizfpEXyNLas4XS7H1EHPLSyUbcLgvj2iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47808 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab1GGQfh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2011 12:35:37 -0400
Received: by eyx24 with SMTP id 24so376283eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2011 09:35:36 -0700 (PDT)
In-Reply-To: <CABAwU-aZMr5FO0h=sizfpEXyNLas4XS7H1EHPLSyUbcLgvj2iQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2011/7/6 huang jun <hjwsm1989@gmail.com>:
> we know we should use journal if we want keep =C2=A0data integrity, b=
ut it really
> influence the performance even we use btrfs as osd low-level fs, not
> fs for journal.
> in the debug log, find that :
> =C2=A0 =C2=A0journal prepare_single_write 1 will write 3649536 : seq =
445 len
> 4195462 -> 4202496 =C2=A0 =C2=A0(head 40 pre_pad 3895 ebl 4195462 pos=
t_pad 3059
> tail 40) (ebl alignment 3935)
>
> it will generate 4195462 bytes journal of writing =C2=A04MB data from=
 client.
> that means we will write 8MB when it actually write 4MB data,
> so what advices you can give if we want to lower the overhead of jour=
nal?

Journals pretty much by definition mean you write the data twice;
that's inherent in their design.

As far as I know, if you want good performance, you should use btrfs
and a recent kernel. If you insist on using ext3, different mount
options may bring you performance improvements, but we have not had
the time to explore those yet -- and in any case, I expect our efforts
would focus on btrfs first.

We are building tools for better benchmarking of Ceph right now, but
the truth is that most of the performance work is still ahead of us.
Current wisdom is pretty much "if it's slow, add machines". Right now,
we're hard at work on correctness.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
