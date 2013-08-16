From: Milosz Tanski <milosz@adfin.com>
Subject: Re: kclient: Missing directories
Date: Fri, 16 Aug 2013 16:50:50 -0400
Message-ID: <CANP1eJGwngdxHE26MDqaYy=5be6umvpn4gZt+o5v4NqAcv0tWw@mail.gmail.com>
References: <CANP1eJHZE0dFysqTraocaRSF=7-ieBag8hjNVYKTOJ8YqfmPdg@mail.gmail.com>
	<alpine.DEB.2.00.1308161310370.22762@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:36728 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3HPW2I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 18:28:08 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so2164050wes.9
        for <ceph-devel@vger.kernel.org>; Fri, 16 Aug 2013 15:28:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308161310370.22762@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Okay,

I'll incorporate rebase our work on top of testing once Yan's changes
have some time to make it through the test bots.

Sadly it's very intermittent for us happening randomly... I feel like
we experience it once or twice a week. It might be that we're more
prone to it then the test bots because we end rewriting a lot of data
(when new data makes it into our system we end up optimizing it a few
times in the first few days before it settles).

Thanks,
-- Milosz

On Fri, Aug 16, 2013 at 4:12 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Milosz,
>
> On Fri, 16 Aug 2013, Milosz Tanski wrote:
>> I've been experiencing some weird issues with the kclient that I don't
>> know how to debug. In some cases the kclient is only seeing part of
>> the directory tree.
>>
>> For example earlier today one clients was not seeing a top level
>> directory (with around 100G of data) that's been created on the ceph
>> cluster for 2 months now. After I removed another unrelated directory
>> (also at the top level) in a different node this node started seeing
>> this.
>>
>> I don't really know how to debug this issue as it seams intermittent
>> and comes and goes (as you see). Usually re-mounting helps.
>>
>> If you have any pointers how to deal / debug with this when file /
>> directory becomes invisible I would greatly appreciate it.
>
> This sounds like it might http://tracker.ceph.com/issues/5927.  I just
> pushed a patch from Yan into the testing branch that hopefully resoles an
> issue with d_prune in the VFS, so we'll hopefully know shortly if that
> resolves the problem.  Unfortunately in our QA it's not something that
> triggers very often so only time will tell.  If this is something you can
> reproduce easily, that is good news...
>
> sage
>
>
