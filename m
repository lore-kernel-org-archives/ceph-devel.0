From: Wido den Hollander <wido@widodh.nl>
Subject: Re: incremental rbd export / sparse files?
Date: Sat, 24 Nov 2012 08:04:27 +0800
Message-ID: <50B00F0B.2020807@widodh.nl>
References: <50AE062E.5020301@profihost.ag> <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:33754 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332Ab2KXAEf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 19:04:35 -0500
In-Reply-To: <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 11/23/2012 05:59 AM, Sage Weil wrote:
> On Thu, 22 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> right now a rbd export exports exactly the size of the disk even if there is
>> KNOWN free space. Is this inteded to change?
>>
>> Might it be possible to export just differences between snapshots and merge
>> them later?
>
> We were just talking about this the other day.
>
> Step 1 is to create a mechanism to output a list of block ranges that
> have/have not changed between snapshots.
>
> Step 2 is to export the incremental changes.  The hangup there is figuring
> out a generic and portable file format to represent those incremental
> changes; we'd rather not invent something ourselves that is ceph-specific.
> Suggestions welcome!
>

I'm not sure about the licensing and such, but doesn't VMware do 
something with their VMDK images?

There you have a base image and each snapshot is a separate file.

You have:

image.vmdk
image-delta1.vmdk
image-delta2.vmdk
..
..

You can merge all these files together again to a new image based on the 
last snapshot you feeded it.

They probably didn't use a open format to do this, but something in that 
direction is what you are looking for?

Wido

> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
