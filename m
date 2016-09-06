From: Sage Weil <sage@newdream.net>
Subject: Re: OOB message roll into Messenger interface
Date: Tue, 6 Sep 2016 13:17:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609061314440.24099@piezo.us.to>
References: <CACJqLyYuofjcwGgwRP09DjtZ77Hs9_-0eEmQkGf5ASjDits-og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37101 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935017AbcIFNRr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 09:17:47 -0400
In-Reply-To: <CACJqLyYuofjcwGgwRP09DjtZ77Hs9_-0eEmQkGf5ASjDits-og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Haomai!

On Sun, 4 Sep 2016, Haomai Wang wrote:
> Background:
> Each osd has two heartbeat messenger instances to maintain front/back
> network available. It brings lots of connections and messages overhead
> in scale out cluster. Actually we can combine these heartbeat
> exchanges to public/cluster messengers to reduce tons of
> connections(resources).
> 
> Then heartbeat message should be OOB and shared the same thread/socket
> with normal message channel. So it can exactly represent the heartbeat
> role for real IO message. Otherwise, heartbeat channel's status can't
> indicate the real IO message channel status. Because different socket
> uses different send buffer/recv buffer, if real io message blocked,
> oob message may be healthy.
> 
> Besides OSD's heartbeat things, we have logic PING/PONG lived in
> Objecter Ping/WatchNotify Ping etc. For the same goal, they could
> share the heartbeat message.
> 
> In a real rbd use case env, if we combines these ping/pong messages,
> thousands of messages could be avoided which means lots of resources.
> 
> As we reduce the heartbeat overhead, we can reduce heartbeat interval
> and increase frequency which help a lot to the accurate of cluster
> failure detection!

I'm very excited to see this move forward!
 
> Design:
> 
> As discussed in Raleigh, we could defines these interfaces:
> 
> int Connection::register_oob_message(identitfy_op, callback, interval);
> 
> Users like Objecter linger ping could register a "callback" which
> generate bufferlist used to be carried by heartbeat message.
> "interval" indicate the user's oob message's send interval.
> 
> "identitfy_op" indicates who can handle the oob info in peer side.
> Like "Ping", "OSDPing" or "LingerPing" as the current message define.

This looks convenient for the simpler callers, but I worry it won't work 
as well for OSDPing. There's a bunch of odd locking around the heartbeat 
info and the code already exists to do the the heartbeat sends.  I'm not 
sure it will simplify to a simple interval.

An easier first step would be to just define a 
Connection::send_message_oob(Message*).  That would require almost no 
changes to the calling code, and avoid having to create the timing 
infrastructure inside AsyncMessenger...

sage

> void Dispatcher::ms_dispatch_oob(Message*)
> 
> handle the oob message with parsing each oob part.
> 
> So lots of timer control in user's side could be avoided via callback
> generator. When sending, OOB message could insert the front of send
> message queue but we can't get any help from kernel oob flag since
> it's really useless..
> 
> Any suggestion is welcomed!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
