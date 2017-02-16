From: Sage Weil <sweil@redhat.com>
Subject: Re: Improvement on write performance is more than 100% with the
 bluefs_buffered_io from false to true in ceph version 11.2.0 and HDD disks
Date: Thu, 16 Feb 2017 14:36:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702161433570.7782@piezo.novalocal>
References: <DB6PR0701MB22315811FF200B41551F018CED5A0@DB6PR0701MB2231.eurprd07.prod.outlook.com> <alpine.DEB.2.11.1702161418580.7782@piezo.novalocal> <412657564.10154.1487255501123@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbdBPOgP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Feb 2017 09:36:15 -0500
In-Reply-To: <412657564.10154.1487255501123@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "Ruiz Alonso, Jaime Jesus (Nokia - ES)" <jaime_jesus.ruiz_alonso@nokia.com>, ceph-devel@vger.kernel.org

On Thu, 16 Feb 2017, Wido den Hollander wrote:
> > Op 16 februari 2017 om 15:24 schreef Sage Weil <sweil@redhat.com>:
> > 
> > 
> > On Thu, 16 Feb 2017, Ruiz Alonso, Jaime Jesus (Nokia - ES) wrote:
> > > 
> > > Thanks a lot for your help,
> > > 
> > > We left the test running with this change ( bluefs_buffered_io set to true )
> > > and we observed a radical increase on performance.
> > > 
> > > Effects of the change on our only write test:
> > > 
> > > - No reads from disk ( before change were in the 500 r/s range )
> > > - Minimum Write bandwidth moved from 12 MBps to 24 MBps
> > > 
> > > Attached Sheet "Test1-2_Kraken_11.2_iotrue" in the xls.
> > > 
> > > See attached pictures.
> > > 
> > > Best Regards,
> > > Jaime
> > 
> > Thanks for testing!  This suggests to me that even a simple LRU write 
> > buffer cache in bluefs to catch recently compacted SSTs will be enough to 
> > prime the rocksdb kv cache.  Either that or we need to do the same in 
> > rocksdb itself, but they didn't seem very interested in doing that in the 
> > general case.  Our situation is a bit atypical in that we'd prefer to 
> > eliminate the dependence on the OS page cache so that we can work with 
> > SPDK.
> > 
> 
> What would be the true downside of setting bluefs_buffered_io to true in 
> the default config?

For now, I think none.  I'll change the default until we have a better 
solution.  I was hoping we could get by without it but it seems not!

Eventually I want ot remove the buffered code entirely, though, which 
means we need to get the same caching behavior in some other way.  I think 
it will be pretty easy to do that in bluefs, though, with minimal code.

sage
