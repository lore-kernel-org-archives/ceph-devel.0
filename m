From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Proporttions of each role in a cluster
Date: Tue, 08 Mar 2011 10:43:21 +0100
Message-ID: <1299577401.2629.6.camel@wido-laptop.pcextreme.nl>
References: <1299506341.17468.2.camel@ceph>
	 <1299509895.2433.87.camel@wido-desktop>  <4D755382.6030303@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38331 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab1CHJnc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2011 04:43:32 -0500
In-Reply-To: <4D755382.6030303@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel@vger.kernel.org

Hi,

On Mon, 2011-03-07 at 22:52 +0100, Martin Mailand wrote:
> > I'm running a Ceph cluster at the moment on Atom CPU's with 4GB of RAM,
> > each machine has 4x2TB (4 OSD's in total) and uses about ~800MB of RAM,
> > the other 3.2GB is used for caching.
> > 
> 
> Hi Wido,
> would you recommend a Atom CPU for an OSD? At the moment I'm looking at 
> this mainboard 
> http://www.supermicro.com/products/motherboard/ATOM/ICH9/X7SPA.cfm?typ=H&IPMI=Y, 
> I want to use it with 6 disks.

I'm using the same board. Currently I have on running with 4 OSD's on
it, but I hope to have 9 of them (each with 4 OSD's) running by the end
of next week.

> The 800MB your machine uses is for all 4 OSD's together? Do you have any 
> numbers for the CPU utilization?

There are my current stats:

root@atom:~# free -m
             total       used       free     shared    buffers
cached
Mem:          3963       3871         92          0         34
3247
-/+ buffers/cache:        590       3373
Swap:         7627          2       7625
root@atom:~#

root@atom:~# pidof cosd
9314 8201 8101 8028
root@atom:~#

> I'm looking for the sweetspot of max IO-OPs/s per watt.

Although I haven't been benchmarking it really hard, I don't think the
CPU will be a bottleneck. I did a expansion from 4 to 8 OSD's where the
Atom machine hosts the new OSD's, about 500GB of data had to be copied
to the box. The recovery pushed about 40MB/sec to the OSD's, where the
CPU utilization was about 40%

I hope to have the 9 Atom machines running by next, that will give me
some more information.

Wido

> 
> Thanks in advance.
> 
> martin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

