From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueStore metadata write overhead
Date: Fri, 19 Aug 2016 14:00:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608191358510.10673@piezo.us.to>
References: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754215AbcHSOAU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 10:00:20 -0400
In-Reply-To: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 18 Aug 2016, Somnath Roy wrote:
> Sage, Here is some estimate probably how much extra (space wise) we are 
> writing with Bluestore. Considering Rocksdb has not much space amp for 
> level style compaction , these are mostly the metadata Bluestore is 
> writing.
> 
> BlueStore:
> ----------------
> root@stormeap-1:~/fio_rbd/fio/examples# ceph df
> 2016-08-17 11:00:57.936952 7f5c39a2b700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-17 11:00:57.939969 7f5c39a2b700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-17 11:00:57.941269 7f5c39a2b700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> GLOBAL:
>     SIZE     AVAIL      RAW USED     %RAW USED
>     106T     22411G       86867G         79.49
> POOLS:
>     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
>     recovery_test     1      39062G     71.49         6290G     10000003
> 
> 
> So, if we trust the statfs implementation of Bluestore , it is  writing ~8743 GB more.  Total data  = image size of 39062 GB * replication 2 = ~78124 GB. So, ~11.19% more.
> BTW, this is after 1MB image preconditioning only, filling with 4K blocksize will be adding more metadata.
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
> So, in the similar setup , filestore is writing only ~23GB extra and i.e ~0.029%

This seems like a lot for bluestore.  The statfs output from bluestore 
should show how much of the space is bluefs vs bluestore.

Hmm, my guess is that bluestore is counting all of the space that it has 
given to bluefs as used, even though bluefs isn't using it.  Probably 
just need to make BlueStore::statfs() call BlueFs::statfs() and correct 
for the bluefs unused space...

sage
