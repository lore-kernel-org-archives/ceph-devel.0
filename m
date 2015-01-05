From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: 10 times higher disk load with btrfs
Date: Mon, 05 Jan 2015 21:20:10 +0100
Message-ID: <54AAF1FA.9040709@profihost.ag>
References: <54AAD9B5.5080207@profihost.ag> <54AAE3BF.9080908@profihost.ag> <alpine.DEB.2.00.1501051124430.5967@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:11500 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbbAEUTl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 15:19:41 -0500
In-Reply-To: <alpine.DEB.2.00.1501051124430.5967@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Am 05.01.2015 um 20:25 schrieb Sage Weil:
> On Mon, 5 Jan 2015, Stefan Priebe wrote:
>>
>> Am 05.01.2015 um 19:36 schrieb Stefan Priebe:
>>> Hi devs,
>>>
>>> while btrfs is now declared as stable ;-) i wanted to retest btrfs on
>>> our production cluster on 2 out of 54 osds. So if they crash it doesn't
>>> hurt.
>>>
>>> While if those OSDs run XFS have spikes of 20MB/s every 4-7s. The same
>>> OSDs after formatting them with btrfs have spikes of 190MB/s every 4-7s.
>>>
>>> Why does just another filesystem raises the disk load by a factor of 10?
>>
>> OK this seems to happen cause ceph is creating every 5s a new subvolume /
>> snap. Is this really expected / needed?
>
> You can disable it with
>
>   filestore btrfs snap = false
>
> I'm curious how much this drops the load down; originally the
> snaps were no more expensive than a regular sync but perhaps this
> has changed...

- with XFS the average write is at 9Mb/s
- with btrfs (filestore_btrfs_snap=true) write is at 40Mb/s
- with btrfs (filestore_btrfs_snap=false) write is at 20Mb/s

Stefan
