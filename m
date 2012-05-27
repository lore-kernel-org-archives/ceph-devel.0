From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Sun, 27 May 2012 20:57:23 +0200
Message-ID: <4FC27913.7080504@profihost.ag>
References: <eaec3e6f-4cf2-4a8b-a6ee-22805243ddef@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54548 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab2E0S5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 May 2012 14:57:21 -0400
In-Reply-To: <eaec3e6f-4cf2-4a8b-a6ee-22805243ddef@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 27.05.2012 13:33, schrieb Alexandre DERUMIER:
>> how much time to flush from journal to disks ?
>>> I don't know how to measure this.
> Do an iostat, you must see timelapse of write inactivity on disk (datas are written to journal) , then after a timelapse
 > of write activity on disk.(data flushed from journal to disk)
No it always starts in parallel. Journal is set to 1GB. I've now moved 
the journal to disk - so i can use iostat.

>>> As ceph starts to write to journal and
>>> disk in parallel
>
> this is strange, from doc:
> http://ceph.com/wiki/OSD_journal
>
> the journal mode should be write-ahead with xfs.
> So write to journal first then flush to disk each 30sec.
I'm not quite sure as:
http://ceph.com/wiki/Ceph.conf#filestore_journal_writeahead

says there are two options:
filestore journal writeahead
and
filestore journal parallel
but even
filestore journal writeahead = 1
filestore journal parallel = 0

results in a parallel start.

> maybe your tmpfs is too small, and flushs occurs at 50% of free space on journal.
> If by exemple, your flush occurs each 1 or 2seconds, this can cause very slow write.
1GB? My 1Gbit/s LAN test connection can't handle more than about 
120MB/s. So there's at least room for 8-10s.

;-(

Stefan
