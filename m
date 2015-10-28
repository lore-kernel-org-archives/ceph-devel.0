From: GuangYang <yguang11@outlook.com>
Subject: RE: PG: all requests stuck when acting set < min_size
Date: Tue, 27 Oct 2015 17:14:04 -0700
Message-ID: <BLU175-W3851F997168E5C1E68510FDF210@phx.gbl>
References: <BLU175-W31BC44F9AFEBFB5588D05CDF220@phx.gbl>,<CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc3s2.hotmail.com ([65.55.116.77]:51598 "EHLO
	BLU004-OMC3S2.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbJ1AOE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 20:14:04 -0400
In-Reply-To: <CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Greg.

----------------------------------------
> Date: Tue, 27 Oct 2015 12:47:34 -0700
> Subject: Re: PG: all requests stuck when acting set < min_size
> From: gfarnum@redhat.com
> To: yguang11@outlook.com
> CC: ceph-devel@vger.kernel.org
>
> On Tue, Oct 27, 2015 at 11:47 AM, GuangYang <yguang11@outlook.com> wr=
ote:
>> Hi there,
>> Is there any reason we stuck read only requests as well for a PG whe=
n the acting set size is less than min_size?
>
> A few.
> The most important reason: PGs don't have any concept of a read-only
> mode in the code. They are "active" or not, and an active PG handles
> writes. (The full flags and other things which block writes but allow
> reads are at the OSD level, not the PG level, and are handled when op=
s
> come in before they reach the PG.) Allowing read requests against a P=
G
> to complete even when we aren't taking writes on a per-PG level would
> take some doing.
[yguang] Yeah that is what I thought as well, I didn't see a read-only =
PG state, they are either active or inactive (incomplete).
> Also: it would be weird from several different levels. We'd need to
> keep track of client streams because we wouldn't want to let through =
a
> read that is ordered after a write. How would we handle the memory
> pressure implied by that?=A0
[yguang] I am not aware of this part, could you elaborate a little bit?
While I can imagine it being useful for some
> stuff like RGW reads, in general making data available for read but
> not write is a pretty complicated thing to explain to users =97 how d=
o
> we expose that in a useful way?
[yguang] The motivation is to improve availability upon failures (yay w=
e are using radosgw:), and some use cases of object storage like S3,
most commonly object are written once, read many, and this could help w=
ith the availability.
> -Greg
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
