From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] ceph/iov_iter: fix bad iov_iter handling in ceph
 splice codepaths
Date: Thu, 12 Jan 2017 07:59:46 +0000
Message-ID: <20170112075946.GU1555@ZenIV.linux.org.uk>
References: <1483727016-343-1-git-send-email-jlayton@redhat.com>
 <1484053051-23685-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484053051-23685-1-git-send-email-jlayton@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jan 10, 2017 at 07:57:31AM -0500, Jeff Layton wrote:
> v2: fix bug in offset handling in iov_iter_pvec_size
> 
> xfstest generic/095 triggers soft lockups in kcephfs. Basically it uses
> fio to drive some I/O via vmsplice ane splice. Ceph then ends up trying
> to access an ITER_BVEC type iov_iter as a ITER_IOVEC one. That causes it
> to pick up a wrong offset and get stuck in an infinite loop while trying
> to populate the page array. dio_get_pagev_size has a similar problem.
> 
> To fix the first problem, add a new iov_iter helper to determine the
> offset into the page for the current segment and have ceph call that.
> I would just replace dio_get_pages_alloc with iov_iter_get_pages_alloc,
> but that will only return a single page at a time for ITER_BVEC and
> it's better to make larger requests when possible.
> 
> For the second problem, we simply replace it with a new helper that does
> what it does, but properly for all iov_iter types.
> 
> Since we're moving that into generic code, we can also utilize the
> iterate_all_kinds macro to simplify this. That means that we need to
> rework the logic a bit since we can't advance to the next vector while
> checking the current one.

Yecchhh...  That really looks like exposing way too low-level stuff instead
of coming up with saner primitive ;-/

Is page vector + offset in the first page + number of bytes really what
ceph wants?  Would e.g. an array of bio_vec be saner?  Because _that_
would make a lot more natural iov_iter_get_pages_alloc() analogue...

And yes, I realize that you have ->pages wired into the struct ceph_osd_request;
how painful would it be to have it switched to struct bio_vec array instead?
