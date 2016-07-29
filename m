From: Wido den Hollander <wido@42on.com>
Subject: Re: Active/Active MDS
Date: Fri, 29 Jul 2016 11:09:42 +0200 (CEST)
Message-ID: <1748038854.1636.1469783382224@ox.pcextreme.nl>
References: <CALSMtUBtwuRyoX0XmLYRBvjdMuSEs7-bmO5OtXr4RRapVrg7dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:55874 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbcG2JJq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 05:09:46 -0400
In-Reply-To: <CALSMtUBtwuRyoX0XmLYRBvjdMuSEs7-bmO5OtXr4RRapVrg7dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Webb <billwebbatl@gmail.com>, ceph-devel@vger.kernel.org


> Op 29 juli 2016 om 0:50 schreef Bill Webb <billwebbatl@gmail.com>:
>=20
>=20
> Hello,
>=20
> We have a bit of interest in seeing MDS support Active-Active HA.  I=E2=
=80=99d
> be interested to learn about the status of this, and possibly
> contribute.  What is the best way to proceed?
>=20

Great to see! I think the best route would be that you start with a dev=
 setup. Build a (small) Ceph cluster with HA MDS servers and start runn=
ing tests. If you see stuff fail, try to gather as much data as possibl=
e and report it back on the dev list or the issue tracker.

Wido

> Thanks,
> Bill Webb
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
