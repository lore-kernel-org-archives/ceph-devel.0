From: Sage Weil <sage@newdream.net>
Subject: Re: Initial newstore vs filestore results
Date: Wed, 8 Apr 2015 10:38:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504081034531.4469@cobra.newdream.net>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com> <55248856.1010808@redhat.com> <alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net> <CACJqLyY+tqNxAv+kLMQNgb_iWWW=jArz2k-KOTcTjfui=kRCtQ@mail.gmail.com> <alpine.DEB.2.00.1504080942440.4469@cobra.newdream.net>
 <CAC6JEv83BeQR8i50nZ0Y7Qyf68OyBaWR9PhNLyXq35BfF5BO4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40219 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbbDHRib (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 13:38:31 -0400
In-Reply-To: <CAC6JEv83BeQR8i50nZ0Y7Qyf68OyBaWR9PhNLyXq35BfF5BO4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 8 Apr 2015, Gregory Farnum wrote:
> On Wed, Apr 8, 2015 at 9:49 AM, Sage Weil <sage@newdream.net> wrote:
> > On Wed, 8 Apr 2015, Haomai Wang wrote:
> >> On Wed, Apr 8, 2015 at 10:58 AM, Sage Weil <sage@newdream.net> wrote:
> >> > On Tue, 7 Apr 2015, Mark Nelson wrote:
> >> >> On 04/07/2015 02:16 PM, Mark Nelson wrote:
> >> >> > On 04/07/2015 09:57 AM, Mark Nelson wrote:
> >> >> > > Hi Guys,
> >> >> > >
> >> >> > > I ran some quick tests on Sage's newstore branch.  So far given that
> >> >> > > this is a prototype, things are looking pretty good imho.  The 4MB
> >> >> > > object rados bench read/write and small read performance looks
> >> >> > > especially good.  Keep in mind that this is not using the SSD journals
> >> >> > > in any way, so 640MB/s sequential writes is actually really good
> >> >> > > compared to filestore without SSD journals.
> >> >> > >
> >> >> > > small write performance appears to be fairly bad, especially in the RBD
> >> >> > > case where it's small writes to larger objects.  I'm going to sit down
> >> >> > > and see if I can figure out what's going on.  It's bad enough that I
> >> >> > > suspect there's just something odd going on.
> >> >> > >
> >> >> > > Mark
> >> >> >
> >> >> > Seekwatcher/blktrace graphs of a 4 OSD cluster using newstore for those
> >> >> > interested:
> >> >> >
> >> >> > http://nhm.ceph.com/newstore/
> >> >> >
> >> >> > Interestingly small object write/read performance with 4 OSDs was about
> >> >> > 1/3-1/4 the speed of the same cluster with 36 OSDs.
> >> >> >
> >> >> > Note: Thanks Dan for fixing the directory column width!
> >> >> >
> >> >> > Mark
> >> >>
> >> >> New fio/librbd results using Sage's latest code that attempts to keep small
> >> >> overwrite extents in the db.  This is 4 OSD so not directly comparable to the
> >> >> 36 OSD tests above, but does include seekwatcher graphs.  Results in MB/s:
> >> >>
> >> >>       write   read    randw   randr
> >> >> 4MB   57.9    319.6   55.2    285.9
> >> >> 128KB 2.5     230.6   2.4     125.4
> >> >> 4KB   0.46    55.65   1.11    3.56
> >> >
> >> > What would be very interesting would be to see the 4KB performance
> >> > with the defaults (newstore overlay max = 32) vs overlays disabled
> >> > (newstore overlay max = 0) and see if/how much it is helping.
> >> >
> >> > The latest branch also has open-by-handle.  It's on by default (newstore
> >> > open by handle = true).  I think for most workloads it won't be very
> >> > noticeable... I think there are two questions we need to answer though:
> >> >
> >> > 1) Does it have any impact on a creation workload (say, 4kb objects).  It
> >> > shouldn't, but we should confirm.
> >> >
> >> > 2) Does it impact small object random reads with a cold cache.  I think to
> >> > see the effect we'll probably need to pile a ton of objects into the
> >> > store, drop caches, and then do random reads.  In the best case the
> >> > effect will be small, but hopefully noticeable: we should go from
> >> > a directory lookup (1+ seeks) + inode lookup (1+ seek) + data
> >> > read, to inode lookup (1+ seek) + data read.  So, 3 -> 2 seeks best case?
> >> > I'm not really sure what XFS is doing under the covers here..
> >>
> >> WOW, it's really a cool implementation beyond my original mind
> >> according to blueprint. Handler, overlay_map and data_map looks so
> >> flexible and make small io cheaper in theory. Now we only have 1
> >> element in data_map and I'm not sure your goal about the future's
> >> usage. Although I have a unclearly idea that it could enhance the role
> >> of NewStore and make local filesystem just as a block space allocator.
> >> Let NewStore own a variable of FTL(File Translation Layer), so many
> >> cool features could be added. What's your idea about data_map?
> >
> > Exactly, that is one option.  The other is that we'd treat the data_map
> > similar to overlay_map with a fixed or max extent size so that a large
> > partial overwrite will mostly go to a new file instead of doing the
> > slow WAL.
> >
> >> My concern currently still is WAL after fsync and kv commiting, maybe
> >> fsync process is just fine because mostly we won't meet this case in
> >> rbd. But submit sync kv transaction isn't a low latency job I think,
> >> maybe we could let WAL parallel with kv commiting?(yes, I really
> >> concern the latency of one op :-) )
> >
> > The WAL has to come after kv commit.  But the fsync after the wal
> > completion sucks, especially since we are always dispatching a single
> > fsync at a time so it's kind of worst-case seek behavior.  We could throw
> > these into another parallel fsync queue so that the fs can batch them up,
> > but I'm not sure we will enough parallelism.  What would really be nice is
> > a batch fsync syscall, but in leiu of that maybe we wait until we have a
> > bunch of fsyncs pending and then throw them at the kernel together in a
> > bunch of threads?  Not sure.  These aren't normally time sensitive
> > unless a read comes along (which is pretty rare), but they have to be done
> > for correctness.
> 
> Couldn't we write both the log entry and the data in parallel and only
> acknowledge to the client once both commit?
> If we replay the log without the data we'll know it didn't get
> committed, and we can collect the data after replay if it's not
> referenced by the log (I'm speculating, as I haven't looked at the
> code or how it's actually choosing names).

We're only doing WAL for things where we need atomicity, like a partial 
overwrite.  In that case, we need to avoid clobbering old state until we 
the new transaction in its entirety.  I'm not sure we can get around 
those...

There are times when we can avoid it, though, mainly with creation of new 
objects and with appends.  In both of those cases we write directly to the 
file, fsync, and then commit the kv transaction.  I guess we could do 
something clever there and roll-back the transaction if we find that the 
backing file doesn't have what we expected it to.  I'm worried that will 
turn out to be really complex, though: we'd need to roll back the kv 
transaction, including any other changes it made (creating, 
deleting, or updating other k/v pairs), *and* any later transactions on 
the same sequencer.

s


> -Greg
> 
> >
> >> Then from the actual rados write op, it will add setattr and
> >> omap_setkeys ops. Current NewStore looks plays badly for setattr. It
> >> always encode all xattrs(and other not so tiny fields) and write again
> >> (Is this true?) though it could batch multi transaction's onode write
> >> in short time.
> >
> > Yeah, this could be optimized so that we only unpack and repack the
> > bufferlist, or do a single walk through the buffer to do the updates
> > (similar to what TMAP used to do).
> >
> >> NewStore also employ much more workload to KeyValueDB compared to
> >> FileStore, so maybe we need to consider the rich workload again
> >> compared before. FileStore only use leveldb just for write workload
> >> mainly so leveldb could fit into greatly, but currently overlay
> >> keys(read) and onode(read) will occur a main latency source in normal
> >> IO I think. The default kvdb like leveldb and rocksdb both plays not
> >> well for random read workload, it maybe will be problem. Looking for
> >> another kv db maybe a choice.
> >
> > I'm defaulting to rocksdb for now.  We should try LMDB at some point...
> >
> >> And it still doesn't add journal codes for wal?
> >
> > I'm pretty sure the WAL stuff is all complete?
> >
> > Anyway, I think most of the pieces are there, so now it's a matter of
> > figuring out how well they work for different workloads, then tuning and
> > optimizing...
> >
> >> Anyway, NewStore should cover more workloads compared to FileStore. Good
> >> job!
> >
> > Thanks!
> > sage
> >
> >>
> >> >
> >> > sage
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> >> --
> >> Best Regards,
> >>
> >> Wheat
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
