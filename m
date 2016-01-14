From: Erwan Velu <evelu@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Thu, 14 Jan 2016 11:10:21 -0500 (EST)
Message-ID: <831805509.11479927.1452787821164.JavaMail.zimbra@redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com> <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com> <20160112173248.GA8218@ultraspiritum.redhat.com> <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:50524 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbcANQKV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 11:10:21 -0500
In-Reply-To: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks for your insights.=20

I even wonder if the change of the daylight time saving could not trigg=
er that bug I'm thinking about.
Especially if the server time is in local time .... That's an horrible =
vision :(

I'll work on that next week, I have to complete some work before switch=
ing to that.

Cheers,

----- Mail original -----
De: "Sage Weil" <sweil@redhat.com>
=C3=80: "Erwan Velu" <evelu@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, "The Sacred Order of the S=
quid Cybernetic" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 13 Janvier 2016 14:48:00
Objet: Re: About ceph_clock_now()

On Wed, 13 Jan 2016, Erwan Velu wrote:
> >One concern with monotonic clocks, even for elapsed time, is that th=
eir epoch is
> >unspecified. You cannot send a monotonic time over the network to an=
other
> >machine nor can you save it to a file and re-read it later. Anything=
 to be
> >serialized must be a real time.
>=20
> While speaking about ceph_clock_now(), I was more likely targeting lo=
ts of local code like
>   start =3D ceph_clock_now();
>   ... do_stuff ...
>   elapse_time =3D ceph_clock_now() - start
>=20
>=20
> I'm thinking of code like this in void OSD::tick_without_osd_lock():
> Starting at https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L=
4009.
>=20
> This code is trying to estimate if a mon is still alive by computing =
a difference of system time by
> doing a  "if (now - last_pg_stats_sent > max) {" where now & last_pg_=
stats_sent are the output of "ceph_clock_now()"
>=20
> As ceph_clock_now() is using CLOCK_REALTIME, we could have cases wher=
e a simple drift caused by a NTP trigger that code.
> As we are only trying to compute a difference of absolute time (and n=
ot system time), using a MONOTONIC_* seems much more accurate at my tas=
te.
>=20
> I know that's pretty picky but that could exists.

That's a perfect example of where the monotonic time should be used. Th=
ere=20
are a zillion instances of this pattern that could be cleaned up... :)

> >I find it interesting. If you want to change more subsystems to use =
ceph_time
> >and use monotonic and coarse clocks in appropriate places I think th=
at would be
> >wonderful. It might be worthwhile to focus on the places where we us=
e double to
> >represent a time value.
> >Please read through ceph_time.h and osdc to get a feel for it. If yo=
u think it
> >could use improvement, I'd be happy to hear your ideas.
>=20
> You mean we could switch some of ceph_clock_now() calls to ceph_time =
?=20
> We could use coarse_mono_clock to perform that.
>=20
> If you agree that switching code like the one I'm speaking is valuabl=
e,=20
> I can work on it.

That would be great!

sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
