From: Wido den Hollander <wido@42on.com>
Subject: Re: pre_start command not executed with upstart
Date: Thu, 30 Jul 2015 14:30:57 +0200
Message-ID: <55BA1901.9080504@42on.com>
References: <55B73581.3040501@42on.com> <alpine.DEB.2.00.1507280528210.22099@cobra.newdream.net> <55B9D5A5.9060301@42on.com> <alpine.DEB.2.00.1507300526420.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:56135 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbbG3Ma7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jul 2015 08:30:59 -0400
In-Reply-To: <alpine.DEB.2.00.1507300526420.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 30-07-15 14:28, Sage Weil wrote:
> On Thu, 30 Jul 2015, Wido den Hollander wrote:
>> On 28-07-15 14:29, Sage Weil wrote:
>>> On Tue, 28 Jul 2015, Wido den Hollander wrote:
>>>> Hi,
>>>>
>>>> I was trying to inject a pre_start command on a bunch of OSDs under
>>>> Ubuntu 14.04, but that didn't work.
>>>>
>>>> I found out that only the sysvinit script execute pre_start commands,
>>>> but the upstart nor the systemd scripts do this.
>>>>
>>>> Is this a thing which will disappear or is this just a oversight?
>>>>
>>>> I'm actually using "sleep 30" as a pre-start to prevent all OSDs from
>>>> starting at the same time. Big boxes which die under the workload of all
>>>> OSDs starting at the same time.
>>>>
>>>> I also try to prevent a lot of OSDMap changes by booting the OSDs slowly
>>>> so I tried to fix this with "pre_start".
>>>
>>> I was hoping to let it die...
>>>
>>> I would take a fresh look at systemd and see if there is a 
>>> different/better mechanism there to address the startup issue.  You can 
>>> manually add a prestart script/command to the unit file...
>>>
>>
>> Oh, it doesn't matter if it dies out. It's just that there will probably
>> be scenarios where users want to do some sort of pre-start before a OSD
>> is executed.
>>
>> The update_crush hook is one of the examples which is already executed
>> for example.
>>
>> A pre_start which does a mount for example (for those without udev)
>> might be useful.
> 
> For what it's worth, the view from Leannart is that unit files are simple 
> enough to be configuration, in which case such users can just add a 
> ExecStartPre to their ceph-osd@.service file (instead of doing the same in 
> the ceph.conf file).
> 

Agreed and you are right. We shouldn't do anything special here. Since
both Ubuntu and CentOS/RHEL are migrating to systemd we shouldn't
probably really care about pre_start anymore.

Wido

> sage
> 
