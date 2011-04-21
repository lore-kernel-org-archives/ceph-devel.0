From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: Scrubbing
Date: Thu, 21 Apr 2011 16:30:48 -0700
Message-ID: <4DB0BE28.2070806@hq.newdream.net>
References: <4DB053C4.2020704@provocation.net> <4DB05926.6020406@hq.newdream.net> <4DB06BFC.9010207@provocation.net>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56402 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1DVAdq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 20:33:46 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 408BCC063
	for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 17:33:46 -0700 (PDT)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3CDE3C062
	for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 17:33:46 -0700 (PDT)
In-Reply-To: <4DB06BFC.9010207@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  Hmm, it's supposed to throttle background scrubbing.  Could we get 
access to the osd logs?

Thanks,
-Sam

On 04/21/2011 10:40 AM, Zenon Panoussis wrote:
> On 04/21/2011 06:19 PM, Samuel Just wrote:
>
> Hi
>
>> Well, that is definitely not supposed to happen, sorry about
>> that!  Did you request the scrubs or did it start them automatically?
> I had my one monitor mounted by a client. I said "ceph osd scrub 0"
> and it behaved quite nicely, scrubbing two or three pgs at a time
> (I have default osd threads). Then I did "umount mon:/" on the
> client and as soon as umount returned (it took a few seconds) the
> scrubbing exploded.
>
> It's 0.26 tarball release BTW.
>
> Z
>

