From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] ceph/iov_iter: fix bad iov_iter handling in ceph
 splice codepaths
Date: Thu, 12 Jan 2017 12:37:25 +0100
Message-ID: <CAOi1vP8bqHAt_ZfTxTuqk7gxiia-Q=X+V4b409jCdW_y=kAJOg@mail.gmail.com>
References: <1483727016-343-1-git-send-email-jlayton@redhat.com>
 <1484053051-23685-1-git-send-email-jlayton@redhat.com> <20170112075946.GU1555@ZenIV.linux.org.uk>
 <1484220421.2970.20.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484220421.2970.20.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, Jan 12, 2017 at 12:27 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Thu, 2017-01-12 at 07:59 +0000, Al Viro wrote:
>> On Tue, Jan 10, 2017 at 07:57:31AM -0500, Jeff Layton wrote:
>> >
>> > v2: fix bug in offset handling in iov_iter_pvec_size
>> >
>> > xfstest generic/095 triggers soft lockups in kcephfs. Basically it uses
>> > fio to drive some I/O via vmsplice ane splice. Ceph then ends up trying
>> > to access an ITER_BVEC type iov_iter as a ITER_IOVEC one. That causes it
>> > to pick up a wrong offset and get stuck in an infinite loop while trying
>> > to populate the page array. dio_get_pagev_size has a similar problem.
>> >
>> > To fix the first problem, add a new iov_iter helper to determine the
>> > offset into the page for the current segment and have ceph call that.
>> > I would just replace dio_get_pages_alloc with iov_iter_get_pages_alloc,
>> > but that will only return a single page at a time for ITER_BVEC and
>> > it's better to make larger requests when possible.
>> >
>> > For the second problem, we simply replace it with a new helper that does
>> > what it does, but properly for all iov_iter types.
>> >
>> > Since we're moving that into generic code, we can also utilize the
>> > iterate_all_kinds macro to simplify this. That means that we need to
>> > rework the logic a bit since we can't advance to the next vector while
>> > checking the current one.
>>
>> Yecchhh...  That really looks like exposing way too low-level stuff instead
>> of coming up with saner primitive ;-/
>>
>
> Fair point. That said, I'm not terribly thrilled with how
> iov_iter_get_pages* works right now.
>
> Note that it only ever touches the first vector. Would it not be better
> to keep getting page references if the bvec/iov elements are aligned
> properly? It seems quite plausible that they often would be, and being
> able to hand back a larger list of pages in most cases would be
> advantageous.
>
> IOW, should we have iov_iter_get_pages basically do what
> dio_get_pages_alloc does -- try to build as long an array of pages as
> possible before returning, provided that the alignment works out?
>
> The NFS DIO code, for instance, could also benefit there. I know we've
> had reports there in the past that sending down a bunch of small iovecs
> causes a lot of small-sized requests on the wire.
>
>> Is page vector + offset in the first page + number of bytes really what
>> ceph wants?  Would e.g. an array of bio_vec be saner?  Because _that_
>> would make a lot more natural iov_iter_get_pages_alloc() analogue...
>>
>> And yes, I realize that you have ->pages wired into the struct ceph_osd_request;
>> how painful would it be to have it switched to struct bio_vec array instead?
>
> Actually...it looks like that might not be too hard. The low-level OSD
> handling code can already handle bio_vec arrays in order to service RBD.
> It looks like we could switch cephfs to use
> osd_req_op_extent_osd_data_bio instead of
> osd_req_op_extent_osd_data_pages. That would add a dependency in cephfs
> on CONFIG_BLOCK, but I think we could probably live with that.

Ah, just that part might be easy enough ;)

Thanks,

                Ilya
