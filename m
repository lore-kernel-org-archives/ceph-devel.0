From: Tianshan Qu <qutianshan@gmail.com>
Subject: Re: [ceph-users] A simple problem of log directory
Date: Mon, 14 Mar 2016 15:26:32 +0800
Message-ID: <2F9BD66E-1C2A-4F41-9831-4D96E1E63428@gmail.com>
References: <47D132BF400BE64BAE6D71033F7D3D7503E0936B@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34806 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbcCNH20 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 03:28:26 -0400
Received: by mail-pa0-f44.google.com with SMTP id fe3so134900519pab.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 00:28:26 -0700 (PDT)
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D7503E0936B@H3CMLB14-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wukongming <wu.kongming@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

try add log_file=3D/var/log/ceph/$name.log in [client] section

> =D4=DA 2016=C4=EA3=D4=C214=C8=D5=A3=AC11:45=A3=ACWukongming <wu.kongm=
ing@h3c.com> =D0=B4=B5=C0=A3=BA
>=20
> Hi All
>=20
> Here I want ceph to separate rbd,rgw,mds' logs into individual file. =
I knew rgw's can be configured by adding comment[client.radosgw.***], b=
ut useless to the other 2 module.
> Is that 2(rbd,mds) configured?  Thank you!
>=20
> ---------------------------------------------
> wukongming ID: 12019
> Tel=A3=BA0571-86760239
> Dept=A3=BA2014 UIS2 ONEStor
>=20
>=20
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> =B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=BA=BC=D6=DD=BB=
=AA=C8=FD=CD=A8=D0=C5=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=CB=BE=B5=C4=B1=A3=C3=
=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=CD=B8=F8=C9=CF=C3=E6=B5=
=D8=D6=B7=D6=D0=C1=D0=B3=F6
> =B5=C4=B8=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=
=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=
=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=
=B6=A1=A2=B8=B4=D6=C6=A1=A2
> =BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=
=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=
=FA=C1=A2=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=
=CB=B2=A2=C9=BE=B3=FD=B1=BE
> =D3=CA=BC=FE=A3=A1
> This e-mail and its attachments contain confidential information from=
 H3C, which is
> intended only for the person or entity whose address is listed above.=
 Any use of the
> information contained herein in any way (including, but not limited t=
o, total or partial
> disclosure, reproduction, or dissemination) by persons other than the=
 intended
> recipient(s) is prohibited. If you receive this e-mail in error, plea=
se notify the sender
> by phone or email immediately and delete it!
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
