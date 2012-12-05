From: Amon Ott <ao@m-privacy.de>
Subject: Re: [PATCH 0/2] fixes for undeletable empty directory
Date: Wed, 05 Dec 2012 09:43:43 +0100
Message-ID: <50BF093F.4060709@m-privacy.de>
References: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:34205 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab2LEInx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 Dec 2012 03:43:53 -0500
In-Reply-To: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Am 04.12.2012 09:09, schrieb Yan, Zheng:
> These two patches fix MDS restart issues that may corrupt the fragsta=
t accounting
> and cause undeletable empty directory. These two patches, together wi=
th the patch
> "mds: fix journaling issue regarding rstat accounting", have passed o=
vernight
> "fsstress + restart MDS every 120s" test. No undeletable directory wa=
s found.
>=20
> These patches are also in:
>   git://github.com/ukernel/ceph.git wip-mds

Thank you very much for working on MDS issues, your work gave me some
hope that our very long standing crashes at MDS failover could be fixed
soon.

Right now, we have our four node test cluster running with 0.55 and you=
r
latest patches. Hopefully, today's stress test will work fine.

One question: with your latest patches, is a multiple MDS setup stable
in your tests? So far, we only tried with max mds =3D 1. As our work lo=
ad
writes many small files, some load sharing for MDS would be nice to
have. I would be willing to help with tests and reports, if needed.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 99296856
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
