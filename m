From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Higher OSD disk util due to RBD snapshots from Dumpling to Firefly
Date: Fri, 02 Jan 2015 19:43:19 +0100
Message-ID: <54A6E6C7.9050901@profihost.ag>
References: <54A42280.60607@42on.com>	<54A513C5.6040407@profihost.ag> <CA+4uBUZziztmmx+FJdNJ=Tjva3muaJofCo-ijk4S1V9PcpXBxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:29938 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbABSmw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jan 2015 13:42:52 -0500
In-Reply-To: <CA+4uBUZziztmmx+FJdNJ=Tjva3muaJofCo-ijk4S1V9PcpXBxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com, Josh Durgin <jdurgin@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 02.01.2015 um 17:49 schrieb Samuel Just:
> Odd, sounds like it might be rbd client side?
> -Sam

That one was already on list:
https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg19091.html

Sadly there was no result as it was unseen for 2 weeks and i didn't had 
the test equipment anymore.

Greets,
Stefan

> On Thu, Jan 1, 2015 at 1:30 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> hi,
>>
>> Am 31.12.2014 um 17:21 schrieb Wido den Hollander:
>>>
>>> Hi,
>>>
>>> Last week I upgraded a 250 OSD cluster from Dumpling 0.67.10 to Firefly
>>> 0.80.7 and after the upgrade there was a severe performance drop on the
>>> cluster.
>>>
>>> It started raining slow requests after the upgrade and most of them
>>> included a 'snapc' in the request.
>>>
>>> That lead me to investigate the RBD snapshots and I found that a rogue
>>> process had created ~1800 snapshots spread out over 200 volumes.
>>>
>>> One image even had 181 snapshots!
>>>
>>> As the snapshots weren't used I removed them all and after the snapshots
>>> were removed the performance of the cluster came back to normal level
>>> again.
>>>
>>> I'm wondering what changed between Dumpling and Firefly which caused
>>> this? I saw OSDs spiking to 100% disk util constantly under Firefly
>>> where this didn't happen with Dumpling.
>>>
>>> Did something change in the way OSDs handle RBD snapshots which causes
>>> them to create more disk I/O?
>>
>>
>> I saw the same and addionally a slowdown in librbd too, that's why i'm still
>> on dumpling and won't upgrade until hammer.
>>
>> Stefan
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
