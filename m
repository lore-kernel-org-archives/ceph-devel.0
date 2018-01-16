From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Porting snap trim queue check to Luminous
Date: Tue, 16 Jan 2018 11:41:04 +0100
Message-ID: <73225e82-f3a5-1e93-c8ac-cd44e2334809@corp.ovh.com>
References: <6258c4a1-3fa1-3627-1e47-cde2bcb4742e@corp.ovh.com>
 <alpine.DEB.2.11.1801151901450.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo301.mail-out.ovh.net ([137.74.110.73]:51478 "EHLO
        10.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeAPKlH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 05:41:07 -0500
In-Reply-To: <alpine.DEB.2.11.1801151901450.24931@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 18-01-15 08:02 PM, Sage Weil wrote:
> On Mon, 15 Jan 2018, Piotr Dałek wrote:
>> With Mimic, there are a new fields added to pg_stat_t: "state" and
>> "purged_snaps". My snap trim queue check
>> (https://github.com/ceph/ceph/pull/19520) adds one more field
>> ("snaptrimq_len") and it is positioned quite unfortunately - AFTER those two,
>> meaning that I can't add it without adding the other two. Knowing that Mimic
>> is not out, there are three options:
>>
>> 1 - Backport just
>> https://github.com/ceph/ceph/pull/19520/commits/dc7781cf17d11cb09067656cb25c0d710ab60d71
>> that adds snap_trimq_len field to "pg query" command and leave out the rest.
>> That's not entirely satisfying from my perspective, but it's still a little
>> step forward.
>> 2 - Fill "state" and "purged snaps" with dummy data in Luminous, but that can
>> screw up upgrades from Luminous to Mimic.
>> 3 - Reorder fields in master/Mimic and add snaptrimq_len before state and
>> purged snaps. Probably no impact as Mimic is not out yet.
> 
> I think #3 is fine!

I just pushed a PR (https://github.com/ceph/ceph/pull/19965) that does just 
that. Once that gets merged I can port snap trim queue check to Luminous.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
