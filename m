From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Prioritize Heartbeat packets
Date: Fri, 10 Apr 2015 11:46:32 -0600
Message-ID: <CAANLjFo1MLhRhyR564NokaUFsuGZ+_gbCR-SHNscMrDfXqjtEg@mail.gmail.com>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>
	<alpine.DEB.2.00.1408271755160.966@cobra.newdream.net>
	<ltmnkp$tod$1@ger.gmane.org>
	<CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
	<mdg18n$gsj$1@ger.gmane.org>
	<CAANLjFpH=0ZjXm2FKNF4Qz421jcM8QsW8HTDGpLqy5=w8POXQw@mail.gmail.com>
	<CAMXzGWK+8hpv0LOp6tAGft_=f8Peb9qackcLXruQH7qVVD9chQ@mail.gmail.com>
	<CAANLjFrwqr-znyMSBw=wCgiVkwqRT69ud3n0yAnhWUH=PZRTTw@mail.gmail.com>
	<CAMXzGWJJpDbV0M0rtTkoRU=tSkgi3tM=x6Sy+wKhfZ=oPNy2hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34454 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbDJRqe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Apr 2015 13:46:34 -0400
Received: by wgso17 with SMTP id o17so24920803wgs.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Apr 2015 10:46:33 -0700 (PDT)
In-Reply-To: <CAMXzGWJJpDbV0M0rtTkoRU=tSkgi3tM=x6Sy+wKhfZ=oPNy2hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jian Wen <wenjianhn@gmail.com>
Cc: Daniel Swarbrick <daniel.swarbrick@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

We have had some delays. Our to be production cluster is currently on
firefly but should be on hammer next week. Once upgraded we will
preform the network saturation test and verify results.

On Fri, Apr 10, 2015 at 12:39 AM, Jian Wen <wenjianhn@gmail.com> wrote:
> Robert,
>     60 days ago, we enabled this feature in our production environment.
>     It works for us.
>
>     Did you see any flapping OSDs?
>
> On Tue, Mar 10, 2015 at 1:16 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> Jian,
>>
>> Thanks for the clarification. I'll mark traffic destined for the
>> monitors as well. We are getting ready to put our first cluster into
>> production. If you are interested we will be testing the heartbeat
>> priority to see if we can saturate the network (not an easy task for
>> 40 Gb) and keep the cluster from falling apart. Our network team is
>> marking COS based on the DSCP and enforcing priority. We have three
>> VLANs on bonded 40 GbE, management, storage (monitors, clients, OSDs),
>> and cluster (replication). We have three priority classes management
>> (heartbeats on all VLANs, SSH, DNS, etc), storage traffic (no
>> marking), and replication (scavenger class). We are interested to see
>> how things pan out.
>>
>> Thanks,
>> Robert
>>
>> On Mon, Mar 9, 2015 at 8:58 PM, Jian Wen <wenjianhn@gmail.com> wrote:
>>> Only OSD calls set_socket_priority().
>>> See  https://github.com/ceph/ceph/pull/3353
>>>
>>> On Tue, Mar 10, 2015 at 3:36 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
>>>> I've found commit 9b9a682fe035c985e416ee1c112fa58f9045a27c and I see
>>>> that when 'osd heartbeat use min delay socket = true' it will mark the
>>>> packet with DSCP CS6. Based on the setting of the socket in
>>>> msg/simple/Pipe.cc is it possible that this can apply to both OSD and
>>>> monitor? I don't understand the code enough to know how the
>>>> set_socket_options() is called from the OSD and monitor.
>>>>
>>>> If this applies to both monitor and OSD, would it be better to rename
>>>> the option to a more generic name?
>>>>
>>>> Thanks,
>>>>
>>>> On Sat, Mar 7, 2015 at 4:23 PM, Daniel Swarbrick
>>>> <daniel.swarbrick@gmail.com> wrote:
>>>>> Judging by the commit, this ought to do the trick:
>>>>>
>>>>> osd heartbeat use min delay socket = true
>>>>>
>>>>> On 07/03/15 01:20, Robert LeBlanc wrote:
>>>>>>
>>>>>> I see that Jian Wen has done work on this for 0.94. I tried looking
>>>>>> through the code to see if I can figure out how to configure this new
>>>>>> option, but it all went over my head pretty quick.
>>>>>>
>>>>>> Can I get a brief summary on how to set the priority of heartbeat
>>>>>> packets or where to look in the code to figure it out?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick
>>>>>> <daniel.swarbrick@profitbricks.com
>>>>>> <mailto:daniel.swarbrick@profitbricks.com>> wrote:
>>>>>>
>>>>>>     On 28/08/14 02:56, Sage Weil wrote:
>>>>>>     > I seem to remember someone telling me there were hooks/hints you
>>>>>> could
>>>>>>     > call that would tag either a socket or possibly data on that socket
>>>>>> with a
>>>>>>     > label for use by iptables and such.. but I forget what it was.
>>>>>>     >
>>>>>>
>>>>>>     Something like setsockopt() SO_MARK?
>>>>>>
>>>>>>             *SO_MARK *(since Linux 2.6.25)
>>>>>>                    Set the mark for each packet sent through this socket
>>>>>>     (similar
>>>>>>                    to the netfilter MARK target but socket-based).
>>>>>>     Changing the
>>>>>>                    mark can be used for mark-based routing without
>>>>>>     netfilter or
>>>>>>                    for packet filtering.  Setting this option requires the
>>>>>>                    *CAP_NET_ADMIN *capability.
>>>>>>
>>>>>>     Alternatively, directly set IP_TOS options on the socket, or
>>>>>> SO_PRIORITY
>>>>>>     which sets the IP TOS bits as well.
>>>>>>
>>>>>>
>>>>>>     _______________________________________________
>>>>>>     ceph-users mailing list
>>>>>>     ceph-users@lists.ceph.com
>>>>>>     <mailto:ceph-users@lists.ceph.com>
>>>>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> ceph-users mailing list
>>>>>> ceph-users@lists.ceph.com
>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>>>
>>> --
>>> Best,
>>>
>>> Jian
>
>
>
> --
> Best,
>
> Jian
