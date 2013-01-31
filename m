From: Sage Weil <sage@inktank.com>
Subject: Re: ceph write path
Date: Thu, 31 Jan 2013 12:09:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301311206570.807@cobra.newdream.net>
References: <CAB7xdikxeLumDMJNYacoxiiijkx2vekAdc5ccDy0A+5isOJ-3Q@mail.gmail.com> <alpine.DEB.2.00.1301242056150.14731@cobra.newdream.net> <CAB7xdin1y1WVEtvSRHWLv6iOaid-c4sUOaAWdgVZozY2UUHJtA@mail.gmail.com> <alpine.DEB.2.00.1301250843550.11516@cobra.newdream.net>
 <CAB7xdik0hGU9G1Nmk1Ai56ViXzGmLSgCBU9at0TyJps-DPXUHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39336 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3AaUJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 15:09:17 -0500
In-Reply-To: <CAB7xdik0hGU9G1Nmk1Ai56ViXzGmLSgCBU9at0TyJps-DPXUHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 31 Jan 2013, sheng qiu wrote:
> Hi Sage,
> 
> thanks for your reply. sorry to bother you again.
> 
> i like your suggestion "create different pools with different types of
> storage devices". Can you give me a quick guide, if i want to
> implement this function, which code files i need to review in ceph
> server side?
> i tried to figure out myself, but not quite work well. The code base
> is very complicated to me as a new guy to ceph.
> 
> i reviewed the codes on kernel client part, generally it will first
> calculate the obj-id and pgid and pg-pool id. Then call
> ceph_osdc_start_request() to use CRUSH to actually map to the OSDs
> list and send the request through the socket connection.
> some concepts are not clear to me:
> 
> a. what is the pg pool used for? is it a logical group of PGs? if so,
> how do you group the PGs?
> b. How does the client/monitor know the alive OSDs? i suppose ceph
> should maintain a table or list which have information for all
> connected OSDs. if so, can you tell me what's the data structure in
> the code? How do you fill/update this table? i suppose you can get the
> initial OSDs from the configure file during setting up.

'ceph osd dump' to see the structure.

> If i want to implement my function, i guess i need to do the following job:
> 
> a. tag different obj with which pool it want to go (i.e. SSD or HDD)
> b. put the obj into the proper PG and PG pools.
> c. when map PG to OSD, map them to the proper OSD.

The fs client does all of that for you.  All you need to do is tag a 
direcory with a new data pool so that new files are tagged; the rest is 
done for you.

It's something like

 ceph osd pool create foo <num pgs>
 ceph mds add_data_pool foo
 ceph osd dump | grep foo
 cephfs /mnt/ceph/something -p <numeric id for pool foo>


> 
> Do you think this is the correct path for it?
> 
> Thanks,
> Sheng
> 
> On Fri, Jan 25, 2013 at 10:46 AM, Sage Weil <sage@inktank.com> wrote:
> > On Fri, 25 Jan 2013, sheng qiu wrote:
> >> Hi Sage,
> >>
> >> i am appreciated for your reply.
> >>
> >> by my understanding on reading the client codes, i think ceph
> >> allocates msg based on individual file. In another word, if one client
> >> is updating on different files (each file is doing small
> >> writes/updates, i.e. 4kb), ceph has to compose different msgs for each
> >> file and send them to the corresponding OSDs.
> >
> > Right.
> >
> >> if there are msgs
> >> targeted on the same OSDs, can they be merged at client side?
> >
> > No..
> >
> >> This may
> >> help if the bandwidth of network is not sufficient, although i do not
> >> know how much the chance they fall onto the same OSDs.
> >
> > It would save on the header/footer msg overhead, but increase complexity
> > on both sides (esp the OSD side).  I don't think it's worth it.
> >
> >> if my understanding is not correct, please figure out. i am doing
> >> research on DFS, and pretty interested on ceph. Have you considered
> >> manage a hybrid storage pool, while may compose of some faster devices
> >> such as NVRAM/SSD and some slow devices such as HDD, and make ceph be
> >> aware of this to better place/distribute data instead of a flat way.
> >
> > You can create different pols with different types of storage, and
> > distribute uniformly ("flat") across each pool.  Eventually, we'd like
> > cephfs to migrate files between pools based on temperature.
> >
> > Alternatively, you can build hybrid OSDs that combine SSD and HDDs (and/or
> > NVRAM) and do the teiring inside each OSD.
> >
> > sage
> >
> >>
> >> Thanks,
> >> Sheng
> >>
> >>
> >> On Thu, Jan 24, 2013 at 11:00 PM, Sage Weil <sage@inktank.com> wrote:
> >> > Hi Sheng,
> >> >
> >> > On Thu, 24 Jan 2013, sheng qiu wrote:
> >> >> i am trying to understand the ceph codes on client side.
> >> >> for write path, if it's aio_write, the ceph_write_begin() allocate
> >> >> pages in page cache to buffer the written data, however i did not see
> >> >> it allocated any space on the remote OSDs (for local fs such as ext2,
> >> >> the get_block() did this),
> >> >> i suppose it's done later when invoke kernel flushing process to write
> >> >> back the dirty pages.
> >> >
> >> > Right.  Objects are instantiated and written to teh osds when the write
> >> > operations are sent over the network, normally during writeback (via
> >> > the ->writepages() op in addr.c).
> >> >
> >> >> i checked the ceph_writepages_start(), here it seems organize the
> >> >> dirty data and prepare the requests to send to the OSDs.  For new
> >> >> allocated written data, how it maps to the OSDs and where it is done?
> >> >> is it done in ceph_osdc_new_request()?
> >> >
> >> > I happens later, when the actual request is ready to go over the wire. The
> >> > target OSD may change in the meantime, or the request may have to be
> >> > resent to another OSD.  As far as the upper layers are concerned, though,
> >> > they are writing to the object, without caring where the object happens to
> >> > currently live.
> >> >
> >> >> If the transfer unit is not limited to sizes of obj, i supposed that
> >> >> ceph needed to packed several pieces of data (smaller than one obj
> >> >> size)  together so that there won't be internal fragmentation for an
> >> >> object. who does this job and which part of source codes/files are
> >> >> related with this?
> >> >
> >> > Each file is striped over a different sequence of objects.  Small
> >> > files mean small objects.  Large files stipe over (by default) 4
> >> > MB objects.  It's the OSDs job to store these efficiently.  We just use a
> >> > local file system.  btrfs is great about packing small files inline in the
> >> > btree; xfs and ext4 are more convential fs's and pretty well.
> >> >
> >> > sage
> >> >
> >> >> I really want to get a deep understanding about the codes, so i raised
> >> >> these questions. if my understanding is not correct, please figure
> >> >> out. i will be very appreciated.
> >> >>
> >> >> Thanks,
> >> >> Sheng
> >> >>
> >> >> --
> >> >> Sheng Qiu
> >> >> Texas A & M University
> >> >> Room 332B Wisenbaker
> >> >> email: herbert1984106@gmail.com
> >> >> College Station, TX 77843-3259
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >>
> >> >>
> >>
> >>
> >>
> >> --
> >> Sheng Qiu
> >> Texas A & M University
> >> Room 332B Wisenbaker
> >> email: herbert1984106@gmail.com
> >> College Station, TX 77843-3259
> >>
> >>
> 
> 
> 
> -- 
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
> 
> 
