From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Docs falling out of sync with code
Date: Wed, 21 Sep 2016 15:34:24 -0700
Message-ID: <CAMMFjmFvhzyia0yLnHic3VyDU+ADR_ZvPP6gH8hpubLHK7ccqA@mail.gmail.com>
References: <52e4b5e2-2db7-1437-8fd3-ab7b7e8ec879@redhat.com> <alpine.DEB.2.11.1609212228270.1040@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37738 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbcIUWe0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 18:34:26 -0400
Received: by mail-wm0-f45.google.com with SMTP id b130so116629600wmc.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 15:34:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609212228270.1040@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

If a 'needs-docs' tag precedes "needs-qa" tag we can make it part of
PRs testing and merging process.

On Wed, Sep 21, 2016 at 3:29 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 21 Sep 2016, Dan Mick wrote:
>> The upstream docs at http://ceph.com/docs can tend to become out of
>> date.  We don't have much process to track things that need doc work.
>>
>> As a start, I propose we add a "docs needed" flag to tracker.ceph.com so
>> that we can at least search things that add or change features through a
>> tracker issue, and a "docs needed" label to github, so we can track it
>> on PRs as well.
>>
>> Thoughts?  We can make this happen pretty quickly, and of course it's no
>> perfect lock, but at least it may start contributors and reviewers
>> thinking about the issue.
>
> We can make a 'needs-docs' tag for PRs in github.  If they don't block the
> merge, then we can still search for them in open or closed prs, and make a
> point of removing the tag once the docs are eventually updated.
>
> For the tracker, maybe a category for each project instead of a
> separate tracker?  Not sure..
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
