From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Sat, 7 Feb 2015 00:00:43 +0800
Message-ID: <CACJqLybjQQOWqh_r+3VNAgqy=rMFazmV37Vz=SokHU0-7DRUhw@mail.gmail.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
	<alpine.DEB.2.00.1502060134260.27042@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53206 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbbBFQAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 11:00:44 -0500
Received: by mail-wi0-f176.google.com with SMTP id bs8so3553383wib.3
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2015 08:00:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502060134260.27042@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 6, 2015 at 5:40 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 6 Feb 2015, Haomai Wang wrote:
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
>
> The way this case is normally handled is one layer up.  The messenger
> doesn't know at that level whether it is seeing a bug or whether someone
> it marked down and forgot about doesn't know it is dead and is trying to
> reconnect.
>
> In OSD.cc, we have a check in require_same_or_newer_map that will defer
> the Message if the other end is newer than us.  If we are newer (as would
> be the case if we marked down the peer and they don't realize they are
> dead) then require_same_peer_instance() will catch it and mark_down(),
> again throwing out all of our state about the old osd session.
>
>> 5. now any side issue a message, it will trigger "assert(0 == "old
>> msgs despite reconnect_seq feature");"
>
> IIRC the above checks ensure that we mark_down the connection before we
> send a message on the old session.  (Or, SimpleMessenger doesn't assert; I
> forget which, sorry.)
>
>> I can replay these steps in unittest and actually it's hit in test lab
>> for async messenger which follows simple messenger's design.
>>
>> Besides, if we enable reset_check here, "was_session_reset" will be
>> called and it will random out_seq, so it will certainly hit "assert(0
>> == "skipped incoming seq")".
>>
>> Anything wrong above?
>
> What happens when you run the unit test against SimpleMessenger?

You can just run "./ceph_test_msgr --gtest_filter="*Inject*/1"
--ms_die_on_skipped_message=true" got assert failure.

It's just because of random seq.

>
> sage
>
>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



-- 
Best Regards,

Wheat
