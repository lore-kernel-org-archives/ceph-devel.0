From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: =?utf-8?Q?Re:_Can_i_improve_the_performan?=
 =?utf-8?Q?ce_of_rbd_rollback_in_this_way=EF=BC=9F?=
Date: Tue, 17 Mar 2015 07:43:35 +0100 (CET)
Message-ID: <1047024924.4735475.1426574615914.JavaMail.zimbra@oxygem.tv>
References: <CAO7bE7fXz7-An2REcJKSjsb-HZFMnfi0Bo-MWtskptmLDd=8_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38059 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbCQGni convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 02:43:38 -0400
In-Reply-To: <576710578.4735463.1426574609418.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5b6Q5piV?= <xuxinhfut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I'm not sure it's helping for snapshot rollback, but hammer have a new =
object_map feature:

https://wiki.ceph.com/Planning/Blueprints/Hammer/librbd%3A_shared_flag,=
_object_map


which help for resize,flatten,...


----- Mail original -----
De: "=E5=BE=90=E6=98=95" <xuxinhfut@gmail.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mardi 17 Mars 2015 04:24:28
Objet: Can i improve the performance of rbd rollback in this way=EF=BC=9F

Hi,=20

I am a newbie to ceph. Recently i need to improve the performance of=20
rbd rollback on xfs in my project. Through experiment i found that the=20
mechanism of rbd rollback is like this:=20

When a image is rolled back to one of its snapshot (say N), for every=20
object that has been allocated,=20
case A) if the object has no snap version since snap N, then the head=20
version will be copied back to the latest snap (say N+M);=20
case B) if the object has snap version since snap N, and it has the=20
latest snap version (N+M), then the oldest snap version since snap N=20
(say N+x, 0<=3Dx<=3DM) will be copied to cover the head version;=20
case C) if the object has snap version since snap N, and it has no=20
version in the latest snap (N+M), then the head version will be copied=20
back to the latest snap N+M, and the oldest snap version since snap N=20
(say N+x, 0<=3Dx<M) will be copied to cover the head version.=20

I think in case A, we need not to copied the head version back. So for=20
improving performance, i comment the following statement in function=20
ReplicatedPG::_rollback_to in osd/ReplicatedPG.cc,=20

=2E.....=20
else if (rollback_to->obs.oi.soid.snap =3D=3D CEPH_NOSNAP) {=20
// rolling back to the head; we just need to clone it.=20
// ctx->modify =3D true;=20
}=20
=2E.....=20

Can i improve performance of rollback like this? If CAN NOT, what is th=
e reason?=20

Thank you.=20

Xin Xu=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
