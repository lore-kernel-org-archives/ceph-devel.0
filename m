From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 8/8] rbd: img_data requests don't own their page array
Date: Mon, 26 Sep 2016 19:25:54 +0200
Message-ID: <CAOi1vP9LexxS62KJEW14T_GiY1t78EB7QbwXW2CJ2p_0FcJKWA@mail.gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-9-git-send-email-idryomov@gmail.com> <3fe273f8-7f12-26d4-885a-972e63c0b48e@linaro.org>
 <20160926173322.50fa05f8@echidna.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32856 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034708AbcIZRZ4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 13:25:56 -0400
Received: by mail-vk0-f65.google.com with SMTP id z126so3020657vkd.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 10:25:55 -0700 (PDT)
In-Reply-To: <20160926173322.50fa05f8@echidna.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Sep 26, 2016 at 5:33 PM, David Disseldorp <ddiss@suse.de> wrote:
> On Sun, 25 Sep 2016 12:06:34 -0500, Alex Elder wrote:
>
>> On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
>> > Move the check into rbd_obj_request_destroy(), to avoid use-after-free
>> > on errors in rbd_img_request_fill().
>> >
>> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>>
>> Is this because an error occurring in rbd_img_request_fill()
>> causes rbd_img_obj_request_del() to be called, which leads to
>> rbd_obj_request_destroy(), which (by this time) has not yet
>> had its obj_request->pages pointer set to NULL because the
>> object request is still outstanding?  (Your explanation was
>> a little brief...)
>
> I agree, the commit message could be improved...
>
> I think the use after free is in the rbd_img_obj_parent_read_full()
> call path - if rbd_img_request_fill() fails after adding an obj_request
> to the img_request->obj_requests list, then the corresponding page(s)
> will be freed in the rbd_img_request_fill() out_unwind error path *and*
> the rbd_img_obj_parent_read_full() error path.

Correct.  The same goes for rbd_img_request_fill(OBJ_REQUEST_PAGES)
call in rbd_img_parent_read().  I'll update the commit message.

>
>> The change in rbd_obj_request_destroy() looks good for that
>> case.
>>
>> The code deleted in rbd_img_obj_end_request() could still stay,
>> however.  Almost everywhere, pointers are reassigned to NULL
>> when it's known the thing referred to is no longer needed.
>> It's useful in post-mortem understanding of what's occurred.
>
> Agreed.

I disagree.  Yes, it sometimes helps if you do it systematically and
all you have is a panic message.  But if you have a vmcore and trying
to do an actual post-mortem, NULLed out pointers tend to work against
you, especially if you NULL out something that hasn't just been freed.

Thanks,

                Ilya
