From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Sat, 7 Feb 2015 00:16:42 +0800
Message-ID: <CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
	<425811556.75315.1423234030246.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:42115 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680AbbBFQQn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 11:16:43 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so3594015wid.2
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2015 08:16:42 -0800 (PST)
In-Reply-To: <425811556.75315.1423234030246.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 6, 2015 at 10:47 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> ----- Original Message -----
>> From: "Haomai Wang" <haomaiwang@gmail.com>
>> To: "Sage Weil" <sweil@redhat.com>, "Gregory Farnum" <greg@inktank.com>
>> Cc: ceph-devel@vger.kernel.org
>> Sent: Friday, February 6, 2015 12:26:18 AM
>> Subject: About in_seq, out_seq in Messenger
>>
>> Hi all,
>>
>> Recently we enable a async messenger test job in test
>> lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-master-distro-basic-multi/#).
>> We hit many failed assert mostly are:
>>               assert(0 == "old msgs despite reconnect_seq feature");
>>
>> And assert connection all are cluster messenger which mean it's OSD
>> internal connection. The policy associated this connection is
>> Messenger::Policy::lossless_peer.
>>
>> So when I dive into this problem, I find something confusing about
>> this. Suppose these steps:
>> 1. "lossless_peer" policy is used by both two side connections.
>> 2. markdown one side(anyway), peer connection will try to reconnect
>> 3. then we restart failed side, a new connection is built but
>> initiator will think it's a old connection so sending in_seq(10)
>> 4. new started connection has no message in queue and it will receive
>> peer connection's in_seq(10) and call discard_requeued_up_to(10). But
>> because no message in queue, it won't modify anything
>> 5. now any side issue a message, it will trigger "assert(0 == "old
>> msgs despite reconnect_seq feature");"
>>
>> I can replay these steps in unittest and actually it's hit in test lab
>> for async messenger which follows simple messenger's design.
>>
>> Besides, if we enable reset_check here, "was_session_reset" will be
>> called and it will random out_seq, so it will certainly hit "assert(0
>> == "skipped incoming seq")".
>>
>> Anything wrong above?
>
> Sage covered most of this. I'll just add that the last time I checked it, I came to the conclusion that the code to use a random out_seq on initial connect was non-functional. So there definitely may be issues there.
>
> In fact, we've fixed a couple (several?) bugs in this area since Firefly was initially released, so if you go over the point release SimpleMessenger patches you might gain some insight. :)
> -Greg

If we want to make random out_seq functional, I think we need to
exchange "out_seq" when handshaking too. Otherwise, we need to give it
up.

Another question, do you think "reset_check=true" is always good for
osd internal connection?

Let Messenger rely on upper layer may not a good idea, so maybe we can
enhance "in_seq" exchange process(ensure each side
in_seq+sent.size()==out_seq). From the current handshake impl, it's
not easy to insert more action to "in_seq" exchange process, because
this session has been built regardless of the result of "in_seq"
process.

If enable "reset_check=true", it looks we can solve most of incorrect
seq out-of-sync problem?

-- 
Best Regards,

Wheat
