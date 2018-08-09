From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: RBD image "lightweight snapshots"
Date: Thu, 9 Aug 2018 13:15:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1808091311360.15688@piezo.novalocal>
References: <45c564fb-63ed-af46-851b-6467649ae56d@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-557850460-1533820510=:15688"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <45c564fb-63ed-af46-851b-6467649ae56d-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-557850460-1533820510=:15688
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 9 Aug 2018, Piotr Dałek wrote:
> Hello,
> 
> At OVH we're heavily utilizing snapshots for our backup system. We think
> there's an interesting optimization opportunity regarding snapshots I'd like
> to discuss here.
> 
> The idea is to introduce a concept of a "lightweight" snapshots - such
> snapshot would not contain data but only the information about what has
> changed on the image since it was created (so basically only the object map
> part of snapshots).
> 
> Our backup solution (which seems to be a pretty common practice) is as
> follows:
> 
> 1. Create snapshot of the image we want to backup
> 2. If there's a previous backup snapshot, export diff and apply it on the
> backup image
> 3. If there's no older snapshot, just do a full backup of image
> 
> This introduces one big issue: it enforces COW snapshot on image, meaning that
> original image access latencies and consumed space increases. "Lightweight"
> snapshots would remove these inefficiencies - no COW performance and storage
> overhead.

The snapshot in 1 would be lightweight you mean?  And you'd do the backup 
some (short) time later based on a diff with changed extents?

I'm pretty sure this will export a garbage image.  I mean, it will usually 
be non-garbage, but the result won't be crash consistent, and in some 
(many?) cases won't be usable.

Consider:

- take reference snapshot
- back up this image (assume for now it is perfect)
- write A to location 1
- take lightweight snapshot
- write B to location 1
- backup process copie location 1 (B) to target

That's the wrong data.  Maybe that change is harmless, but maybe location 
1 belongs to the filesystem journal, and you have some records that now 
reference location 10 that as an A-era value, or haven't been written at 
all yet, and now your file system journal won't replay and you can't 
mount...

sage
 
> At first glance, it seems like it could be implemented as extension to current
> RBD snapshot system, leaving out the machinery required for copy-on-write. In
> theory it could even co-exist with regular snapshots. Removal of these
> "lightweight" snapshots would be instant (or near instant).
> 
> So what do others think about this?
> 
> -- 
> Piotr Dałek
> piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org
> https://www.ovhcloud.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-557850460-1533820510=:15688
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-557850460-1533820510=:15688--
