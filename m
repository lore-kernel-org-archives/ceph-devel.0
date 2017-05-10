From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: RBD client wallclock profile during 4k random writes
Date: Wed, 10 May 2017 18:31:19 -0400
Message-ID: <CA+aFP1BBTvbNca1qEQeWyPYbiU497+cDqqO0OpCHnQNUy5+xdw@mail.gmail.com>
References: <9e13c0f0-cde1-b8ec-d469-da5d87c5ba74@redhat.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33454 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdEJWbV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 May 2017 18:31:21 -0400
Received: by mail-yw0-f178.google.com with SMTP id 203so4914377ywe.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 May 2017 15:31:20 -0700 (PDT)
In-Reply-To: <9e13c0f0-cde1-b8ec-d469-da5d87c5ba74@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 10, 2017 at 6:10 PM, Mark Nelson <mnelson@redhat.com> wrote:
> 1) 7 - tp_librbd, line 82
>
> Lots of stuff going on here, but the big thing is all the time spent in
> librbd::ImageCtx::write_to_cache.  70.2% of the total time in this thread is
> spent in ObjectCacher::writex with lots of nested stuff, but if you look all
> the way down on line 1293, another 11.8% of the time is spent in Locker()
> and 1.5% of the time spent in ~Locker().

Yes -- the ObjectCacher is long overdue for a re-write since it's
single threaded. It looks like you were essentially performing
writethrough as well. I'd imagine you would just be better off
disabling the rbd cache when doing high-performance random write
workloads since you are going to get zero benefit from the cache with
that workload -- at least that's what I usually recommend.
