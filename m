From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH 1/1] ceph: parallelize all copy-from requests in
 copy_file_range
Date: Thu, 30 Jan 2020 16:31:01 +0000
Message-ID: <20200130163101.GA22679@suse.com>
References: <20200129182011.5483-1-lhenriques@suse.com>
 <20200129182011.5483-2-lhenriques@suse.com>
 <CAOi1vP92rXoNU7ne-XrOiGH=WzVmMO9h8XnbReeEDO=xAcXHEg@mail.gmail.com>
 <20200130153711.GA20170@suse.com>
 <CAOi1vP9+MkjrsH662zpkNLu2=RJA91dKuPo+ra7rXxFcEqxWLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP9+MkjrsH662zpkNLu2=RJA91dKuPo+ra7rXxFcEqxWLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Jan 30, 2020 at 04:59:59PM +0100, Ilya Dryomov wrote:
...
> > > > @@ -2117,14 +2126,33 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > > >                         dout("ceph_osdc_copy_from returned %d\n", err);
> > > >                         if (!ret)
> > > >                                 ret = err;
> > > > +                       /* wait for all queued requests */
> > > > +                       ceph_osdc_wait_requests(&osd_reqs);
> > > >                         goto out_caps;
> > > >                 }
> > > > +               list_add(&req->r_private_item, &osd_reqs);
> > > >                 len -= object_size;
> > > >                 src_off += object_size;
> > > >                 dst_off += object_size;
> > > >                 ret += object_size;
> > >
> > > So ret is incremented here, but you have numerious tests where ret is
> > > assigned an error only if ret is 0.  Unless I'm missing something, this
> > > interferes with returning errors from __ceph_copy_file_range().
> >
> > Well, the problem is that an error may occur *after* we have already done
> > some copies.  In that case we need to return the number of bytes that have
> > been successfully copied instead of an error; eventually, subsequent calls
> > to complete the copy_file_range will then return the error.  At least this
> > is how I understood the man page (i.e. similar to the write(2) syscall).
> 
> AFAICS ret is incremented before you know that *any* of the copies were
> successful.  If the first copy fails, how do you report that error?

Ah, got it.  So, a solution would be to have the ceph_osdc_wait_requests
interface changed so that we can get the number of successful requests.

/me takes a deep breath and goes look at the *whole* thing to prevent
these mistakes.  Thanks a lot for your review, Ilya.

> 
> >
> > > > +               if (--ncopies == 0) {
> > > > +                       err = ceph_osdc_wait_requests(&osd_reqs);
> > > > +                       if (err) {
> > > > +                               if (!ret)
> > > > +                                       ret = err;
> > > > +                               goto out_caps;
> > > > +                       }
> > > > +                       ncopies = (src_fsc->mount_options->wsize /
> > > > +                                  object_size) * 4;
> > >
> > > The object size is constant within a file, so ncopies should be too.
> > > Perhaps introduce a counter instead of recalculating ncopies here?
> >
> > Not sure I understood your comment.  You would rather have:
> >
> >  * ncopies initialized only once outside the loop
> >  * have a counter counting the number of objects copied
> >  * call ceph_osdc_wait_requests() when this counter is a multiple of
> >    ncopies
> 
> I was thinking of a counter that is initialized to ncopies and reset to
> ncopies any time it reaches 0.  This is just a nit though.

Sure, no problem.

Cheers,
--
Luís
