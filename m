From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: 10 times higher disk load with btrfs
Date: Mon, 05 Jan 2015 14:29:00 -0600
Message-ID: <54AAF40C.3060608@redhat.com>
References: <54AAD9B5.5080207@profihost.ag> <54AAE3BF.9080908@profihost.ag> <alpine.DEB.2.00.1501051124430.5967@cobra.newdream.net> <54AAF1FA.9040709@profihost.ag>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:59872 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbAEU3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 15:29:04 -0500
Received: by mail-qg0-f45.google.com with SMTP id z107so4711204qgd.4
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 12:29:03 -0800 (PST)
In-Reply-To: <54AAF1FA.9040709@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org



On 01/05/2015 02:20 PM, Stefan Priebe wrote:
> Hi Sage,
>
> Am 05.01.2015 um 20:25 schrieb Sage Weil:
>> On Mon, 5 Jan 2015, Stefan Priebe wrote:
>>>
>>> Am 05.01.2015 um 19:36 schrieb Stefan Priebe:
>>>> Hi devs,
>>>>
>>>> while btrfs is now declared as stable ;-) i wanted to retest btrfs on
>>>> our production cluster on 2 out of 54 osds. So if they crash it doesn't
>>>> hurt.
>>>>
>>>> While if those OSDs run XFS have spikes of 20MB/s every 4-7s. The same
>>>> OSDs after formatting them with btrfs have spikes of 190MB/s every
>>>> 4-7s.
>>>>
>>>> Why does just another filesystem raises the disk load by a factor of
>>>> 10?
>>>
>>> OK this seems to happen cause ceph is creating every 5s a new
>>> subvolume /
>>> snap. Is this really expected / needed?
>>
>> You can disable it with
>>
>>   filestore btrfs snap = false
>>
>> I'm curious how much this drops the load down; originally the
>> snaps were no more expensive than a regular sync but perhaps this
>> has changed...
>
> - with XFS the average write is at 9Mb/s
> - with btrfs (filestore_btrfs_snap=true) write is at 40Mb/s
> - with btrfs (filestore_btrfs_snap=false) write is at 20Mb/s

Is that the average and not the spikes?  It looks like before the spikes 
were 20MB/s and 190MB/s?

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
