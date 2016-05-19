From: Gaurav Bafna <bafnag@gmail.com>
Subject: Re: No Ceph Recovery : Is it a bug ?
Date: Thu, 19 May 2016 14:44:03 +0530
Message-ID: <CAPg135bLWLMetYan5HGjaUA-mTcXRdbsuuNRQCgzeDZwAAg1NA@mail.gmail.com>
References: <CAPg135a2YdLrMspcGdLbkx-fWvh30VJ3J4Y=hKSMAxDzosd+KQ@mail.gmail.com>
	<alpine.DEB.2.11.1605190343450.980@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36318 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcESJOK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 05:14:10 -0400
Received: by mail-oi0-f48.google.com with SMTP id x201so118855577oif.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 02:14:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605190343450.980@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage & hzwulibin

Many thanks for your reply :)

Ceph osd tree : http://pastebin.com/3cC8brcF

Crushmap : http://pastebin.com/K2BNSHys

Since I removed the 12 osds from the crush map, there are no more stuck PGs .

Version : Hammer 0.94.5.    Do you think it can just be a reporting
issue ? The osds that went down had around 300 PGs mapped to them out
of which it was primary for 0 . We have two IDCs. All the primary are
in one IDC only for now.

Sage, I did not get yor first point. What is not matching ?  In our
cluster there were 2758 running osds before the 12 osd crash . After
that event , there were 2746 osds left.

PG Stat for your reference :   v3733136: 75680 pgs: 75680
active+clean; 409 GB data, 16745 GB used, 14299 TB / 14315 TB avail;
443 B/s wr, 0 op/s

Also, I have seen this issue 3 times with our cluster. Even when 1 osd
goes down in IDC1 or IDC2, some PG always remain undersized. I am sure
this issue will come up once again . So can you tell me what things
should I look when an OSD goes down next time ?

When I manually stop an osd daemon in IDC1 or IDC2 by running,
/etc/init.d/ceph  stop osd.x , the cluster recovers nicely. That is
what making the issue so complex.

It is a big cluster and we have just started . We will need the
community help to make it run smoothly and expand further :)

Thanks
Gaurav

On Thu, May 19, 2016 at 1:17 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 19 May 2016, Gaurav Bafna wrote:
>> Hi Cephers ,
>>
>> In our production cluster at Reliance Jio, when as osd goes corrupt
>> and crashes, Cluster remains unhealthy even after 4 hours.
>>
>>     cluster fac04d85-db48-4564-b821-deebda046261
>>      health HEALTH_WARN
>>             658 pgs degraded
>>             658 pgs stuck degraded
>>             688 pgs stuck unclean
>>             658 pgs stuck undersized
>>             658 pgs undersized
>               ^^^ this...
>
>>             recovery 3064/1981308 objects degraded (0.155%)
>>             recovery 124/1981308 objects misplaced (0.006%)
>>      monmap e11: 11 mons at
>> {dssmon2=10.140.208.224:6789/0,dssmon3=10.140.208.225:6789/0,dssmon31=10.135.38.141:6789/0,dssmon32=10.135.38.142:6789/0,dssmon33=10.135.38.143:6789/0,dssmon34=10.135.38.144:6789/0,dssmon35=10.135.38.145:6789/0,dssmon4=10.140.208.226:6789/0,dssmon5=10.140.208.227:6789/0,dssmon6=10.140.208.228:6789/0,dssmonleader1=10.140.208.223:6789/0}
>>             election epoch 792, quorum 0,1,2,3,4,5,6,7,8,9,10
>> dssmon31,dssmon32,dssmon33,dssmon34,dssmon35,dssmonleader1,dssmon2,dssmon3,dssmon4,dssmon5,dssmon6
>>      osdmap e8778: 2774 osds: 2746 up, 2746 in; 30 remapped pgs
>                                doesn't match this ^^
>
> which makes it look like a problem with OSDs reporting PG state to the
> mon.  The fact that an OSD restarts supports that theory.
>
> What version is this?  A bunch of the osd -> mon pg reporting code was
> recently rewritten (between infernalis and jewel), so the new code is
> hopefully more robust.  (OTOH, it is also new, so we may have missed
> something.)
>
> Nice big cluster!
>
> sage



-- 
Gaurav Bafna
9540631400
