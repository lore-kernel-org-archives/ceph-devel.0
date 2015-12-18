From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: Client still connect failed leader after that mon down
Date: Fri, 18 Dec 2015 11:41:13 +0800
Message-ID: <56738059.3070505@gmail.com>
References: <CAKZcxgeK8=au4yBxcsP+=ewtFr8_ruZCxUKJtWWSk6eGc-b8Ow@mail.gmail.com>
 <alpine.DEB.2.00.1512170525540.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35689 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbbLRDlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 22:41:25 -0500
Received: by mail-pf0-f169.google.com with SMTP id v86so41610173pfa.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 19:41:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512170525540.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 17/12/15 21:27, Sage Weil wrote:
> On Thu, 17 Dec 2015, Jaze Lee wrote:
>> Hello cephers:
>>      In our test, there are three monitors. We find client run ceph
>> command will slow when the leader mon is down. Even after long time, a
>> client run ceph command will also slow in first time.
>> >From strace, we find that the client first to connect the leader, then
>> after 3s, it connect the second.
>> After some search we find that the quorum is not change, the leader is
>> still the down monitor.
>> Is that normal?  Or is there something i miss?
> It's normal.  Even when the quorum does change, the client doesn't
> know that.  It should be contacting a random mon on startup, though, so I
> would expect the 3s delay 1/3 of the time.
That's because client randomly picks up a mon from Monmap. But what we 
observed is that when a mon is down no change is made to monmap(neither 
the epoch nor the members). Is it the culprit for this phenomenon?

Thanks,
Jevon
> A long-standing low-priority feature request is to have the client contact
> 2 mons in parallel so that it can still connect quickly if one is down.
> It's requires some non-trivial work in mon/MonClient.{cc,h} though and I
> don't think anyone has looked at it seriously.
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

