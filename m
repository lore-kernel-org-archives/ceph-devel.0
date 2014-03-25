From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 11:04:35 +0200
Message-ID: <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:56124 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaCYJEg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 05:04:36 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so148859qcr.39
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 02:04:35 -0700 (PDT)
In-Reply-To: <1395736765.2823.29.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@daevel.fr> wrote:
> Hi,
>
> what can/should I do to help fix that problem ?
>
> for now, RBD kernel client hang on :
>         Assertion failure in rbd_img_obj_callback() at line 2131:
>            rbd_assert(which >= img_request->next_completion);
>
> or on :
>         Assertion failure in rbd_img_obj_callback() at line 2127:
>             rbd_assert(img_request != NULL);
>
>
> I have both case at least once per week, on latest 3.13.5 kernels.
>
> It seems that the problem occurs only on more loaded servers (I have 4
> near same servers, and crash occurs on two of them. If I move the VM,
> crash follows...).

Hi,

I'm looking into this, but it doesn't reproduce on my boxes.  This must
be some sort of race and the fact that there is nothing else in the
dmesg right before the splats doesn't help.

Can you send me your 3.13.5 rbd.ko and libceph.ko?  Also, just so
I know, can you build your own kernel?

Thanks,

                Ilya
