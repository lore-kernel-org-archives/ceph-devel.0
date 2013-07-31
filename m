From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Blueprint:  Add LevelDB support to ceph cluster backend store
Date: Wed, 31 Jul 2013 14:38:11 +0800
Message-ID: <D1BCFB84-8694-461C-A81B-2A7E1E8CF4D4@gmail.com>
References: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com> <alpine.DEB.2.00.1307302251510.24945@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:64491 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3GaGiS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 02:38:18 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so381097pdc.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 23:38:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1307302251510.24945@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


2013-7-31=A3=AC 2:01=A3=AC Sage Weil <sage@inktank.com> wrote:

> Hi Haomai,
>=20
> On Wed, 31 Jul 2013, Haomai Wang wrote:
>> Every node of ceph cluster has a backend filesystem such as btrfs,
>> xfs and ext4 that provides storage for data objects, whose location
>> are determined by CRUSH algorithm. There should exists an abstract
>> interface sitting between osd and backend store, allowing different
>> backend store implementation. Currently, we only have general=20
>> POSIX interface. LevelDB is a fast key-value storage library written=
 at=20
>> Google that provides an ordered mapping from string keys to string=20
>> values. We could implement a LevelDB backend to support base=20
>> operations correspond to POSIX operations.  LevelDB driver enables=20
>> gateway to communicate with LevelDB to store objects on the node=20
>> basis.
>>=20
>>=20
>> LevelDB driver is attractive by the folks who own a special use case=
=20
>> such as a write-heave system. If we can abstract a general interface=
,=20
>> we can choose other DBM if you find it more suitable, such as Kyoto=20
>> Cabinet, BDB. Futhermore, we can choose backen store for each OSD
>> node. So we have different OSD type for special purpose.
>>=20
>> Expected Results: Objects can be stored reliably to LevelDB. The IO=20
>> performance and recovery process can be comparable to original=20
>> stores. And for special case, LevelDB driver should have much better=
=20
>> performance than local filesystem backend driver. The snapshot and
>> any features you think of are optional.
>=20
> I added a comment in the wiki, but I'll reply here.
>=20
> Much of what you're talking about is already in place:
>=20
> - There is an ObjectStore.h abstraction of the local storage.  The on=
ly=20
>   up to date implementation is FileStore, which uses a combination=20
>   of a local file system and leveldb, but other backends have been us=
ed=20
>   in the past, and new ones can we easily added in.
>=20
> - We currently use leveldb for the 'omap' component of rados objects.=
 =20
>   That is, each rados object has a bytestream portion (like a file),=20
>   attr (like extended attributes), and an omap (keys/values).  All of=
=20
>   none of those interfaces can be used for any given object, although=
=20
>   most users only use one interface at a time.  The main limitation h=
ere=20
>   if you want to use leveldb only is that we still have an inode in t=
he=20
>   file system to represent each object, even when it contains only=20
>   key/value pairs.
>=20
> - The use of leveldb itself is also well abstracted by a KeyValueDB=20
>   interface, so other key/value libraries could be swapped in in its=20
>   place.  The main other component is a middle layer that wraps the k=
v=20
>   store to provide copy-on-write type semantics for each object's set=
 of=20
>   keys (to facilitate the snapshot functionality in rados/ceph).
>=20
> If you have a workload that you want to be purgely key/value based, i=
t=20
> would be possible to write a much simpler ObjectStore implementation =
that=20
> ignores or trivially implements the byte and attr portions of the obj=
ect=20
> in leveldb (or the KeyValueDB abstraction).  It would have very diffe=
rent=20
> performance characteristics than what we're doing now, of course.  Yo=
u=20
> might also be interested in looking at the HyperLevelDB project, whic=
h is=20
> a fork of leveldb that focuses on multithreading and compaction=20
> performance.
I'm happy to hear it.=20

I think there may exists one thing you may leave out.  If we abstract a=
 unified
or more different interfaces, we can allow different pool to use in dif=
ferent
situation. For example, there exists two LevelDB backend OSD nodes form=
ing
up a distributed k/v store, three Btrfs OSD nodes forming up a traditio=
nal use case.
More imaging space will be given to users.
>=20
> We've heard from other people who are interested in wiring different=20
> key/value backends into the OSD, so any work to make it easier to do =
that=20
> would be great!
>=20
> sage

Best regards,
Wheats



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
