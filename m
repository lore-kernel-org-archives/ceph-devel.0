From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Questions about ceph mount dir subdirectory max size limit
Date: Wed, 23 Feb 2011 09:12:44 +0800
Message-ID: <1298423564.1879.37.camel@cephhost>
References: <1298367457.1879.33.camel@cephhost>
	 <1298371146.2423.63.camel@wido-laptop.pcextreme.nl>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:59171 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755549Ab1BWBMe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Feb 2011 20:12:34 -0500
In-Reply-To: <1298371146.2423.63.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi wido,

Thanks!

Jeff.



=E5=9C=A8 2011-02-22=E4=BA=8C=E7=9A=84 18:39 +0800=EF=BC=8CWido den Hol=
lander=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jeff,
>=20
> On Tue, 2011-02-22 at 17:37 +0800, Jeff Wu wrote:
> > Hi ,
> > Resemble quota,
> > is there a way to limit per subdirectory max size under ceph mount
> > directory  ?=20
>=20
> I don't thin there currently is any way of having a quota per directo=
ry.
> User/Group quota's are not supported either.
>=20
> Wido
>=20
> >=20
> > For instance :
> > mount.ceph cephserver:6789:/ /mnt/ceph
> > /mnt/ceph     max size    300G=20
> > /mnt/ceph/user1     max size limit   30G=20
> > /mnt/ceph/user2     max size limit   50G=20
> > /mnt/ceph/user3     max size limit   10G=20
> > ................
> > ................
> >=20
> > Thanks
> >=20
> > Jeff C.P.Wu
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
