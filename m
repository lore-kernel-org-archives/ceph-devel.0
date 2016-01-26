From: Erwan Velu <evelu@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Tue, 26 Jan 2016 09:12:57 -0500 (EST)
Message-ID: <814795121.17157781.1453817577776.JavaMail.zimbra@redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com> <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com> <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com> <20160119162902.GA21358@ultraspiritum.redhat.com> <1522288191.15295456.1453404176015.JavaMail.zimbra@redhat.com> <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com> <20160122173521.GA29065@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:37778 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503AbcAZOM7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 09:12:59 -0500
In-Reply-To: <20160122173521.GA29065@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hey Adam,

I updated my branch based on your recommendations. Thanks.
I'm continuing my edit.

----- Mail original -----
De: "Adam C. Emerson" <aemerson@redhat.com>
=C3=80: "Erwan Velu" <evelu@redhat.com>
Cc: "Sage Weil" <sweil@redhat.com>, "The Sacred Order of the Squid Cybe=
rnetic" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 22 Janvier 2016 18:35:22
Objet: Re: About ceph_clock_now()

On 22/01/2016, Erwan Velu wrote:
> Hey,
>=20
> I've been able to continue this work and updated by branch accordingl=
y.
> I understand the benefit of using the ceph_time work but I feel that =
it makes the change pretty verbose for a not a so big change (CLOCK_REA=
LTIME vs CLOCK_MONO).
>
> This imply a change of all utime_t and makes the computations a littl=
e bit more complex to read.

There are a few changes one can use to make it less verbose. If you're =
not in a
header file (or inside a function), you might like to do:

using ceph::coarse_mono_clock;

(Don't do that in headers outside of functions, though.)

Then you can just do things like

auto now =3D mono_clock_coarse::now();

Which should be a bit less verbose.

Or even:

using cm_clock =3D ceph::coarse_mono_clock;

auto now =3D cm_clock::now();

> Does it worth the time spent on it ? If yes, I don't have any issue c=
ontinuing this way.
> I'm pretty new to the project and would like to make the best PR as p=
ossible.
> So your insights on the under-work patch would be very helpful.

I think so. We definitely wnat to use monotonic clocks where appropriat=
e. And we
can get a performance benefit from using coarse clocks where appropriat=
e, too.
And we want to switch to the ceph_time stuff anyway just because it rul=
es out a
whole class of bugs and integrates with standard and third-party librar=
ies.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
