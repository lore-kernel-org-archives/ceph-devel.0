From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Thu, 15 Oct 2015 09:56:23 +0300
Message-ID: <20151015065622.GB7834@gmail.com>
References: <20150930065044.GA14958@gmail.com>
 <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
 <561F19A5.4080500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:35393 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbJOG41 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 02:56:27 -0400
Received: by wicuv6 with SMTP id uv6so14468946wic.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2015 23:56:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <561F19A5.4080500@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, ceph-devel@vger.kernel.org

On Wed, Oct 14, 2015 at 08:12:37PM -0700, Josh Durgin wrote:
> On 10/14/2015 12:34 PM, Jason Dillaman wrote:
> >In general, I like the approach.
> >
> >I am concerned about passing a void* + length to specify the option value since you really can't protect against the user providing data in the incorrect format.  For example, if the backend treated RBD_OPTION_STRIPE_UNIT as a 4byte int, what happens if someone passes a 2- or 8-byte int or a 4-byte char* string?  Therefore, I would vote for passing strings a la librados rados_conf_set.
> 
> It seems like that'd be a bit clunky from C, since you'd need to create
> and fill in buffers for each option.
> 
> For safety we could have typed rbd_image_options_{get,set} for char*
> and uint64_t - it doesn't seem like we need any other types right now,
> since uint64_t is a superset of what we use int for.

I like this approach much more than using string, due to its
simplicity. I prefer it if my reasoning about my initial version I
sent in the response to Jason doesn't change your mind, guys.

> 
> Another alternative is a single get/set that takes a tagged union, e.g.
> 
> struct rbd_image_option {
>     int option;
>     int type;
>     union {
>         uint64_t ui
>         int       i
>         char*     s // NUL-terminated
>     };
> }
> 
> where type is an enum of RBD_OPTION_TYPE_{UINT64,INT,STRING} or
> similar.

Could do this way, it is ok to me too, though I like it a little less
than my version as I expect the code to encode/decode this would be a
little more complicated.

So, summarizing, I am listing the discussed approaches in the order I
like them from more to less.

1) initial variant (void*, lenght)
2) rbd_image_options_{get,set}_{uint64,str}
3) struct rbd_image_option
4) use string for options

Please tell me what you like more, I agree to do any way.

Thanks.

> 
> >Perhaps rbd_create4 and rbd_clone3 should move the order and features options to rbd_image_options_t as well?
> 
> Sounds good - no reason to keep mandatory parameters for options with
> defaults.
> 
> >>>Hi,
> >>>
> >>>It was mentioned several times eralier that it would be nice to pass
> >>>options as key/value configuration pairs on image create instead of
> >>>expanding rbd_create/rbd_clone/rbd_copy for every possible
> >>>configuration override.
> >>>
> >>>What do you think about this API?
> >>>
> >>>Introduce rbd_image_options_t and functions to manipulate it:
> >>>
> >>>int rbd_image_options_create(rbd_image_options_t* opts);
> >>>
> >>>void rbd_image_options_destroy(rbd_image_options_t opts);
> >>>
> >>>int rbd_image_options_set(rbd_image_options_t opts, int optname,
> >>>                           const void* optval, size_t optlen);
> >>>
> >>>int rbd_image_options_get(rbd_image_options_t opts, int optname,
> >>>                           void* optval, size_t* optlen);
> >>>
> >>>void rbd_image_options_iterate(rbd_image_options_t opts,
> >>>                                void (*func)(int*  optname, void* optval,
> >>>                                size_t* optlen));
> >>>
> >>>Functions that return a value return 0 on success, and -ERROR on
> >>>failure.
> >>>
> >>>optname is a constant like RBD_OPTION_STRIPE_UNIT,
> >>>RBD_OPTION_STRIPE_COUNT...
> >>>
> >>>Pass options as additional argument to rbd_create, rbd_clone (and may
> >>>be rbd_copy) functions:
> >>>
> >>>int rbd_create4(rados_ioctx_t io, const char *name, uint64_t size,
> >>>	        uint64_t features, int *order, rbd_image_options_t opts);
> >>>
> >>>int rbd_clone3(rados_ioctx_t p_ioctx, const char *p_name,
> >>>                const char *p_snapname, rados_ioctx_t c_ioctx,
> >>>                const char *c_name, uint64_t features, int *c_order,
> >>>                rbd_image_options_t opts);
> >>>
> >>>int rbd_copy3(rbd_image_t src, rbd_image_t dest, rbd_image_options_t opts);
> >>>// possibly
> 
> I'm ambivalent about a copy3. If you'd like to implement it, it should
> use the form that creates the destination image:
> 
> int rbd_copy3(rbd_image_t src, rados_ioctx_t dest_io_ctx,
>               const char *destname);
> 
> >>>
> >>>
> >>>Example:
> >>>
> >>>rbd_image_options_t opts;
> >>>int r;
> >>>r = rbd_image_options_create(&opts);
> >>>assert(r == 0);
> >>>uint64_t stripe_unit = 65536;
> >>>r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_UNIT,
> >>>                           &stripe_unit, size_of(stripe_unit));
> >>>assert(r == 0);
> >>>uint64_t stripe_count = 16;
> >>>r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_COUNT,
> >>>                           &stripe_count, size_of(stripe_count));
> >>>assert(r == 0);
> >>>const char* journal_object_pool = "journal";
> >>>r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
> >>>                           journal_object_pool, strlen(journal_object_pool) +
> >>>                           1);
> >>>assert(r == 0);
> >>>r = rbd_create4(io, name, size, features, int *order, rbd_image_options_t
> >>>opts);
> >>>
> >>>cleanup:
> >>>rbd_image_options_destroy(opts);
> 
> I like the API in general. The ability to reuse the same options or
> make small changes to them is nice.
> 
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
