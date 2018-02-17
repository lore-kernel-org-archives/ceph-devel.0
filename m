From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: wip-fancy-striping in ceph/ceph-client
Date: Sat, 17 Feb 2018 09:44:26 +0100
Message-ID: <CAOi1vP9GXEzq3jgwhUvOONn0zgVJgf+aDZMkmBR0aLyHraFwpg@mail.gmail.com>
References: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
 <acdbe5717d29dccdb7dae03696204886@petasan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:38325 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeBQIo1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Feb 2018 03:44:27 -0500
Received: by mail-io0-f174.google.com with SMTP id d13so6543249iog.5
        for <ceph-devel@vger.kernel.org>; Sat, 17 Feb 2018 00:44:27 -0800 (PST)
In-Reply-To: <acdbe5717d29dccdb7dae03696204886@petasan.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maged Mokhtar <mmokhtar@petasan.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>, David Disseldorp <ddiss@suse.de>

On Fri, Feb 16, 2018 at 5:30 PM, Maged Mokhtar <mmokhtar@petasan.org> wrote:
> On 2018-02-13 11:58, Ilya Dryomov wrote:
>
>> Hello,
>>
>> I've pushed wip-fancy-striping with my striping v2 patches.  I didn't
>> want to patch bomb the list and opened a dummy PR for feedback:
>>
>> https://github.com/ceph/ceph-client/pull/19
>>
>> As this is a full striping v2 implementation with adjacent extent
>> merging and no limitations on parent layouts, the patch set is very
>> invasive -- it's basically a rewrite of the entire I/O path.  Any
>> review comments and testing cycles would be greatly appreciated!
>>
>> Thanks,
>>
>> Ilya
>
>
> Hi Ilya,
>
> I looked at the patches, it is not a small change but is very nicely done. i
> was surprised since even though you added complex feature support, the new
> code is less (in rbd.c) and is clearer. The different fill from functions
> and different osd request creation functions is a very clean design.
>
> If i may say any minor/cosmetic comments:
>
> Out of all the old code i was happy to see removed, the only thing i would
> "miss" is the obj_requests list in the rbd_img_request struct. It is not
> needed now, but i tend to think it is logical to have a place to find all
> osd requests for a particular top block layer request. it maybe just a warm
> a and fuzzy feeling to have this control, but it could be useful for
> debugging or if in the future we think of implementing a task abort
> operation and need to find the osd inflight ops in a quick way.

It's still there -- rbd_img_request::object_extents.  It holds object
extents, which are embedded in object requests.  As before, each object
request holds an OSD request.

>
> Another cosmetic thing, i tend to think the new object <-> file extent
> conversion be placed in a separate new file rather than osdmap.c

ceph_calc_file_object_mapping() is in osdmap.c, so I just piled on.
You are right though, it has nothing to do with osdmaps.

>
> I would not be able to do full test any time soon, but i do intend to do
> some manual testing of basic functionality next week. i have in mind writing
> data pattern with each value repeating the size of stripe unit and doing a
> mix of read/write interchangeably between rbd and librbd, i would also test
> copyup functionality in clones. I will let you know if i do find any issues.

Thanks!

                Ilya
