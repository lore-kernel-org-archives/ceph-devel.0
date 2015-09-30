From: Mykola Golub <mgolub@mirantis.com>
Subject: CEPH_RBD_API: options on image create
Date: Wed, 30 Sep 2015 09:50:45 +0300
Message-ID: <20150930065044.GA14958@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33426 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbI3Gut (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Sep 2015 02:50:49 -0400
Received: by lahh2 with SMTP id h2so34593651lah.0
        for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2015 23:50:47 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>

Hi,

It was mentioned several times eralier that it would be nice to pass
options as key/value configuration pairs on image create instead of
expanding rbd_create/rbd_clone/rbd_copy for every possible
configuration override.

What do you think about this API?

Introduce rbd_image_options_t and functions to manipulate it:

int rbd_image_options_create(rbd_image_options_t* opts);

void rbd_image_options_destroy(rbd_image_options_t opts);

int rbd_image_options_set(rbd_image_options_t opts, int optname,
                          const void* optval, size_t optlen);

int rbd_image_options_get(rbd_image_options_t opts, int optname,
                          void* optval, size_t* optlen);

void rbd_image_options_iterate(rbd_image_options_t opts,
                               void (*func)(int* optname, void* optval, size_t* optlen));

Functions that return a value return 0 on success, and -ERROR on
failure.

optname is a constant like RBD_OPTION_STRIPE_UNIT,
RBD_OPTION_STRIPE_COUNT...

Pass options as additional argument to rbd_create, rbd_clone (and may
be rbd_copy) functions:

int rbd_create4(rados_ioctx_t io, const char *name, uint64_t size,
	        uint64_t features, int *order, rbd_image_options_t opts);

int rbd_clone3(rados_ioctx_t p_ioctx, const char *p_name,
               const char *p_snapname, rados_ioctx_t c_ioctx,
               const char *c_name, uint64_t features, int *c_order,
               rbd_image_options_t opts);

int rbd_copy3(rbd_image_t src, rbd_image_t dest, rbd_image_options_t opts); // possibly


Example:

rbd_image_options_t opts;
int r;
r = rbd_image_options_create(&opts);
assert(r == 0);
uint64_t stripe_unit = 65536;
r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_UNIT,
                          &stripe_unit, size_of(stripe_unit));
assert(r == 0);
uint64_t stripe_count = 16;
r = rbd_image_options_set(opts, RBD_OPTION_STRIPE_COUNT,
                          &stripe_count, size_of(stripe_count));
assert(r == 0);
const char* journal_object_pool = "journal";
r = rbd_image_options_set(opts, RBD_OPTION_JOURNAL_OBJECT_POOL,
                          journal_object_pool, strlen(journal_object_pool) + 1);
assert(r == 0);
r = rbd_create4(io, name, size, features, int *order, rbd_image_options_t opts);

cleanup:
rbd_image_options_destroy(opts);

-- 
Mykola Golub
