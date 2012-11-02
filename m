From: Danny Al-Gaaf <danny@bisect.de>
Subject: Re: limit of maximum number of rbd devices that can be mapped
Date: Fri, 02 Nov 2012 11:59:25 +0100
Message-ID: <5093A78D.4060409@bisect.de>
References: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com> <507F66F1.4000509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:35866 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762306Ab2KBK7a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 06:59:30 -0400
In-Reply-To: <507F66F1.4000509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Christian Huang <ythuang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 18.10.2012 04:18, schrieb Alex Elder:
> On 10/17/2012 09:15 PM, Christian Huang wrote:
>> Hi,
>>     what is the maximum number of rbd devices that can be mapped on a
>> single host?
>>     we recently did a test to mount a large number of rbd devices and
>> hit a wall around 230
>>     with the following message
> 
> That sounds about right.  We were just discussing this earlier
> this week.  It's limited at the moment by the number of major
> device numbers available on the system, and I think you found
> that limit.  We would obviously like to have a solution for
> this but we've only just started considering options.

Any news on this? We have seen the same issues here.

IMO the RBD code should to something similar to some other block drivers:

1) reserve a major block number for RBD in general (or use the number
returned from the register_blkdev call, if there is no number we can
reserve in general for RBD, see [1])

2) Use this major number for all RBDs on this machine and handle each
new RBD via different minor numbers.

If we can agree on this I would take a look into it and send a patch.

Regards

Danny

[1]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob_plain;f=Documentation/devices.txt;hb=HEAD
