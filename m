From: Javen Wu <javen.wu@xtaotech.com>
Subject: Re: Is BlueFS an alternative of BlueStore?
Date: Thu, 7 Jan 2016 22:40:24 +0800
Message-ID: <568E78D8.8080401@xtaotech.com>
References: <568DE333.7070206@xtaotech.com>
 <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com>
 <568E781B.4030803@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:35973 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbcAGOki (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 09:40:38 -0500
In-Reply-To: <568E781B.4030803@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "peng.hse" <peng.hse@xtaotech.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Thanks Sage for your reply.

I am not sure I understand the challenges you mentioned about=20
backfill/scrub.
I will investigate from the code and let you know if we can conquer the
challenge by easy means.
Our rough idea for ZFSStore are:
1. encapsulate dnode object as onode and add onode attributes.
2. uses ZAP object as collection. (ZFS directory uses ZAP object)
3. enumerating entries in ZAP object is list objects in collection.
4. create a new metaslab class to store CEPH journal.
5. align CEPH journal and ZFS transcation.

Actually we've talked about the possibility of building RocksDB::Env on=
 top
of the zfs libraries. It must align ZIL(ZFS intent log) and RocksDB WAL=
=2E
Otherwise, there is still same problem as XFS and RocksDB.

ZFS is tree style log structure-like file system, once a leaf block upd=
ates,
the modification would be propagated from the leaf to the root of tree.
To batch writes and reduce times of disk write, ZFS persist modificatio=
n=20
to disk
in 5 seconds transaction. Only when Fsync/sync write arrives in the=20
middle of
the 5 seconds, ZFS would persist the journal to ZIL.
I remembered RocksDB would do a sync after log record adding, so it mea=
ns if
we can not align ZIL and WAL, the log write would be write to ZIL=20
firstly and
then apply ZIL to log file, finally Rockdb update sst file. It's almost=
 the
same problem as XFS if my understanding is correct.

In my mind, aligning ZIL and WAL need more modifications in RocksDB.

Thanks
Javen


On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 22:37, peng.hse wrote:
> Hi Sage,
>
> thanks for your quick response. Javen and I  once the zfs=20
> developer,are currently focusing on how to
> leverage some of the zfs ideas to improve the ceph backend performanc=
e=20
> in userspace.
>
>
> Based on your encouraging reply, we come up with 2 schemes to continu=
e=20
> our future work
>
> 1. the scheme one: using the entire new FS to replace rocksdb+bluefs,=
=20
> the FS itself handles the mapping of
>     oid->fs-object(kind of zfs dnode) and the according attrs used by=
=20
> ceph.
>    Despite the implemention challenges you mentioned about the=20
> in-order enumeration of objects during backfill, scrub, etc (the
>     same situation we also confronted in zfs, the ZAP features help u=
s=20
> a lot).
>     From performance or architecture point of view, it looks more=20
> clear and clean, would you suggest us to give a try ?
>
> 2. the scheme two: As your last suspect, we just temporarily=20
> implemented the simple version of the FS
>      which leverage libzpool ideas to plug into rocksdb underneath as=
=20
> your bluefs did
>
> precious your insightful reply.
>
> Thanks
>
>
>
> On 2016=E5=B9=B401=E6=9C=8807=E6=97=A5 21:19, Sage Weil wrote:
>> On Thu, 7 Jan 2016, Javen Wu wrote:
>>> Hi Sage,
>>>
>>> Sorry to bother you. I am not sure if it is appropriate to send=20
>>> email to you
>>> directly, but I cannot find any useful information to address my=20
>>> confusion
>>> from Internet. Hope you can help me.
>>>
>>> Occasionally, I heard that you are going to start BlueFS to=20
>>> eliminate the
>>> redudancy between XFS journal and RocksDB WAL. I am a little confus=
ed.
>>> Is the Bluefs only to host RocksDB for BlueStore or it's an
>>> alternative of BlueStore?
>>>
>>> I am a new comer to CEPH, I am not sure my understanding is correct=
=20
>>> about
>>> BlueStore. BlueStore in my mind is as below.
>>>
>>>               BlueStore
>>>               =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>     RocksDB
>>> +-----------+          +-----------+
>>> |   onode   |          |           |
>>> |    WAL    |          |           |
>>> |   omap    |          |           |
>>> +-----------+          |   bdev    |
>>> |           |          |           |
>>> |   XFS     |          |           |
>>> |           |          |           |
>>> +-----------+          +-----------+
>> This is the picture before BlueFS enters the picture.
>>
>>> I am curious if BlueFS is able to host RocksDB, actually it's alrea=
dy a
>>> "filesystem" which have to maintain blockmap kind of metadata by it=
s=20
>>> own
>>> WITHOUT the help of RocksDB.
>> Right.  BlueFS is a really simple "file system" that is *just*=20
>> complicated
>> enough to implement the rocksdb::Env interface, which is what rocksd=
b
>> needs to store its log and sst files.  The after picture looks like
>>
>>   +--------------------+
>>   |     bluestore      |
>>   +----------+         |
>>   | rocksdb  |         |
>>   +----------+         |
>>   |  bluefs  |         |
>>   +----------+---------+
>>   |    block device    |
>>   +--------------------+
>>
>>> The reason we care the intention and the design target of BlueFS is=
=20
>>> that I had
>>> discussion with my partner Peng.Hse about an idea to introduce a ne=
w
>>> ObjectStore using ZFS library. I know CEPH supports ZFS as FileStor=
e=20
>>> backend
>>> already, but we had a different immature idea to use libzpool to=20
>>> implement a
>>> new
>>> ObjectStore for CEPH totally in userspace without SPL and ZOL kerne=
l=20
>>> module.
>>> So that we can align CEPH transaction and zfs transaction in order=20
>>> to  avoid
>>> double write for CEPH journal.
>>> ZFS core part libzpool (DMU, metaslab etc) offers a dnode object=20
>>> store and
>>> it's platform kernel/user independent. Another benefit for the idea=
=20
>>> is we
>>> can extend our metadata without bothering any DBStore.
>>>
>>> Frankly, we are not sure if our idea is realistic so far, but when =
I=20
>>> heard of
>>> BlueFS, I think we need to know the BlueFS design goal.
>> I think it makes a lot of sense, but there are a few challenges.  On=
e
>> reason we use rocksdb (or a similar kv store) is that we need in-ord=
er
>> enumeration of objects in order to do collection listing (needed for
>> backfill, scrub, and omap).  You'll need something similar on top of=
=20
>> zfs.
>>
>> I suspect the simplest path would be to also implement the rocksdb::=
Env
>> interface on top of the zfs libraries.  See BlueRocksEnv.{cc,h} to=20
>> see the
>> interface that has to be implemented...
>>
>> sage
>>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
