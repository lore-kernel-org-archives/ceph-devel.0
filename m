From: Haomai Wang <haomai@xsky.com>
Subject: Re: OOB message roll into Messenger interface
Date: Wed, 7 Sep 2016 10:43:29 +0800
Message-ID: <CACJqLybCz4UCa+=2GMUKQXoeQcToyELULSVDRAhagVX0fXERFg@mail.gmail.com>
References: <CACJqLyYuofjcwGgwRP09DjtZ77Hs9_-0eEmQkGf5ASjDits-og@mail.gmail.com>
 <alpine.DEB.2.11.1609061314440.24099@piezo.us.to> <CACJqLyZwMyYK5C1kigG+r8KBe4QwYN6z0+jBpnE8a+aaebnGzw@mail.gmail.com>
 <alpine.DEB.2.11.1609061400550.31624@piezo.us.to> <CACJqLyawmL0YVoeX_n8L2W-n+TZKVHYJmSU9=jD0S=Q4csuY3w@mail.gmail.com>
 <CAJ4mKGbt_-Qg06TjEJLD3TGn-M24BgAsKNgoxRzx55pT=rZweg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0123.outbound.protection.outlook.com ([104.47.125.123]:14569
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932768AbcIGCnq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Sep 2016 22:43:46 -0400
Received: by mail-ua0-f171.google.com with SMTP id 71so1997478uag.2
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 19:43:35 -0700 (PDT)
In-Reply-To: <CAJ4mKGbt_-Qg06TjEJLD3TGn-M24BgAsKNgoxRzx55pT=rZweg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 7, 2016 at 1:42 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Sep 6, 2016 at 7:15 AM, Haomai Wang <haomai@xsky.com> wrote:
>> On Tue, Sep 6, 2016 at 10:06 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Tue, 6 Sep 2016, Haomai Wang wrote:
>>>> On Tue, Sep 6, 2016 at 9:17 PM, Sage Weil <sage@newdream.net> wrote:
>>>> > Hi Haomai!
>>>> >
>>>> > On Sun, 4 Sep 2016, Haomai Wang wrote:
>>>> >> Background:
>>>> >> Each osd has two heartbeat messenger instances to maintain front/ba=
ck
>>>> >> network available. It brings lots of connections and messages overh=
ead
>>>> >> in scale out cluster. Actually we can combine these heartbeat
>>>> >> exchanges to public/cluster messengers to reduce tons of
>>>> >> connections(resources).
>>>> >>
>>>> >> Then heartbeat message should be OOB and shared the same thread/soc=
ket
>>>> >> with normal message channel. So it can exactly represent the heartb=
eat
>>>> >> role for real IO message. Otherwise, heartbeat channel's status can=
't
>>>> >> indicate the real IO message channel status. Because different sock=
et
>>>> >> uses different send buffer/recv buffer, if real io message blocked,
>>>> >> oob message may be healthy.
>>>> >>
>>>> >> Besides OSD's heartbeat things, we have logic PING/PONG lived in
>>>> >> Objecter Ping/WatchNotify Ping etc. For the same goal, they could
>>>> >> share the heartbeat message.
>>>> >>
>>>> >> In a real rbd use case env, if we combines these ping/pong messages=
,
>>>> >> thousands of messages could be avoided which means lots of resource=
s.
>>>> >>
>>>> >> As we reduce the heartbeat overhead, we can reduce heartbeat interv=
al
>>>> >> and increase frequency which help a lot to the accurate of cluster
>>>> >> failure detection!
>>>> >
>>>> > I'm very excited to see this move forward!
>>>> >
>>>> >> Design:
>>>> >>
>>>> >> As discussed in Raleigh, we could defines these interfaces:
>>>> >>
>>>> >> int Connection::register_oob_message(identitfy_op, callback, interv=
al);
>>>> >>
>>>> >> Users like Objecter linger ping could register a "callback" which
>>>> >> generate bufferlist used to be carried by heartbeat message.
>>>> >> "interval" indicate the user's oob message's send interval.
>>>> >>
>>>> >> "identitfy_op" indicates who can handle the oob info in peer side.
>>>> >> Like "Ping", "OSDPing" or "LingerPing" as the current message defin=
e.
>>>> >
>>>> > This looks convenient for the simpler callers, but I worry it won't =
work
>>>> > as well for OSDPing. There's a bunch of odd locking around the heart=
beat
>>>> > info and the code already exists to do the the heartbeat sends.  I'm=
 not
>>>> > sure it will simplify to a simple interval.
>>>>
>>>> Hmm, I'm not sure what's the odd locking thing refer to. As we can
>>>> register callback when adding new peer and unregister callback when
>>>> removing peer from "heartbeat_peers".
>>>>
>>>> The main send message construct callback extract from this loop:
>>>>   for (map<int,HeartbeatInfo>::iterator i =3D heartbeat_peers.begin();
>>>>        i !=3D heartbeat_peers.end();
>>>>        ++i) {
>>>>     int peer =3D i->first;
>>>>     i->second.last_tx =3D now;
>>>>     if (i->second.first_tx =3D=3D utime_t())
>>>>       i->second.first_tx =3D now;
>>>>     dout(30) << "heartbeat sending ping to osd." << peer << dendl;
>>>>     i->second.con_back->send_message(new MOSDPing(monc->get_fsid(),
>>>>  service.get_osdmap()->get_epoch(),
>>>>  MOSDPing::PING,
>>>>  now));
>>>>
>>>>     if (i->second.con_front)
>>>>       i->second.con_front->send_message(new MOSDPing(monc->get_fsid(),
>>>>     service.get_osdmap()->get_epoch(),
>>>>     MOSDPing::PING,
>>>>     now));
>>>>   }
>>>>
>>>> Only "fsid", "osdmap epoch" are required, I don't think it will block.
>>>> Then I think lots of locking/odding things exists on heartbeat
>>>> dispatch/handle process. sending process is clear I guess.
>>>
>>> Yeah, I guess that's fine.  I was worried about some dependency between
>>> who we ping and the osdmap epoch in the message (and races adding/remov=
ing
>>> heartbeat peers), but I think it doesn't matter.
>>>
>>> Even so, I think it would be good to expose the send_message_oob()
>>> interface, and do this in 2 stages so the two changes are decoupled.
>>> Unless there is some implementation reason why the oob message scheduli=
ng
>>> needs to be done inside the messenger?
>>
>> Agreed! we could remove heartbeat messenger firstly!
>>
>>>
>>> sage
>>>
>>>> The advantage to register callback is we can combine multi layers oob
>>>> messages to one.
>>>>
>>>> >
>>>> > An easier first step would be to just define a
>>>> > Connection::send_message_oob(Message*).  That would require almost n=
o
>>>> > changes to the calling code, and avoid having to create the timing
>>>> > infrastructure inside AsyncMessenger...
>>>> >
>>>> > sage
>>>> >
>>>> >> void Dispatcher::ms_dispatch_oob(Message*)
>>>> >>
>>>> >> handle the oob message with parsing each oob part.
>>>> >>
>>>> >> So lots of timer control in user's side could be avoided via callba=
ck
>>>> >> generator. When sending, OOB message could insert the front of send
>>>> >> message queue but we can't get any help from kernel oob flag since
>>>> >> it's really useless..
>>>> >>
>>>> >> Any suggestion is welcomed!
>
> Let's keep in mind the challenges of out-of-band messaging over TCP/IP.
>
> Namely, when we discussed this we couldn't figure out any way
> (including the TCP priority stuff, which doesn't work with the
> required semantics =E2=80=94 even when it does function) to get traffic t=
o
> actually go out-of-band. IB messaging systems actually have a
> "channels" concept that lets you do genuine OOB transmission that
> skips over queues and other data; TCP doesn't. In fact the best we
> came up with for doing this with Simple/AsyncMessenger was giving the
> Messenger duplicate sockets/queues/etc, which is hardly ideal.

hmm, I also think about oob message may not deliver when the socket is
busy,  do we consider to add oob udp socket associated to
Connection(hb msg should be lossy, so we don't need to handle errors).
So in the upper layer, we don't explicit maintain heartbeat
connection. I can see we can achieve the same goal mentioned above.

Then when we target to msgr v2, we still want to move heartbeat logic
to messenger layer to aggregate hb msg in multi entity case.

>
> So, maybe we can remove the heartbeat messenger by giving each
> Connection two sockets and queues. That might even work better for the
> AsyncMessenger than it does for SimpleMessenger?

actually asyncmessenger also plays a lightweight role compared to
simplemessenger, so we may not need to do this.

> But any implementation that orders OSD heartbeat messages behind
> ordinary data traffic in kernel or router buffers is probably going to
> fail us. :(
> -Greg
