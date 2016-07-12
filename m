From: Sage Weil <sage@newdream.net>
Subject: RE: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 16:57:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607121656420.22089@piezo.us.to>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com> <BL2PR02MB2115078CDAD92FC1F7612B35F4300@BL2PR02MB2115.namprd02.prod.outlook.com> <56ae4a08-0f34-a843-3cbc-9832faddc030@redhat.com> <86ec3393-dfea-02df-df74-97cca42aaae1@mirantis.com>
 <e2538609-7724-5e2f-b71a-8a32c45f4479@redhat.com> <ad19ecba-2dab-6cb3-e193-0da3d5d06da8@mirantis.com> <fcd816f1-057d-7cc7-d989-4c8ee5ede2db@redhat.com> <BL2PR02MB2115FC2AABEC8FA6055680F5F4300@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1607121655130.497@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60640 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcGLQ5L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 12:57:11 -0400
In-Reply-To: <alpine.DEB.2.11.1607121655130.497@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 12 Jul 2016, Sage Weil wrote:
> On Tue, 12 Jul 2016, Somnath Roy wrote:
> > Mark,
> > Recently, the default allocator is changed to Bitmap and I saw it is 
> > returning < 0 return value only in the following case.
> > 
> >   count = m_bit_alloc->alloc_blocks_res(nblks, &start_blk);
> >   if (count == 0) {
> >     return -ENOSPC;
> >   }
> > 
> > So, it seems it may not be the memory but db partition is getting out of 
> > space (?). I never faced it so far as I was running with 100GB of db 
> > partition may be. The amount of metadata write going on to the db even 
> > after onode diet is starting from ~1K and over time it is reaching > 4k 
> > or so (I checked for 4K RW). It is growing as extents are growing. So, 8 
> > GB may not be enough. If this is true, next challenge is , how to 
> > automatically (or document) the size of rocksdb db partition based on 
> > the data partition size. For example, in the ZS case, we have calculated 
> > that we need ~9G db space per TB. We need to do similar calculation for 
> > rocksbd as well.
> 
> We can precalculate or otherwise pre-size the db partition because we 
     ^
     can't

> don't know what kind of data the user is going to store, and that data 
> might even be 100% omap.  This is why BlueStore and BlueFS balance their 
> free space--so that the bluefs/db usage can grow and shrink dynamically as 
> needed.
> 
> We'll need to implement something similar for ZS.
> 
> sage
