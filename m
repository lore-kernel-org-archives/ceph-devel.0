From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Kernel crashes with RBD
Date: Fri, 13 Apr 2012 13:56:04 -0700
Message-ID: <4F8892E4.6030504@dreamhost.com>
References: <4F860619.5040802@bisect.de> <4F88670A.7080709@dreamhost.com> <4F886E09.7040801@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52220 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855Ab2DMU4L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 16:56:11 -0400
In-Reply-To: <4F886E09.7040801@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@dreamhost.com>

On 04/13/2012 11:18 AM, Danny Kukawka wrote:
> Hi
>
> Am 13.04.2012 19:48, schrieb Josh Durgin:
>> On 04/11/2012 03:30 PM, Danny Kukawka wrote:
> [...]
>>
>> This looks similar to http://tracker.newdream.net/issues/2261. What do
>> you think Alex?
>
> Not sure about that, since this crashes only the clients and not the
> OSDs. We see no crashes in the cluster.

These are both rbd kernel client crashes, but looking again they seem
like different underlying issues, so I opened
http://tracker.newdream.net/issues/2287 to track this problem.

>
> I analyzed it a bit more and found that the last working version was
> 0.43. Any later released version leads to this crash sooner or later,
> but as I already said only on a 10Gbit (FC) network. I didn't see any
> crash on the 1Gbit net on the same machines.
>
> What kind of network do you use at dreamhost for testing?

Mostly 1Gbit, some 10Gbit, but I don't think we've tested the kernel
client on 10Gbit yet.

> If you need more info, let me known.

Do the crashes always have the same stack trace? When you say 10Gbit
for the cluster, does that include the client using rbd, or just the
osds?

Josh
