From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: wip-fancy-striping in ceph/ceph-client
Date: Tue, 13 Feb 2018 17:24:09 +0100
Message-ID: <CAOi1vP98H_ZAH9zmOBCDfmWRQnapSeuum0-RsaDuNxg7g+RpCQ@mail.gmail.com>
References: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
 <47566385-f84b-6bdb-45ee-afc1b9a015c1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:40146 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeBMQYL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 11:24:11 -0500
Received: by mail-it0-f49.google.com with SMTP id v186so6262960itc.5
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 08:24:10 -0800 (PST)
In-Reply-To: <47566385-f84b-6bdb-45ee-afc1b9a015c1@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, David Disseldorp <ddiss@suse.de>, Maged Mokhtar <mmokhtar@petasan.org>

On Tue, Feb 13, 2018 at 4:05 PM, Alex Elder <elder@linaro.org> wrote:
> On 02/13/2018 03:58 AM, Ilya Dryomov wrote:
>> Hello,
>>
>> I've pushed wip-fancy-striping with my striping v2 patches.  I didn't
>> want to patch bomb the list and opened a dummy PR for feedback:
>>
>>   https://github.com/ceph/ceph-client/pull/19
>>
>> As this is a full striping v2 implementation with adjacent extent
>> merging and no limitations on parent layouts, the patch set is very
>> invasive -- it's basically a rewrite of the entire I/O path.  Any
>> review comments and testing cycles would be greatly appreciated!
>
> This looks like a nice improvement.  I think the bio improvements
> from Kent Overstreet shortly after I finished working on this stuff,
> and some of this might have been enabled by that work.  Some of the

Yeah, all of the new iterator stuff is based on Kent's immutable
bio_vecs work.

> multiqueue work helps too.  Regardless, I won't say I've formally
> reviewed it but it looks really good to me, improves things beyond
> just adding the fancy striping functionality.
>
> I'm only scanning through them right now.  Here are a few simple things:
> - Very nice cleanup in  __ceph_calc_file_object_mapping()
> - I don't like the ({ zero_bvec(&bv); }) in zero_bios.  It looks wrong,
>   but the real problem is the way ceph_bio_iter_advance_step() is defined.
>   The caller shouldn't (have to) assume the existence of a symbol having
>   a particular name.  I'm not sure how this advance step macro will be
>   used elsewhere but can you just supply a function that operates on
>   bio_vec pointer instead (possibly null)?  I think that may be the only
>   reason you need a macro for pass-by-name, so doing this might allow this
>   to become an inline function instead.  (I see later that this code got
>   affected; maybe the problem goes away?)

These macros were private to rbd.c and weren't supposed to be used
anywhere else.  I pulled them into messenger.h during last minute
refactoring, because they ended up being not rbd specific after all.
ceph_bvec_iter in particular might be used in the filesystem, which
also needs a fully-featured striping implementation.

Here is a more advanced example, from copy_bio_bvecs():

        ceph_bio_iter_advance_step(it, bytes, ({
                obj_req->bvec_pos.bvecs[obj_req->bvec_idx++] = bv;
                obj_req->bvec_pos.iter.bi_size += bv.bv_len;
        }));

It could certainly take a (struct bio_vec *bv, void *arg) function
instead, but I'm not sure if it's that much better or how good a job
gcc would do in that case.

> - I'm not sure why OBJ_REQUEST_PAGES was used for stat requests.
> - Are CEPH_MSG_DATA_BVECS dependent on CONFIG_BLOCK?  (Though I always
>   wondered what system might ever be configured without it.)

No.  struct bio_vec is a big misnomer -- it has nothing to do with
bios.  It should be struct part_of_page or something like that.

> - I think you should (have) split "rbd: new request handling code" into
>   several patches.  I wanted to see the non-image requests going away
>   separately, or the opportunistic write in a stat, for example.

The opportunistic write is what let non-image requests go -- it's just
a side effect, not an actual change.  There is no good way to split
that commit into smaller pieces, at least not without adding a bunch of
new callback based code and then removing it in the next commit.

> - I like the state machine, and you simplified a lot with that commit.
> - It's nice to complete all image requests at once rather than having to
>   do so in order.
> - Generally I didn't work through the new fancy striping code; too fancy
>   for a quick review.

:-)

> - Nice to see more use of multiple ops in an OSD request.  As I recall
>   the way it's implemented is pretty limited; I wanted to generalize it
>   but never got that far.

It's fine for regular OSD ops, but issues crop up when you try to
combine multiple method call ops.

> - I think the reference counting between parent and child images was
>   done safely, but I'm glad you were able to reason away the need for
>   some of it.
>
> I'd love to give this a much deeper review but it'll take a full day
> at some point and I don't have that right now.  (I've already used
> time I probably can't afford...)  I can probably make time though if
> you think it's final.

It's final.  I'd definitely appreciate a deeper review.

Thanks,

                Ilya
