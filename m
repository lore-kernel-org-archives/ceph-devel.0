From: Sage Weil <sage@inktank.com>
Subject: Re: ceph write path
Date: Thu, 24 Jan 2013 21:00:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301242056150.14731@cobra.newdream.net>
References: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45430 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab3AYFAF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 00:00:05 -0500
In-Reply-To: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sheng,

On Thu, 24 Jan 2013, sheng qiu wrote:
> i am trying to understand the ceph codes on client side.
> for write path, if it's aio_write, the ceph_write_begin() allocate
> pages in page cache to buffer the written data, however i did not see
> it allocated any space on the remote OSDs (for local fs such as ext2,
> the get_block() did this),
> i suppose it's done later when invoke kernel flushing process to write
> back the dirty pages.

Right.  Objects are instantiated and written to teh osds when the write 
operations are sent over the network, normally during writeback (via 
the ->writepages() op in addr.c).

> i checked the ceph_writepages_start(), here it seems organize the
> dirty data and prepare the requests to send to the OSDs.  For new
> allocated written data, how it maps to the OSDs and where it is done?
> is it done in ceph_osdc_new_request()?

I happens later, when the actual request is ready to go over the wire. The 
target OSD may change in the meantime, or the request may have to be 
resent to another OSD.  As far as the upper layers are concerned, though, 
they are writing to the object, without caring where the object happens to 
currently live.

> If the transfer unit is not limited to sizes of obj, i supposed that
> ceph needed to packed several pieces of data (smaller than one obj
> size)  together so that there won't be internal fragmentation for an
> object. who does this job and which part of source codes/files are
> related with this?

Each file is striped over a different sequence of objects.  Small 
files mean small objects.  Large files stipe over (by default) 4 
MB objects.  It's the OSDs job to store these efficiently.  We just use a 
local file system.  btrfs is great about packing small files inline in the 
btree; xfs and ext4 are more convential fs's and pretty well.

sage

> I really want to get a deep understanding about the codes, so i raised
> these questions. if my understanding is not correct, please figure
> out. i will be very appreciated.
> 
> Thanks,
> Sheng
> 
> --
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
