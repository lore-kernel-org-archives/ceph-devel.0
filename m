From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Stale NFS file handle
Date: Tue, 14 Feb 2012 00:51:11 +0100
Message-ID: <4477620.YaFairnoV9@mranderson>
References: <7386587.xNpCPNsyj0@mranderson> <Pine.LNX.4.64.1202131533540.29455@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:60476 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431Ab2BMXvS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 18:51:18 -0500
In-Reply-To: <Pine.LNX.4.64.1202131533540.29455@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 2012. February 13. 15:34:13 Sage Weil wrote:
> On Tue, 14 Feb 2012, Sz=E9kelyi Szabolcs wrote:
> > I'm using Ceph 0.41 with the FUSE client. After a while I get stale=
 NFS
> > file errors when trying to read a file or list a directory. Logs an=
d
> > scrubbing doesn't show any errors or suspicious entries. After
> > remounting the filesystem either by restarting the cluster thus for=
cing
> > the clients to reconnect or umount+mount, files and directories eit=
her
> > show up again or seem lost forever.
> >=20
> > Can you give me any hint on what to check?
>=20
> Are you reexporting NFS, or are you getting ESTALE from the fuse moun=
t
> itself?

No, there's no NFS in the picture. The OSDs' backend storage is on a lo=
cal=20
filesystem. I think it's the FUSE client telling me this.

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
