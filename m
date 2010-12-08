From: Sage Weil <sage@newdream.net>
Subject: Re: installation: where do I start debugging this error?
Date: Tue, 7 Dec 2010 21:32:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012072132010.5044@cobra.newdream.net>
References: <AANLkTinfNC1fXqynJ8abp8Ms8GpkLN806MgpCvGaJiCe@mail.gmail.com>
 <1291775597.1958.5.camel@cephhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-425127044-1291786369=:5044"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53097 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab0LHF17 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Dec 2010 00:27:59 -0500
In-Reply-To: <1291775597.1958.5.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-425127044-1291786369=:5044
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Dec 2010, Jeff Wu wrote:
> Hi ,i take the followng steps , fail to mount,too.
>=20
> ## save auth secret to a file:
> $cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
> chmod 600 /etc/ceph/secret
> ## future ,support,read a secret from a file
> $ mount -t ceph 172.16.50.10:6789:/foo /mnt/ceph =20
>    -o name=3Dadmin,secretfile=3Dsecret
>=20
> but ,the following steps ,mount ceph is successful.
>=20
>=20
> # enable cephx, add a user and secret
>     $ mount -t ceph -o name=3Dadmin,secret=3D<secret>=20
>        1.2.3.4:/ /mnt/ceph
> $ mount -t ceph 172.16.50.10:6791:/foo /mnt/ceph=20
>     -o name=3Dadmin,secret=3D=FF=FFAQArWtdMiI1uDRAAVbNRMeiwsjK+DEMeB7ewLg=
=3D=3D=FF=FF

The 'secretfile=3D' option only works if /sbin/mount.ceph is present.  Mayb=
e=20
that didn't get installed by the rpm?  mount.ceph is also what lets you=20
specify a hostname instead of an ip.

sage
--557981400-425127044-1291786369=:5044--
