From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Stale NFS file handle
Date: Tue, 14 Feb 2012 14:20:17 +0100
Message-ID: <6961573.U2on90beo2@mranderson>
References: <7386587.xNpCPNsyj0@mranderson> <CAORUGqDdHPGkBZUV1Hpt5on2hdoYw0z=fFVRcuFb9Mk5CW-KWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:52049 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756246Ab2BNNU1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 08:20:27 -0500
In-Reply-To: <CAORUGqDdHPGkBZUV1Hpt5on2hdoYw0z=fFVRcuFb9Mk5CW-KWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 2012. February 13. 17:04:27 Tommi Virtanen wrote:
> 2012/2/13 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
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
> Is this on a 32-bit machine, by any chance?

No, all machines run 64-bit kernel and 64-bit userspace.

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
