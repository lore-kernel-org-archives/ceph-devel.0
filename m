From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to sync data on different server but with the same image
Date: Tue, 06 Dec 2011 10:33:19 +0100
Message-ID: <1323163999.26341.2.camel@Nokia-N900-02-8>
References: <8512670932FB654F81AF0FEF1BE6D49D9430EB@WHQBEMAIL1.whq.wistron>
Reply-To: Wido den Hollander <wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:52741 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932974Ab1LFJd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 04:33:26 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D9430EB@WHQBEMAIL1.whq.wistron>
Content-ID: <1323163998.26341.1.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com, ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com

Hi,

----- Original message -----
> Dear All:
>=20
>=C2=A0 =C2=A0 =C2=A0  I map the same rbd image to the rbd device on tw=
o different servers.
>=20
> =C2=A0=C2=A0=C2=A0 For example:=C2=A0 =C2=A0 =20
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  1. create rbd image named foo
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  2. map foo to /dev/rbd0 on server =
A,=C2=A0  mount /dev/rbd0 to /mnt
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  3. map foo to /dev/rbd0 on server =
B,=C2=A0  mount /dev/rbd0 to /mnt
>=20
>=C2=A0 =C2=A0 =C2=A0  If I put add a file to /mnt via server A, I hope=
 I can see the same
> file on server B.
>=C2=A0 =C2=A0 =C2=A0  However, I can't see it until I umount /mnt on s=
erver A and re-mount
> /mnt on server B.

You'd have to use an cluster filesystem like GFS or OCFS2 to let this w=
ork.

But why not use Ceph as a filesystem instead of RBD? That seems to do w=
hat you want.

Wido

>=C2=A0 =C2=A0 =C2=A0 =20
>=C2=A0 =C2=A0 =C2=A0  Do you have any comment about this scenario? How=
 could I force the
> data synchronization?
>=20
>=C2=A0 =C2=A0 =C2=A0  Actually, I want to implement the iSCSI High Ava=
ilable multipath on
> http://ceph.newdream.net/wiki/ISCSI.
>=C2=A0 =C2=A0 =C2=A0  Therefore, I tried this small experiment first, =
but fail. Would you
> please give me some suggestion before I start to implement it? Thanks=
!
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0  http://vger.kernel.org/majordomo-info.h=
tml

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
