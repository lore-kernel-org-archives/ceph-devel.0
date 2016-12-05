From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
        <bartlomiej.swiecki@corp.ovh.com>
Subject: Re: Question about recovery vs backfill priorities
Date: Mon, 5 Dec 2016 10:29:26 +0100
Message-ID: <899b3678-82fc-3dcf-a3ed-151aa033dc79@corp.ovh.com>
References: <3b219d94-431d-0a4f-e656-826003028a9d@corp.ovh.com>
 <alpine.DEB.2.11.1612012158570.2097@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 5.mo302.mail-out.ovh.net ([137.74.110.78]:49677 "EHLO
        5.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbcLEJ3b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 04:29:31 -0500
In-Reply-To: <alpine.DEB.2.11.1612012158570.2097@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I made a quick draft of how new priority code could look like, please 
let me know if that's a good direction:

https://github.com/ceph/ceph/compare/master...ovh:wip-rework-recovery-priorities

Haven't tested it yet though so no PR yet, will do it today.

A side question: Is there any reason why pool_recovery_priority is not 
adjusting backfill priority?
Maybe it would be beneficial to include it there too?

Regards,
Bartek


On 12/01/2016 11:10 PM, Sage Weil wrote:
> Hi Bartek,
>
> On Thu, 1 Dec 2016, Bartłomiej Święcki wrote:
>> We're currently being hit by an issue with cluster recovery. The cluster size
>> has been significantly extended (~50% new OSDs) and started recovery.
>> During recovery there was a HW failure and we ended up with some PGS in peered
>> state with size < min_size (inactive).
>> Those peered PGs are waiting for backfill but the cluster still prefers
>> recovery of recovery_wait PGs - in our case this could be even few hours
>> before all recovery is finished (we're speeding up recovery up to limits to
>> get the downtime as short as possible). Those peered PGs are blocked during
>> this time and the whole cluster just struggles to operate at a reasonable
>> level.
>>
>> We're running hammer 0.94.6 there and from the code it looks like recovery
>> will always have higher priority (jewel seems similar).
>> Documentation only says that log-based recovery must finish before backfills.
>> Is this requirement needed for data consistency or something else?
> For a given single PG, it will do it's own log recovery (to bring acting
> OSDs fully up to date) before starting backfill, but between PGs there's
> no dependency.
>
>> Ideally we'd like it to be this order: undersized inactive (size < min_size)
>> recovery_wait => undersized inactive (size < min_size) wait_backfill =>
>> degraded recovery_wait => degraded wait_backfill => remapped wait_backfill.
>> Changing priority calculation doesn't seem to be that hard but would it end up
>> with inconsistent data?
> We could definitely improve this, yeah.  The prioritization code is based
> around PG::get_{recovery,backfill}_priority(), and the
> OSD_{RECOVERY,BACKFILL}_* #defines in PG.h.  It currently assumes (log)
> recovery is always higher priority than backfill, but as you say we can do
> better.  As long as everything maps into a 0..255 priority value it should
> be fine.
>
> Getting the undersized inactive bumped to the top should be a simple tweak
> (just force a top-value priority in that case)...
>
> sage

