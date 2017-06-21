From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Sparse file info in filestore not propagated to
	other OSDs
Date: Wed, 21 Jun 2017 13:56:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706211351410.32269@piezo.novalocal>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
	<alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
	<d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com>
	<415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl>
	<alpine.DEB.2.11.1706141340520.3646@piezo.novalocal>
	<e89cc0ed-14f0-b092-784f-784c8c967e9d@corp.ovh.com>
	<alpine.DEB.2.11.1706211322360.32269@piezo.novalocal>
	<898546b4-b9b2-5413-27ab-74534cc77eed@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1149222677-1498053378=:32269"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <898546b4-b9b2-5413-27ab-74534cc77eed-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
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
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1149222677-1498053378=:32269
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jun 2017, Piotr Dałek wrote:
> > > > > I tested on few of our production images and it seems that about 30%
> > > > > is
> > > > > sparse. This will be lost on any cluster wide event (add/remove nodes,
> > > > > PG grow, recovery).
> > > > > 
> > > > > How this is/will be handled in BlueStore?
> > > > 
> > > > BlueStore exposes the same sparseness metadata that enabling the
> > > > filestore seek hole or fiemap options does, so it won't be a problem
> > > > there.
> > > > 
> > > > I think the only thing that we could potentially add is zero detection
> > > > on writes (so that explicitly writing zeros consumes no space).  We'd
> > > > have to be a bit careful measuring the performance impact of that check
> > > > on
> > > > non-zero writes.
> > > 
> > > I saw that RBD (librbd) does that - replacing writes with discards when
> > > buffer
> > > contains only zeros. Some code that does the same in librados could be
> > > added
> > > and it shouldn't impact performance much, current implementation of
> > > mem_is_zero is fast and shouldn't be a big problem.
> > 
> > I'd rather not have librados silently translating requests; I think it
> > makes more sense to do any zero checking in bluestore.  _do_write_small
> > and _do_write_big already break writes into (aligned) chunks; that would
> > be an easy place to add the check.
> 
> That leaves out filestore.
> 
> And while I get your point, doing it on librados level would reduce network
> usage for zeroed out regions as well, and check could be done just once, not
> replica_size times...

In the librbd case I think a client-side check makes sense.

For librados, it's a low level interface with complicated semantics.  
Silently translating a write op to a zero op feels dangerous to me.  
Would a zero range extend the object size, for example?  Or implicitly 
create an object that doesn't exist?  I can't remember.  (It would need to 
match write perfectly for this to be safe.)  The user might also have a 
compound op of multiple operations, which would make swapping one out in 
the middle stranger.  And probably half the librados unit tests would 
stop testing what we thought they were testing.  Etc.

It seems more natural to do this a layer up in librbd or rgw...

sage
--8323329-1149222677-1498053378=:32269
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1149222677-1498053378=:32269--
