From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Wed, 25 Feb 2015 13:19:01 -0800
Message-ID: <5FF0D640-8B5A-49BF-B6DA-F5684B011CCF@redhat.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com> <425811556.75315.1423234030246.JavaMail.zimbra@redhat.com> <CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com> <1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com> <CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com> <AC814495-3C6B-492A-9E34-D45657FF7844@redhat.com> <CACJqLyb=mEfnJmuC=yjkxozKaFtrEYtGiEdD+wTnyeOHxdPNXg@mail.gmail.com> <AF011BF6-7D9F-4DF7-9D4F-8005101014CA@redhat.com> <CACJqLyagOUrOe3Ch6s-bskL6s1SDd5aB_eWk0hhYhtURicNq=A@mail.gmail.com> <DD683B10-4819-4DBF-8591-1A00116002EE@redhat.com> <CACJqLya+73-X5+hq00hs302jSXjKEqvDsrt48g_RG2V2Cw4ccQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbbBYVTE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 16:19:04 -0500
In-Reply-To: <CACJqLya+73-X5+hq00hs302jSXjKEqvDsrt48g_RG2V2Cw4ccQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks good to me, but I haven=E2=80=99t looked at any of the messenger =
testing bits so I assigned it to Sage on Github. Also left a comment as=
king you to tag the actual bug fix commit for backports.
-Greg

> On Feb 25, 2015, at 9:40 AM, Haomai Wang <haomaiwang@gmail.com> wrote=
:
>=20
> https://github.com/ceph/ceph/pull/3797
>=20
> The assert failure is hard to reproduce for existing test suites
> because it's only happen when lossless_peer_reuse policy and it's har=
d
> to simulate the reproduce steps from upper layer.
>=20
> But we can easily reproduce this when do stress tests for Messenger, =
I
> added a inject-error stress test for lossless_peer_reuse policy, it
> can reproduce it easily
>=20
> On Wed, Feb 25, 2015 at 2:27 AM, Gregory Farnum <gfarnum@redhat.com> =
wrote:
>>=20
>>> On Feb 24, 2015, at 7:18 AM, Haomai Wang <haomaiwang@gmail.com> wro=
te:
>>>=20
>>> On Tue, Feb 24, 2015 at 12:04 AM, Greg Farnum <gfarnum@redhat.com> =
wrote:
>>>> On Feb 12, 2015, at 9:17 PM, Haomai Wang <haomaiwang@gmail.com> wr=
ote:
>>>>>=20
>>>>> On Fri, Feb 13, 2015 at 1:26 AM, Greg Farnum <gfarnum@redhat.com>=
 wrote:
>>>>>> Sorry for the delayed response.
>>>>>>=20
>>>>>>> On Feb 11, 2015, at 3:48 AM, Haomai Wang <haomaiwang@gmail.com>=
 wrote:
>>>>>>>=20
>>>>>>> Hmm, I got it.
>>>>>>>=20
>>>>>>> There exists another problem I'm not sure whether captured by u=
pper layer:
>>>>>>>=20
>>>>>>> two monitor node(A,B) connected with lossless_peer_reuse policy=
,
>>>>>>> 1. lots of messages has been transmitted....
>>>>>>> 2. markdown A
>>>>>>=20
>>>>>> I don=E2=80=99t think monitors ever mark each other down?
>>>>>>=20
>>>>>>> 3. restart A and call send_message(message will be in out_q)
>>>>>>=20
>>>>>> oh, maybe you just mean rebooting it, not an interface thing, ok=
ay...
>>>>>>=20
>>>>>>> 4. network error injected and A failed to build a *session* wit=
h B
>>>>>>> 5. because of policy and in_queue() =3D=3D true, we will reconn=
ect in "writer()"
>>>>>>> 6. connect_seq++ and try to reconnect
>>>>>>=20
>>>>>> I think you=E2=80=99re wrong about this step. The messenger won=E2=
=80=99t increment connect_seq directly in writer() because it will be i=
n STATE_CONNECTING, so it just calls connect() directly.
>>>>>> connect() doesn=E2=80=99t increment the connect_seq unless it su=
ccessfully finishes a session negotiation.
>>>>>=20
>>>>> Hmm, sorry. I checked log again. Actually A doesn't have any mess=
age
>>>>> in queue. So it will enter standby state and increase connect_seq=
=2E It
>>>>> will not be *STATE_CONNECTING*.
>>>>>=20
>>>>=20
>>>> Urgh, that case does seem broken, yes. I take it this is something=
 you=E2=80=99ve actually run across?
>>>>=20
>>>> It looks like that connect_seq++ was added by https://github.com/c=
eph/ceph/commit/0fc47e267b6f8dcd4511d887d5ad37d460374c25. Which makes m=
e think we might just be able to increment the connect_seq appropriatel=
y in the connect() function if we need to do so (on replacement, I assu=
me). Would you like to look at that and how this change might impact th=
e peer with regards to the referenced assert failure?
>>>>=20
>>>> -A very slow-to-reply and apologetic Greg
>>>=20
>>> Thanks to Greg!
>>>=20
>>> I looked at commit(https://github.com/ceph/ceph/commit/0fc47e267b6f=
8dcd4511d887d5ad37d460374c25#diff-500cebf3665775f2e77db1ff88255b9bR1553=
)
>>> and think it's useless now.
>>>=20
>>> When accepting and "connect.connect_seq =3D=3D existing->connect_se=
q",
>>> existing->state maybe STATE_OPEN, STATE_STANDBY or STANDY_CONNECTIN=
G.
>>> This commit only fix partial problem and want to assert
>>> "(existing->state =3D=3D STATE_CONNECTING)". So later we added code=
s to
>>> catch "(existing->state =3D=3D STATE_OPEN || existing->state =3D=3D
>>> STATE_STANDBY)" before asserting.
>>>=20
>>> So from my point, this commit is unnecessary now and we can drop th=
is commit.
>>>=20
>>> @sage, what do you think? Any other corner point this commit consid=
ered?
>>=20
>> Yeah, that looks right to me. Are you seeing this error frequently e=
nough to validate it in testing? We can run it through our suite as wel=
l of course, but the race is very narrow and I don=E2=80=99t think our =
current tests capture it anyway. :/
>> Maybe even a PR to enable testing on this kind of connection network=
 failure race? :)
>> -Greg
>>=20
>=20
>=20
>=20
> --=20
> Best Regards,
>=20
> Wheat

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
