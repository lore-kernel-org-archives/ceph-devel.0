From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: ./run-make-check.sh
Date: Fri, 20 Nov 2015 08:21:48 -0500 (EST)
Message-ID: <1072642004.16652865.1448025708481.JavaMail.zimbra@redhat.com>
References: <1842494150.16154755.1447976394788.JavaMail.zimbra@redhat.com> <564ED6AF.2030106@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:54556 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934878AbbKTNWv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 08:22:51 -0500
In-Reply-To: <564ED6AF.2030106@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks, Loic!!!

Am I ought to dig into OSD.cc, or is that message ignorable ?

 Shinobu

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Shinobu Kinjo" <skinjo@redhat.com>, "ceph-devel" <ceph-devel@vger.=
kernel.org>
Sent: Friday, November 20, 2015 5:15:43 PM
Subject: Re: [CEPH-DEVEL] ./run-make-check.sh

Hi,

It is uncommon to run this script as root, there is no need to.

On 20/11/2015 00:39, Shinobu Kinjo wrote:
> Hello,
>=20
> I saw this message during executing run-make-check.sh on fc23:
>=20
> 2015-11-20 01:05:37.529021 7f8742e3d7c0 -1  ** ERROR: error creating =
empty object store in testdir/osd-reactivate/0: (13) Permission denied

Could you publish somewhere (paste2.org for instance) the full output o=
f run-make-check.sh ? It is possible to get EPERM for reasons other tha=
n the underlying file system permission.

Cheers

>=20
> Can we ignore at the moment?
>=20
> If I've missed anything, let me know.
>=20
> Thanks!!
> Shinobu
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
