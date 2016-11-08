From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: master branch merges must pass unit tests
Date: Tue, 8 Nov 2016 15:01:23 -0700
Message-ID: <CALqRxCz-0+jH4T6iGogsm1S=sZBgDbjNkTPtrPqqqeDn0AR46A@mail.gmail.com>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to> <CA+2bHPY=GQ-mXi_GpanXRefTmtrZxAee_eMATUpO-W+QhRpSZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36132 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbcKHWBu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 17:01:50 -0500
Received: by mail-ua0-f170.google.com with SMTP id b35so158996621uaa.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 14:01:24 -0800 (PST)
In-Reply-To: <CA+2bHPY=GQ-mXi_GpanXRefTmtrZxAee_eMATUpO-W+QhRpSZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 8, 2016 at 2:56 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> On Tue, Nov 8, 2016 at 4:49 PM, Sage Weil <sweil@redhat.com> wrote:
>> I enabled the github check that the unit tests pass in order to merge to
>> master.  These tests still aren't completely reliable, but they're close,
>> and we'll make better progress if we start enforcing it now.
>>
>> Note that core developers can still override the check to merge if
>> it's necessary, but I encourage you to avoid doing so!
>
> Does this effect manual merges?

From what I've seen in GitHub, it is in force for both scenarios: the
web UI as well as "git push origin master"

- Ken
