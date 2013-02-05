From: ArtemGr <artemciy@gmail.com>
Subject: Re: Increase number of pg in running system
Date: Tue, 5 Feb 2013 14:40:17 +0000 (UTC)
Message-ID: <loom.20130205T153942-509@post.gmane.org>
References: <CAD3n6hFb=m_PL27sWZ5BSBAYP3xmTGZS_DrL-4ozF2+JbndMCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35242 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab3BEOkc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Feb 2013 09:40:32 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U2jhY-0006dR-Vg
	for ceph-devel@vger.kernel.org; Tue, 05 Feb 2013 15:40:49 +0100
Received: from client.yota.ru ([client.yota.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 15:40:48 +0100
Received: from artemciy by client.yota.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 15:40:48 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Martin B Nielsen <martin <at> unity3d.com> writes:
> Hi,
>=20
> Looking at:
> http://ceph.com/docs/master/rados/operations/pools/
>=20
> It has this description roughly in the middle:
>=20
> ---------------
> Important
> Increasing the number of placement groups in a pool after you create
> the pool is still an experimental feature in Bobtail (v 0.56). We
> recommend defining a reasonable number of placement groups and
> maintaining that number until Ceph=E2=80=99s placement group splittin=
g and
> merging functionality matures.
> ---------------
>=20
> However, I cannot find any references how to do this?
>=20
> I'm asking since we have a test system with 10TB data with only the
> default 8 PG's created.

Here's how I do it in ceph.conf:

[osd]
  ; Increase groups number in order to decrease scrub size
  osd pool default pg num =3D 64
  osd pool default pgp num =3D 64


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
