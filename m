From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Ceph Developer Summit - Oct 28-29
Date: Tue, 28 Oct 2014 07:31:21 -0700
Message-ID: <CABBk=J9vpqveMH8pYc8ppJZK0b2d60zWBitGxGoEiLwEM18ORg@mail.gmail.com>
References: <CAP8Oy=KeYryUPO5y-HxUGw3qaccr0XkPSP+6CsYh=DHGsRqFzw@mail.gmail.com>
	<BLU175-W363F2FE6846A790EBFC393DF9F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:50808 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaJ1ObW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 10:31:22 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so762354ieb.22
        for <ceph-devel@vger.kernel.org>; Tue, 28 Oct 2014 07:31:21 -0700 (PDT)
In-Reply-To: <BLU175-W363F2FE6846A790EBFC393DF9F0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: Patrick McGarry <patrick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, the idea was to discuss the feature, the decisions that were
made, and the status. Also, we're now only in phase 1, it might be a
good idea to start thinking about the next phase, where bucket
sharding will be done automatically.

Yehuda


On Tue, Oct 28, 2014 at 6:33 AM, GuangYang <yguang11@outlook.com> wrote:
> Hi Patrick,
> Sorry I am not able to join today's session for the bucket index scalability. I am working with Yehuda to polish the implementation according to our discussion in last CDS, and hopefully we will merge the patch soon. There is not much update (in terms of what we will implement and how we implement them) after last discussion so that I think it is fine to skip the session.
>
> Yehuda,
> Please correct me here if I am wrong.
>
> Thanks,
> Guang
>
> ----------------------------------------
>> Date: Wed, 22 Oct 2014 13:13:17 -0400
>> Subject: Ceph Developer Summit - Oct 28-29
>> From: patrick@inktank.com
>> To: ceph-users@ceph.com; ceph-devel@vger.kernel.org; ceph-community@lists.ceph.com
>>
>> Greetings cephalofolks,
>>
>> As I'm sure many of you have seen, the schedule for the upcoming
>> virtual Ceph Developer Summit has been posted:
>>
>> https://wiki.ceph.com/Planning/CDS/Hammer_(Oct_2014)
>>
>> As usual we have a EMEA friendly day and an APAC friendly day with the
>> sessions being distributed across each day that include the blueprint
>> authors and interested parties. If you are unable to attend a session
>> that you are interested in please be sure to add your
>> comments/questions to the etherpad in question (with your name) so
>> that those concerns can be addressed during the discussion.
>>
>> All sessions will be recorded for later perusal if you are unable to attend.
>>
>> If you have any questions, comments, or concerns, feel free to email
>> me directly. Thanks, and see you all there!
>>
>>
>> Best Regards,
>>
>> Patrick McGarry
>> Director Ceph Community || Red Hat
>> http://ceph.com || http://community.redhat.com
>> @scuttlemonkey || @ceph
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
