From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Wed, 11 Feb 2015 19:48:32 +0800
Message-ID: <CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
	<425811556.75315.1423234030246.JavaMail.zimbra@redhat.com>
	<CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com>
	<1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43657 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbBKLsd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 06:48:33 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so16337506wid.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 03:48:32 -0800 (PST)
In-Reply-To: <1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hmm, I got it.

There exists another problem I'm not sure whether captured by upper layer:

two monitor node(A,B) connected with lossless_peer_reuse policy,
1. lots of messages has been transmitted....
2. markdown A
3. restart A and call send_message(message will be in out_q)
4. network error injected and A failed to build a *session* with B
5. because of policy and in_queue() == true, we will reconnect in "writer()"
6. connect_seq++ and try to reconnect
7. because of connect_seq != 0, B can't detect remote reset and
in_seq(a large value) will be exchange and cause A
crashed(Pipe.cc:1154)

So I guess we can't increase connect_seq when reconnecting? We need to
let peer side detect remote reset via connect_seq == 0.



On Tue, Feb 10, 2015 at 12:00 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> ----- Original Message -----
>> From: "Haomai Wang" <haomaiwang@gmail.com>
>> To: "Gregory Farnum" <gfarnum@redhat.com>
>> Cc: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>> Sent: Friday, February 6, 2015 8:16:42 AM
>> Subject: Re: About in_seq, out_seq in Messenger
>>
>> On Fri, Feb 6, 2015 at 10:47 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> > ----- Original Message -----
>> >> From: "Haomai Wang" <haomaiwang@gmail.com>
>> >> To: "Sage Weil" <sweil@redhat.com>, "Gregory Farnum" <greg@inktank.com>
>> >> Cc: ceph-devel@vger.kernel.org
>> >> Sent: Friday, February 6, 2015 12:26:18 AM
>> >> Subject: About in_seq, out_seq in Messenger
>> >>
>> >> Hi all,
>> >>
>> >> Recently we enable a async messenger test job in test
>> >> lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-master-distro-basic-multi/#).
>> >> We hit many failed assert mostly are:
>> >>               assert(0 == "old msgs despite reconnect_seq feature");
>> >>
>> >> And assert connection all are cluster messenger which mean it's OSD
>> >> internal connection. The policy associated this connection is
>> >> Messenger::Policy::lossless_peer.
>> >>
>> >> So when I dive into this problem, I find something confusing about
>> >> this. Suppose these steps:
>> >> 1. "lossless_peer" policy is used by both two side connections.
>> >> 2. markdown one side(anyway), peer connection will try to reconnect
>> >> 3. then we restart failed side, a new connection is built but
>> >> initiator will think it's a old connection so sending in_seq(10)
>> >> 4. new started connection has no message in queue and it will receive
>> >> peer connection's in_seq(10) and call discard_requeued_up_to(10). But
>> >> because no message in queue, it won't modify anything
>> >> 5. now any side issue a message, it will trigger "assert(0 == "old
>> >> msgs despite reconnect_seq feature");"
>> >>
>> >> I can replay these steps in unittest and actually it's hit in test lab
>> >> for async messenger which follows simple messenger's design.
>> >>
>> >> Besides, if we enable reset_check here, "was_session_reset" will be
>> >> called and it will random out_seq, so it will certainly hit "assert(0
>> >> == "skipped incoming seq")".
>> >>
>> >> Anything wrong above?
>> >
>> > Sage covered most of this. I'll just add that the last time I checked it, I
>> > came to the conclusion that the code to use a random out_seq on initial
>> > connect was non-functional. So there definitely may be issues there.
>> >
>> > In fact, we've fixed a couple (several?) bugs in this area since Firefly
>> > was initially released, so if you go over the point release
>> > SimpleMessenger patches you might gain some insight. :)
>> > -Greg
>>
>> If we want to make random out_seq functional, I think we need to
>> exchange "out_seq" when handshaking too. Otherwise, we need to give it
>> up.
>
> Possibly. Or maybe we just need to weaken our asserts to infer it on initial messages?
>
>>
>> Another question, do you think "reset_check=true" is always good for
>> osd internal connection?
>
> Huh? resetcheck is false for lossless peer connections.
>
>>
>> Let Messenger rely on upper layer may not a good idea, so maybe we can
>> enhance "in_seq" exchange process(ensure each side
>> in_seq+sent.size()==out_seq). From the current handshake impl, it's
>> not easy to insert more action to "in_seq" exchange process, because
>> this session has been built regardless of the result of "in_seq"
>> process.
>>
>> If enable "reset_check=true", it looks we can solve most of incorrect
>> seq out-of-sync problem?
>
> Oh, I see what you mean.
> Yeah, the problem here is a bit of a mismatch in the interfaces. OSDs are "lossless peers" with each other, they should not miss any messages, and they don't ever go away. Except of course sometimes they do go away, if one of them dies. This is supposed to be handled by marking it down, but it turns out the race conditions around that are a little larger than we'd realized. Changing that abstraction in the other direction by enabling reset is also difficult, as witnessed by our vacillating around how to handle resets in the messenger code base. :/
>
> Anyway, you may not have seen http://tracker.ceph.com/issues/9555, which fixes the bug you're seeing here. It will be in the next Firefly point release. :)
> -Greg



-- 
Best Regards,

Wheat
