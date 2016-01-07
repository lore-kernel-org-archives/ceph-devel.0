From: "peng.hse" <peng.hse@xtaotech.com>
Subject: Re: Is BlueFS an alternative of BlueStore?
Date: Thu, 7 Jan 2016 22:37:15 +0800
Message-ID: <568E781B.4030803@xtaotech.com>
References: <568DE333.7070206@xtaotech.com>
 <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:37149 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbcAGOnj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 09:43:39 -0500
In-Reply-To: <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Javen Wu <javen.wu@xtaotech.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

thanks for your quick response. Javen and I  once the zfs developer,are=
=20
currently focusing on how to
leverage some of the zfs ideas to improve the ceph backend performance=20
in userspace.


Based on your encouraging reply, we come up with 2 schemes to continue=20
our future work

1. the scheme one: using the entire new FS to replace rocksdb+bluefs,=20
the FS itself handles the mapping of
     oid->fs-object(kind of zfs dnode) and the according attrs used by =
ceph.
    Despite the implemention challenges you mentioned about the in-orde=
r=20
enumeration of objects during backfill, scrub, etc (the
     same situation we also confronted in zfs, the ZAP features help us=
=20
a lot).
     From performance or architecture point of view, it looks more clea=
r=20
and clean, would you suggest us to give a try ?

2. the scheme two: As your last suspect, we just temporarily implemente=
d=20
the simple version of the FS
      which leverage libzpool ideas to plug into rocksdb underneath as=20
your bluefs did

precious your insightful reply.

Thanks



On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 21:19, Sage Weil wrote:
> On Thu, 7 Jan 2016, Javen Wu wrote:
>> Hi Sage,
>>
>> Sorry to bother you. I am not sure if it is appropriate to send emai=
l to you
>> directly, but I cannot find any useful information to address my con=
fusion
>> from Internet. Hope you can help me.
>>
>> Occasionally, I heard that you are going to start BlueFS to eliminat=
e the
>> redudancy between XFS journal and RocksDB WAL. I am a little confuse=
d.
>> Is the Bluefs only to host RocksDB for BlueStore or it's an
>> alternative of BlueStore?
>>
>> I am a new comer to CEPH, I am not sure my understanding is correct =
about
>> BlueStore. BlueStore in my mind is as below.
>>
>>               BlueStore
>>               =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     RocksDB
>> +-----------+          +-----------+
>> |   onode   |          |           |
>> |    WAL    |          |           |
>> |   omap    |          |           |
>> +-----------+          |   bdev    |
>> |           |          |           |
>> |   XFS     |          |           |
>> |           |          |           |
>> +-----------+          +-----------+
> This is the picture before BlueFS enters the picture.
>
>> I am curious if BlueFS is able to host RocksDB, actually it's alread=
y a
>> "filesystem" which have to maintain blockmap kind of metadata by its=
 own
>> WITHOUT the help of RocksDB.
> Right.  BlueFS is a really simple "file system" that is *just* compli=
cated
> enough to implement the rocksdb::Env interface, which is what rocksdb
> needs to store its log and sst files.  The after picture looks like
>
>   +--------------------+
>   |     bluestore      |
>   +----------+         |
>   | rocksdb  |         |
>   +----------+         |
>   |  bluefs  |         |
>   +----------+---------+
>   |    block device    |
>   +--------------------+
>
>> The reason we care the intention and the design target of BlueFS is =
that I had
>> discussion with my partner Peng.Hse about an idea to introduce a new
>> ObjectStore using ZFS library. I know CEPH supports ZFS as FileStore=
 backend
>> already, but we had a different immature idea to use libzpool to imp=
lement a
>> new
>> ObjectStore for CEPH totally in userspace without SPL and ZOL kernel=
 module.
>> So that we can align CEPH transaction and zfs transaction in order t=
o  avoid
>> double write for CEPH journal.
>> ZFS core part libzpool (DMU, metaslab etc) offers a dnode object sto=
re and
>> it's platform kernel/user independent. Another benefit for the idea =
is we
>> can extend our metadata without bothering any DBStore.
>>
>> Frankly, we are not sure if our idea is realistic so far, but when I=
 heard of
>> BlueFS, I think we need to know the BlueFS design goal.
> I think it makes a lot of sense, but there are a few challenges.  One
> reason we use rocksdb (or a similar kv store) is that we need in-orde=
r
> enumeration of objects in order to do collection listing (needed for
> backfill, scrub, and omap).  You'll need something similar on top of =
zfs.
>
> I suspect the simplest path would be to also implement the rocksdb::E=
nv
> interface on top of the zfs libraries.  See BlueRocksEnv.{cc,h} to se=
e the
> interface that has to be implemented...
>
> sage
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
