From: Wido den Hollander <wido@widodh.nl>
Subject: Re: HEALTH_WARNING
Date: Sat, 02 Apr 2011 10:22:52 +0200
Message-ID: <1301732572.2389.8.camel@wido-laptop.pcextreme.nl>
References: <2118397089.13429.1301716779192.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38032 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab1DBIWz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2011 04:22:55 -0400
In-Reply-To: <2118397089.13429.1301716779192.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

Hi,

On Sat, 2011-04-02 at 05:59 +0200, Martin Wilderoth wrote:
> Hello,
> 
> One of my hosts run out of diskspace on the root file system (logfiles)
> So I restared ceph. Discoverd the low diskspace during the restart. osd2 and osd3
> 

Do you have separate partitions for your OSD data? Or do you have one
big / partition? I'd recommend a separate partition for your OSD's. 

> ceph health gives a message like this
> 
> HEALTH_WARN osdmonitor: num_osds = 6, num_up_osds = 4, num_in_osds = 4 Some PGs are: degraded,peering
> 
> now osd.1 is dead all the other are running
> 
> How do I get the running one up and in ? and how do I know which ods it is ?
> 

$ ceph osd dump -o -

That should tell you which OSD is down/out.

> how do I recover the dead one ?
> 

Normally starting the OSD would be enough. Look closely though, you
might have hit a bug which caused the OSD to crash. If so, there should
be a file called "core" in / which has a core-dump and could tell why
the OSD crashed:

$ gdb /usr/bin/cosd /core

Make sure you have the debug symbols (-dbg packages) installed when
doing so.

If you monitor 'ceph -w' then, you should see the cluster recover and
all OSD's should be up & in.

Wido

