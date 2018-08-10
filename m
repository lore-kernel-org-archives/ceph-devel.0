From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: RBD image "lightweight snapshots"
Date: Fri, 10 Aug 2018 12:29:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1808101222580.15696@piezo.novalocal>
References: <45c564fb-63ed-af46-851b-6467649ae56d@corp.ovh.com>
 <alpine.DEB.2.11.1808091311360.15688@piezo.novalocal>
 <cdc2a3bb-d3aa-0208-503a-e37c8bb3ed5d@ieee.org>
 <27efd295-8a87-94ea-aa77-fcaee4e5f250@sadziu.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1178392100-1533904185=:15696"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <27efd295-8a87-94ea-aa77-fcaee4e5f250-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?ISO-8859-2?Q?Pawe=B3_Sadowski?= <pawel.sadowski-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Alex Elder <elder-EkmVulN54Sk@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1178392100-1533904185=:15696
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 10 Aug 2018, Paweł Sadowski wrote:
> On 08/09/2018 04:39 PM, Alex Elder wrote:
> > On 08/09/2018 08:15 AM, Sage Weil wrote:
> >> On Thu, 9 Aug 2018, Piotr Dałek wrote:
> >>> Hello,
> >>>
> >>> At OVH we're heavily utilizing snapshots for our backup system. We think
> >>> there's an interesting optimization opportunity regarding snapshots I'd like
> >>> to discuss here.
> >>>
> >>> The idea is to introduce a concept of a "lightweight" snapshots - such
> >>> snapshot would not contain data but only the information about what has
> >>> changed on the image since it was created (so basically only the object map
> >>> part of snapshots).
> >>>
> >>> Our backup solution (which seems to be a pretty common practice) is as
> >>> follows:
> >>>
> >>> 1. Create snapshot of the image we want to backup
> >>> 2. If there's a previous backup snapshot, export diff and apply it on the
> >>> backup image
> >>> 3. If there's no older snapshot, just do a full backup of image
> >>>
> >>> This introduces one big issue: it enforces COW snapshot on image, meaning that
> >>> original image access latencies and consumed space increases. "Lightweight"
> >>> snapshots would remove these inefficiencies - no COW performance and storage
> >>> overhead.
> >>
> >> The snapshot in 1 would be lightweight you mean?  And you'd do the backup 
> >> some (short) time later based on a diff with changed extents?
> >>
> >> I'm pretty sure this will export a garbage image.  I mean, it will usually 
> >> be non-garbage, but the result won't be crash consistent, and in some 
> >> (many?) cases won't be usable.
> >>
> >> Consider:
> >>
> >> - take reference snapshot
> >> - back up this image (assume for now it is perfect)
> >> - write A to location 1
> >> - take lightweight snapshot
> >> - write B to location 1
> >> - backup process copie location 1 (B) to target
> 
> The way I (we) see it working is a bit different:
>  - take snapshot (1)
>  - data write might occur, it's ok - CoW kicks in here to preserve data
>  - export data
>  - convert snapshot (1) to a lightweight one (not create new):
>    * from now on just remember which blocks has been modified instead
>      of doing CoW
>    * you can get rid on previously CoW data blocks (they've been
>      exported already)
>  - more writes
>  - take snapshot (2)
>  - export diff - only blocks modified since snap (1)
>  - convert snapshot (2) to a lightweight one
>  - ...
> 
> 
> That way I don't see a place for data corruption. Of course this has
> some drawbacks - you can't rollback/export data from such lightweight
> snapshot anymore. But on the other hand we are reducing need for CoW -
> and that's the main goal with this idea. Instead of making CoW ~all the
> time it's needed only for the time of exporting image/modified blocks.

Ok, so this is a bit different.  I'm a bit fuzzy still on how the 
'lightweight' (1) snapshot will be implemented, but basically I think 
you just mean saving on its storage overhead, but keeping enough metadata 
to make a fully consistent (2) for the purposes of the backup.

Maybe Jason has a better idea for how this would work in practice?  I 
haven't thought about the RBD snapshots in a while (not above the rados 
layer at least).

> >> That's the wrong data.  Maybe that change is harmless, but maybe location 
> >> 1 belongs to the filesystem journal, and you have some records that now 
> >> reference location 10 that as an A-era value, or haven't been written at 
> >> all yet, and now your file system journal won't replay and you can't 
> >> mount...
> > 
> > Forgive me if I'm misunderstanding; this just caught my attention.
> > 
> > The goal here seems to be to reduce the storage needed to do backups of an
> > RBD image, and I think there's something to that.
> 
> Storage reduction is only side effect here. We want to get rid of CoW as
> much as possible. In an example - we are doing snapshot every 24h - this
> means that every 24h we will start doing CoW from the beginning on every
> image. This has big impact on a cluster latency
> 
> As for the storage need, with 24h backup period we see a space usage
> increase by about 5% on our clusters. But this clearly depends on client
> traffic.

One thing to keep in mind here is that the CoW/clone overheard goes *way* 
down with BlueStore.  On FileStore we are literally blocking to make 
a copy of each 4MB object.  With BlueStore there is a bit of metadata 
overhead for the tracking but it is doing CoW at the lowest layer.

Lightweight snapshots might be a big win for FileStore but that advantage 
will mostly evaporate once you repave the OSDs.

sage


> > This seems to be no different from any other incremental backup scheme.  It's
> > layered, and it's ultimately based on an "epoch" complete backup image (what
> > you call the reference snapshot).
> > 
> > If you're using that model, it would be useful to be able to back up only
> > the data present in a second snapshot that's the child of the reference
> > snapshot.  (And so on, with snapshot 2 building on snapshot 1, etc.)
> > RBD internally *knows* this information, but I'm not sure how (or whether)
> > it's formally exposed.
> > 
> > Restoring an image in this scheme requires restoring the epoch, then the
> > incrementals, in order.  The cost to restore is higher, but the cost
> > of incremental backups is significantly smaller than doing full ones.
> 
> It depends how we will store exported data. We might just want to merge
> all diffs into base image right after export to keep only single copy.
> But that is out of scope of main topic here, IMHO.
> 
> > I'm not sure how the "lightweight" snapshot would work though.  Without
> > references to objects there's no guarantee the data taken at the time of
> > the snapshot still exists when you want to back it up.
> > 
> > 					-Alex
> > 
> >>
> >> sage
> >>  
> >>> At first glance, it seems like it could be implemented as extension to current
> >>> RBD snapshot system, leaving out the machinery required for copy-on-write. In
> >>> theory it could even co-exist with regular snapshots. Removal of these
> >>> "lightweight" snapshots would be instant (or near instant).
> >>>
> >>> So what do others think about this?
> >>>
> >>> -- 
> >>> Piotr Dałek
> >>> piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org
> >>> https://www.ovhcloud.com
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
--8323329-1178392100-1533904185=:15696
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1178392100-1533904185=:15696--
