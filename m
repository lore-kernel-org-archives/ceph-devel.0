From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Any librados C API users out there?
Date: Thu, 12 Jan 2017 13:48:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701121344270.5745@piezo.novalocal>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com>
	<CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
	<alpine.DEB.2.11.1701111755260.5745@piezo.novalocal>
	<e0e85f8a-5f78-e652-9838-5aae2ef97d14@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-809660423-1484228908=:5745"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <e0e85f8a-5f78-e652-9838-5aae2ef97d14-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
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

--8323329-809660423-1484228908=:5745
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2017, Piotr Dałek wrote:
> On 01/11/2017 07:01 PM, Sage Weil wrote:
> > On Wed, 11 Jan 2017, Jason Dillaman wrote:
> > > On Wed, Jan 11, 2017 at 11:44 AM, Piotr Dałek <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
> > > wrote:
> > > > As the subject says - are here any users/consumers of librados C API?
> > > > I'm
> > > > asking because we're researching if this PR:
> > > > https://github.com/ceph/ceph/pull/12216 will be actually beneficial for
> > > > larger group of users. This PR adds a bunch of new APIs that perform
> > > > object
> > > > writes without intermediate data copy, which will reduce cpu and memory
> > > > load
> > > > on clients. If you're using librados C API for object writes, feel free
> > > > to
> > > > comment here or in the pull request.
> > > +1
> > > 
> > > I'd be happy to tweak the internals of librbd to support pass-through
> > > of C buffers all the way to librados. librbd clients like QEMU use the
> > > C API and this currently results in several extra copies (in librbd
> > > and librados).
> > 
> > +1 from me too.
> > 
> > The caveat is that we have to be very careful with buffers that are
> > provided by users.  Currently the userspace messenger code doesn't provide
> > a way to manage the provenance of references to the buffer::raw_static
> > buffers, which means that even if the write has completed, there may be
> > ways for an MOSDOp to still be alive that references that memory.
> > 
> > Either (1) we have to audit the code to be sure that by the time the
> > Objecter request completes we know that all messages and their bufferlists
> > are cleared (tricky/fragile), or (2) introduce some buffer management
> > interface in librados so that the buffer lifecycle is independent of the
> > request.  I would prefer (2), but it means the interfaces would be
> > something like
> > 
> >  rados_buffer_create(...)
> >  copy your data into that buffer
> >  rados_write(...) or whatever
> >  rados_buffer_release(...)
> > 
> > and then rados can do the proper refcounting and only deallocate the
> > memory when all refs have gone away.  Unfortunately, I suspect that there
> > is a largish category of users where this isn't sufficient... e.g., if
> > some existing C user has its own buffer and it isn't practical to
> > allocate/release via rados_buffer_* calls instead of malloc/free (or
> > whatever).
> 
> Personally I vote for (1). That way is time consuming, but may help us find
> other ways to optimize resource consumption of API itself. In particular, if
> librbd, as you all wrote, does several copies of user buffers, then maybe it's
> worth spending some time on figuring out the actual lifetime of buffers?
> Maybe, for example, buffers in MOSDOp are actually copies of already copied
> buffers, so the extra copy done by librados is unnecessary?
> Regardless, the idea behind my PR wasn't to make librados/librbd/libwhatever
> 100% optimal right away, but to make one step towards it being efficient -
> recduce cpu and memory usage a bit, have it go through testing, if nothing
> breaks, try harder until we're close to perfection.
> even if few percent decrease in memory consumption doesn't look interesting on
> single-client level, few percents in large scale deployments may mean hundreds
> of gigabytes of memory that could be put to better use.
> 
> (2), and particularly the requirement for API changes, along with need to put
> user data into specific RADOS structure doesn't look good because
> - that requires way more changes to user code, and I don't expect any of
> current user to be interested in that (unless we force it with API change)
> - most of devs are simply lazy and instead of using "rados_buffer_create" to
> put their data directly into them, they'll keep using their own buffers and
> *then* copy them into RADOS buffers, just like we're doing it right now (even
> if behind the scenes).

Yeah, I think you're right.  The bad news is just that (1) is hard.  It's 
going to require a few things in order to address the problem of sending 
multiple MOSDOp requests for the same operation (e.g., after peering).  I 
think it will mean

- The Message superclass is going to require a new Mutex that is taken by 
the messenger implementation while accessing the encoded message payload 
buffer

- It will also need a revoke_buffers() method (that takes the mutex) so 
that Objecter can yank references to buffers for any messages in flight 
that it no longer cares about

- Objecter will need to keep a ref of the in-flight request of record.  If 
it needs to resend to a different OSD, it can use that ref to revoke the 
buffers.

- Once the operation completes, Objecter can drop it's ref to that 
Message.

Until we do that, any zero-copy changes like those in the PR will mostly 
work but trigger use-after-free is various cases where the PG mappings are 
changing.

sage
--8323329-809660423-1484228908=:5745
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-809660423-1484228908=:5745--
