From: Martin Mailand <martin@tuxadero.com>
Subject: Re: os/FileJournal.cc: 1011: FAILED assert(seq >= last_committed_seq)
Date: Mon, 05 Dec 2011 19:33:04 +0100
Message-ID: <4EDD0E60.6090902@tuxadero.com>
References: <4ED4C68A.9060606@tuxadero.com> <4ED4C87F.6010505@grnet.gr> <4ED4CCAB.6040005@tuxadero.com> <4ED4E477.6060108@tuxadero.com> <Pine.LNX.4.64.1111290806450.32268@cobra.newdream.net> <4EDCB881.3060704@tuxadero.com> <Pine.LNX.4.64.1112050943260.16190@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000506040208070908090806"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:33145 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab1LESdI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 13:33:08 -0500
In-Reply-To: <Pine.LNX.4.64.1112050943260.16190@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506040208070908090806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sage,
I just updated the crashed osd, and it did not work very well.

os/FileJournal.cc: 1173: FAILED assert(h->seq >= last_committed_seq)

1173	os/FileJournal.cc: No such file or directory.
	in os/FileJournal.cc
(gdb) p h->seq
value has been optimized out
(gdb) p last_committed_seq
$1 = 16834095


-martin

Am 05.12.2011 18:44, schrieb Sage Weil:
> dc167bac7800c75df971bded4b54e0de48f7b18f (wip-journal branch) should fix
> this.  Can you give it a test before I push to stable?
>
> Thanks!
> sage
>
>
> On Mon, 5 Dec 2011, Martin Mailand wrote:
>
>> Hi Sage,
>> it happened again, this time I have the log, it's attached.
>>
>> (gdb) thread 1
>> [Switching to thread 1 (Thread 24077)]#0  0x00007f7995b83b3b in raise () from
>> /lib/x86_64-linux-gnu/libpthread.so.0
>> (gdb) frame 11
>> #11 0x000000000072ee8d in FileJournal::committed_thru (this=0x1ebc000,
>> seq=16833973) at os/FileJournal.cc:1011
>> 1011    os/FileJournal.cc: No such file or directory.
>>          in os/FileJournal.cc
>> (gdb) p seq
>> $1 = 16833973
>> (gdb) p last_committed_seq
>> $2 = 16834010
>> (gdb)
>>
>> Is this all info you need, or should I leave the osd in this state for further
>> debugging?
>>
>> -martin
>>
>> Am 29.11.2011 17:07, schrieb Sage Weil:
>>> On Tue, 29 Nov 2011, Martin Mailand wrote:
>>>> Hi,
>>>> with a build from today, I have the same prob.
>>>>
>>>> os/FileJournal.cc: In function 'virtual void
>>>> FileJournal::committed_thru(uint64_t)', in thread '7fc55c85f700'
>>>> os/FileJournal.cc: 1011: FAILED assert(seq>= last_committed_seq)
>>>>    ceph version 0.38-250-gc2889fe
>>>> (commit:c2889fef420611df3dd0de4064c91f6aa9f86625)
>>>
>>> Can you post a log of the failed ceph-osd restart with 'debug journal =
>>> 20' and 'debug filestore = 20'?
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------000506040208070908090806
Content-Type: application/x-bzip;
 name="osd.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="osd.log.bz2"

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
zg==
--------------000506040208070908090806--
