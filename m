From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 05 Jan 2013 18:46:48 +0100
Message-ID: <50E86708.6070909@profihost.ag>
References: <50E85799.4060607@profihost.ag> <50E85CC9.9080503@profihost.ag> <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net> <50E85EB1.8060803@profihost.ag> <50E86008.30000@profihost.ag> <alpine.DEB.2.00.1301050939570.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35425 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab3AERqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 12:46:43 -0500
In-Reply-To: <alpine.DEB.2.00.1301050939570.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
Am 05.01.2013 18:40, schrieb Sage Weil:
> On Sat, 5 Jan 2013, Stefan Priebe wrote:
>> Hi,
>> Am 05.01.2013 18:11, schrieb Stefan Priebe:
>>> Hi,
>>>
>>> i just stopped EVERYTHING and have now started ALL osds again. It seems
>>> to recover now. But here is the output.
>> Just an illusion. Still hangs.
>
> Can you turn up logging, or attach with gdb, so we can see what they are
> doing with all that CPU?

Right now i've imported the OLD crushmap and i've no stale PGs nor 
hanging OSDs anymore.

But my rbd images are gone ?!

[1202: ~]# rbd -p kvmpool1 ls
[1202: ~]#

Greets
Stefan
