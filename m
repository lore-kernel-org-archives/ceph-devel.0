From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian
 wheezy?
Date: Fri, 31 Jul 2015 05:33:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507310532370.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net> <20150730155812.GE15736@gmail.com> <2085249323.24865068.1438327308865.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2141783074-1438346034=:22099"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54682 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbGaMdy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 08:33:54 -0400
In-Reply-To: <2085249323.24865068.1438327308865.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Brian Kroth <bpkroth@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, adeza@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2141783074-1438346034=:22099
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jul 2015, Alexandre DERUMIER wrote:
> >>As I still haven't heard or seen about any upstream distros for Debia=
n=20
> >>Jessie (see also [1]),
>=20
> Gitbuilder is already done for jessie
>=20
> http://gitbuilder.ceph.com/ceph-deb-jessie-x86_64-basic/
>=20
> @Sage : Don't known if something is blocking to release package officia=
lly ?

I don't think there are specific blockers except Alfredo's time.  We need=
=20
to set up another release build target machine in Jenkins.  Alfredo's bee=
n=20
rearchitecting the release build process and I've been hoping he can avoi=
d=20
touching the old ball of duct tape and add Jessie to the new hotness, but=
=20
I'm not sure what the timeline looks like... Alfredo?

sage


>=20
>=20
>=20
> ----- Mail original -----
> De: "Brian Kroth" <bpkroth@gmail.com>
> =C3=80: "Sage Weil" <sweil@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users=
@ceph.com>
> Envoy=C3=A9: Jeudi 30 Juillet 2015 17:58:12
> Objet: Re: [ceph-users] dropping old distros: el6, precise 12.04, debia=
n wheezy?
>=20
> Sage Weil <sweil@redhat.com> 2015-07-30 06:54:=20
> >As time marches on it becomes increasingly difficult to maintain prope=
r=20
> >builds and packages for older distros. For example, as we make the=20
> >systemd transition, maintaining the kludgey sysvinit and udev support =
for=20
> >centos6/rhel6 is a pain in the butt and eats up time and energy to=20
> >maintain and test that we could be spending doing more useful work.=20
> >=20
> >"Dropping" them would mean:=20
> >=20
> > - Ongoing development on master (and future versions like infernalis =
and=20
> >jewel) would not be tested on these distros.=20
> >=20
> > - We would stop building upstream release packages on ceph.com for ne=
w=20
> >releases.=20
> >=20
> > - We would probably continue building hammer and firefly packages for=
=20
> >future bugfix point releases.=20
> >=20
> > - The downstream distros would probably continue to package them, but=
 the=20
> >burden would be on them. For example, if Ubuntu wanted to ship Jewel o=
n=20
> >precise 12.04, they could, but they'd probably need to futz with the=20
> >packaging and/or build environment to make it work.=20
> >=20
> >So... given that, I'd like to gauge user interest in these old distros=
.=20
> >Specifically,=20
> >=20
> > CentOS6 / RHEL6=20
> > Ubuntu precise 12.04=20
> > Debian wheezy=20
> >=20
> >Would anyone miss them?=20
> >=20
> >In particular, dropping these three would mean we could drop sysvinit=20
> >entirely and focus on systemd (and continue maintaining the existing=20
> >upstart files for just a bit longer). That would be a relief. (The=20
> >sysvinit files wouldn't go away in the source tree, but we wouldn't wo=
rry=20
> >about packaging and testing them properly.)=20
> >=20
> >Thanks!=20
> >sage=20
>=20
> As I still haven't heard or seen about any upstream distros for Debian=20
> Jessie (see also [1]), I am still running Debian Wheezy and as that is=20
> supposed to be supported for another ~4 years by Debian, it would be=20
> very nice if there were at least stability and security fixes backporte=
d=20
> for the upstream ceph package repositories for that platform.=20
>=20
> Additionally, I'll note that I'm personally likely to continue to use=20
> sysvinit so long as I still can, even when I am able to make the switch=
=20
> to Jessie.=20
>=20
> Thanks,=20
> Brian=20
>=20
> [1] <http://www.spinics.net/lists/ceph-users/msg19959.html>=20
>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2141783074-1438346034=:22099--
