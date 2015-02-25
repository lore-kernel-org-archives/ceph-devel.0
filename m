From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Thu, 26 Feb 2015 01:40:25 +0800
Message-ID: <CACJqLya+73-X5+hq00hs302jSXjKEqvDsrt48g_RG2V2Cw4ccQ@mail.gmail.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
	<425811556.75315.1423234030246.JavaMail.zimbra@redhat.com>
	<CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com>
	<1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com>
	<CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com>
	<AC814495-3C6B-492A-9E34-D45657FF7844@redhat.com>
	<CACJqLyb=mEfnJmuC=yjkxozKaFtrEYtGiEdD+wTnyeOHxdPNXg@mail.gmail.com>
	<AF011BF6-7D9F-4DF7-9D4F-8005101014CA@redhat.com>
	<CACJqLyagOUrOe3Ch6s-bskL6s1SDd5aB_eWk0hhYhtURicNq=A@mail.gmail.com>
	<DD683B10-4819-4DBF-8591-1A00116002EE@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35066 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbBYRk0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 12:40:26 -0500
Received: by pdbfl12 with SMTP id fl12so6384695pdb.2
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 09:40:25 -0800 (PST)
In-Reply-To: <DD683B10-4819-4DBF-8591-1A00116002EE@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

https://github.com/ceph/ceph/pull/3797

The assert failure is hard to reproduce for existing test suites
because it's only happen when lossless_peer_reuse policy and it's hard
to simulate the reproduce steps from upper layer.

But we can easily reproduce this when do stress tests for Messenger, I
added a inject-error stress test for lossless_peer_reuse policy, it
can reproduce it easily

On Wed, Feb 25, 2015 at 2:27 AM, Gregory Farnum <gfarnum@redhat.com> wr=
ote:
>
>> On Feb 24, 2015, at 7:18 AM, Haomai Wang <haomaiwang@gmail.com> wrot=
e:
>>
>> On Tue, Feb 24, 2015 at 12:04 AM, Greg Farnum <gfarnum@redhat.com> w=
rote:
>>> On Feb 12, 2015, at 9:17 PM, Haomai Wang <haomaiwang@gmail.com> wro=
te:
>>>>
>>>> On Fri, Feb 13, 2015 at 1:26 AM, Greg Farnum <gfarnum@redhat.com> =
wrote:
>>>>> Sorry for the delayed response.
>>>>>
>>>>>> On Feb 11, 2015, at 3:48 AM, Haomai Wang <haomaiwang@gmail.com> =
wrote:
>>>>>>
>>>>>> Hmm, I got it.
>>>>>>
>>>>>> There exists another problem I'm not sure whether captured by up=
per layer:
>>>>>>
>>>>>> two monitor node(A,B) connected with lossless_peer_reuse policy,
>>>>>> 1. lots of messages has been transmitted....
>>>>>> 2. markdown A
>>>>>
>>>>> I don=E2=80=99t think monitors ever mark each other down?
>>>>>
>>>>>> 3. restart A and call send_message(message will be in out_q)
>>>>>
>>>>> oh, maybe you just mean rebooting it, not an interface thing, oka=
y...
>>>>>
>>>>>> 4. network error injected and A failed to build a *session* with=
 B
>>>>>> 5. because of policy and in_queue() =3D=3D true, we will reconne=
ct in "writer()"
>>>>>> 6. connect_seq++ and try to reconnect
>>>>>
>>>>> I think you=E2=80=99re wrong about this step. The messenger won=E2=
=80=99t increment connect_seq directly in writer() because it will be i=
n STATE_CONNECTING, so it just calls connect() directly.
>>>>> connect() doesn=E2=80=99t increment the connect_seq unless it suc=
cessfully finishes a session negotiation.
>>>>
>>>> Hmm, sorry. I checked log again. Actually A doesn't have any messa=
ge
>>>> in queue. So it will enter standby state and increase connect_seq.=
 It
>>>> will not be *STATE_CONNECTING*.
>>>>
>>>
>>> Urgh, that case does seem broken, yes. I take it this is something =
you=E2=80=99ve actually run across?
>>>
>>> It looks like that connect_seq++ was added by https://github.com/ce=
ph/ceph/commit/0fc47e267b6f8dcd4511d887d5ad37d460374c25. Which makes me=
 think we might just be able to increment the connect_seq appropriately=
 in the connect() function if we need to do so (on replacement, I assum=
e). Would you like to look at that and how this change might impact the=
 peer with regards to the referenced assert failure?
>>>
>>> -A very slow-to-reply and apologetic Greg
>>
>> Thanks to Greg!
>>
>> I looked at commit(https://github.com/ceph/ceph/commit/0fc47e267b6f8=
dcd4511d887d5ad37d460374c25#diff-500cebf3665775f2e77db1ff88255b9bR1553)
>> and think it's useless now.
>>
>> When accepting and "connect.connect_seq =3D=3D existing->connect_seq=
",
>> existing->state maybe STATE_OPEN, STATE_STANDBY or STANDY_CONNECTING=
=2E
>> This commit only fix partial problem and want to assert
>> "(existing->state =3D=3D STATE_CONNECTING)". So later we added codes=
 to
>> catch "(existing->state =3D=3D STATE_OPEN || existing->state =3D=3D
>> STATE_STANDBY)" before asserting.
>>
>> So from my point, this commit is unnecessary now and we can drop thi=
s commit.
>>
>> @sage, what do you think? Any other corner point this commit conside=
red?
>
> Yeah, that looks right to me. Are you seeing this error frequently en=
ough to validate it in testing? We can run it through our suite as well=
 of course, but the race is very narrow and I don=E2=80=99t think our c=
urrent tests capture it anyway. :/
> Maybe even a PR to enable testing on this kind of connection network =
failure race? :)
> -Greg
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
