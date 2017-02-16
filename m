From: Wido den Hollander <wido@42on.com>
Subject: Re: Improvement on write performance is more than 100% with the
 bluefs_buffered_io from false to true in ceph version 11.2.0 and HDD disks
Date: Thu, 16 Feb 2017 15:31:40 +0100 (CET)
Message-ID: <412657564.10154.1487255501123@ox.pcextreme.nl>
References: <DB6PR0701MB22315811FF200B41551F018CED5A0@DB6PR0701MB2231.eurprd07.prod.outlook.com>
 <alpine.DEB.2.11.1702161418580.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39192 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbdBPObq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 09:31:46 -0500
In-Reply-To: <alpine.DEB.2.11.1702161418580.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ruiz Alonso, Jaime Jesus (Nokia - ES)" <jaime_jesus.ruiz_alonso@nokia.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


> Op 16 februari 2017 om 15:24 schreef Sage Weil <sweil@redhat.com>:
> 
> 
> On Thu, 16 Feb 2017, Ruiz Alonso, Jaime Jesus (Nokia - ES) wrote:
> > 
> > Thanks a lot for your help,
> > 
> > We left the test running with this change ( bluefs_buffered_io set to true )
> > and we observed a radical increase on performance.
> > 
> > Effects of the change on our only write test:
> > 
> > - No reads from disk ( before change were in the 500 r/s range )
> > - Minimum Write bandwidth moved from 12 MBps to 24 MBps
> > 
> > Attached Sheet "Test1-2_Kraken_11.2_iotrue" in the xls.
> > 
> > See attached pictures.
> > 
> > Best Regards,
> > Jaime
> 
> Thanks for testing!  This suggests to me that even a simple LRU write 
> buffer cache in bluefs to catch recently compacted SSTs will be enough to 
> prime the rocksdb kv cache.  Either that or we need to do the same in 
> rocksdb itself, but they didn't seem very interested in doing that in the 
> general case.  Our situation is a bit atypical in that we'd prefer to 
> eliminate the dependence on the OS page cache so that we can work with 
> SPDK.
> 

What would be the true downside of setting bluefs_buffered_io to true in the default config?

Wido

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
