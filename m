From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: [ceph-commit] HEALTH_WARN 192 pgs degraded
Date: Fri, 26 Oct 2012 11:53:11 +1300
Message-ID: <5089C2D7.7090307@catalyst.net.nz>
References: <5087F3AE.8080601@gmail.com> <alpine.DEB.2.00.1210240839280.25958@cobra.newdream.net> <5088824A.4000700@catalyst.net.nz> <5088B8EE.7080109@inktank.com> <CAJCPpWJy=k2Sw6iRH-wPq85uWCY7yRA3yE6kBUYwfuQsm2Hz7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37483 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2JYWw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 18:52:57 -0400
In-Reply-To: <CAJCPpWJy=k2Sw6iRH-wPq85uWCY7yRA3yE6kBUYwfuQsm2Hz7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 25/10/12 17:55, Mark Nelson wrote:
> On Wed, Oct 24, 2012 at 10:58 PM, Dan Mick <dan.mick@inktank.com> wrote:
>
>>   HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean; recovery 21/42
>>> The other alternative is to just set the pool(s) replication size to 1,
>>> if you are just wanting a single osd for (say) testing:
>>>
>>> $ ceph osd pool set <your pool(s)> size 1
>>>
>>> I find it I need to restart ceph after doing the above, it then sorts
>>> itself out to a nice healthy status!
>>>
>>
>>
> I was actually just talking to Greg and Sam about this earlier today.  If
> you rely on ceph health as part of an automated process to determine
> whether or not tests should start running, having degraded PGs due to some
> of the pools expecting 2x replication (when there is 1 OSD) is annoying.
> It will go away if whatever default pools are created get manually set to
> 1x replication, but it's not something that is immediately obvious.  I
> don't know that changing the defaults is necessarily the right answer.
> Instead perhaps we just haven't done a good enough job of explaining what
> pools get created, how they are used, and when/if they should be modified
> in some way .  Maybe this belongs in a FAQ?
>



Ah yes - you are quite right, it is *not* required to restart ceph to 
make it sort out those stuck pages after changing the size. I believe at 
some point (maybe < 0.50) it was and I had gotten into the habit!

+1 for adding a FAQ about the defaults pools and replication levels etc.

Cheers

Mark
