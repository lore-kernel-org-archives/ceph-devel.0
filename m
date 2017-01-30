From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Not starting a OSD journal
Date: Mon, 30 Jan 2017 10:47:08 +0100
Message-ID: <3a72574a-8b23-727e-90dc-700a1499e7b6@digiware.nl>
References: <30ca4a82-d51a-c190-6e4c-0ac329644d04@digiware.nl>
 <351131ca-d626-3bba-833b-c3281a5b25e1@suse.cz>
 <611a59a0-3511-079b-e2a3-691342234510@digiware.nl>
 <3e65b463-494b-4609-306e-6851d1c19b2e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:36680 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750843AbdA3Jrs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 04:47:48 -0500
In-Reply-To: <3e65b463-494b-4609-306e-6851d1c19b2e@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kostas Liakakis <koukou73gr@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 30-1-2017 10:17, Kostas Liakakis wrote:
> On 2017-01-29 22:09, Willem Jan Withagen wrote:
>> The disadvantage is that there will be a double write per original write:
>>  (ceph) first write is to the journal-file
>>     (zfs) write is stored in the write queue
>>     (zfs) write to ZIL(ssd) if write is synced write
>>     (zfs) async write to disk when write slot is available
>>  (ceph) read from zfs-store,
>>     (zfs) delivers data either arc(ram) or l2arc(ssd) or HD
>>  (ceph) writes data to filestore.
>>     (zfs) write is stored in the write queue
>>     (zfs) write to ZIL(ssd) if write is synced write
>>     (zfs) async write to disk when write slot is available
>>
>> And I hoped to forgo the Ceph journal write/read cycle.
> You've got a slight misconception there, not that it matters much to
> your problem.
> 
> A Ceph OSD will never read its journal under normal operation. OSD will
> only commit data to the journal before it commits them to its filestore.
> The journal is only replayed after an OSD crash or otherwise abnormal
> termination.

Ah, Oke .. Thanx for the clarification.

This is also how ZFS does it. The ZIL is only read in case a node
crashes and transactions need to be replayed.

> The way Ceph OSDs w/ filestore has been put in place I don't think there
> is a way to fully utilize zfs features.

I'm running some benchmarks with a simple config just to see what is
going on. And your explanation is in accordance with what I was seeing.
Although I do see some reads from the journal, but not at the same rate
things are written.

Guess I'm going to be toying a bit more....

--WjW


