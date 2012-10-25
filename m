From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [ceph-commit] HEALTH_WARN 192 pgs degraded
Date: Wed, 24 Oct 2012 20:58:38 -0700
Message-ID: <5088B8EE.7080109@inktank.com>
References: <5087F3AE.8080601@gmail.com> <alpine.DEB.2.00.1210240839280.25958@cobra.newdream.net> <5088824A.4000700@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57712 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab2JYD6m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 23:58:42 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so570283dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 20:58:41 -0700 (PDT)
In-Reply-To: <5088824A.4000700@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


>>> HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean; recovery 21/42
>>> degraded
>>> (50.000%)
>> This is simply because you only have 1 osd but the default policy is 2x
>> replication.  As such, all PGs are 'degraded' because they are only
>> replicated once.
>>
>> If you add another OSD to your cluster the warning will go away.
>>
>> sage
>>
>
> The other alternative is to just set the pool(s) replication size to 1,
> if you are just wanting a single osd for (say) testing:
>
> $ ceph osd pool set <your pool(s)> size 1
>
> I find it I need to restart ceph after doing the above, it then sorts
> itself out to a nice healthy status!

OTOH it should be noted that I'm constantly running test clusters with
replication 2, #osd 1, and they're "unhealthy", and work just fine.
(These are test clusters, clearly, but...nothing wrong with them.)

