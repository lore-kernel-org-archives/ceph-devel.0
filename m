From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Stale NFS file handle
Date: Tue, 14 Feb 2012 01:51:53 +0100
Message-ID: <2047170.AK8tFQQFuI@mranderson>
References: <7386587.xNpCPNsyj0@mranderson> <4477620.YaFairnoV9@mranderson> <Pine.LNX.4.64.1202131553310.32014@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:56387 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158Ab2BNAv7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 19:51:59 -0500
In-Reply-To: <Pine.LNX.4.64.1202131553310.32014@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 2012. February 13. 15:54:39 Sage Weil wrote:
> On Tue, 14 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> > No, there's no NFS in the picture. The OSDs' backend storage is on =
a
> > local filesystem. I think it's the FUSE client telling me this.
>=20
> Okay, that sounds like a bug then.  The two interesting things would =
be a
> ceph-fuse log (--debug-client 10 --debug-ms 1 --log-file /path/to/log=
) and
> an mds log (debug mds =3D 20, debug ms =3D 1 in [mds] section of ceph=
=2Econf).

Thanks, I've set it up, now waiting for it to break. ;)

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
