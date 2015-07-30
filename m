From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian
 wheezy?
Date: Thu, 30 Jul 2015 14:34:17 +0000
Message-ID: <BB7431A1-4C47-42EB-8FD9-4F2B5CA46657@hp.com>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>,<515A1511-3ED8-481F-8E71-C5CC8332F225@zviratko.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:38708 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbG3OfE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 10:35:04 -0400
In-Reply-To: <515A1511-3ED8-481F-8E71-C5CC8332F225@zviratko.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?Windows-1252?Q?Jan_=93Zviratko=94_Schermer?= <zviratko@zviratko.net>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

So, essentially, you'd vote that all LTS/enterprise releases be support=
ed until their vendor's (canonical, Suse, red hat) designated EOL date?=
 Not voting either way, just trying to put a date stamp on some of this=
=2E

Joe

> On Jul 30, 2015, at 9:30 AM, Jan =93Zviratko=94 Schermer <zviratko@zv=
iratko.net> wrote:
>=20
> I understand your reasons, but dropping support for LTS release like =
this
> is not right.
>=20
> You should lege artis support every distribution the LTS release coul=
d have
> ever been installed on - that=92s what the LTS label is for and what =
we rely on
> once we build a project on top of it
>=20
> CentOS 6 in particular is still very widely used and even installed, =
enterprise
> apps rely on it to this day. Someone out there is surely maintaining =
their LTS
> Ceph release on this distro and not having tested packages will hurt =
badly.
> We don=92t want out project managers selecting EMC SAN over CEPH SDS
> because of such uncertainty, and you should benchmark yourself to tho=
se
> vendors, maybe...
>=20
> Every developer loves dropping support and concentrating on the bleed=
ing
> edge interesting stuff but that=92s not how it should work.
>=20
> Just my 2 cents...
>=20
> Jan
>=20
>> On 30 Jul 2015, at 15:54, Sage Weil <sweil@redhat.com> wrote:
>>=20
>> As time marches on it becomes increasingly difficult to maintain pro=
per=20
>> builds and packages for older distros.  For example, as we make the=20
>> systemd transition, maintaining the kludgey sysvinit and udev suppor=
t for=20
>> centos6/rhel6 is a pain in the butt and eats up time and energy to=20
>> maintain and test that we could be spending doing more useful work.
>>=20
>> "Dropping" them would mean:
>>=20
>> - Ongoing development on master (and future versions like infernalis=
 and=20
>> jewel) would not be tested on these distros.
>>=20
>> - We would stop building upstream release packages on ceph.com for n=
ew=20
>> releases.
>>=20
>> - We would probably continue building hammer and firefly packages fo=
r=20
>> future bugfix point releases.
>>=20
>> - The downstream distros would probably continue to package them, bu=
t the=20
>> burden would be on them.  For example, if Ubuntu wanted to ship Jewe=
l on=20
>> precise 12.04, they could, but they'd probably need to futz with the=
=20
>> packaging and/or build environment to make it work.
>>=20
>> So... given that, I'd like to gauge user interest in these old distr=
os. =20
>> Specifically,
>>=20
>> CentOS6 / RHEL6
>> Ubuntu precise 12.04
>> Debian wheezy
>>=20
>> Would anyone miss them?
>>=20
>> In particular, dropping these three would mean we could drop sysvini=
t=20
>> entirely and focus on systemd (and continue maintaining the existing=
=20
>> upstart files for just a bit longer).  That would be a relief.  (The=
=20
>> sysvinit files wouldn't go away in the source tree, but we wouldn't =
worry=20
>> about packaging and testing them properly.)
>>=20
>> Thanks!
>> sage
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
