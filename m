From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSD abstract class
Date: Thu, 25 Apr 2013 18:05:35 -0700
Message-ID: <CA+4uBUbLf9SsVM1Y5Pd=asA7VgiKGEaKn8w_2JfwiKwGZijvPg@mail.gmail.com>
References: <5178E6AE.6060609@dachary.org>
	<CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com>
	<517975D6.1020904@dachary.org>
	<CAPYLRzg__S87=WTByxrKDnxRmx+PqtxibYLQGUC51hJ4dSsMow@mail.gmail.com>
	<51799024.8030101@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:50548 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab3DZBFg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 21:05:36 -0400
Received: by mail-vc0-f169.google.com with SMTP id gd11so3427425vcb.28
        for <ceph-devel@vger.kernel.org>; Thu, 25 Apr 2013 18:05:35 -0700 (PDT)
In-Reply-To: <51799024.8030101@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Gregory Farnum <greg@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

A good place to start would be to get some unit test coverage of the
PG::PriorSet logic.  It's already factored out to a degree.
osd_types.h::pg_interval_t::check_new_interval would also be a good
place for testing.

=46or something rather more ambitious, the
merge_log/rewind_dievergent_log and related methods could use better
test coverage, but that would require some significant refactoring.
-Sam

On Thu, Apr 25, 2013 at 1:20 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 04/25/2013 09:47 PM, Gregory Farnum wrote:
>> On Thu, Apr 25, 2013 at 11:28 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>
>>>
>>> On 04/25/2013 06:45 PM, Gregory Farnum wrote:
>>>> On Thu, Apr 25, 2013 at 1:17 AM, Loic Dachary <loic@dachary.org> w=
rote:
>>>>> Hi,
>>>>>
>>>>> In the context of the implementation of
>>>>>
>>>>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_enc=
oding_as_a_storage_backend
>>>>>
>>>>> I'm preparing tests to assert that the modifications that will be=
 made to the existing PG and ReplicatedPG will not introduce regression=
s. Unless I'm mistaken, there are no unit tests or functional tests for=
 PG or ReplicatedPG at the moment. I thought that it might be useful to=
 add an abstract OSD class from which OSD is derived, to allow a test t=
o derive from it to implement synthetic behavior.
>>>>>
>>>>>
>>>>> I gave it a try and it passes make check successfully. It is a li=
ttle hairy because I commented out the code instead of removing it to h=
elp with rebasing.
>>>>>
>>>>> https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cd=
e048b084e314eb
>>>>>
>>>>> I'll now try to use it to implement some tests for ReplicatedPG.
>>>>>
>>>>> I would very much appreciate if someone has an advice on the best=
 way to proceed. Even if it's to say : "you're crazy, don't go there ! =
you're wasting your time, there is a much simpler way !" ;-)
>>>>
>>>> What's your plot here? The OSD is fairly large to be doing unit te=
sts
>>>> on (although it's not insensible) =97 but if we want to form a new=
 PG it
>>>> might be best to start out by making abstract PG implementations.
>>>>
>>>
>>> My reasoning was that to for a new PG it was enough to rely on
>>>
>>> https://github.com/ceph/ceph/blob/master/src/osd/PG.h
>>>
>>> and create a new ErasureEncodingPG.{cc,h} after
>>>
>>> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc
>>>
>>> Since ReplicatedPG is the only class derived from PG, I assumed the=
re will be a need to move code from ReplicatedPG to PG and vice versa t=
o make sure PG can actually be the base class of two different implemen=
tations. Are you suggesting that PG should be abstracted ? Is there a r=
eason why it would not be a good base class for a new ErasureEncodedPG =
?
>>
>> Oh, it *should* be the base class, but the distinction between PG an=
d
>> ReplicatedPG right now is...vanishing. I had a quick chat about this
>> with Sam a couple days ago and we agreed the first task here is goin=
g
>> to be properly slicing them up somehow (the current state of affairs
>> is not a good model, even, from what he's told me).
>
> Understood :-) I'm quite sure this is out of my league.
>
>> I'm not saying the OSD is a bad plan, just that I'm not sure what ki=
nd
>> of useful tests we could produce by abstracting it =97 whereas the u=
nit
>> tests we can write against a PG seem a lot simpler and more obvious.=
 I
>> could well be missing something, though.
>
> I'll focus on writing PG tests. It will help me understand the detail=
s of PG / ReplicatedPG and eventually help with the necessary refactori=
ng.
>
> Thanks again for the guidance :-)
>
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
