From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: incremental rbd export / sparse files?
Date: Sat, 24 Nov 2012 07:31:33 +0100
Message-ID: <88D25EF7-78AA-4E3C-8105-6D872F415BDA@profihost.ag>
References: <50AE062E.5020301@profihost.ag> <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net> <50B00F0B.2020807@widodh.nl>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35957 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab2KXGbg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 01:31:36 -0500
In-Reply-To: <50B00F0B.2020807@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.11.2012 um 01:04 schrieb Wido den Hollander <wido@widodh.nl>:

> 
> 
> On 11/23/2012 05:59 AM, Sage Weil wrote:
>> On Thu, 22 Nov 2012, Stefan Priebe - Profihost AG wrote:
>>> Hello list,
>>> 
>>> right now a rbd export exports exactly the size of the disk even if there is
>>> KNOWN free space. Is this inteded to change?
>>> 
>>> Might it be possible to export just differences between snapshots and merge
>>> them later?
>> 
>> We were just talking about this the other day.
>> 
>> Step 1 is to create a mechanism to output a list of block ranges that
>> have/have not changed between snapshots.
>> 
>> Step 2 is to export the incremental changes.  The hangup there is figuring
>> out a generic and portable file format to represent those incremental
>> changes; we'd rather not invent something ourselves that is ceph-specific.
>> Suggestions welcome!
> 
> I'm not sure about the licensing and such, but doesn't VMware do something with their VMDK images?
> 
> There you have a base image and each snapshot is a separate file.
> 
> You have:
> 
> image.vmdk
> image-delta1.vmdk
> image-delta2.vmdk
> ..
> ..
> 
> You can merge all these files together again to a new image based on the last snapshot you feeded it.
> 
> They probably didn't use a open format to do this, but something in that direction is what you are looking for?

Yes something like that would be perfect.

Stefan

> 
> Wido
> 
>> sage
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
