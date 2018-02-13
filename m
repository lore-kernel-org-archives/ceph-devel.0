From: Alex Elder <elder@linaro.org>
Subject: Re: wip-fancy-striping in ceph/ceph-client
Date: Tue, 13 Feb 2018 09:05:45 -0600
Message-ID: <47566385-f84b-6bdb-45ee-afc1b9a015c1@linaro.org>
References: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:44648 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965037AbeBMPFs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 10:05:48 -0500
Received: by mail-io0-f171.google.com with SMTP id z6so21554677iob.11
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 07:05:48 -0800 (PST)
In-Reply-To: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: David Disseldorp <ddiss@suse.de>, Maged Mokhtar <mmokhtar@petasan.org>

On 02/13/2018 03:58 AM, Ilya Dryomov wrote:
> Hello,
> 
> I've pushed wip-fancy-striping with my striping v2 patches.  I didn't
> want to patch bomb the list and opened a dummy PR for feedback:
> 
>   https://github.com/ceph/ceph-client/pull/19
> 
> As this is a full striping v2 implementation with adjacent extent
> merging and no limitations on parent layouts, the patch set is very
> invasive -- it's basically a rewrite of the entire I/O path.  Any
> review comments and testing cycles would be greatly appreciated!

This looks like a nice improvement.  I think the bio improvements
from Kent Overstreet shortly after I finished working on this stuff,
and some of this might have been enabled by that work.  Some of the
multiqueue work helps too.  Regardless, I won't say I've formally
reviewed it but it looks really good to me, improves things beyond
just adding the fancy striping functionality.

I'm only scanning through them right now.  Here are a few simple things:
- Very nice cleanup in  __ceph_calc_file_object_mapping()
- I don't like the ({ zero_bvec(&bv); }) in zero_bios.  It looks wrong,
  but the real problem is the way ceph_bio_iter_advance_step() is defined.
  The caller shouldn't (have to) assume the existence of a symbol having
  a particular name.  I'm not sure how this advance step macro will be
  used elsewhere but can you just supply a function that operates on
  bio_vec pointer instead (possibly null)?  I think that may be the only
  reason you need a macro for pass-by-name, so doing this might allow this
  to become an inline function instead.  (I see later that this code got
  affected; maybe the problem goes away?)
- I'm not sure why OBJ_REQUEST_PAGES was used for stat requests.
- Are CEPH_MSG_DATA_BVECS dependent on CONFIG_BLOCK?  (Though I always
  wondered what system might ever be configured without it.)
- I think you should (have) split "rbd: new request handling code" into
  several patches.  I wanted to see the non-image requests going away
  separately, or the opportunistic write in a stat, for example.
- I like the state machine, and you simplified a lot with that commit.
- It's nice to complete all image requests at once rather than having to
  do so in order.
- Generally I didn't work through the new fancy striping code; too fancy
  for a quick review.
- Nice to see more use of multiple ops in an OSD request.  As I recall
  the way it's implemented is pretty limited; I wanted to generalize it
  but never got that far.
- I think the reference counting between parent and child images was
  done safely, but I'm glad you were able to reason away the need for
  some of it.

I'd love to give this a much deeper review but it'll take a full day
at some point and I don't have that right now.  (I've already used
time I probably can't afford...)  I can probably make time though if
you think it's final.  

					-Alex

> Thanks,
> 
>                 Ilya
> 

