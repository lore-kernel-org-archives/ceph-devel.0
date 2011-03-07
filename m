From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Proporttions of each role in a cluster
Date: Mon, 07 Mar 2011 22:52:02 +0100
Message-ID: <4D755382.6030303@tuxadero.com>
References: <1299506341.17468.2.camel@ceph> <1299509895.2433.87.camel@wido-desktop>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51355 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab1CGVwK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 16:52:10 -0500
In-Reply-To: <1299509895.2433.87.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

> I'm running a Ceph cluster at the moment on Atom CPU's with 4GB of RAM,
> each machine has 4x2TB (4 OSD's in total) and uses about ~800MB of RAM,
> the other 3.2GB is used for caching.
> 

Hi Wido,
would you recommend a Atom CPU for an OSD? At the moment I'm looking at 
this mainboard 
http://www.supermicro.com/products/motherboard/ATOM/ICH9/X7SPA.cfm?typ=H&IPMI=Y, 
I want to use it with 6 disks.
The 800MB your machine uses is for all 4 OSD's together? Do you have any 
numbers for the CPU utilization?
I'm looking for the sweetspot of max IO-OPs/s per watt.

Thanks in advance.

martin


