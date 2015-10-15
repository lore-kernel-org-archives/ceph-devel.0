From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 09:33:10 +0300
Message-ID: <20151015063308.GA7834@gmail.com>
References: <20150930065044.GA14958@gmail.com>
 <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38732 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbJOGdN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 02:33:13 -0400
Received: by wicll6 with SMTP id ll6so3318171wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2015 23:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <jdurgin@redhat.com>

On Wed, Oct 14, 2015 at 03:34:52PM -0400, Jason Dillaman wrote:
> In general, I like the approach.  
>
> I am concerned about passing a void* + length to specify the option
> value since you really can't protect against the user providing data
> in the incorrect format.  For example, if the backend treated
> RBD_OPTION_STRIPE_UNIT as a 4byte int, what happens if someone
> passes a 2- or 8-byte int or a 4-byte char* string?

Then rbd_image_options_set() will fail with EINVAL, because the option
type (size) is a part of interface.

I do this by analogy to setsockopt(2):

http://pubs.opengroup.org/onlinepubs/009695399/functions/setsockopt.html

Note option type documented for every option there, and it works
fairly well.

Following a common practice is an additional argument to this
approach to me.

> Therefore, I would vote for passing strings a la librados
> rados_conf_set.

I'd rather don't use this approach, as it adds unnecessary work on
both user (encode the option to string) and backend (decode from
string) sides.

> Perhaps rbd_create4 and rbd_clone3 should move the order and
> features options to rbd_image_options_t as well?

My initial thought was that a user would want to set features and
orders more frequently than other options, so keeping them as
additional arguments would be useful. But now thinking more about it,
I agree that they can be moved to options.

> -- 
> 
> Jason Dillaman 
> 
> 
> ----- Original Message -----
> > From: "Mykola Golub" <mgolub@mirantis.com>
> > To: ceph-devel@vger.kernel.org
> > Cc: "Jason Dillaman" <dillaman@redhat.com>, "Josh Durgin" <jdurgin@redhat.com>
> > Sent: Wednesday, September 30, 2015 2:50:45 AM
> > Subject: CEPH_RBD_API: options on image create
> > 
> > Hi,
> > 
> > It was mentioned several times eralier that it would be nice to pass
> > options as key/value configuration pairs on image create instead of
> > expanding rbd_create/rbd_clone/rbd_copy for every possible
> > configuration override.
> > 
> > What do you think about this API?
> > 
> > Introduce rbd_image_options_t and functions to manipulate it:
> > 
> > int rbd_image_options_create(rbd_image_options_t* opts);
> > 
> > void rbd_image_options_destroy(rbd_image_options_t opts);
> > 
> > int rbd_image_options_set(rbd_image_options_t opts, int optname,
> >                           const void* optval, size_t optlen);
> > 
> > int rbd_image_options_get(rbd_image_options_t opts, int optname,
> >                           void* optval, size_t* optlen);
> > 
> > void rbd_image_options_iterate(rbd_image_options_t opts,
> >                                void (*func)(int* optname, void* optval,
> >                                size_t* optlen));
> > 
> > Functions that return a value return 0 on success, and -ERROR on
> > failure.
> > 
> > optname is a constant like RBD_OPTION_STRIPE_UNIT,
> > RBD_OPTION_STRIPE_COUNT...
> > 
> > Pass options as additional argument to rbd_create, rbd_clone (and may
> > be rbd_copy) functions:
> > 
> > int rbd_create4(rados_ioctx_t io, const char *name, uint64_t size,
> > 	        uint64_t features, int *order, rbd_image_options_t opts);
> > 
> > int rbd_clone3(rados_ioctx_t p_ioctx, const char *p_name,
> >                const char *p_snapname, rados_ioctx_t c_ioctx,
> >                const char *c_name, uint64_t features, int *c_order,
> >                rbd_image_options_t opts);
> > 
> > int rbd_copy3(rbd_image_t src, rbd_image_t dest, rbd_image_options_t opts);
> > // possibly
> > 
> > 
> > Example:
> > 
> > rbd_image_options_t opts;
> > int r;
> > r = rbd_image_options_create(&opts);
> > assert(r == 0);
> > uint64_t stripe_unit = 65536;
> > r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_UNIT,
> >                           &stripe_unit, size_of(stripe_unit));
> > assert(r == 0);
> > uint64_t stripe_count = 16;
> > r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_COUNT,
> >                           &stripe_count, size_of(stripe_count));
> > assert(r == 0);
> > const char* journal_object_pool = "journal";
> > r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
> >                           journal_object_pool, strlen(journal_object_pool) +
> >                           1);
> > assert(r == 0);
> > r = rbd_create4(io, name, size, features, int *order, rbd_image_options_t
> > opts);
> > 
> > cleanup:
> > rbd_image_options_destroy(opts);
> > 
> > --
> > Mykola Golub
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
