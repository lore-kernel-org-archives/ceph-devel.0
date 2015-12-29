From: Linux Chips <linux.chips@gmail.com>
Subject: Re: How to configure if there are tow network cards in Client
Date: Tue, 29 Dec 2015 13:21:21 +0300
Message-ID: <56825EA1.1070803@gmail.com>
References: <57b6c7ee.cffc.151d9741bd2.Coremail.cymengxiang@126.com>
 <alpine.DEB.2.00.1512280846380.14656@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34644 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbbL2KUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Dec 2015 05:20:53 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so1222958wmb.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Dec 2015 02:20:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512280846380.14656@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, =?UTF-8?B?6JSh5q+F?= <cymengxiang@126.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-cn@lists.ceph.com

On 12/28/2015 07:47 PM, Sage Weil wrote:
> On Fri, 25 Dec 2015, ?? wrote:
>> Hi all,
>>      When we read the code, we haven?t find the function that the client can bind a specific IP. In Ceph?s configuration, we could only find the parameter ?public network?, but it seems acts on the OSD but not the client.
>>      There is a scenario that the client has two network cards named NIC1 and NIC2. The NIC1 is responsible for communicating with cluster (monitor and RADOS) and the NIC2 has other services except Ceph?s client. So   we need the client can bind specific IP in order to differentiate the IP communicating with cluster from another IP serving other applications. We want to know is there any configuration in Ceph to achieve this function? If there is, how could we configure the IP? if not, could we add this function in Ceph? Thank you so much.
you can use routing tables plus routing rules. otherwise linux will just 
use the default gateway.
or you can put the second interface on the same public net of ceph. 
though that would break if you have multiple external nets.
> Right.  There isn't a configurable to do this now--we've always just let
> the kernel network layer sort it out. Is this just a matter of calling
> bind on the socket before connecting? I've never done this before..
linux will send all packets to the default gateway event if an 
application binds to an ip on different interface, the packet will go 
out with the source address as the binded one but through your router. 
the only solution, even if the bind function exists is to use the 
routing tables and rules.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


