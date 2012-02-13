From: Sage Weil <sage@newdream.net>
Subject: Re: Stale NFS file handle
Date: Mon, 13 Feb 2012 15:54:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202131553310.32014@cobra.newdream.net>
References: <7386587.xNpCPNsyj0@mranderson> <Pine.LNX.4.64.1202131533540.29455@cobra.newdream.net>
 <4477620.YaFairnoV9@mranderson>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-908625562-1329177279=:32014"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55584 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab2BMXyj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 18:54:39 -0500
In-Reply-To: <4477620.YaFairnoV9@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-908625562-1329177279=:32014
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> On 2012. February 13. 15:34:13 Sage Weil wrote:
> > On Tue, 14 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> > > I'm using Ceph 0.41 with the FUSE client. After a while I get stale N=
FS
> > > file errors when trying to read a file or list a directory. Logs and
> > > scrubbing doesn't show any errors or suspicious entries. After
> > > remounting the filesystem either by restarting the cluster thus forci=
ng
> > > the clients to reconnect or umount+mount, files and directories eithe=
r
> > > show up again or seem lost forever.
> > >=20
> > > Can you give me any hint on what to check?
> >=20
> > Are you reexporting NFS, or are you getting ESTALE from the fuse mount
> > itself?
>=20
> No, there's no NFS in the picture. The OSDs' backend storage is on a loca=
l=20
> filesystem. I think it's the FUSE client telling me this.

Okay, that sounds like a bug then.  The two interesting things would be a=
=20
ceph-fuse log (--debug-client 10 --debug-ms 1 --log-file /path/to/log) and=
=20
an mds log (debug mds =3D 20, debug ms =3D 1 in [mds] section of ceph.conf)=
=2E

sage=20
--557981400-908625562-1329177279=:32014--
