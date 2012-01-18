From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: How to remove lost objects.
Date: Thu, 19 Jan 2012 01:57:02 +0400
Message-ID: <CAADCt4LJY5LTqCcSv2XegEUvoRFJmrVFbE9gZzyAUVkAWwdDpg@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
 <CAORUGqAj-2k+8cvzxwVwDb32upEdv_FFAc96-05fiyVRF3qE6g@mail.gmail.com>
 <CAADCt4JEEjhmsKem2M0-7auyx5wh2UGd7YLAtDYhiofkFSkkoA@mail.gmail.com> <CAORUGqCmhjMh6YpsS_5uaKh9OxHjoqwWSXhnZTh2JD5vpixvPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61287 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab2ARV5Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 16:57:24 -0500
Received: by wibhm6 with SMTP id hm6so2588823wib.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 13:57:23 -0800 (PST)
In-Reply-To: <CAORUGqCmhjMh6YpsS_5uaKh9OxHjoqwWSXhnZTh2JD5vpixvPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2012/1/19 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Wed, Jan 18, 2012 at 12:45, Andrey Stepachev <octo47@gmail.com> wr=
ote:
>> I understand this. But I want to know, how ceph will react on
>> some =C2=A0bad conditions. I don't want to lost my data because
>> of some broken hardware (like switch) do some bad things on
>> my cluster. (so far, ceph looks good event in such bad environment).
>
> When a node becomes unreachable / equivalently slow, Ceph clients wil=
l
> wait for it. After a brief period of time, the node is declared down,
> and the operations will continue -- the Placement Group(s) involved
> will be in degraded mode, and you won't have all the replicas of the
> data you want. Once the node recovers (goes up) or is declared lost
> (goes out), replicas of the relevant data will be placed elsewhere.
> Either way, once the data is at the desired replication level again,
> the PG gets out of degraded mode.

Thanks for clarification. I don't dig yet, how data moved when osd
marked as out and how pg calculated for this data. (in other words,
how new place for missing replica calculated, and what happens,
when out osd returns back)

>
> We don't recommend running Ceph in a WAN scenario. If you care about
> your not losing your data, you should still be able to build
> independent failure domains just by using different rows/areas/racks
> in a single data center. Low latency and high bandwidth are very
> desirable. Ceph does synchronous replication instead of the more
> common "slave trails the master by some unknown amount of operations"=
=2E

We don't try to use Ceph in true WAN. But we try to find some dfs, whic=
h will
operate well in our environment: multiple dc, relatively low latency
(<10ms as average),
irregular dc outages. And we need synchronous replication and we need
bigtable (hbase in case of ceph).
I believe, that ceph can be configured to operate in such environment, =
but
I can be completely wrong. And I try to check some boundary conditions.

>
>>> Object removal is done in the background. Give it some time, and go=
od
>>> networking, and you should get the free space back.
>> So, I can't 'trigger' this procedure?
>> (I can't find good docs about scrub and repair, so I still don't
>> know what they do exactly).
>
> It's triggered automatically, just give it idle time and it should ge=
t it done.

Yeah, it is good to see some progress (like mdadm shows), but it is not
critical. Can you point me, who does this job. MDS?


--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
