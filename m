From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: handle parent_overlap on writes correctly
Date: Fri, 13 Jun 2014 12:06:57 +0400
Message-ID: <CALFYKtALm2q==dLr01eSQ6F6Dd7VOxzwqHeA94OivaAvbMoa+w@mail.gmail.com>
References: <1402504849-9958-1-git-send-email-ilya.dryomov@inktank.com>
	<539A5350.1070706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48313 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaFMIG6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jun 2014 04:06:58 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so3804830qcy.29
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jun 2014 01:06:57 -0700 (PDT)
In-Reply-To: <539A5350.1070706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jun 13, 2014 at 5:26 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 06/11/2014 09:40 AM, Ilya Dryomov wrote:
>>
>> The following check in rbd_img_obj_request_submit()
>>
>>      rbd_dev->parent_overlap <= obj_request->img_offset
>>
>> allows the fall through to the non-layered write case even if both
>> parent_overlap and obj_request->img_offset belong to the same RADOS
>> object.  This leads to data corruption, because the area to the left of
>> parent_overlap ends up unconditionally zero-filled instead of being
>> populated with parent data.  Suppose we want to write 1M to offset 6M
>> of image bar, which is a clone of foo@snap; object_size is 4M,
>> parent_overlap is 5M:
>>
>>      rbd_data.<id>.0000000000000001
>>       ---------------------|----------------------|------------
>>      | should be copyup'ed | should be zeroed out | write ...
>>       ---------------------|----------------------|------------
>>     4M                    5M                     6M
>>                      parent_overlap    obj_request->img_offset
>>
>> 4..5M should be copyup'ed from foo, yet it is zero-filled, just like
>> 5..6M is.
>>
>> Given that the only striping mode kernel client currently supports is
>> chunking (i.e. stripe_unit == object_size, stripe_count == 1), round
>> parent_overlap up to the next object boundary for the purposes of the
>> overlap check.
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>
>
> Good catch! This should be included in any stable kernels 3.10 or later
> too.
>
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

This commit in ceph-client already has the 3.10+ stable tag.

Thanks,

                Ilya
