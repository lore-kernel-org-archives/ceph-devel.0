From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore::fsck() during mkfs()
Date: Wed, 31 Aug 2016 21:42:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608312142220.19032@piezo.us.to>
References: <BL2PR02MB211583CCF7ABCA3F4C0CABF7F4E30@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608312120040.24099@piezo.us.to> <BL2PR02MB2115EC510AF3C9EBED27E3CEF4E30@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753103AbcHaVmp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 17:42:45 -0400
In-Reply-To: <BL2PR02MB2115EC510AF3C9EBED27E3CEF4E30@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Okay, let's just turn it off by default, but enable it for the 
tests.


On Wed, 31 Aug 2016, Somnath Roy wrote:

> I am using stupid allocator. With fsck() on , it is >5x slower. If I enable bitmap allocator, it will be ~10X slow.
> I saw most of the time spent on checking freelist vs allocated (~22sec).
> 
> 2016-08-31 17:30:45.614947 7f730b1378c0  1 bluestore(/var/lib/ceph/osd/ceph-7) fsck checking freelist vs allocated
> 2016-08-31 17:31:07.638331 7f730b1378c0  1 stupidalloc shutdown
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, August 31, 2016 2:21 PM
> To: Somnath Roy
> Cc: ceph-devel
> Subject: Re: BlueStore::fsck() during mkfs()
> 
> On Wed, 31 Aug 2016, Somnath Roy wrote:
> > Sage,
> > I saw with recent master we have introduced fsck() (and it is 'on' by default) during mkfs() , wondering what is the use case of fsck() during mkfs() ?
> > This is making cluster creation terribly slow for BlueStore.
> 
> I recently fixed a bug where mkfs was creating a store that failed fsck.  I would expect it to be fast, though, if it's empty...
> 
> Oh, is this because of the big in-memory bitmap for allocation?
> sage
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
