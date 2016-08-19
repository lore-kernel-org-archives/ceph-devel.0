From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: BlueStore metadata write overhead
Date: Fri, 19 Aug 2016 17:03:01 +0000
Message-ID: <BL2PR02MB2115CA2313338720CA844CA3F4160@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608191358510.10673@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:50096
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753916AbcHSRDF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 13:03:05 -0400
In-Reply-To: <alpine.DEB.2.11.1608191358510.10673@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, seems something wrong..Here is the 'ceph df' on a freshly created clus=
ter with no data.

root@stormeap-1:~/fio_rbd/fio/examples# ceph df
2016-08-19 09:47:45.714539 7f7fd3ed9700 -1 WARNING: the following dangerous=
 and experimental features are enabled: bluestore,rocksdb
2016-08-19 09:47:45.717589 7f7fd3ed9700 -1 WARNING: the following dangerous=
 and experimental features are enabled: bluestore,rocksdb
2016-08-19 09:47:45.718583 7f7fd3ed9700 -1 WARNING: the following dangerous=
 and experimental features are enabled: bluestore,rocksdb
GLOBAL:
    SIZE     AVAIL       RAW USED     %RAW USED
    106T     100536G        8742G          8.00
POOLS:
    NAME              ID     USED     %USED     MAX AVAIL     OBJECTS
    recovery_test     1        16         0        50268G           3

It is saying 8TB RAW used , I will take a look.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Friday, August 19, 2016 7:00 AM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: Re: BlueStore metadata write overhead

On Thu, 18 Aug 2016, Somnath Roy wrote:
> Sage, Here is some estimate probably how much extra (space wise) we
> are writing with Bluestore. Considering Rocksdb has not much space amp
> for level style compaction , these are mostly the metadata Bluestore
> is writing.
>
> BlueStore:
> ----------------
> root@stormeap-1:~/fio_rbd/fio/examples# ceph df
> 2016-08-17 11:00:57.936952 7f5c39a2b700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-17 11:00:57.939969 7f5c39a2b700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-17 11:00:57.941269 7f5c39a2b700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> GLOBAL:
>     SIZE     AVAIL      RAW USED     %RAW USED
>     106T     22411G       86867G         79.49
> POOLS:
>     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
>     recovery_test     1      39062G     71.49         6290G     10000003
>
>
> So, if we trust the statfs implementation of Bluestore , it is  writing ~=
8743 GB more.  Total data  =3D image size of 39062 GB * replication 2 =3D ~=
78124 GB. So, ~11.19% more.
> BTW, this is after 1MB image preconditioning only, filling with 4K blocks=
ize will be adding more metadata.
>
> Filestore:
> -----------
> GLOBAL:
>     SIZE     AVAIL      RAW USED     %RAW USED
>     109T     34443G       78147G         69.41
> POOLS:
>     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
>     recovery_test     2      39062G     69.39        12930G     10000003
>
> So, in the similar setup , filestore is writing only ~23GB extra and
> i.e ~0.029%

This seems like a lot for bluestore.  The statfs output from bluestore shou=
ld show how much of the space is bluefs vs bluestore.

Hmm, my guess is that bluestore is counting all of the space that it has gi=
ven to bluefs as used, even though bluefs isn't using it.  Probably just ne=
ed to make BlueStore::statfs() call BlueFs::statfs() and correct for the bl=
uefs unused space...

sage
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
