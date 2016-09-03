From: Haomai Wang <haomai@xsky.com>
Subject: OOB message roll into Messenger interface
Date: Sun, 4 Sep 2016 00:01:38 +0800
Message-ID: <CACJqLyYuofjcwGgwRP09DjtZ77Hs9_-0eEmQkGf5ASjDits-og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0121.outbound.protection.outlook.com ([104.47.125.121]:23341
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753860AbcICQB6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 3 Sep 2016 12:01:58 -0400
Received: by mail-vk0-f48.google.com with SMTP id v189so48002713vkv.1
        for <ceph-devel@vger.kernel.org>; Sat, 03 Sep 2016 09:01:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Background:
Each osd has two heartbeat messenger instances to maintain front/back
network available. It brings lots of connections and messages overhead
in scale out cluster. Actually we can combine these heartbeat
exchanges to public/cluster messengers to reduce tons of
connections(resources).

Then heartbeat message should be OOB and shared the same thread/socket
with normal message channel. So it can exactly represent the heartbeat
role for real IO message. Otherwise, heartbeat channel's status can't
indicate the real IO message channel status. Because different socket
uses different send buffer/recv buffer, if real io message blocked,
oob message may be healthy.

Besides OSD's heartbeat things, we have logic PING/PONG lived in
Objecter Ping/WatchNotify Ping etc. For the same goal, they could
share the heartbeat message.

In a real rbd use case env, if we combines these ping/pong messages,
thousands of messages could be avoided which means lots of resources.

As we reduce the heartbeat overhead, we can reduce heartbeat interval
and increase frequency which help a lot to the accurate of cluster
failure detection!

Design:

As discussed in Raleigh, we could defines these interfaces:

int Connection::register_oob_message(identitfy_op, callback, interval);

Users like Objecter linger ping could register a "callback" which
generate bufferlist used to be carried by heartbeat message.
"interval" indicate the user's oob message's send interval.

"identitfy_op" indicates who can handle the oob info in peer side.
Like "Ping", "OSDPing" or "LingerPing" as the current message define.

void Dispatcher::ms_dispatch_oob(Message*)

handle the oob message with parsing each oob part.

So lots of timer control in user's side could be avoided via callback
generator. When sending, OOB message could insert the front of send
message queue but we can't get any help from kernel oob flag since
it's really useless..

Any suggestion is welcomed!
