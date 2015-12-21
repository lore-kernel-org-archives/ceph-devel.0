From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Re: Client still connect failed leader after that mon down
Date: Mon, 21 Dec 2015 10:55:14 +0800
Message-ID: <CAGkCoNKYiJ+KWEg7w-JAF9tq+X9LtWV5X2OJcEp81yF9+Y4W2g@mail.gmail.com>
References: <CAKZcxgeK8=au4yBxcsP+=ewtFr8_ruZCxUKJtWWSk6eGc-b8Ow@mail.gmail.com>
 <alpine.DEB.2.00.1512170525540.10312@cobra.newdream.net> <56738059.3070505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35232 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbLUCzy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Dec 2015 21:55:54 -0500
Received: by mail-wm0-f41.google.com with SMTP id l126so51227913wml.0
        for <ceph-devel@vger.kernel.org>; Sun, 20 Dec 2015 18:55:54 -0800 (PST)
In-Reply-To: <56738059.3070505@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Jaze Lee <jazeltq@gmail.com>, ceph-devel@vger.kernel.org

Which msg type and ceph version are you using?

Once we used 0.94.1 with async msg, we encountered similar issue.
Client was trying to connect a down monitor when it was just started
and this connection would hung there. This is because previous async
msg used blocking connection mode.

After we back ported non-blocking mode of async msg from higher ceph
version, we haven't encountered such issue yet.


Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com


On Fri, Dec 18, 2015 at 11:41 AM, Jevon Qiao <scaleqiao@gmail.com> wrote:
> On 17/12/15 21:27, Sage Weil wrote:
>>
>> On Thu, 17 Dec 2015, Jaze Lee wrote:
>>>
>>> Hello cephers:
>>>      In our test, there are three monitors. We find client run ceph
>>> command will slow when the leader mon is down. Even after long time, a
>>> client run ceph command will also slow in first time.
>>> >From strace, we find that the client first to connect the leader, then
>>> after 3s, it connect the second.
>>> After some search we find that the quorum is not change, the leader is
>>> still the down monitor.
>>> Is that normal?  Or is there something i miss?
>>
>> It's normal.  Even when the quorum does change, the client doesn't
>> know that.  It should be contacting a random mon on startup, though, so I
>> would expect the 3s delay 1/3 of the time.
>
> That's because client randomly picks up a mon from Monmap. But what we
> observed is that when a mon is down no change is made to monmap(neither the
> epoch nor the members). Is it the culprit for this phenomenon?
>
> Thanks,
> Jevon
>
>> A long-standing low-priority feature request is to have the client contact
>> 2 mons in parallel so that it can still connect quickly if one is down.
>> It's requires some non-trivial work in mon/MonClient.{cc,h} though and I
>> don't think anyone has looked at it seriously.
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
