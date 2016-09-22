From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Docs falling out of sync with code
Date: Thu, 22 Sep 2016 07:34:42 -0400
Message-ID: <CAC-Np1zKs0XF8e4eZDAFGf0dFwmg+X7yLeiwkWgAy_vjzs4e1A@mail.gmail.com>
References: <52e4b5e2-2db7-1437-8fd3-ab7b7e8ec879@redhat.com>
 <alpine.DEB.2.11.1609212228270.1040@piezo.us.to> <478c5b5e-2bfe-33ff-67e9-401f7d9f38c4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36380 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbcIVLeo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 07:34:44 -0400
Received: by mail-wm0-f43.google.com with SMTP id w84so247509909wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 04:34:44 -0700 (PDT)
In-Reply-To: <478c5b5e-2bfe-33ff-67e9-401f7d9f38c4@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 9:33 PM, Dan Mick <dmick@redhat.com> wrote:
> On 09/21/2016 03:29 PM, Sage Weil wrote:
>> On Wed, 21 Sep 2016, Dan Mick wrote:
>>> The upstream docs at http://ceph.com/docs can tend to become out of
>>> date.  We don't have much process to track things that need doc work.
>>>
>>> As a start, I propose we add a "docs needed" flag to tracker.ceph.com so
>>> that we can at least search things that add or change features through a
>>> tracker issue, and a "docs needed" label to github, so we can track it
>>> on PRs as well.
>>>
>>> Thoughts?  We can make this happen pretty quickly, and of course it's no
>>> perfect lock, but at least it may start contributors and reviewers
>>> thinking about the issue.
>>
>> We can make a 'needs-docs' tag for PRs in github.  If they don't block the
>> merge, then we can still search for them in open or closed prs, and make a
>> point of removing the tag once the docs are eventually updated.
>>
>> For the tracker, maybe a category for each project instead of a
>> separate tracker?  Not sure..
>>
>> sage
>
> Seemed like general consensus, so I've added both a "Needs Doc" checkbox
> to tracker and a "needs-doc" tag for PRs and GH issues.  See how they feel.

This is great Dan. Thank you!
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
