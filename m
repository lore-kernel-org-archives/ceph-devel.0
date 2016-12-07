From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Ceph QoS user stories
Date: Tue, 6 Dec 2016 20:44:58 -0800
Message-ID: <CAFMfnwqW4xTha0Yq+Lf33ND_tzof7G1SCmWz-3vuZYP6u5==Hg@mail.gmail.com>
References: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36318 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbcLGEo7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2016 23:44:59 -0500
Received: by mail-yw0-f172.google.com with SMTP id a10so291032851ywa.3
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2016 20:44:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

> We're working on getting infrasture into RADOS to allow for proper
> distributed quality-of-service guarantees.  The work is based on the
> mclock paper published in OSDI'10
>
>         https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf
>
> There are a few ways this can be applied:
>
>  - We can use mclock simply as a better way to prioritize background
> activity (scrub, snap trimming, recovery, rebalancing) against client IO.
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS or
> proportional priority/weight) on RADOS pools
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS) for
> individual clients.
>
> Once the rados capabilities are in place, there will be a significant
> amount of effort needed to get all of the APIs in place to configure and
> set policy.  In order to make sure we build somethign that makes sense,
> I'd like to collection a set of user stores that we'd like to support so
> that we can make sure we capture everything (or at least the important
> things).
>
> Please add any use-cases that are important to you to this pad:
>
>         http://pad.ceph.com/p/qos-user-stories
>
> or as a follow-up to this email.
>
> mClock works in terms of a minimum allocation (of IOPS or bandwidth; they
> are sort of reduced into a single unit of work), a maximum (i.e. simple
> cap), and a proportional weighting (to allocation any additional capacity
> after the minimum allocations are satisfied).  It's somewhat flexible in
> terms of how we apply it to specific clients, classes of clients, or types
> of work (e.g., recovery).  How we put it all together really depends on
> what kinds of things we need to accomplish (e.g., do we need to support a
> guaranteed level of service shared across a specific set of N different
> clients, or only individual clients?).

I added a handful of user stories to the page that address the use
case of someone wanting to emulate aws / gce block storage services.
I'm also keen to see a 'best effort' qos policy :)

-- 

Kyle Bader
