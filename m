From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: final luminous blockers
Date: Tue, 8 Aug 2017 09:38:53 -0700
Message-ID: <CA+2bHPa3GdKm=1fmN2rX9CbpEycBBT2-fuckfwSY2j-_Rj=5bA@mail.gmail.com>
References: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35534 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbdHHQjY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 12:39:24 -0400
Received: by mail-qk0-f173.google.com with SMTP id d145so22667408qkc.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 09:39:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 8, 2017 at 8:58 AM, Sage Weil <sweil@redhat.com> wrote:
> I'm hoping we get get 12.2.0 out the door tomorrow.  On the rados side,
> there is just one blocker:
>
>         http://tracker.ceph.com/issues/20925
>
> which I'm testing a fix for now.  There is also the rocskdb build issue
> that makes things break for folks with really old CPUs, but I don't think
> it needs to block the initial release.
>
> I'm waiting for the latest round of upgrade tests to run as well but I
> think everything is resolved there.
>
> Jason, Matt, Patrick: how are rbd, rgw, and cephfs looking?

CephFS is good. Just some harmless QA warnings that need silenced. I
have this PR which I just merged:

https://github.com/ceph/ceph/pull/16378/

I will backport that to luminous shortly.

-- 
Patrick Donnelly
