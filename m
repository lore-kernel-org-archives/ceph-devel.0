From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: CEPH_RBD_API: options on image create
Date: Wed, 14 Oct 2015 20:12:37 -0700
Message-ID: <561F19A5.4080500@redhat.com>
References: <20150930065044.GA14958@gmail.com>
 <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932437AbbJODLb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Oct 2015 23:11:31 -0400
In-Reply-To: <807360446.46582415.1444851292070.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Mykola Golub <mgolub@mirantis.com>
Cc: ceph-devel@vger.kernel.org

On 10/14/2015 12:34 PM, Jason Dillaman wrote:
> In general, I like the approach.
>
> I am concerned about passing a void* + length to specify the option value since you really can't protect against the user providing data in the incorrect format.  For example, if the backend treated RBD_OPTION_STRIPE_UNIT as a 4byte int, what happens if someone passes a 2- or 8-byte int or a 4-byte char* string?  Therefore, I would vote for passing strings a la librados rados_conf_set.

It seems like that'd be a bit clunky from C, since you'd need to create
and fill in buffers for each option.

For safety we could have typed rbd_image_options_{get,set} for char*
and uint64_t - it doesn't seem like we need any other types right now,
since uint64_t is a superset of what we use int for.

Another alternative is a single get/set that takes a tagged union, e.g.

struct rbd_image_option {
     int option;
     int type;
     union {
         uint64_t ui
         int       i
         char*     s // NUL-terminated
     };
}

where type is an enum of RBD_OPTION_TYPE_{UINT64,INT,STRING} or similar.

> Perhaps rbd_create4 and rbd_clone3 should move the order and features options to rbd_image_options_t as well?

Sounds good - no reason to keep mandatory parameters for options with
defaults.

>> >Hi,
>> >
>> >It was mentioned several times eralier that it would be nice to pass
>> >options as key/value configuration pairs on image create instead of
>> >expanding rbd_create/rbd_clone/rbd_copy for every possible
>> >configuration override.
>> >
>> >What do you think about this API?
>> >
>> >Introduce rbd_image_options_t and functions to manipulate it:
>> >
>> >int rbd_image_options_create(rbd_image_options_t* opts);
>> >
>> >void rbd_image_options_destroy(rbd_image_options_t opts);
>> >
>> >int rbd_image_options_set(rbd_image_options_t opts, int optname,
>> >                           const void* optval, size_t optlen);
>> >
>> >int rbd_image_options_get(rbd_image_options_t opts, int optname,
>> >                           void* optval, size_t* optlen);
>> >
>> >void rbd_image_options_iterate(rbd_image_options_t opts,
>> >                                void (*func)(int*  optname, void* optval,
>> >                                size_t* optlen));
>> >
>> >Functions that return a value return 0 on success, and -ERROR on
>> >failure.
>> >
>> >optname is a constant like RBD_OPTION_STRIPE_UNIT,
>> >RBD_OPTION_STRIPE_COUNT...
>> >
>> >Pass options as additional argument to rbd_create, rbd_clone (and may
>> >be rbd_copy) functions:
>> >
>> >int rbd_create4(rados_ioctx_t io, const char *name, uint64_t size,
>> >	        uint64_t features, int *order, rbd_image_options_t opts);
>> >
>> >int rbd_clone3(rados_ioctx_t p_ioctx, const char *p_name,
>> >                const char *p_snapname, rados_ioctx_t c_ioctx,
>> >                const char *c_name, uint64_t features, int *c_order,
>> >                rbd_image_options_t opts);
>> >
>> >int rbd_copy3(rbd_image_t src, rbd_image_t dest, rbd_image_options_t opts);
>> >// possibly

I'm ambivalent about a copy3. If you'd like to implement it, it should
use the form that creates the destination image:

int rbd_copy3(rbd_image_t src, rados_ioctx_t dest_io_ctx,
               const char *destname);

>> >
>> >
>> >Example:
>> >
>> >rbd_image_options_t opts;
>> >int r;
>> >r = rbd_image_options_create(&opts);
>> >assert(r == 0);
>> >uint64_t stripe_unit = 65536;
>> >r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_UNIT,
>> >                           &stripe_unit, size_of(stripe_unit));
>> >assert(r == 0);
>> >uint64_t stripe_count = 16;
>> >r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_COUNT,
>> >                           &stripe_count, size_of(stripe_count));
>> >assert(r == 0);
>> >const char* journal_object_pool = "journal";
>> >r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
>> >                           journal_object_pool, strlen(journal_object_pool) +
>> >                           1);
>> >assert(r == 0);
>> >r = rbd_create4(io, name, size, features, int *order, rbd_image_options_t
>> >opts);
>> >
>> >cleanup:
>> >rbd_image_options_destroy(opts);

I like the API in general. The ability to reuse the same options or
make small changes to them is nice.

Josh
