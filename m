From: Sage Weil <sage@inktank.com>
Subject: Re: What does replica size mean?
Date: Wed, 4 Jul 2012 19:35:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207041934110.6931@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49D019C06A8@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-205611126-1341455709=:6931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57657 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab2GECfL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 22:35:11 -0400
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D019C06A8@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-205611126-1341455709=:6931
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Jul 2012, Eric_YH_Chen@wiwynn.com wrote:
> Hi, all:
>=20
> Just want to make sure one thing.=20
> If I set replica size as 2, that means one data with 2 copies, right?
> Therefore, if I measure the performance of rbd is 100MB/s,=20
> I can imagine the actually io throughputs on hard disk is over 100MB/s *3=
 =3D 300 MB/s. =A0
> Am I correct?=20

Right.

"pool size" =3D> "pg size" =3D> number of osds in each PG =3D> number of re=
plicas

So a pool with 'size 3' means 3x replication.

sage
--557981400-205611126-1341455709=:6931--
