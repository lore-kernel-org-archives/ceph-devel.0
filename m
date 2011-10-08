From: Martin Mailand <martin@tuxadero.com>
Subject: Re: OSD::disk_tp timeout
Date: Sun, 09 Oct 2011 00:15:24 +0200
Message-ID: <4E90CB7C.3010304@tuxadero.com>
References: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com> <Pine.LNX.4.64.1110081427160.26432@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:50192 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab1JHWPd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2011 18:15:33 -0400
In-Reply-To: <Pine.LNX.4.64.1110081427160.26432@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,
I am using v3.1-rc9, so the fix in there. Maybe I can nail it down a bit 
more specific.

Best Regards,
  martin

Sage Weil schrieb:
> Hi Christian,
> 
> On Sat, 8 Oct 2011, Christian Brunner wrote:
>> Hi,
>>
>> I've upgraded ceph from 0.32 to 0.36 yesterday. Now I have a totaly
>> screwed ceph cluster. :(
>>
>> What bugs me most is the fact, that OSDs become unresponsive
>> frequently. The process is eating a lot of cpu and I can see the
> 
> What version of btrfs are you running?  This sound a bit like the bug 
> fixed by this patch:
> 
> http://www.spinics.net/lists/linux-btrfs/msg12627.html
> 
> (That was just merged into mainline this week.)
> 
>> following messages in the log:
>>
>> Oct  8 22:30:05 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
>> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>> Oct  8 22:30:10 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
>> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>> Oct  8 22:30:15 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
>> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>> Oct  8 22:30:20 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
>> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>> Oct  8 22:30:25 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
>> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>> Oct  8 22:30:30 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
>> is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
>>
>> Do you have any idea, what to do about that?
> 
> Those messages just mean that a thread in the disk threadpool (which is 
> doing all the writes to btrfs) is blocked/stopped.
> 
> sage
