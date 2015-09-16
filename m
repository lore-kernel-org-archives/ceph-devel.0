From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Review Request
Date: Wed, 16 Sep 2015 11:31:31 -0700
Message-ID: <CAJ4mKGbP8K_iMN6AvZW2UwMjjxcEnb0vO2c_k2_3VUWSCWMQKA@mail.gmail.com>
References: <55F9B061.2090300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32854 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbbIPSbd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 14:31:33 -0400
Received: by wiclk2 with SMTP id lk2so85885864wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 11:31:31 -0700 (PDT)
In-Reply-To: <55F9B061.2090300@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Ceph Developers <ceph-devel@vger.kernel.org>

On Wed, Sep 16, 2015 at 11:09 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> Creators of the Storage Squid,
>
> If you're interested in less use of the allocator, you are interested in
> Context* elimination. If so, please review the top two commits on the
> wip-decontextualization branch of:
>
> https://github.com/cohortfsllc/cohortfs-ceph
>
> They provide an enhanced version of std::function that allows you to
> specify how much space gets preallocated for function objects or disable
> allocation entirely.

Can you provide a little background (links or text) for those of us
who aren't up on C++11x/14x? I looked at them briefly but having only
the vaguest idea about some of them quickly got lost. :)
-Greg

>
> Also, I have two pull requests, wip-cxx11time and wip-cxx11concurrency
> that pass check on which I would appreciate any feedback.
>
> Thank you, Comrades!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
