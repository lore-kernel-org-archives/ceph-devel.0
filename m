From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 4/8] rbd: move bumping img_request refcount into rbd_obj_request_submit()
Date: Mon, 26 Sep 2016 16:38:48 +0200
Message-ID: <CAOi1vP-dDyJLNca+DHoSvdS9+i9ZdZUTF537jfg44RDOeJfnvg@mail.gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-5-git-send-email-idryomov@gmail.com> <93d01f3c-78a7-6407-8af9-78680455024f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36738 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934219AbcIZOiw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 10:38:52 -0400
Received: by mail-vk0-f66.google.com with SMTP id v205so2712993vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 07:38:51 -0700 (PDT)
In-Reply-To: <93d01f3c-78a7-6407-8af9-78680455024f@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Sep 25, 2016 at 5:56 PM, Alex Elder <elder@linaro.org> wrote:
> On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
>> Commit 0f2d5be792b0 ("rbd: use reference counts for image requests")
>> added rbd_img_request_get(), which rbd_img_request_fill() calls for
>> each obj_request added to img_request.  It was an urgent band-aid for
>> the uglyness that is rbd_img_obj_callback() and none of the error paths
>> were updated.
>
> I'm not sure how to improve that function.  Object requests in
> an image request need to be completed in sequential order,
> because blk_update_request() requires that.  (Or maybe you
> were referring to something else you find ugly.)

Quoting 0f2d5be792b0 commit message:

"There is a race here, however.  The instant an object request is
marked "done" it can be provided (by a thread handling completion of
one of its predecessor operations) to rbd_img_obj_end_request(),
which (for the last request) can then lead to the image request
getting torn down.  And this can happen *before* that object has
itself entered rbd_img_obj_end_request().  As a result, once it
*does* enter that function, the image request (and even the object
request itself) may have been freed and become invalid."

"... we don't want rbd_img_request_complete() to necessarily
result in the image request being destroyed, because it may
get called before we've finished processing on all of its
object requests."

This "I'm called for obj_request1, but I'll also complete obj_request2
along with the entire img_request if I get a chance, before I'm called
for obj_request2" behaviour is *really* *really* sneaky.

I think a simple atomic, decremented for each obj_request completion
would do.  When it hits 0, we say "OK, this img_request is finished"
and call rbd_img_obj_end_request() for each obj_request in order.  I'm
not sure we are getting anything from calling blk_update_request() in
this fashion, at the expense of hard to comprehend buggy code.

>
>> Given that this img_request reference is meant to represent an
>> obj_request that hasn't passed through rbd_img_obj_callback() yet,
>
> It was, for the purpose of that commit.  But I don't like to think
> of reference counting that way.  I usually try to reason about
> reference counts as actual counts of pointers referring to objects.
> And in that sense, I think it might have been better in the first
> place to drop the an object request's reference to the image request
> in rbd_img_obj_request_del(), where the img_request pointer gets
> nulled out.  And move the call to rbd_img_request_get() for an
> object request into rbd_img_obj_request_add(), where the pointer
> gets assigned.  I don't know why I didn't do it that way before;
> like you said it was sort of an urgently developed change.
>
> I haven't investigated this alternative exhaustively, but if
> it works I think it would be a cleaner fix.

That won't work, exactly because this reference is not a normal
reference, but a band-aid for what I quoted.  rbd_img_obj_request_del()
is called from rbd_img_request_put() when refcount hits 0, which it
never will because of at least one object request holding it.  For this
to work, object requests have to be deleted explicitly.

>
>> proper cleanup in appropriate destructors is a challenge.  However,
>> noting that if we don't get a chance to call rbd_obj_request_complete(),
>> there is not going to be a call to rbd_img_obj_callback(), we can move
>> rbd_img_request_get() into rbd_obj_request_submit() and fixup the two
>> places that call rbd_obj_request_complete() directly and not through
>> rbd_obj_request_submit() to temporarily bump img_request, so that
>> rbd_img_obj_callback() can put as usual.
>>
>> This takes care of img_request leaks on errors on the submit side.
>
> So *this* is the problem you're aiming to solve here...  It would
> have been nice for you to call attention to where these leaks were
> occurring.  (It seems rbd_img_obj_parent_read_full_callback()
> and rbd_img_obj_exists_callback().)

By "on the submit side", I meant everywhere where we error out before
rbd_obj_request_submit() on the original request.

>
> It looks to me like your change is sound, but again, I think it
> would be better to make the reference counting match the actual
> recording of references to objects as I mentioned before.  I'm
> going to ask for your opinion on that before I offer you my
> "reviewed by" on this.

The aim of this patch was to fix up error paths while preserving the
semantics of this kref.  Any other improvements can only come with the
full re-write of the completion code - it's too fragile.

>
>                                         -Alex
>
> And now, some more gratuitous analysis...
>
> We currently (without this patch) get a reference to an image request
> for every object request populated in rbd_img_request_fill(), right
> after calling rbd_img_obj_request_fill().  We want each of these to
> have a matching reference drop, once that object request is completed,
> and the object request no longer has any use for what's in the image
> request.  Right now that occurs in rbd_img_obj_callback().  But that
> function is only called if an image object request gets successfully
> submitted.  And in particular, if an error occurs while processing
> a layered write--either while doing an existence check for an object
> or when doing a read of the parent data--the original image object
> requests never get submitted, and therefore their references to the
> image don't get dropped properly.  This issue is the subject of your
> patch.  All other image object requests appear to get submitted,
> and therefore properly release their reference.

Correct.  There is also the issue of two-obj_request img_requests,
where the first obj_request gets submitted while the second errors out.
This patch captures it, but there may well be other issues there -
I haven't gone down that rabbit hole yet...

Thanks,

                Ilya
