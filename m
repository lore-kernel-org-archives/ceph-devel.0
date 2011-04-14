From: Sage Weil <sage@newdream.net>
Subject: Re: The cache problem of re-export NFS test
Date: Thu, 14 Apr 2011 10:12:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104141008470.9026@cobra.newdream.net>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
 <Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
 <BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-52260151-1302801136=:9026"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39198 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758416Ab1DNRIk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 13:08:40 -0400
In-Reply-To: <BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-52260151-1302801136=:9026
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Apr 2011, Sylar Shen wrote:
> Hi Sage,
> Thanks for your reply. I really appreciated.
> I tried what you suggested to set the argument "sync" in /etc/exports.
> I also checked "man 5 exports" and it showed that sync means reply to
> requests only after the changes have been committed to stable storage.
> It didn't mention that the export server won't do the cache task.
> However, after I did the experiment, I found that the memory usage of
> Ceph-client still went up to maximum value while writing the data
> which means Ceph-client did the cache task.

Right: 'sync' will make it write-through and flush the data to disk, but=20
it will still keep a copy in the page cache.

> So...are there other possible ways to solve my problem?

Are you sure it's a problem?  Caching is usually a good thing.  If you're=
=20
worried about safety, 'sync' solves that.  If you're worried about memory=
=20
usage, you may not need to be.  The kernel will always use as much free=20
ram as is available for caching fs data.  That's a normal and good thing. =
=20
It will throw it out as soon as it needs the memory for something else.

I think the only case where that might be problematic is if you have other=
=20
local file systems and want to make sure the memory is used for those=20
instead of ceph.  I'm not aware of a way to do that...

sage




> Thanks~~
>=20
> Best Regards,
> Sylar Shen
>=20
> 2011/4/12 Sage Weil <sage@newdream.net>:
> > On Tue, 12 Apr 2011, Sylar Shen wrote:
> >> Hi developers,
> >> I know that the following question may not be relative to Ceph but
> >> this confuses me a lot.
> >> I am testing the function of re-exporting nfs by command "dd" without
> >> using buffer.
> >> That means I would like my data to be written to Ceph DFS directly
> >> without passing by the buffer of client or nfs-client.
> >> Here is my test architecture. Hope you could understand what I am
> >> trying to express.....:p
> >> ----------------------------------------------------------------------=
--------
> >> =A0 =A0 =A0 =A0 =A0 =A0    =A0nfs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ceph protocol
> >> Client <------------>Ceph-Client <-------------------> Ceph DFS
> >> ----------------------------------------------------------------------=
--------
> >> I used the command "dd if=3D/dev/zero of=3D/mnt/ceph/test bs=3D64k
> >> count=3D10000 oflag=3Ddsync"
> >> My purpose was to write the data from the client to Ceph DFS through
> >> Ceph-client.
> >> Ceph DFS was mounted by Ceph-client using Ceph protocol and
> >> Ceph-client was mounted by client using nfs protocol.
> >> I know that my dd command with argument oflag=3Ddsync would write the
> >> data to Ceph-client without using buffer on the client.
> >> But I want my Ceph-client could also just pass the data to Ceph DFS
> >> without using its buffer.
> >> So.....is there any way I can run my scenario?
> >> Or in other words, is there any method I can assure that Ceph-client
> >> won't do the buffer task itself?
> >
> > I think what you're looking for is the 'sync' option in /etc/exports on
> > the ceph-client machine. =A0See 'man 5 exports'. =A0That will slow thin=
gs down
> > considerably but will give you the consistency and safety you're lookin=
g
> > for.
> >
> > sage
> >
>=20
>=20
>=20
> --=20
> Best Regards,
> Sylar Shen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-52260151-1302801136=:9026--
