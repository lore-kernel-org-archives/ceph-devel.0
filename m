From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Statistics / Nagios
Date: Sun, 25 Nov 2012 20:32:13 +0100
Message-ID: <50B2723D.5020904@profihost.ag>
References: <50B262F2.4090205@profihost.ag> <9536A23884D44002B4C59911713210DF@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58173 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab2KYTcM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 14:32:12 -0500
In-Reply-To: <9536A23884D44002B4C59911713210DF@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

Am 25.11.2012 20:08, schrieb Gregory Farnum:
> On Sunday, November 25, 2012 at 10:26 AM, Stefan Priebe wrote:
>> Hello list,
>>
>> are there any useful statistics for ceph? ceph -s shows just the status
>> but i would like to record something which gives me an idea about the
>> ceph load or usage.
>
> Each daemon has an admin socket which you can use to extract "perfcounters" (performance counters). It's not well-documented at all right now, unfortunately.
> "ceph --admin-daemon /path/to/admin/socket help"
> "ceph --admin-daemon /path/to/admin/socket perfcounters_dump"
>
> "ceph --admin-daemon /path/to/admin/socket perfcounters_schema"
>
> should get you started.
> http://ceph.com/docs/master/radosgw/troubleshooting has some examples of troubleshooting the gateway with them.

thanks! I don't use radosgw. Just ceph-mon and ceph-osd with rbd block 
devices.

So i have to query each OSD on their own?

Right now i have
[global]
   admin socket=/var/run/ceph.sock

but that gives:
# ceph --admin-daemon /var/run/ceph.sock perfcounters_schema
{}

Greets,
Stefan
