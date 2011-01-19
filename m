From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 17:21:30 +0100
Message-ID: <4D370F8A.3080601@wpkg.org>
References: <4D36BDF9.4030404@wpkg.org>	<1295437286.2255.25.camel@wido-desktop>	<4D36D5B3.4040601@wpkg.org> <AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:49836 "EHLO mail.virtall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221Ab1ASQVg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Jan 2011 11:21:36 -0500
In-Reply-To: <AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On 19.01.2011 16:57, Gregory Farnum wrote:

>> Currently, I'm running glusterfs in such a scenario (two servers, each being
>> also clients), but I wanted to give ceph a try (glusterfs has some
>> performance issues with lots of small files), also because of its nice
>> features (snapshots, rbd etc.).
> Rather than running 3 monitors you could just put a monitor on one of
> the machines -- your cluster will go down if it fails, but in a 2-node
> system it's not like resilience from one-node failure would be very
> helpful anyway.

OK, I could imagine starting the monitor on just one node i.e. with the 
help of heartbeat - so if the node with the monitor goes down, heartbeat 
starts the monitor process on the other machine.


> However, there is a serious issue with running clients and servers on
> one machine, which may or may not be a problem depending on your use
> case: Deadlock becomes a significant possibility.

Sounds like the "freezes" issue mentioned by Dong Jin Lee?


> This isn't a problem
> we've come up with a good solution for, unfortunately, but imagine
> you're writing a lot of files to Ceph. Ceph dutifully writes them and
> the kernel dutifully caches them. You also have a lot of write
> activity so the Ceph kernel client is doing local caching. Then the
> kernel comes along and says "I'm low on memory! Flush stuff to disk!"
> and the kernel client tries to flush it out...which involves creating
> another copy of the data in memory on the same machine. Uh-oh!

Uh-oh, it doesn't sound encouraging, and will likely happen sooner or later.

Would some sort of zero-copy help here? But perhaps it's not that easy 
to solve, otherwise, we wouldn't be discussing it here.

I think swapping over NFS (or, iSCSI) has a similar problem ("need to 
write, but the network buffer is full, so we can't write over network -> 
deadlock"), and there were some patches floating around some years ago 
to solve it. Not sure what's the state of it and how similar it is to 
Ceph though.


Last I checked, 2 < 3, so having a budget HA solution which just needed 
2 servers instead of 3 would be a great thing to have! ;)


-- 
Tomasz Chmielewski
http://wpkg.org
