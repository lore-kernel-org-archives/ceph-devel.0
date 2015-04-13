From: Sage Weil <sweil@redhat.com>
Subject: RE: Newstore get_omap_iterator
Date: Mon, 13 Apr 2015 08:27:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504130819170.4469@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC021C90B0@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504081012130.4469@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC021CADF4@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504121312490.4469@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC021CB9CE@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbbDMP1Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 11:27:25 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC021CB9CE@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mnelson@redhat.com>

[adding ceph-devel]

On Mon, 13 Apr 2015, Chen, Xiaoxi wrote:
> Hi,
> 
>       Actually I have done the tuning survey on RocksDB when I was 
> updating the RocksDB to newer version and exposed the tuning in 
> ceph.conf.
> 
>       What we need to ensure is the WAL never hit the disk. The rocksdb 

We'll always have to pay that 1x write to the log; we just want to make 
sure it doesn't turn into 2x.  I take it you're assuming the log is on an 
SSD (not disk)?

> write ahead log is already introduce 1X write, if the data flushed to 
> SST in level 0, that will be 2X, not to mention any further compaction.
>
>       The tuning that makes the differences are :
> 	write_buffer_size
> 	max_write_buffer_number
> 	min_write_buffer_number_to_merge
> 
>       Say if we have 
> 	write_buffer_size =512M
> 	max_write_buffer_number = 6
> 	min_write_buffer_number_to_merge =2
>    
>        Writes to RocksDB will only be hold in memory write_buffer, and 
> not starting the flusher until #write_buffer_size 
> >=min_write_buffer_number_to merge. That's say if the WAL key lives 

Right now newstore has a thread that does nothing but commit a synchronous 
transation to flush anything pending to disk.  It does that in a loop, so 
we're basically relying on the disk/OS and the log queue depth of 1 to 
balance the log writes vs everything else.

> short enough to fit into the window, no items will be actually written 
> to the Level0(on disk), larger #merge threshold may benefit but at the 
> risk of Disk usage spike. RocksDB will stall the writes when it hit 
> max_write_buffer_number, so 3GB(512MB*6) is the capping to memory 
> consumption that we used to tradeoff the write performance.

It seems like want at least 2, so that an item has to sit in the log for 
at least a full buffer's worth of time before it gets amplified.  What are 
the default values for these?

>        Another thing I think useful is prefix_extractor, since we don't 
> need the key to be fully sorted, we only need ordering key in a common 
> prefix. If we make oid to a fix length string,we could use 
> {S/C/O/M}_{oid} as the prefix. Which should lower the RocksDB 
> overhead(in terms of CPU/Memory) in compaction.

I think for some of these we do need full ordering (e.g. omap data and 
onodes).  For overlay data the prefix is V_<nid>_<offset>, and there are a 
small number, so we could skip it there.  In fact probably anything that 
we can relax the ordering is also something where we can use the nid 
(unique local integer id for the object) instead of the oid...

sage



> 
> 																	
> 											Xiaoxi
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com] 
> Sent: Monday, April 13, 2015 4:15 AM
> To: Chen, Xiaoxi
> Subject: RE: Newstore get_omap_iterator
> 
> great, merged!
> 
> do you want to look at tuning rocksdb?  it would be great to increase the lenght of the log, or do something else that prevents write amplification the short-lived WAL keys... if there's a way we can make rocksdb super lazy about them that would be great.  we will happily pay scanning more log files on startup to avoid rewriting them.
> 
> oh, see also https://www.facebook.com/groups/rocksdb.dev/ .. there an option w/ fallocate that we should try?
> 
> sage
> 
> 
> 
> On Sun, 12 Apr 2015, Chen, Xiaoxi wrote:
> 
> > Hi,
> >       The get_omap_iterator is here 
> > https://github.com/ceph/ceph/pull/4342 and now the PGs will come back 
> > to ACTIVE+CLEAN after restarting OSD:)
> > 
> >       Are there some pieces of work that I could help?
> > 											Xiaoxi
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Thursday, April 9, 2015 1:13 AM
> > To: Chen, Xiaoxi
> > Subject: Re: Newstore get_omap_iterator
> > 
> > > Hi Sage,
> > >          I found the bug that with newstore, if OSD restart, the PG 
> > > will not come back to ACTIVE+CLEAN, after some debugging I got this PR:
> > > https://github.com/ceph/ceph/pull/4303. I think it should fix the issue.
> > 
> > tahnks, merged!
> > 
> > > 
> > >         After fixing the bug, we need Newstore::get_omap_iterator 
> > > implemented to make the OSD continue the PG::read_log process.  I 
> > > drafted one here:
> > > https://github.com/xiaoxichen/ceph/commit/3081642476c246e737ff5a7dba
> > > 77
> > > 63eb67331566 but still need some work to make the PG::read_log works. 
> > > Will try to make it done tomorrow.
> > 
> > ah, thanks.  can you add a test to store_test.cc too?  and drop the
> > assert(0) line.
> > 
> > >          Another thing to discuss, in RocksDBStore::get, we can do 
> > > batch get, but what will we do when one of the keys are not found?
> > > Currently if Nth key not found, the (N+1) th key will not be operate 
> > > but still return 0. I think this is not right, but don't have a good 
> > > idea how to define the returns to indicate there is some error happened.
> > 
> > Hmm... perhaps the return value would be the number of keys we did read?
> > 
> > s
> > 
> > 
> 
> 
