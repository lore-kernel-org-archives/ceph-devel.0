From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 07:57:23 -0800
Message-ID: <AANLkTimHi64ZB5_AY1_eQu5abHB+S+bvcSShL_NE3Me0@mail.gmail.com>
References: <4D36BDF9.4030404@wpkg.org>
	<1295437286.2255.25.camel@wido-desktop>
	<4D36D5B3.4040601@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39124 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab1ASP5Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 10:57:25 -0500
Received: by ewy5 with SMTP id 5so492467ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 07:57:24 -0800 (PST)
In-Reply-To: <4D36D5B3.4040601@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, Jan 19, 2011 at 4:14 AM, Tomasz Chmielewski <mangoo@wpkg.org> w=
rote:
> On 19.01.2011 12:41, Wido den Hollander wrote:
>>
>> Hi Thomas,
>>
>> I think the answer is Yes and No on this question, the devs might ha=
ve
>> another approach for your situation.
>>
>> If you would do this, you would have a MON, MDS and OSD on every ser=
ver,
>> in theory that would work. Mounting would be done by connecting to o=
n of
>> the MON's (doesn't matter which one).
>>
>> But Ceph requires, well, advises a odd number of monitors (Source:
>> http://ceph.newdream.net/wiki/Designing_a_cluster )
>>
>> So you would require a third node which is running your third monito=
r to
>> keep track of both nodes.
>>
>> My advise, for two nodes, use something like DRBD in Primary<> =A0Pr=
imary
>> and use a cluster filesystem like OCFS2.
>
> Currently, I'm running glusterfs in such a scenario (two servers, eac=
h being
> also clients), but I wanted to give ceph a try (glusterfs has some
> performance issues with lots of small files), also because of its nic=
e
> features (snapshots, rbd etc.).
Rather than running 3 monitors you could just put a monitor on one of
the machines -- your cluster will go down if it fails, but in a 2-node
system it's not like resilience from one-node failure would be very
helpful anyway.

However, there is a serious issue with running clients and servers on
one machine, which may or may not be a problem depending on your use
case: Deadlock becomes a significant possibility. This isn't a problem
we've come up with a good solution for, unfortunately, but imagine
you're writing a lot of files to Ceph. Ceph dutifully writes them and
the kernel dutifully caches them. You also have a lot of write
activity so the Ceph kernel client is doing local caching. Then the
kernel comes along and says "I'm low on memory! Flush stuff to disk!"
and the kernel client tries to flush it out...which involves creating
another copy of the data in memory on the same machine. Uh-oh!
Now if you use the FUSE client this won't be an issue, but your
performance also won't be so good. :/
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
