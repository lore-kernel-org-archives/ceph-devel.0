From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph hangs when accessed
Date: Fri, 23 Sep 2011 13:20:14 -0400
Message-ID: <1316798414.2822.33.camel@wido-laptop>
References: <1801183894.301109.1316793492464.JavaMail.root@zmbs4.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:55888 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1IWRUS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 13:20:18 -0400
In-Reply-To: <1801183894.301109.1316793492464.JavaMail.root@zmbs4.inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cedric Morandin <cedric.morandin@inria.fr>
Cc: ceph-devel@vger.kernel.org

Hi.

Could you sent us your ceph.conf and the output of "ceph -s" ?

Wido

On Fri, 2011-09-23 at 17:58 +0200, Cedric Morandin wrote:
> Hi everybody,
> 
> I didn't find any ceph-users list so I post here. If this is not the right place to do it please let me know.
> I'm currently trying to test ceph but I'm probably doing something wrong because I have a really strange behavior.
> 
> Context:
> Ceph compiled and installed on five Centos6 machines.
> A BTRFS partition is available on each machine.
> This partition is mounted under /data/osd.[0-3]
> Clients are using cfuse compiled for FC11 ( 2.6.29.4-167.fc11.x86_64 )
> 
> What happen:
> I configured everything in ceph.conf, started ceph daemons on all nodes.
> When I issue ceph health, I have a HEALTH_OK answer.
> I can access the filesystem through cfuse and create some files on it, but when I try to create files bigger than 2 or 3 Mo, the filesystem hangs.
> When I try to copy an entire directory ( ceph sources for instance) I have the same problem.
> When the system is in this state, the cosd daemon die on OSD machines: [INF] osd0 out (down for 304.836218)
> Even killing it doesn't release the mountpoint :
> cosd       9170      root   10uW     REG                8,6          8    2506754 /data/osd.0/fsid
> cosd       9170      root   11r      DIR                8,6       4096    2506753 /data/osd.0
> cosd       9170      root   12r      DIR                8,6      24576    2506755 /data/osd.0/current
> cosd       9170      root   13u      REG                8,6          4    2506757 /data/osd.0/current/commit_op_seq
> 
> 
> I tried to change some parameters but it results in the same problem:
> Tried both with the 0.34 and 0.35 releases and using both BTRFS or EXTR3 with user_attr attribute.
> I tried the cfuse client on one of the Centos 6 machine.
> 
> I read everything on  http://ceph.newdream.net/wiki but I can't figure out the problem.
> Does somebody have any clue of the problem's origin ?
> 
> Regards,
> 
> Cedric Morandin 
> 
> 
> 


