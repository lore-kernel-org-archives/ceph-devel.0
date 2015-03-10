From: Jian Wen <wenjianhn@gmail.com>
Subject: Re: [ceph-users] Prioritize Heartbeat packets
Date: Tue, 10 Mar 2015 10:58:30 +0800
Message-ID: <CAMXzGWK+8hpv0LOp6tAGft_=f8Peb9qackcLXruQH7qVVD9chQ@mail.gmail.com>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>
 <alpine.DEB.2.00.1408271755160.966@cobra.newdream.net> <ltmnkp$tod$1@ger.gmane.org>
 <CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
 <mdg18n$gsj$1@ger.gmane.org> <CAANLjFpH=0ZjXm2FKNF4Qz421jcM8QsW8HTDGpLqy5=w8POXQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:42942 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbbCJC7M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 22:59:12 -0400
Received: by wesq59 with SMTP id q59so23078024wes.9
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2015 19:59:10 -0700 (PDT)
In-Reply-To: <CAANLjFpH=0ZjXm2FKNF4Qz421jcM8QsW8HTDGpLqy5=w8POXQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Daniel Swarbrick <daniel.swarbrick@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Only OSD calls set_socket_priority().
See  https://github.com/ceph/ceph/pull/3353

On Tue, Mar 10, 2015 at 3:36 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
> I've found commit 9b9a682fe035c985e416ee1c112fa58f9045a27c and I see
> that when 'osd heartbeat use min delay socket = true' it will mark the
> packet with DSCP CS6. Based on the setting of the socket in
> msg/simple/Pipe.cc is it possible that this can apply to both OSD and
> monitor? I don't understand the code enough to know how the
> set_socket_options() is called from the OSD and monitor.
>
> If this applies to both monitor and OSD, would it be better to rename
> the option to a more generic name?
>
> Thanks,
>
> On Sat, Mar 7, 2015 at 4:23 PM, Daniel Swarbrick
> <daniel.swarbrick@gmail.com> wrote:
>> Judging by the commit, this ought to do the trick:
>>
>> osd heartbeat use min delay socket = true
>>
>> On 07/03/15 01:20, Robert LeBlanc wrote:
>>>
>>> I see that Jian Wen has done work on this for 0.94. I tried looking
>>> through the code to see if I can figure out how to configure this new
>>> option, but it all went over my head pretty quick.
>>>
>>> Can I get a brief summary on how to set the priority of heartbeat
>>> packets or where to look in the code to figure it out?
>>>
>>> Thanks,
>>>
>>> On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick
>>> <daniel.swarbrick@profitbricks.com
>>> <mailto:daniel.swarbrick@profitbricks.com>> wrote:
>>>
>>>     On 28/08/14 02:56, Sage Weil wrote:
>>>     > I seem to remember someone telling me there were hooks/hints you
>>> could
>>>     > call that would tag either a socket or possibly data on that socket
>>> with a
>>>     > label for use by iptables and such.. but I forget what it was.
>>>     >
>>>
>>>     Something like setsockopt() SO_MARK?
>>>
>>>             *SO_MARK *(since Linux 2.6.25)
>>>                    Set the mark for each packet sent through this socket
>>>     (similar
>>>                    to the netfilter MARK target but socket-based).
>>>     Changing the
>>>                    mark can be used for mark-based routing without
>>>     netfilter or
>>>                    for packet filtering.  Setting this option requires the
>>>                    *CAP_NET_ADMIN *capability.
>>>
>>>     Alternatively, directly set IP_TOS options on the socket, or
>>> SO_PRIORITY
>>>     which sets the IP TOS bits as well.
>>>
>>>
>>>     _______________________________________________
>>>     ceph-users mailing list
>>>     ceph-users@lists.ceph.com
>>>     <mailto:ceph-users@lists.ceph.com>
>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Best,

Jian
