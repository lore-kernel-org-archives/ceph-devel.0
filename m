From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD abstract class
Date: Thu, 25 Apr 2013 12:47:08 -0700
Message-ID: <CAPYLRzg__S87=WTByxrKDnxRmx+PqtxibYLQGUC51hJ4dSsMow@mail.gmail.com>
References: <5178E6AE.6060609@dachary.org>
	<CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com>
	<517975D6.1020904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57733 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025Ab3DYTrJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 15:47:09 -0400
Received: by mail-wg0-f44.google.com with SMTP id a12so1679709wgh.11
        for <ceph-devel@vger.kernel.org>; Thu, 25 Apr 2013 12:47:08 -0700 (PDT)
In-Reply-To: <517975D6.1020904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Apr 25, 2013 at 11:28 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 04/25/2013 06:45 PM, Gregory Farnum wrote:
>> On Thu, Apr 25, 2013 at 1:17 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi,
>>>
>>> In the context of the implementation of
>>>
>>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encod=
ing_as_a_storage_backend
>>>
>>> I'm preparing tests to assert that the modifications that will be m=
ade to the existing PG and ReplicatedPG will not introduce regressions.=
 Unless I'm mistaken, there are no unit tests or functional tests for P=
G or ReplicatedPG at the moment. I thought that it might be useful to a=
dd an abstract OSD class from which OSD is derived, to allow a test to =
derive from it to implement synthetic behavior.
>>>
>>>
>>> I gave it a try and it passes make check successfully. It is a litt=
le hairy because I commented out the code instead of removing it to hel=
p with rebasing.
>>>
>>> https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cde0=
48b084e314eb
>>>
>>> I'll now try to use it to implement some tests for ReplicatedPG.
>>>
>>> I would very much appreciate if someone has an advice on the best w=
ay to proceed. Even if it's to say : "you're crazy, don't go there ! yo=
u're wasting your time, there is a much simpler way !" ;-)
>>
>> What's your plot here? The OSD is fairly large to be doing unit test=
s
>> on (although it's not insensible) =97 but if we want to form a new P=
G it
>> might be best to start out by making abstract PG implementations.
>>
>
> My reasoning was that to for a new PG it was enough to rely on
>
> https://github.com/ceph/ceph/blob/master/src/osd/PG.h
>
> and create a new ErasureEncodingPG.{cc,h} after
>
> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc
>
> Since ReplicatedPG is the only class derived from PG, I assumed there=
 will be a need to move code from ReplicatedPG to PG and vice versa to =
make sure PG can actually be the base class of two different implementa=
tions. Are you suggesting that PG should be abstracted ? Is there a rea=
son why it would not be a good base class for a new ErasureEncodedPG ?

Oh, it *should* be the base class, but the distinction between PG and
ReplicatedPG right now is...vanishing. I had a quick chat about this
with Sam a couple days ago and we agreed the first task here is going
to be properly slicing them up somehow (the current state of affairs
is not a good model, even, from what he's told me).


I'm not saying the OSD is a bad plan, just that I'm not sure what kind
of useful tests we could produce by abstracting it =97 whereas the unit
tests we can write against a PG seem a lot simpler and more obvious. I
could well be missing something, though.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
