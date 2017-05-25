From: Sage Weil <sage@newdream.net>
Subject: Re: slowness in builds this week
Date: Thu, 25 May 2017 22:27:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705252227060.3646@piezo.novalocal>
References: <CAC-Np1x_oa2r4d9KOztcWYnSG8LyN8NPN=9hqyd=8SqhjyQRjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46676 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425615AbdEYW1j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 May 2017 18:27:39 -0400
In-Reply-To: <CAC-Np1x_oa2r4d9KOztcWYnSG8LyN8NPN=9hqyd=8SqhjyQRjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: sepia@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 25 May 2017, Alfredo Deza wrote:
> If you have experienced slow builds this week it was because we caused
> a misconfiguration to get Ubuntu 14.04 nodes provisioned to build when
> we really need 16.04.
> 
> The disparity was caused because the system that provisions was edited
> by hand when we had the Jenkins issue after an upgrade a few weeks
> ago. Ubuntu 14.04 cannot join Jenkins because they have a dated Java
> version that is no longer supported.
> 
> By deploying from version control (as we try to do always) we
> overwrote the manual fix.
> 
> This has now been fixed in source control and the queue is looking
> good. The system is elastic when coping with load, so this issue
> quickly improved once we re-deployed.
> 
> tl;dr: we overwrote some configuration which made nodes unable to join
> jenkins to do builds, hence, slower build times
> 
> Sorry for all/any troubles, this was hard to catch.

Thanks, Alfredo!

sage
