From: Dong Wu <archer.wudong@gmail.com>
Subject: Re: OSDs marked OUT wrongly after monitor failover
Date: Thu, 27 Oct 2016 11:01:27 +0800
Message-ID: <CAAL-TMdpTocq18ezERvbZL+VOWU-=emQ-3g9xDWj_V_aUWYc0g@mail.gmail.com>
References: <CAOb-7Ewpqg1XhCE5HY2P0HcFaZi8CLOzAy=KAFTqisWYiuJXdg@mail.gmail.com>
 <CAOb-7ExV5fSBvkoPid5jvKXOZN2kvbzUAYT2oqpbXZx2+5iYtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34622 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932882AbcJ0DB3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 23:01:29 -0400
Received: by mail-ua0-f178.google.com with SMTP id 51so619763uai.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 20:01:29 -0700 (PDT)
In-Reply-To: <CAOb-7ExV5fSBvkoPid5jvKXOZN2kvbzUAYT2oqpbXZx2+5iYtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ridge Chen <ridge.chen@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

we can easily reproduce:
1. stop osd.0;
2. start osd.0;
3. wait mon_osd_down_out_interval time, eg:300s;
4. stop osd.0;
5. stop monA(leader);
6. monB won the election, becomes the leader, and then osd.0 is marked out.

2016-10-27 10:48 GMT+08:00 Ridge Chen <ridge.chen@gmail.com>:
> I also raised a bug report: http://tracker.ceph.com/issues/17719
>
> 2016-10-27 10:36 GMT+08:00 Ridge Chen <ridge.chen@gmail.com>:
>> Hi Experts,
>>
>> Recently we find an issue with our ceph cluster, the version is 0.94.6.
>>
>> We want to add additional RAM to the ceph nodes, so we need to stop
>> the ceph service on the nodes first. When we did that on the first
>> node, we found the OSDs on that node marked OUT and backfill started
>> (DOWN is expected in this case). The first node is somewhat special
>> that it is also the location of the leader monitor.
>>
>> Then checked the monitor log and found the following:
>>
>> cluster [INF] osd.0 out (down for 3375169.141844)
>>
>> Looks like the monitor (who just become leader) has wrong
>> "down_pending_out" records and computes out a  a very long DOWN time ,
>> finally decides to mark them OUT.
>>
>> After researching the related code, the reason could be that:
>>
>> 1. "down_pending_out" is set a month ago for those OSDs because of a
>> network issue.
>> 2. The down OSDs up and join the cluster again. "down_pending_out" is
>> cleared in the "OSDMonitor::tick()" method. But only happened on
>> leader monitor.
>> 3. When we stop the ceph service on the first node. The monitor group
>> failover. The new leader monitor will recognize the OSDs kept in DOWN
>> status for a a very long time, and mark them OUT wrongly.
>>
>>
>> What do you think of this?
>>
>> Regards
>> Ridge
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
