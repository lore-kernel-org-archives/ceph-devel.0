From: Greg Farnum <gfarnum@redhat.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Thu, 12 Feb 2015 09:26:08 -0800
Message-ID: <AC814495-3C6B-492A-9E34-D45657FF7844@redhat.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com> <425811556.75315.1423234030246.JavaMail.zimbra@redhat.com> <CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com> <1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com> <CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbbBLR0L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 12:26:11 -0500
In-Reply-To: <CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry for the delayed response.

> On Feb 11, 2015, at 3:48 AM, Haomai Wang <haomaiwang@gmail.com> wrote=
:
>=20
> Hmm, I got it.
>=20
> There exists another problem I'm not sure whether captured by upper l=
ayer:
>=20
> two monitor node(A,B) connected with lossless_peer_reuse policy,
> 1. lots of messages has been transmitted....
> 2. markdown A

I don=E2=80=99t think monitors ever mark each other down?

> 3. restart A and call send_message(message will be in out_q)

oh, maybe you just mean rebooting it, not an interface thing, okay...

> 4. network error injected and A failed to build a *session* with B
> 5. because of policy and in_queue() =3D=3D true, we will reconnect in=
 "writer()"
> 6. connect_seq++ and try to reconnect

I think you=E2=80=99re wrong about this step. The messenger won=E2=80=99=
t increment connect_seq directly in writer() because it will be in STAT=
E_CONNECTING, so it just calls connect() directly.
connect() doesn=E2=80=99t increment the connect_seq unless it successfu=
lly finishes a session negotiation.

Unless I=E2=80=99m missing something? :)
-Greg

> 7. because of connect_seq !=3D 0, B can't detect remote reset and
> in_seq(a large value) will be exchange and cause A
> crashed(Pipe.cc:1154)
>=20
> So I guess we can't increase connect_seq when reconnecting? We need t=
o
> let peer side detect remote reset via connect_seq =3D=3D 0.
>=20
>=20
>=20
> On Tue, Feb 10, 2015 at 12:00 AM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
>> ----- Original Message -----
>>> From: "Haomai Wang" <haomaiwang@gmail.com>
>>> To: "Gregory Farnum" <gfarnum@redhat.com>
>>> Cc: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>>> Sent: Friday, February 6, 2015 8:16:42 AM
>>> Subject: Re: About in_seq, out_seq in Messenger
>>>=20
>>> On Fri, Feb 6, 2015 at 10:47 PM, Gregory Farnum <gfarnum@redhat.com=
> wrote:
>>>> ----- Original Message -----
>>>>> From: "Haomai Wang" <haomaiwang@gmail.com>
>>>>> To: "Sage Weil" <sweil@redhat.com>, "Gregory Farnum" <greg@inktan=
k.com>
>>>>> Cc: ceph-devel@vger.kernel.org
>>>>> Sent: Friday, February 6, 2015 12:26:18 AM
>>>>> Subject: About in_seq, out_seq in Messenger
>>>>>=20
>>>>> Hi all,
>>>>>=20
>>>>> Recently we enable a async messenger test job in test
>>>>> lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-master=
-distro-basic-multi/#).
>>>>> We hit many failed assert mostly are:
>>>>>              assert(0 =3D=3D "old msgs despite reconnect_seq feat=
ure");
>>>>>=20
>>>>> And assert connection all are cluster messenger which mean it's O=
SD
>>>>> internal connection. The policy associated this connection is
>>>>> Messenger::Policy::lossless_peer.
>>>>>=20
>>>>> So when I dive into this problem, I find something confusing abou=
t
>>>>> this. Suppose these steps:
>>>>> 1. "lossless_peer" policy is used by both two side connections.
>>>>> 2. markdown one side(anyway), peer connection will try to reconne=
ct
>>>>> 3. then we restart failed side, a new connection is built but
>>>>> initiator will think it's a old connection so sending in_seq(10)
>>>>> 4. new started connection has no message in queue and it will rec=
eive
>>>>> peer connection's in_seq(10) and call discard_requeued_up_to(10).=
 But
>>>>> because no message in queue, it won't modify anything
>>>>> 5. now any side issue a message, it will trigger "assert(0 =3D=3D=
 "old
>>>>> msgs despite reconnect_seq feature");"
>>>>>=20
>>>>> I can replay these steps in unittest and actually it's hit in tes=
t lab
>>>>> for async messenger which follows simple messenger's design.
>>>>>=20
>>>>> Besides, if we enable reset_check here, "was_session_reset" will =
be
>>>>> called and it will random out_seq, so it will certainly hit "asse=
rt(0
>>>>> =3D=3D "skipped incoming seq")".
>>>>>=20
>>>>> Anything wrong above?
>>>>=20
>>>> Sage covered most of this. I'll just add that the last time I chec=
ked it, I
>>>> came to the conclusion that the code to use a random out_seq on in=
itial
>>>> connect was non-functional. So there definitely may be issues ther=
e.
>>>>=20
>>>> In fact, we've fixed a couple (several?) bugs in this area since F=
irefly
>>>> was initially released, so if you go over the point release
>>>> SimpleMessenger patches you might gain some insight. :)
>>>> -Greg
>>>=20
>>> If we want to make random out_seq functional, I think we need to
>>> exchange "out_seq" when handshaking too. Otherwise, we need to give=
 it
>>> up.
>>=20
>> Possibly. Or maybe we just need to weaken our asserts to infer it on=
 initial messages?
>>=20
>>>=20
>>> Another question, do you think "reset_check=3Dtrue" is always good =
for
>>> osd internal connection?
>>=20
>> Huh? resetcheck is false for lossless peer connections.
>>=20
>>>=20
>>> Let Messenger rely on upper layer may not a good idea, so maybe we =
can
>>> enhance "in_seq" exchange process(ensure each side
>>> in_seq+sent.size()=3D=3Dout_seq). From the current handshake impl, =
it's
>>> not easy to insert more action to "in_seq" exchange process, becaus=
e
>>> this session has been built regardless of the result of "in_seq"
>>> process.
>>>=20
>>> If enable "reset_check=3Dtrue", it looks we can solve most of incor=
rect
>>> seq out-of-sync problem?
>>=20
>> Oh, I see what you mean.
>> Yeah, the problem here is a bit of a mismatch in the interfaces. OSD=
s are "lossless peers" with each other, they should not miss any messag=
es, and they don't ever go away. Except of course sometimes they do go =
away, if one of them dies. This is supposed to be handled by marking it=
 down, but it turns out the race conditions around that are a little la=
rger than we'd realized. Changing that abstraction in the other directi=
on by enabling reset is also difficult, as witnessed by our vacillating=
 around how to handle resets in the messenger code base. :/
>>=20
>> Anyway, you may not have seen http://tracker.ceph.com/issues/9555, w=
hich fixes the bug you're seeing here. It will be in the next Firefly p=
oint release. :)
>> -Greg
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
