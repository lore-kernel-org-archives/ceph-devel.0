From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: don't leak parent_spec in rbd_dev_probe_parent()
Date: Fri, 16 Oct 2015 15:50:25 +0200
Message-ID: <CAOi1vP9j=rb4sxVdDfecT37LWS3JQ6KtBEU9UxVTigi5fcHJKQ@mail.gmail.com>
References: <1444586591-24141-1-git-send-email-idryomov@gmail.com>
	<5620163F.3060406@ieee.org>
	<CAOi1vP_eUzSN=WZCqyjXkr-pzZvj1_SeZ3XWUnd55V=jwdrXzg@mail.gmail.com>
	<5620E491.2070006@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36235 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbJPNu2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 09:50:28 -0400
Received: by wicgb1 with SMTP id gb1so10384938wic.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Oct 2015 06:50:27 -0700 (PDT)
In-Reply-To: <5620E491.2070006@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 16, 2015 at 1:50 PM, Alex Elder <elder@ieee.org> wrote:
> On 10/16/2015 04:50 AM, Ilya Dryomov wrote:
>> On Thu, Oct 15, 2015 at 11:10 PM, Alex Elder <elder@ieee.org> wrote:
>>> On 10/11/2015 01:03 PM, Ilya Dryomov wrote:
>>>> Currently we leak parent_spec and trigger a "parent reference
>>>> underflow" warning if rbd_dev_create() in rbd_dev_probe_parent() fails.
>>>> The problem is we take the !parent out_err branch and that only drops
>>>> refcounts; parent_spec that would've been freed had we called
>>>> rbd_dev_unparent() remains and triggers rbd_warn() in
>>>> rbd_dev_parent_put() - at that point we have parent_spec != NULL and
>>>> parent_ref == 0, so counter ends up being -1 after the decrement.
>>>
>>> OK, now that I understand the context...
>>>
>>> You now get extra references for the spec and client
>>> for the parent only after creating the parent device.
>>> I think the reason they logically belonged before
>>> the call to rbd_device_create() for the parent is
>>> because the client and spec pointers passed to that
>>> function carry with them references that are passed
>>> to the resulting rbd_device if successful.
>>
>> Let me stress that those two get()s that I moved is not the point of
>> the patch at all.  Whether we do it before or after rbd_dev_create() is
>> pretty much irrelevant, the only reason I moved those calls is to make
>> the error path simpler.
>
> Yes I understand that.
>
>>> If creating the parent device fails, you unparent the
>>> original device, which will still have a null parent
>>> pointer.  The effect of unparenting in this case is
>>> dropping a reference to the parent's spec, and clearing
>>> the device's pointer to it.  This is confusing, but
>>> let's run with it.
>>>
>>> If creating the parent device succeeds, references to
>>> the client and parent spec are taken (basically, these
>>> belong to the just-created parent device).  The parent
>>> image is now probed.  If this fails, you again
>>> unparent the device.  We still have not set the
>>> device's parent pointer, so the effect is as before,
>>> dropping the parent spec reference and clearing
>>> the device's reference to it.  The error handling
>>> now destroys the parent, which drops references to
>>> its client and the spec.  Again, this seems
>>> confusing, as if we've dropped one more reference
>>> to the parent spec than desired.
>>>
>>> This logic now seems to work.  But it's working
>>> around a flaw in the caller I think.  Upon entry
>>> to rbd_dev_probe_parent(), a layered device will
>>> have have a non-null parent_spec pointer (and a
>>> reference to it), which will have been filled in
>>> by rbd_dev_v2_parent_info().
>>>
>>> Really, it should not be rbd_dev_probe_parent()
>>> that drops that parent spec reference on error.
>>> Instead, rbd_dev_image_probe() (which got the
>>> reference to the parent spec) should handle
>>> cleaning up the device's parent spec if an
>>> error occurs after it has been assigned.
>>>
>>> I'll wait for your response, I'd like to know
>>> if what I'm saying makes sense.
>>
>> All of the above makes sense.  I agree that it is asymmetrical and that
>> it would have been better to have rbd_dev_image_probe() drop the last
>> ref on ->parent_spec.  But, that's not what all of the existing code is
>> doing.
>
> Agreed.
>
>> Consider rbd_dev_probe_parent() without my patch.  There are two
>> out_err jumps.  As it is, if rbd_dev_create() fails, we only revert
>> those two get()s and return with alive ->parent_spec.  However, if
>> rbd_dev_image_probe() fails, we call rbd_dev_unparent(), which will put
>> ->parent_spec.  Really, the issue is rbd_dev_unparent(), which not only
>> removes the parent rbd_dev, but also the parent spec.  All I did with
>> this patch was align both out_err cases to do the same, namely undo the
>> effects of rbd_dev_v2_parent_info() - I didn't want to create yet
>> another error path.
>
> OK.  Walking through the code I did concluded that what
> you did made things "line up" properly.  But I just felt
> like it wasn't necessarily the *right* fix, but it was
> a correct fix.
>
> The only point in suggesting what I think would be a better
> fix is that it would make things easier to reason about
> and get correct, and in so doing, make it easier to
> maintain and adapt in the future.

Well, I'm fixing another rbd_dev refcount/use-after-free problem right
now, so I think the only thing that will really make it easier to
maintain this is refactor into just a couple of symmetrical functions.
Making a single change (e.g. patching rbd_dev_unparent() to only touch
->parent and not ->parent_spec) is going to be invasive - there are
just way too many different error paths.

Thanks,

                Ilya
