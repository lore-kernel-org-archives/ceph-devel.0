From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: don't leak parent_spec in rbd_dev_probe_parent()
Date: Thu, 15 Oct 2015 20:31:53 +0200
Message-ID: <CAOi1vP_msQU77wzy82efVNm1Cybs0JK06iEG67w_o=aSw4ONFA@mail.gmail.com>
References: <1444586591-24141-1-git-send-email-idryomov@gmail.com>
	<561FDE12.9070406@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34452 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbJOSbz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 14:31:55 -0400
Received: by lfaz124 with SMTP id z124so41267341lfa.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 11:31:53 -0700 (PDT)
In-Reply-To: <561FDE12.9070406@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 15, 2015 at 7:10 PM, Alex Elder <elder@ieee.org> wrote:
> On 10/11/2015 01:03 PM, Ilya Dryomov wrote:
>> Currently we leak parent_spec and trigger a "parent reference
>> underflow" warning if rbd_dev_create() in rbd_dev_probe_parent() fails.
>> The problem is we take the !parent out_err branch and that only drops
>> refcounts; parent_spec that would've been freed had we called
>> rbd_dev_unparent() remains and triggers rbd_warn() in
>> rbd_dev_parent_put() - at that point we have parent_spec != NULL and
>> parent_ref == 0, so counter ends up being -1 after the decrement.
>>
>> Redo rbd_dev_probe_parent() to fix this.
>
> I'm just starting to look at this.
>
> My up-front problem is that I want to understand why
> it's OK to no longer grab references to the parent spec
> and the client before creating the new parent device.
> Is it simply because the rbd_dev that's the subject
> of this call is already holding a reference to both,
> so no need to get another?  I think that's right, but
> you should say that in the explanation.  It's a
> change that's independent of the other change (which
> you describe).

I still grab references, I just moved that code after rbd_dev_create().
Fundamentally rbd_dev_create() is just a memory allocation, so whether
we acquire references before or after doesn't matter, except that
acquiring them before complicates the error path.

>
> OK, onto the change you describe.
>
> You say that we get the underflow if rbd_dev_create() fails.
>
> At that point in the function, we have:
>     parent == NULL
>     rbd_dev->parent_spec != NULL
>     parent_spec holds a new reference to that
>     rbdc holds a new reference to the client
>
> rbd_dev_create() only returns NULL if the kzalloc() fails.
> And if so, we jump to out_err, take the !parent branch,
> and we drop the references we took in rbdc and parent_spec
> before returning.
>
> Where is the leak?  (Actually, underflow means we're
> dropping more references than we took.)

We enter rbd_dev_probe_parent().  If ->parent_spec != NULL (and
therefore has a refcount of 1), we bump refcounts and proceed to
allocating parent rbd_dev.  If rbd_dev_create() fails, we drop
refcounts and exit rbd_dev_probe_parent() with ->parent_spec != NULL
and a refcount of 1 on that spec.  We take err_out_probe in
rbd_dev_image_probe() and through rbd_dev_unprobe() end up in
rbd_dev_parent_put().  Now, ->parent_spec != NULL but ->parent_ref == 0
because we never got to atomic_set(&rbd_dev->parent_ref, 1) in
rbd_dev_probe_parent().  Local counter ends up -1 after the decrement
and so instead of calling rbd_dev_unparent() which would have freed
->parent_spec we issue an underflow warning and bail.  ->parent_spec is
leaked.

Thanks,

                Ilya
