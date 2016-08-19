From: Mark Nelson <mnelson@redhat.com>
Subject: Re: BlueStore metadata write overhead
Date: Fri, 19 Aug 2016 06:52:47 -0500
Message-ID: <f5040ff2-325a-10f0-7404-54ba922a3e19@redhat.com>
References: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbcHSLwz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 07:52:55 -0400
In-Reply-To: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Somnath,

Did you have checksums and/or compression enabled during these tests for 
bluestore?

Mark

On 08/18/2016 06:10 PM, Somnath Roy wrote:
> Sage,
> Here is some estimate probably how much extra (space wise) we are writing with Bluestore. Considering Rocksdb has not much space amp for level style compaction , these are mostly the metadata Bluestore is writing.
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
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
