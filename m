From: Sage Weil <sweil@redhat.com>
Subject: Re: Improvement on write performance is more than 100% with the
 bluefs_buffered_io from false to true in ceph version 11.2.0 and HDD disks
Date: Thu, 16 Feb 2017 14:24:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702161418580.7782@piezo.novalocal>
References: <DB6PR0701MB22315811FF200B41551F018CED5A0@DB6PR0701MB2231.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbdBPOYw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Feb 2017 09:24:52 -0500
In-Reply-To: <DB6PR0701MB22315811FF200B41551F018CED5A0@DB6PR0701MB2231.eurprd07.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ruiz Alonso, Jaime Jesus (Nokia - ES)" <jaime_jesus.ruiz_alonso@nokia.com>
Cc: "mnelson@redhat.com" <mnelson@redhat.com>, ceph-devel@vger.kernel.org

On Thu, 16 Feb 2017, Ruiz Alonso, Jaime Jesus (Nokia - ES) wrote:
> 
> Thanks a lot for your help,
> 
> We left the test running with this change ( bluefs_buffered_io set to true )
> and we observed a radical increase on performance.
> 
> Effects of the change on our only write test:
> 
> - No reads from disk ( before change were in the 500 r/s range )
> - Minimum Write bandwidth moved from 12 MBps to 24 MBps
> 
> Attached Sheet "Test1-2_Kraken_11.2_iotrue" in the xls.
> 
> See attached pictures.
> 
> Best Regards,
> Jaime

Thanks for testing!  This suggests to me that even a simple LRU write 
buffer cache in bluefs to catch recently compacted SSTs will be enough to 
prime the rocksdb kv cache.  Either that or we need to do the same in 
rocksdb itself, but they didn't seem very interested in doing that in the 
general case.  Our situation is a bit atypical in that we'd prefer to 
eliminate the dependence on the OS page cache so that we can work with 
SPDK.

sage
