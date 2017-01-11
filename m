From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Any librados C API users out there?
Date: Wed, 11 Jan 2017 18:01:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701111755260.5745@piezo.novalocal>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com>
	<CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-905993304-1484157680=:5745"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-905993304-1484157680=:5745
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Jan 2017, Jason Dillaman wrote:
> +1
> 
> I'd be happy to tweak the internals of librbd to support pass-through
> of C buffers all the way to librados. librbd clients like QEMU use the
> C API and this currently results in several extra copies (in librbd
> and librados).

+1 from me too.

The caveat is that we have to be very careful with buffers that are 
provided by users.  Currently the userspace messenger code doesn't provide 
a way to manage the provenance of references to the buffer::raw_static 
buffers, which means that even if the write has completed, there may be 
ways for an MOSDOp to still be alive that references that memory.

Either (1) we have to audit the code to be sure that by the time the 
Objecter request completes we know that all messages and their bufferlists 
are cleared (tricky/fragile), or (2) introduce some buffer management 
interface in librados so that the buffer lifecycle is independent of the 
request.  I would prefer (2), but it means the interfaces would be 
something like

 rados_buffer_create(...)
 copy your data into that buffer
 rados_write(...) or whatever
 rados_buffer_release(...)

and then rados can do the proper refcounting and only deallocate the 
memory when all refs have gone away.  Unfortunately, I suspect that there 
is a largish category of users where this isn't sufficient... e.g., if 
some existing C user has its own buffer and it isn't practical to 
allocate/release via rados_buffer_* calls instead of malloc/free (or 
whatever).

Jason, where does librbd fall?

sage


> 
> On Wed, Jan 11, 2017 at 11:44 AM, Piotr Dałek <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org> wrote:
> > Hello,
> >
> > As the subject says - are here any users/consumers of librados C API? I'm
> > asking because we're researching if this PR:
> > https://github.com/ceph/ceph/pull/12216 will be actually beneficial for
> > larger group of users. This PR adds a bunch of new APIs that perform object
> > writes without intermediate data copy, which will reduce cpu and memory load
> > on clients. If you're using librados C API for object writes, feel free to
> > comment here or in the pull request.
> >
> >
> > --
> > Piotr Dałek
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
> 
> -- 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-905993304-1484157680=:5745
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-905993304-1484157680=:5745--
