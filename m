From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: 10 times higher disk load with btrfs
Date: Mon, 05 Jan 2015 20:19:27 +0100
Message-ID: <54AAE3BF.9080908@profihost.ag>
References: <54AAD9B5.5080207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:28417 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbbAETS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 14:18:58 -0500
In-Reply-To: <54AAD9B5.5080207@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Am 05.01.2015 um 19:36 schrieb Stefan Priebe:
> Hi devs,
>
> while btrfs is now declared as stable ;-) i wanted to retest btrfs on
> our production cluster on 2 out of 54 osds. So if they crash it doesn't
> hurt.
>
> While if those OSDs run XFS have spikes of 20MB/s every 4-7s. The same
> OSDs after formatting them with btrfs have spikes of 190MB/s every 4-7s.
>
> Why does just another filesystem raises the disk load by a factor of 10?

OK this seems to happen cause ceph is creating every 5s a new subvolume 
/ snap. Is this really expected / needed?

Stefan

>
> I'm running dumpling.
>
> Greets Stefan
