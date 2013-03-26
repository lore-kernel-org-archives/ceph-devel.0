From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Latest 0.56.3 and qemu-1.4.0 and cloned VM-image producing massive
 fs-corruption, not crashing
Date: Tue, 26 Mar 2013 01:30:02 -0700
Message-ID: <51515C8A.1080107@inktank.com>
References: <34E007C3-D952-4350-83FA-F9BC34294EEF@filoo.de> <514CB14F.8040209@inktank.com> <51502118.7060906@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58661 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934095Ab3CZI3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Mar 2013 04:29:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1033910pad.34
        for <ceph-devel@vger.kernel.org>; Tue, 26 Mar 2013 01:29:53 -0700 (PDT)
In-Reply-To: <51502118.7060906@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/25/2013 03:04 AM, Oliver Francke wrote:
> Hi josh,
>
> logfile is attached...

Thanks. It shows nothing out of the ordinary, but I just reproduced the
incorrect rollback locally, so it shouldn't be hard to track down from
here.

I opened http://tracker.ceph.com/issues/4551 to track it.

Josh

> On 03/22/2013 08:30 PM, Josh Durgin wrote:
>> On 03/22/2013 12:09 PM, Oliver Francke wrote:
>>> Hi Josh, all,
>>>
>>> I did not want to hijack the thread dealing with a crashing VM, but
>>> perhaps there are some common things.
>>>
>>> Today I installed a fresh cluster with mkephfs, went fine, imported=
 a
>>> "master" debian 6.0 image with "format 2", made a snapshot, protect=
ed
>>> it, and made some clones.
>>> Clones mounted with qemu-nbd, fiddled a bit with
>>> IP/interfaces/hosts/net.rules=85etc and cleanly unmounted, VM start=
ed,
>>> took 2 secs and the VM was up n running. Cool.
>>>
>>> Now an ordinary shutdown was performed, made a snapshot of this
>>> image. Started again, did some "apt-get update=85 install s/t=85".
>>> Shutdown -> rbd rollback -> startup again -> login -> install s/t
>>> else=85 filesystem showed "many" ex3-errors, fell into read-only mo=
de,
>>> massive corruption.
>>
>> This sounds like it might be a bug in rollback. Could you try clonin=
g
>> and snapshotting again, but export the image before booting, and aft=
er
>> rolling back, and compare the md5sums?
>
> Done, first MD5-mismatch after 32 4MB blocks, checked with dd and a b=
s
> of 4MB.
>
>>
>> Running the rollback with:
>>
>> --debug-ms 1 --debug-rbd 20 --log-file rbd-rollback.log
>>
>> might help too. Does your ceph.conf where you ran the rollback have
>> anything related to rbd_cache in it?
>
> No cache settings in global ceph.conf.
>
> Hope it helps,
>
> Oliver.
>
>>
>>> qemu config was with ":rbd_cache=3Dfalse" if it matters. Above scen=
ario
>>> is reproducible, and as I stated out, no crash detected.
>>>
>>> Perhaps it is in the same area as in the crash-thread, otherwise I
>>> will provide logfiles as needed.
>>
>> It's unrelated, the other thread is an issue with the cache, which d=
oes
>> not cause corruption but triggers a crash.
>>
>> Josh
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
