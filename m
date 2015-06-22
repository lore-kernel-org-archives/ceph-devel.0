From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: firefly v0.80.10 QE validation completed
Date: Mon, 22 Jun 2015 09:40:20 +0200
Message-ID: <1434958820.2806.3.camel@daevel.fr>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>
	 <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:59995 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbbFVHpb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 03:45:31 -0400
In-Reply-To: <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>, Alfredo Deza <adeza@redhat.com>, Sage Weil <sweil@redhat.com>

Hi,

I saw the proposed upgrade to 0.80.10 this morning, but can't find the
announce about this (neither by email or on the website).

Is the 0.80.10 ready to be used ?

thanks,
Olivier

Le mercredi 17 juin 2015 =C3=A0 21:33 -0400, Yuri Weinstein a =C3=A9cri=
t :
> firefly v0.80.10 is ready for publishing (Sage, Alfredo, Loic, Xinxin=
=20
> FYI)
>=20
> All results details were summarized in=20
> http://tracker.ceph.com/issues/11090
>=20
> Note:
>=20
> - upgrade/dumpling-firefly-x (to hammer)(distros) - runs out of=20
> memory on vps and unreliable
> - #11957 fixed (thanks Ilya, Zack!) and tested
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Yuri Weinstein" <yweinste@redhat.com>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Cc: "Loic Dachary" <ldachary@redhat.com>, "Xinxin Shu" <
> xinxin.shu@intel.com>
> Sent: Monday, June 15, 2015 9:37:20 AM
> Subject: firefly v0.80.10 QE validation status 6/15/2015
>=20
> QE validation is almost completed (there are a couple of jobs that=20
> are still running)
>=20
> All statis details were summarized in=20
> http://tracker.ceph.com/issues/11090
>=20
> Highlights (by suite/issue):
>=20
> rados #11914 needs Sam's approval
> kcephfs n/a needs Greg's approval
> samba #6613 needs Greg's approval
>=20
> Nice to have fixes (no blockers):
> upgrade/firefly(distros) #11957	(env noise)
>=20
>=20
> Thx
> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
