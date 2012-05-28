From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Mon, 28 May 2012 08:25:24 +0200
Message-ID: <4FC31A54.4020306@profihost.ag>
References: <84f4a25f-d293-4b38-a4cb-d4a49912e644@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49626 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab2E1GZ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 02:25:27 -0400
In-Reply-To: <84f4a25f-d293-4b38-a4cb-d4a49912e644@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 28.05.2012 07:37, schrieb Alexandre DERUMIER:
> I think filestore journal parallel works only with btrfs.
> Other filesystem are writeahead.
... you might be right but i can't change ceph's implementation.

> if you write at 120MB/S, so your journal of 1GB is at 50% in 4sec.
>
> So you got around 480MB each 4sec, does your disks can flush sequentially these 480MB in less than 4sec ?
> (do a small benchmark of your disk in local filesystem, without ceph)
>
> If not, you can have spikes in your write stats if the journal.
>
> simple schema if disks are not fast enough:
I totally aggree with you but this is just a test setup AND if you have 
a big log file to copy let's say 100GB your journal will never be big 
enough and the speed should never drop to 0MB/s. Also i see the correct 
behaviour with 3.0.X where the speed is maxed to the underlying device. 
So i still see no reason that with 3.4 the speed drops to 0MB/s and is 
mostly 10-20MB/s instead of 130MB/s.

> How many disks (7,2K) do you have by osd ?
One intel 520 SSD per OSD.

Stefan
