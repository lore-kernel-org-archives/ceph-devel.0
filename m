From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Newbie questions
Date: Sat, 06 Oct 2012 17:34:53 -0700
Message-ID: <5070CE2D.7060008@inktank.com>
References: <itxvbcnv59ub7io20vp9jwxp.1349537492870@email.android.com> <k4qh5i$l2a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58439 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2JGAew (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Oct 2012 20:34:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2939683pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 06 Oct 2012 17:34:52 -0700 (PDT)
In-Reply-To: <k4qh5i$l2a$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

In your original question, I assumed you were talking about the
partitioning of a single cluster.  Now you are talking about
Geographic Disaster Recovery: the replication of data across
multiple (relatively) independent clusters.  This is not yet
supported, but it is most definitely on the road-map.

On 10/6/2012 5:08 PM, Adam Nielsen wrote:
>> The problem you are describing is called split-brain.  Ceph has an odd
>> number of monitors and quorum is required before objects can be served.
>> The partition with the smaller number of monitors will wait harmlessly
>> until connectivity is reestablished .
>
> Ah right, that makes sense.  Is this set in stone or can it be
> configured? I'm just thinking that in this scenario it could be
> beneficial to allow read-only access from the partition with the smaller
> number of monitors, if there are also clients that can only see those
> hosts.  (For example, a business with two sites, and the link between
> them goes down, so client PCs can only see their site-local servers.)

