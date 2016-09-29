From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 4/8] rbd: move bumping img_request refcount into rbd_obj_request_submit()
Date: Thu, 29 Sep 2016 17:15:03 +0200
Message-ID: <CAOi1vP_W=NsqRNniwTLu6csY7Q7Z2U_ai4S-gbo0Z7x3_o8x9Q@mail.gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-5-git-send-email-idryomov@gmail.com> <93d01f3c-78a7-6407-8af9-78680455024f@linaro.org>
 <CAOi1vP-dDyJLNca+DHoSvdS9+i9ZdZUTF537jfg44RDOeJfnvg@mail.gmail.com> <8e96ec90-d6b0-ef0c-258f-2262609bbc15@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36721 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbcI2PPE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2016 11:15:04 -0400
Received: by mail-vk0-f67.google.com with SMTP id v205so2891558vke.3
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 08:15:04 -0700 (PDT)
In-Reply-To: <8e96ec90-d6b0-ef0c-258f-2262609bbc15@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 28, 2016 at 2:22 AM, Alex Elder <elder@ieee.org> wrote:
> On 09/26/2016 09:38 AM, Ilya Dryomov wrote:
>> On Sun, Sep 25, 2016 at 5:56 PM, Alex Elder <elder@linaro.org> wrote:
>>> On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
>>>> Commit 0f2d5be792b0 ("rbd: use reference counts for image requests")
>>>> added rbd_img_request_get(), which rbd_img_request_fill() calls for
>>>> each obj_request added to img_request.  It was an urgent band-aid for
>>>> the uglyness that is rbd_img_obj_callback() and none of the error paths
>>>> were updated.
>>>
>>> I'm not sure how to improve that function.  Object requests in
>>> an image request need to be completed in sequential order,
>>> because blk_update_request() requires that.  (Or maybe you
>>> were referring to something else you find ugly.)
>>
>> Quoting 0f2d5be792b0 commit message:
>>
>> "There is a race here, however.  The instant an object request is
>> marked "done" it can be provided (by a thread handling completion of
>> one of its predecessor operations) to rbd_img_obj_end_request(),
>> which (for the last request) can then lead to the image request
>> getting torn down.  And this can happen *before* that object has
>> itself entered rbd_img_obj_end_request().  As a result, once it
>> *does* enter that function, the image request (and even the object
>> request itself) may have been freed and become invalid."
>>
>> "... we don't want rbd_img_request_complete() to necessarily
>> result in the image request being destroyed, because it may
>> get called before we've finished processing on all of its
>> object requests."
>>
>> This "I'm called for obj_request1, but I'll also complete obj_request2
>> along with the entire img_request if I get a chance, before I'm called
>> for obj_request2" behaviour is *really* *really* sneaky.
>
> OK, I understand that.  (And I think you meant "...before I'm
> called for obj_request1".)
>
>> I think a simple atomic, decremented for each obj_request completion
>> would do.  When it hits 0, we say "OK, this img_request is finished"
>> and call rbd_img_obj_end_request() for each obj_request in order.  I'm
>> not sure we are getting anything from calling blk_update_request() in
>> this fashion, at the expense of hard to comprehend buggy code.
>
> OK, now you're talking about something different, which is to
> change how we handle image object request completions.

Yeah, how we handle image object request completions is the root of the
problem here.  It's the reason we have rbd_img_request_get/put() in the
first place.

> Practically speaking, I think you're right that there would
> be very little lost by handling an image request's object
> request completions all at once rather than as quickly as
> possible.
>
> I think the get of the img_request in the error paths looks
> a little funny.  It'll now be encapsulated in another function,
> so maybe you can add a small comment there to say why you need
> to do that--to match what the submit path does (or to match
> the reference dropped in the completion path).

I've just re-pushed with the helper.

>
> I have no argument with what you're doing, and I unfortunately
> feel less confident (maybe 10% less) in my walk-through of
> all the affected code than I normally am on your patches...
> But I'll call that good enough.  I only have small blocks of
> time right now and I don't want to delay things.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks for the review!

                Ilya
