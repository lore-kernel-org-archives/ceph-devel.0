From: Sage Weil <sage@newdream.net>
Subject: Re: OOB message roll into Messenger interface
Date: Tue, 6 Sep 2016 14:06:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609061400550.31624@piezo.us.to>
References: <CACJqLyYuofjcwGgwRP09DjtZ77Hs9_-0eEmQkGf5ASjDits-og@mail.gmail.com> <alpine.DEB.2.11.1609061314440.24099@piezo.us.to> <CACJqLyZwMyYK5C1kigG+r8KBe4QwYN6z0+jBpnE8a+aaebnGzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37460 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756394AbcIFOGI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 10:06:08 -0400
In-Reply-To: <CACJqLyZwMyYK5C1kigG+r8KBe4QwYN6z0+jBpnE8a+aaebnGzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 6 Sep 2016, Haomai Wang wrote:
> On Tue, Sep 6, 2016 at 9:17 PM, Sage Weil <sage@newdream.net> wrote:
> > Hi Haomai!
> >
> > On Sun, 4 Sep 2016, Haomai Wang wrote:
> >> Background:
> >> Each osd has two heartbeat messenger instances to maintain front/back
> >> network available. It brings lots of connections and messages overhead
> >> in scale out cluster. Actually we can combine these heartbeat
> >> exchanges to public/cluster messengers to reduce tons of
> >> connections(resources).
> >>
> >> Then heartbeat message should be OOB and shared the same thread/socket
> >> with normal message channel. So it can exactly represent the heartbeat
> >> role for real IO message. Otherwise, heartbeat channel's status can't
> >> indicate the real IO message channel status. Because different socket
> >> uses different send buffer/recv buffer, if real io message blocked,
> >> oob message may be healthy.
> >>
> >> Besides OSD's heartbeat things, we have logic PING/PONG lived in
> >> Objecter Ping/WatchNotify Ping etc. For the same goal, they could
> >> share the heartbeat message.
> >>
> >> In a real rbd use case env, if we combines these ping/pong messages,
> >> thousands of messages could be avoided which means lots of resources.
> >>
> >> As we reduce the heartbeat overhead, we can reduce heartbeat interval
> >> and increase frequency which help a lot to the accurate of cluster
> >> failure detection!
> >
> > I'm very excited to see this move forward!
> >
> >> Design:
> >>
> >> As discussed in Raleigh, we could defines these interfaces:
> >>
> >> int Connection::register_oob_message(identitfy_op, callback, interval);
> >>
> >> Users like Objecter linger ping could register a "callback" which
> >> generate bufferlist used to be carried by heartbeat message.
> >> "interval" indicate the user's oob message's send interval.
> >>
> >> "identitfy_op" indicates who can handle the oob info in peer side.
> >> Like "Ping", "OSDPing" or "LingerPing" as the current message define.
> >
> > This looks convenient for the simpler callers, but I worry it won't work
> > as well for OSDPing. There's a bunch of odd locking around the heartbeat
> > info and the code already exists to do the the heartbeat sends.  I'm not
> > sure it will simplify to a simple interval.
> 
> Hmm, I'm not sure what's the odd locking thing refer to. As we can
> register callback when adding new peer and unregister callback when
> removing peer from "heartbeat_peers".
> 
> The main send message construct callback extract from this loop:
>   for (map<int,HeartbeatInfo>::iterator i = heartbeat_peers.begin();
>        i != heartbeat_peers.end();
>        ++i) {
>     int peer = i->first;
>     i->second.last_tx = now;
>     if (i->second.first_tx == utime_t())
>       i->second.first_tx = now;
>     dout(30) << "heartbeat sending ping to osd." << peer << dendl;
>     i->second.con_back->send_message(new MOSDPing(monc->get_fsid(),
>  service.get_osdmap()->get_epoch(),
>  MOSDPing::PING,
>  now));
> 
>     if (i->second.con_front)
>       i->second.con_front->send_message(new MOSDPing(monc->get_fsid(),
>     service.get_osdmap()->get_epoch(),
>     MOSDPing::PING,
>     now));
>   }
> 
> Only "fsid", "osdmap epoch" are required, I don't think it will block.
> Then I think lots of locking/odding things exists on heartbeat
> dispatch/handle process. sending process is clear I guess.

Yeah, I guess that's fine.  I was worried about some dependency between 
who we ping and the osdmap epoch in the message (and races adding/removing 
heartbeat peers), but I think it doesn't matter.

Even so, I think it would be good to expose the send_message_oob() 
interface, and do this in 2 stages so the two changes are decoupled.  
Unless there is some implementation reason why the oob message scheduling 
needs to be done inside the messenger?

sage

> The advantage to register callback is we can combine multi layers oob
> messages to one.
> 
> >
> > An easier first step would be to just define a
> > Connection::send_message_oob(Message*).  That would require almost no
> > changes to the calling code, and avoid having to create the timing
> > infrastructure inside AsyncMessenger...
> >
> > sage
> >
> >> void Dispatcher::ms_dispatch_oob(Message*)
> >>
> >> handle the oob message with parsing each oob part.
> >>
> >> So lots of timer control in user's side could be avoided via callback
> >> generator. When sending, OOB message could insert the front of send
> >> message queue but we can't get any help from kernel oob flag since
> >> it's really useless..
> >>
> >> Any suggestion is welcomed!
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
