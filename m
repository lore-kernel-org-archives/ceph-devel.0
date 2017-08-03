From: Mike A <mike.almateia@gmail.com>
Subject: Re: recommended rocksdb/rockswal sizes when using SSD/HDD
Date: Thu, 3 Aug 2017 16:07:27 +0300
Message-ID: <4E87CD84-891B-4115-ACFA-CEC5C562EBB7@gmail.com>
References: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
 <alpine.DEB.2.11.1708022129210.20435@piezo.novalocal>
 <4c48ba58-0ee2-e565-bb56-b8c2cb860a2f@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34910 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdHCNHe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 09:07:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id w199so914474lff.2
        for <ceph-devel@vger.kernel.org>; Thu, 03 Aug 2017 06:07:34 -0700 (PDT)
In-Reply-To: <4c48ba58-0ee2-e565-bb56-b8c2cb860a2f@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "McFarland, Bruce" <Bruce.McFarland@Teradata.com>, Ceph Development <ceph-devel@vger.kernel.org>


> 3 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3., =D0=B2 1:23, Mark Nelson =
<mark.a.nelson@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>=20
>=20
>=20
> On 08/02/2017 04:32 PM, Sage Weil wrote:
>> On Wed, 2 Aug 2017, McFarland, Bruce wrote:
>>> I=E2=80=99m using SDD for the rocksdb/rockswal partitions and =
putting the data
>>> on HDD=E2=80=99s. What is the recommended sizing for these =
partitions. I=E2=80=99ve read
>>> various sizes discussed on the perf call and know that the code =
defaults
>>> of 128MB for rocksdb is small and limits performance. What are the
>>> recommended sizes for these partitions?
>> tl;dr: 1GB for block.wal.  For block.db, as much as you have.
>> For an RBD-only pool, my guess is you want around 1-2% of your total
>> storage, but I'm guessing... we need to deploy a real-ish RBD =
workload and
>> see what the ratio is in practice.  Mark can probably give us a =
worst-case
>> value (after a long-running 4kb random-write workload).
>> Omap data will go to block.db (if it will fit), so for RGW clusters =
there
>> may be more.  OTOH, the object metadata will be smaller (immutable
>> objects, sequentially written), so it depends on how big your RGW =
objects
>> are.  We have no real-world data on this yet.
>=20
>=20
> While this wasn't 4k writes to 4MB rbd blocks, I noticed that with 4kb =
rados bench objects I was able to fill up an 8GB DB partition and start =
to see write slowdowns (without bloom filters in place) associated with =
HDD disk reads from rocksdb after about 670K objects (target was 2M =
objects).  When increased to 98GB, I was able to write out the 2M =
objects without slowdown. That would indicate that in that test at =
least, the final amount of DB space being used for each 4K object after =
counting for our own overhead and rocksdb's space amp (We are heavily =
tuning to favor write amp!) could be as high as 12.5KB (there's other =
stuff in the DB besides object metadata, so it's probably lower than =
this in reality).
>=20
> I don't think rocksdb's space amplification is necessarily going to be =
a constant factor either (even assuming a similar ratio of key =
prefixes/etc).  With LSM a key may with older versions potentially can =
be in multiple files and fragmentation is also going to affect SA.  We =
also are leaking at least some WAL data into the DB (though a much lower =
amount with our current settings than I was originally worried about).
>=20
> The good news is that bloom filters help pretty dramatically when =
metadata roles over to HDD.  I think maybe the general message should be =
that the bigger the flash db partition the better, but it's still worth =
investing in power-loss-protection and write durability when using the =
SSD as a WAL (And DB).
>=20
> Mark
>=20
Thanks for that info.

If I have 12 SSD 4tb disks and random 4K workload, is it enough have a =
one 32Gb NVDIMM storage for rocksdb and WAL for all 12 disks?
With your information I see that it=E2=80=99s not.=20
Each 4Tb disks can hold around 960K 4K objects and need around 12Gb =
storage space.=20
it=E2=80=99s sufficient for best perfomance to place a rocksDB on the =
same SSD disk, with which rocksDB is working?=
