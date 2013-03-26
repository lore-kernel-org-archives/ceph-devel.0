From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Latest 0.56.3 and qemu-1.4.0 and cloned VM-image producing massive
 fs-corruption, not crashing
Date: Tue, 26 Mar 2013 09:33:07 +0100
Message-ID: <51515D43.1080101@filoo.de>
References: <34E007C3-D952-4350-83FA-F9BC34294EEF@filoo.de> <514CB14F.8040209@inktank.com> <51502118.7060906@filoo.de> <51515C8A.1080107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:53875 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934113Ab3CZIdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Mar 2013 04:33:09 -0400
In-Reply-To: <51515C8A.1080107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh,

thanks for the quick response and...

On 03/26/2013 09:30 AM, Josh Durgin wrote:
> On 03/25/2013 03:04 AM, Oliver Francke wrote:
>> Hi josh,
>>
>> logfile is attached...
>
> Thanks. It shows nothing out of the ordinary, but I just reproduced t=
he
> incorrect rollback locally, so it shouldn't be hard to track down fro=
m
> here.
>
> I opened http://tracker.ceph.com/issues/4551 to track it.

the good news.

Oliver.

>
> Josh
>
>> On 03/22/2013 08:30 PM, Josh Durgin wrote:
>>> On 03/22/2013 12:09 PM, Oliver Francke wrote:
>>>> Hi Josh, all,
>>>>
>>>> I did not want to hijack the thread dealing with a crashing VM, bu=
t
>>>> perhaps there are some common things.
>>>>
>>>> Today I installed a fresh cluster with mkephfs, went fine, importe=
d a
>>>> "master" debian 6.0 image with "format 2", made a snapshot, protec=
ted
>>>> it, and made some clones.
>>>> Clones mounted with qemu-nbd, fiddled a bit with
>>>> IP/interfaces/hosts/net.rules=85etc and cleanly unmounted, VM star=
ted,
>>>> took 2 secs and the VM was up n running. Cool.
>>>>
>>>> Now an ordinary shutdown was performed, made a snapshot of this
>>>> image. Started again, did some "apt-get update=85 install s/t=85".
>>>> Shutdown -> rbd rollback -> startup again -> login -> install s/t
>>>> else=85 filesystem showed "many" ex3-errors, fell into read-only m=
ode,
>>>> massive corruption.
>>>
>>> This sounds like it might be a bug in rollback. Could you try cloni=
ng
>>> and snapshotting again, but export the image before booting, and af=
ter
>>> rolling back, and compare the md5sums?
>>
>> Done, first MD5-mismatch after 32 4MB blocks, checked with dd and a =
bs
>> of 4MB.
>>
>>>
>>> Running the rollback with:
>>>
>>> --debug-ms 1 --debug-rbd 20 --log-file rbd-rollback.log
>>>
>>> might help too. Does your ceph.conf where you ran the rollback have
>>> anything related to rbd_cache in it?
>>
>> No cache settings in global ceph.conf.
>>
>> Hope it helps,
>>
>> Oliver.
>>
>>>
>>>> qemu config was with ":rbd_cache=3Dfalse" if it matters. Above sce=
nario
>>>> is reproducible, and as I stated out, no crash detected.
>>>>
>>>> Perhaps it is in the same area as in the crash-thread, otherwise I
>>>> will provide logfiles as needed.
>>>
>>> It's unrelated, the other thread is an issue with the cache, which =
does
>>> not cause corruption but triggers a crash.
>>>
>>> Josh
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
