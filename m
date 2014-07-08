From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 10/14] rbd: rbd_obj_request_wait() should cancel the request
 if interrupted
Date: Tue, 08 Jul 2014 07:17:09 -0500
Message-ID: <53BBE145.2050300@linaro.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>	<1403716607-13535-11-git-send-email-ilya.dryomov@inktank.com>	<53BAD0FC.5020007@linaro.org> <CALFYKtDv7rnPjSVvzMJVPFQj7=p5PZHf6xEogXPGGS7HD3wnLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35388 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbaGHMRI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 08:17:08 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so3928078iec.10
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jul 2014 05:17:07 -0700 (PDT)
In-Reply-To: <CALFYKtDv7rnPjSVvzMJVPFQj7=p5PZHf6xEogXPGGS7HD3wnLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/08/2014 06:18 AM, Ilya Dryomov wrote:
>> > The only question that leaves me with is, does
>> > ceph_osdc_cancel_request() need to include the
>> > call to complete_request() that's present in
>> > ceph_osdc_wait_request()?
> I don't think so - I mentioned it in the ceph_osdc_cancel_request()
> function comment.  ceph_osdc_cancel_request() is supposed to be used by
> higher layers - rbd, cephfs - and exactly because their completion
> logic is decoupled from libceph completions (as you have brilliantly
> explained above) it's the higher layers who should be taking care of
> it.  IOW higher layers are in charge and are supposed to know what and
> when they are cancelling.

I noticed that comment only after sending my message.

RBD doesn't use the safe completion, only the FS client
does, and I was pretty focused on RBD behavior while
looking at this.  I was trying to conceptualize how
(from the perspective of the upper layer) the safe
completion differs from the "normal" completion.

It's possible that an "I have your request" (normal
completion) *also* carries with it the "your request
has completed" (safe completion) indication, but
the higher layer caller has no way of knowing that.

Maybe I should flip my question around, and ask, why
should the ceph_osdc_cancel_request() include the call
to complete_request()?

The answer lies in details of the file system client,
and I'm not in a position right now to dive into that.
Whether it's called in ceph_osdc_cancel_request() or
not has no effect on RBD.

Anyway, your response is fine with me, thank you.

					-Alex
