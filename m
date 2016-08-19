From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore metadata write overhead
Date: Fri, 19 Aug 2016 17:07:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608191706420.14754@piezo.us.to>
References: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608191358510.10673@piezo.us.to> <BL2PR02MB2115CA2313338720CA844CA3F4160@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbcHSRHk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 13:07:40 -0400
In-Reply-To: <BL2PR02MB2115CA2313338720CA844CA3F4160@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Broken united wifi conspired to keep me from pushing this earlier:

	https://github.com/ceph/ceph/pull/10795

This should resolve it I think?  It does include the wal space in the 
total, which is probably not right, but that should be a rounding error.

sage

On Fri, 19 Aug 2016, Somnath Roy wrote:

> Yes, seems something wrong..Here is the 'ceph df' on a freshly created cluster with no data.
> 
> root@stormeap-1:~/fio_rbd/fio/examples# ceph df
> 2016-08-19 09:47:45.714539 7f7fd3ed9700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-19 09:47:45.717589 7f7fd3ed9700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-19 09:47:45.718583 7f7fd3ed9700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> GLOBAL:
>     SIZE     AVAIL       RAW USED     %RAW USED
>     106T     100536G        8742G          8.00
> POOLS:
>     NAME              ID     USED     %USED     MAX AVAIL     OBJECTS
>     recovery_test     1        16         0        50268G           3
> 
> It is saying 8TB RAW used , I will take a look.
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, August 19, 2016 7:00 AM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: BlueStore metadata write overhead
> 
> On Thu, 18 Aug 2016, Somnath Roy wrote:
> > Sage, Here is some estimate probably how much extra (space wise) we
> > are writing with Bluestore. Considering Rocksdb has not much space amp
> > for level style compaction , these are mostly the metadata Bluestore
> > is writing.
> >
> > BlueStore:
> > ----------------
> > root@stormeap-1:~/fio_rbd/fio/examples# ceph df
> > 2016-08-17 11:00:57.936952 7f5c39a2b700 -1 WARNING: the following
> > dangerous and experimental features are enabled: bluestore,rocksdb
> > 2016-08-17 11:00:57.939969 7f5c39a2b700 -1 WARNING: the following
> > dangerous and experimental features are enabled: bluestore,rocksdb
> > 2016-08-17 11:00:57.941269 7f5c39a2b700 -1 WARNING: the following
> > dangerous and experimental features are enabled: bluestore,rocksdb
> > GLOBAL:
> >     SIZE     AVAIL      RAW USED     %RAW USED
> >     106T     22411G       86867G         79.49
> > POOLS:
> >     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
> >     recovery_test     1      39062G     71.49         6290G     10000003
> >
> >
> > So, if we trust the statfs implementation of Bluestore , it is  writing ~8743 GB more.  Total data  = image size of 39062 GB * replication 2 = ~78124 GB. So, ~11.19% more.
> > BTW, this is after 1MB image preconditioning only, filling with 4K blocksize will be adding more metadata.
> >
> > Filestore:
> > -----------
> > GLOBAL:
> >     SIZE     AVAIL      RAW USED     %RAW USED
> >     109T     34443G       78147G         69.41
> > POOLS:
> >     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
> >     recovery_test     2      39062G     69.39        12930G     10000003
> >
> > So, in the similar setup , filestore is writing only ~23GB extra and
> > i.e ~0.029%
> 
> This seems like a lot for bluestore.  The statfs output from bluestore should show how much of the space is bluefs vs bluestore.
> 
> Hmm, my guess is that bluestore is counting all of the space that it has given to bluefs as used, even though bluefs isn't using it.  Probably just need to make BlueStore::statfs() call BlueFs::statfs() and correct for the bluefs unused space...
> 
> sage
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
