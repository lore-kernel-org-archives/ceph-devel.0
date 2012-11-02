From: Danny Al-Gaaf <danny@bisect.de>
Subject: Re: limit of maximum number of rbd devices that can be mapped
Date: Fri, 02 Nov 2012 13:28:14 +0100
Message-ID: <5093BC5E.10307@bisect.de>
References: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com> <507F66F1.4000509@inktank.com> <5093A78D.4060409@bisect.de> <alpine.DEB.2.00.1211020416410.19983@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:41664 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072Ab2KBM2S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 08:28:18 -0400
In-Reply-To: <alpine.DEB.2.00.1211020416410.19983@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>, Christian Huang <ythuang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 02.11.2012 12:22, schrieb Sage Weil:
> On Fri, 2 Nov 2012, Danny Al-Gaaf wrote:
[...]
>> Any news on this? We have seen the same issues here.
>>
>> IMO the RBD code should to something similar to some other block drivers:
>>
>> 1) reserve a major block number for RBD in general (or use the number
>> returned from the register_blkdev call, if there is no number we can
>> reserve in general for RBD, see [1])
>>
>> 2) Use this major number for all RBDs on this machine and handle each
>> new RBD via different minor numbers.
>>
>> If we can agree on this I would take a look into it and send a patch.
> 
> We should probably do what SCSI does, where the minor for each device 
> jumps by 16 to leave room for partitions.

That's exactly what I would propose. I wasn't sure if we really need to
leave the room for the partitions, since I'm not sure if they really
need to have contiguous numbers, but I guess there are some tools which
expect it.

> There was a thread on this a couple of weeks ago that mmy slow internet is 
> preventing me from finding... :)

My internet connection isn't that slow here in Amsterdam ;-) ... but I
couldn't find another thread about this topic.

Do you remember if someone already is working on this?

Danny

