From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Client: what is supposed to protect racing readdirs and unlinks?
Date: Wed, 15 Jul 2015 20:57:06 +0800
Message-ID: <CAAM7YAnYtez9HqpMx16pC_DTSt=yBKgr22qvgKE+5sR2k0ZpNQ@mail.gmail.com>
References: <CAC6JEv9VFv2ywGLOfHpcW=yodWCX_VMX22YMFvjnqQhsrfCJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36212 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbGOM5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 08:57:08 -0400
Received: by lbbpo10 with SMTP id po10so24191577lbb.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2015 05:57:06 -0700 (PDT)
In-Reply-To: <CAC6JEv9VFv2ywGLOfHpcW=yodWCX_VMX22YMFvjnqQhsrfCJdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Sage Weil <sweil@redhat.com>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 15, 2015 at 1:11 AM, Gregory Farnum <greg@gregs42.com> wrote:
> I spent a bunch of today looking at http://tracker.ceph.com/issues/12297.
>
> Long story short: the workload is doing a readdir at the same time as
> it's unlinking files. The readdir functions (in this case,
> _readdir_cache_cb) drop the client_lock each time they invoke the
> callback (for obvious reasons). There is some effort in
> _readdir_cache_cb to try and keep the iterator valid (we check on each
> loop that we aren't at end; we increment the iterator before dropping
> the lock), but it's not sufficient.
>
> Is there supposed to be something preventing this kind of race? If not
> I can work something out in the code but I've not done much work in
> that bit and there are enough pieces that I wonder if I'm missing some
> other issue.

I think calling (*pd)->get() before release the client_lock should work.

Regards
Yan, Zheng

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
