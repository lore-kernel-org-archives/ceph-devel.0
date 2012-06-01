From: Wido den Hollander <wido@widodh.nl>
Subject: Re: "rbd rm image" slow with big images ?
Date: Fri, 01 Jun 2012 22:33:34 +0200
Message-ID: <4FC9271E.6010809@widodh.nl>
References: <b4c574f6-49bf-4d36-b8f2-526bcccb4c71@mailpro> <4FC7B528.30609@widodh.nl> <Pine.LNX.4.64.1205311118150.28422@cobra.newdream.net> <2839159.qIikQGmnXF@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:58197 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab2FAUdh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 16:33:37 -0400
In-Reply-To: <2839159.qIikQGmnXF@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 06/01/2012 03:51 PM, Guido Winkelmann wrote:
> Am Donnerstag, 31. Mai 2012, 11:19:44 schrieben Sie:
>> On Thu, 31 May 2012, Wido den Hollander wrote:
>>> Hi,
>>>
>>>> Is it the normal behaviour ? Maybe some xfs tuning could help ?
>>>
>>> It's in the nature of RBD.
>>
>> Yes.
>>
>> That said, the current implementation is also stupid: it's doing a single
>> io at a time.  #2256 (next sprint) will parallelize this to make it go
>> much faster (probably an order of magnitude?).
>
> Will it speed up copy operations as well? Those are a lot more important in
> practice... A delete operation I can usually just fire off and leave running
> in the background, but if I'm running a copy operation, there's usually
> something else waiting (like starting a virtual server that's waiting for its
> disk) that cannot proceed until the copy is actually finished.
>

#2256 is only about parallelizing deletions: 
http://tracker.newdream.net/issues/2256

I don't see a feature request in the tracker for parallelizing a copy, 
but we can always create that one :)

> On another note, it looks to me (correct me if I'm wrong) like rbd copy
> operations always involve copying all the data objects from the source volume
> to the machine on which the rbd command is running, and then back to the
> cluster, even if that machine isn't even part of the cluster. Are there any
> plans to streamline this?
>

You are running the rbd command on that client, so that client will read 
the object and write them again as new RADOS objects.

What you are asking is a "cluster-side" clone of a volume, correct?

There is working on-going for layering, where you have one "golden 
image" with multiple childs. With that you can achieve what you want, 
but it's not always desired in every situation.

There has been talking about promoting a child to a fresh volume, that 
would be the same as the cloning you are talking about. I don't know the 
status of that.

Wido

> Regards,
> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
