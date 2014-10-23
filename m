From: GuangYang <yguang11@outlook.com>
Subject: Filestore throttling
Date: Thu, 23 Oct 2014 03:52:05 +0000
Message-ID: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s12.hotmail.com ([65.55.111.151]:61317 "EHLO
	BLU004-OMC4S12.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932543AbaJWDwG convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Oct 2014 23:52:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hello Cephers,
During our testing, I found that the filestore throttling became a limi=
ting factor for performance, the four settings (with default value) are=
:
=A0filestore queue max ops =3D 50
=A0filestore queue max bytes =3D 100 << 20
=A0filestore queue committing max ops =3D 500
=A0filestore queue committing max bytes =3D=A0100 << 20

My understanding is, if we lift the threshold, the response for op (end=
 to end) could be improved a lot during high load, and that is one reas=
on to have journal. The downside is that if there is a read following a=
 successful write, the read might stuck longer as the object is not flu=
shed.

Is my understanding correct here?

If that is the tradeoff and read after write is not a concern in our us=
e case, can I lift the parameters to below values?
=A0filestore queue max ops =3D 500
=A0filestore queue max bytes =3D 200 << 20
=A0filestore queue committing max ops =3D 500
=A0filestore queue committing max bytes =3D=A0200 << 20

It turns out very helpful during PG peering stage (e.g. OSD down and up=
).

Thanks,
Guang


 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
