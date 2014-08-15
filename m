From: Sage Weil <sweil@redhat.com>
Subject: Re: some question about limiting multi part size
Date: Fri, 15 Aug 2014 06:16:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408150614250.28244@cobra.newdream.net>
References: <41f812a2d2624c8a86c26a3d6db2200b@cc-ex13-mb01.chinacache.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1276597042-1408108561=:28244"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39129 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaHONQC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Aug 2014 09:16:02 -0400
In-Reply-To: <41f812a2d2624c8a86c26a3d6db2200b@cc-ex13-mb01.chinacache.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "xianghong.li" <xianghong.li@chinacache.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1276597042-1408108561=:28244
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Copying ceph-devel.

On Fri, 15 Aug 2014, xianghong.li wrote:
>=20
> Hi:
>=20
> =A0 I come from china,I am using the ceph,and using the ceph-s3 API to =
do some
> thing,it?s version is 0.72.2. now, I want to limit the min size of each
> multi part, that is, if you chose using multi upload object,the object =
size
> must big than 5MB, and then every part must big than 5MB except the las=
t
> one.what should I do to meet my needs.
>=20
> I read the ceph source. The code is:
>=20
> =A0=A0=A0=A0 ceph=A0/=A0src=A0/=A0rgw=A0/=A0rgw_common.h
>=20
> =A0=A0=A0=A0 #define RGW_MIN_MULTIPART_SIZE (5ULL*1024*1024)
>=20
> ceph=A0/=A0src=A0/=A0rgw=A0/=A0rgw_op.cc

This #define isn't used anywhere, at least not in the latest master=20
branch.   0.72.2 is a bit old; you should look at the firefly or master=20
branch.  There may be a tunable controlling this in=20
common/config_opts.h...

sags



>=20
> =A0=A0=A0=A0 [IMAGE]
>=20
> =A0
>=20
> When I try to upload an 2.3MB object by multi upload,the =A0complete xm=
l file
> is :
>=20
> =A0
>=20
> [IMAGE]
>=20
> Why can I upload successfully? the ceph-s3 API don?t check the size of =
each
> part?
>=20
> Please tell me how to solve this question.
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thank =
you!
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xia=
nghonglee
>=20
>=20
>=20
--557981400-1276597042-1408108561=:28244--
