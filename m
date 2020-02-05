From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v3 1/1] ceph: parallelize all copy-from requests in copy_file_range
Date: Wed, 5 Feb 2020 13:01:52 +0100
Message-ID: <CAOi1vP-kLCY+Q2UwpqvJdfeEV6me=FneLhasQrj2nkcu_7tRew@mail.gmail.com>
References: <20200203165117.5701-1-lhenriques@suse.com> <20200203165117.5701-2-lhenriques@suse.com>
 <CAOi1vP8vXeY156baexdZY2FWK_F0jHfWkyNdZ90PA+7txG=Qsw@mail.gmail.com>
 <20200204151158.GA15992@suse.com> <CAOi1vP-LvJYwAALQ_69rDUaiXYWa-_NPboeZV5zZiw_cokNyfw@mail.gmail.com>
 <20200205110007.GA11836@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205110007.GA11836@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Feb 5, 2020 at 12:00 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> On Tue, Feb 04, 2020 at 07:06:36PM +0100, Ilya Dryomov wrote:
> > On Tue, Feb 4, 2020 at 4:11 PM Luis Henriques <lhenriques@suse.com> wrote:
> > >
> > > On Tue, Feb 04, 2020 at 11:56:57AM +0100, Ilya Dryomov wrote:
> > > ...
> > > > > @@ -2108,21 +2118,40 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > > > >                         CEPH_OSD_OP_FLAG_FADVISE_DONTNEED,
> > > > >                         dst_ci->i_truncate_seq, dst_ci->i_truncate_size,
> > > > >                         CEPH_OSD_COPY_FROM_FLAG_TRUNCATE_SEQ);
> > > > > -               if (err) {
> > > > > -                       if (err == -EOPNOTSUPP) {
> > > > > -                               src_fsc->have_copy_from2 = false;
> > > > > -                               pr_notice("OSDs don't support 'copy-from2'; "
> > > > > -                                         "disabling copy_file_range\n");
> > > > > -                       }
> > > > > +               if (IS_ERR(req)) {
> > > > > +                       err = PTR_ERR(req);
> > > > >                         dout("ceph_osdc_copy_from returned %d\n", err);
> > > > > +
> > > > > +                       /* wait for all queued requests */
> > > > > +                       ceph_osdc_wait_requests(&osd_reqs, &reqs_complete);
> > > > > +                       ret += reqs_complete * object_size; /* Update copied bytes */
> > > >
> > > > Hi Luis,
> > > >
> > > > Looks like ret is still incremented unconditionally?  What happens
> > > > if there are three OSD requests on the list and the first fails but
> > > > the second and the third succeed?  As is, ceph_osdc_wait_requests()
> > > > will return an error with reqs_complete set to 2...
> > > >
> > > > >                         if (!ret)
> > > > >                                 ret = err;
> > > >
> > > > ... and we will return 8M instead of an error.
> > >
> > > Right, my assumption was that if a request fails, all subsequent requests
> > > would also fail.  This would allow ret to be updated with the number of
> > > successful requests (x object size), even if the OSDs replies were being
> > > delivered in a different order.  But from your comment I see that my
> > > assumption is incorrect.
> > >
> > > In that case, when shall ret be updated with the number of bytes already
> > > written?  Only after a successful call to ceph_osdc_wait_requests()?
> >
> > I mentioned this in the previous email: you probably want to change
> > ceph_osdc_wait_requests() so that the counter isn't incremented after
> > an error is encountered.
>
> Sure, I've seen that comment.  But it doesn't help either because it's not
> guaranteed that we'll receive the replies from the OSDs in the same order
> we've sent them.  Stopping the counter when we get an error doesn't
> provide us any reliable information (which means I can simply drop that
> counter).

The list is FIFO so even though replies may indeed arrive out of
order, ceph_osdc_wait_requests() will process them in order.  If you
stop counting as soon as an error is encountered, you know for sure
that requests 1 through $COUNTER were successful and can safely
multiply it by object size.

>
> > > I.e. only after each throttling cycle, when we don't have any requests
> > > pending completion?  In this case, I can simply drop the extra
> > > reqs_complete parameter to the ceph_osdc_wait_requests.
> > >
> > > In your example the right thing to do would be to simply return an error,
> > > I guess.  But then we're assuming that we're loosing space in the storage,
> > > as we may have created objects that won't be reachable anymore.
> >
> > Well, that is what I'm getting at -- this needs a lot more
> > consideration.  How errors are dealt with, how file metadata is
> > updated, when do we fall back to plain copy, etc.  Generating stray
> > objects is bad but way better than reporting that e.g. 0..12M were
> > copied when only 0..4M and 8M..12M were actually copied, leaving
> > the user one step away from data loss.  One option is to revert to
> > issuing copy-from requests serially when an error is encountered.
> > Another option is to fall back to plain copy on any error.  Or perhaps
> > we just don't bother with the complexity of parallel copy-from requests
> > at all...
>
> To be honest, I'm starting to lean towards this option.  Reverting to
> serializing requests or to plain copy on error will not necessarily
> prevent the stray objects:
>
>   - send a bunch of copy requests
>   - wait for them to complete
>      * 1 failed, the other 63 succeeded
>   - revert to serialized copies, repeating the previous 64 requests
>      * after a few copies, we get another failure (maybe on the same OSDs)
>        and abort, leaving behind some stray objects from the previous bulk
>        request

Yeah, doing it serially makes the accounting a lot easier.  If you
issue any OSD requests before updating the size, stray objects are
bound to happen -- that's why "how file metadata is updated" is one
of the important considerations.

Thanks,

                Ilya
