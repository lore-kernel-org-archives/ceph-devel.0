From: =?UTF-8?B?UGF3ZcWCIFNhZG93c2tp?= <ceph@sadziu.pl>
Subject: Re: Ceph data consistency
Date: Tue, 30 Dec 2014 14:40:27 +0100
Message-ID: <54A2AB4B.6000206@sadziu.pl>
References: <54A2609D.1010302@sadziu.pl> <085BC98701B92B4C86AE7696562D284D0B9CE2F3@SACMBXIP03.sdcorp.global.sandisk.com>
Reply-To: ceph@sadziu.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mojave.sadziu.pl ([192.30.35.41]:41556 "EHLO mail.sadziu.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750833AbaL3Nkt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Dec 2014 08:40:49 -0500
Received: from mail.sadziu.pl ([192.168.54.2])
	by mail.sadziu.pl with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <ceph@sadziu.pl>)
	id 1Y5x2Q-0000pT-P4
	for ceph-devel@vger.kernel.org; Tue, 30 Dec 2014 14:40:46 +0100
In-Reply-To: <085BC98701B92B4C86AE7696562D284D0B9CE2F3@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/30/2014 01:40 PM, Vijayendra Shamanna wrote:
> Hi,
>
> There is a sync thread (sync_entry in FileStore.cc) which triggers periodically and executes sync_filesystem() to ensure that the data is consistent. The journal entries are trimmed only after a successful sync_filesystem() call

sync_filesystem() always returns zero and journal will be trimmed. Executing sync()/syncfs() with dirty data in disk buffers will result in data loss ("lost page write due to I/O error").

I was doing some experiments simulating disk errors using Device Mapper "error" target. In this setup OSD was writing to broken disk without crashing. Every 5 seconds (filestore_max_sync_interval) kernel logs that some data were discarded due to IO error.


> Thanks
> Viju
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Pawel Sadowski
>> Sent: Tuesday, December 30, 2014 1:52 PM
>> To: ceph-devel@vger.kernel.org
>> Subject: Ceph data consistency
>>
>> Hi,
>>
>> On our Ceph cluster from time to time we have some inconsistent PGs (after deep-scrub). We have some issues with disk/sata cables/lsi controller causing IO errors from time to time (but that's not the point in this case).
>>
>> When IO error occurs on OSD journal partition everything works as is should -> OSD is crashed and that's ok - Ceph will handle that.
>>
>> But when IO error occurs on OSD data partition during journal flush OSD continue to work. After calling *writev* (in buffer::list::write_fd) OSD does check return code from this call but does NOT verify if write has been successful to disk (data are still only >in memory and there is no fsync). That way OSD thinks that data has been stored on disk but it might be discarded (during sync dirty page will be reclaimed and you'll see "lost page write due to I/O error" in dmesg).
>>
>> Since there is no checksumming of data I just wanted to make sure that this is by design. Maybe there is a way to tell OSD to call fsync after write and have data consistent?

-- 
PS
