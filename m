From: Ning Yao <zay11022@gmail.com>
Subject: Re: issue about the parameter 'paxos_propose_interval'
Date: Tue, 22 Nov 2016 01:42:17 +0800
Message-ID: <CALZt5jzThfAd0-cRr4jiVu8kA+kVx_FWiM63k9mj-YzARFcn-Q@mail.gmail.com>
References: <CAHRQ3VVecRDO1kf8BdtB6jd9rZVF+C42r8xDBYhjLvMoosMcng@mail.gmail.com>
 <alpine.DEB.2.11.1610101322230.18626@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35869 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbcKURmS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2016 12:42:18 -0500
Received: by mail-io0-f181.google.com with SMTP id x94so46296875ioi.3
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2016 09:42:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1610101322230.18626@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Songbo Wang <songbo1227@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

PR: https://github.com/ceph/ceph/pull/12107  for this issues.
Regards
Ning Yao


2016-10-10 21:23 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Sun, 9 Oct 2016, Songbo Wang wrote:
>> Hi, Sage, Sam
>>
>> I got a issue about the parameter 'paxos_propose_interval' with the
>> default value 1.0.
>>
>> I think this parameter aim to reduce the Monitor pressure to call the
>> propose_pending(). But, this introduces another problem, when a osd is
>> started,  it will send 3 kinds of requests to Monitor (e.g. MOSDBoot,
>> MOSDPGTemp, MOSDAlive). Without other changes, It will take 3 seconds
>> at least. which will increase the time that blocks the whole cluster.
>>
>> If the parameter 'paxos_propose_interval' is set to 0.05 or smaller,
>> it loses the propse it designed.
>>
>> I think we can introduce some special process, for some kinds of
>> messages (e.g. MOSDPGTemp, MOSDAlive), to process them immediately.
>
> Currently we essentially have two classes of messages: those that are
> processed immediately (no delay), and those that respect the
> paxos_propose_interval.  We can either introduce a second tunable and
> create a third class (process quickly) with something like .05, or we can
> say that all of the current 'no delay' messages should delay for a short
> period (like .05).
>
> Any preferences?
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
