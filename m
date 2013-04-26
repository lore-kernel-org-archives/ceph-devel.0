From: David Zafman <david.zafman@inktank.com>
Subject: Re: [ceph-users] cuttlefish countdown -- OSD doesn't get marked out
Date: Fri, 26 Apr 2013 11:18:52 -0700
Message-ID: <97612312-821E-44EB-A34B-5E2F17DC95E5@inktank.com>
References: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net> <51791C83.3010403@tuxadero.com> <alpine.DEB.2.00.1304250916430.4411@cobra.newdream.net> <51795BE9.60601@tuxadero.com> <541D0EAA-5D6F-42A1-9FF3-1E41815AB73A@inktank.com> <517A3FD2.6080801@tuxadero.com> <517A84D3.1010906@scholarstack.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:62510 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3DZSS6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 14:18:58 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so4336535oag.34
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 11:18:58 -0700 (PDT)
In-Reply-To: <517A84D3.1010906@scholarstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@scholarstack.com>
Cc: Martin Mailand <martin@tuxadero.com>, ceph-devel@vger.kernel.org


Mike / Martin,

The OSD down behavior Mike is seeing is different.  You should be seeing messages like this in your leader's monitor log:

can_mark_down current up_ratio 0.166667 < min 0.3, will not mark osd.2 down

To dampen certain kinds of cascading failures, we are deliberately restricting automatically marking < 30% of OSDs down.

As far as Martin is concerned his osd tree shows a single rack, but said that his crush rules are supposed to put a replica on each of 2 racks.  I don't remember seeing his crush rules in any of the e-mails, but even so he only has "unknownrack" with id -3 defined.

David Zafman
Senior Developer
http://www.inktank.com




On Apr 26, 2013, at 6:44 AM, Mike Dawson <mike.dawson@scholarstack.com> wrote:

> David / Martin,
> 
> I can confirm this issue. At present I am running monitors only with 100% of my OSD processes shutdown down. For the past couple hours, Ceph has reported:
> 
> osdmap e1323: 66 osds: 19 up, 66 in
> 
> I can mark them down manually using
> 
> ceph osd down 0
> 
> as expected, but they never get marked down automatically. Like Martin, I also have a custom crushmap, but this cluster is operating with a single rack. I'll be happy to provide any documentation / configs / logs you would like.
> 
> I am currently running ceph version 0.60-666-ga5cade1 (a5cade1fe7338602fb2bbfa867433d825f337c87) from gitbuilder.
> 
> - Mike
> 
> On 4/26/2013 4:50 AM, Martin Mailand wrote:
>> Hi David,
>> 
>> did you test it with more than one rack as well? In my first problem I
>> used two racks, with a custom crushmap, so that the replicas are in the
>> two racks (replicationlevel = 2). Than I took one osd down, and expected
>> that the remaining osds in this rack would get the now missing replicas
>> from the osd of the other rack.
>> But nothing happened, the cluster stayed degraded.
>> 
>> -martin
>> 
>> 
>> On 26.04.2013 02:22, David Zafman wrote:
>>> 
>>> I filed tracker bug 4822 and have wip-4822 with a fix.  My manual testing shows that it works.  I'm building a teuthology test.
>>> 
>>> Given your osd tree has a single rack it should always mark OSDs down after 5 minutes by default.
>>> 
>>> David Zafman
>>> Senior Developer
>>> http://www.inktank.com
>>> 
>>> 
>>> 
>>> 
>>> On Apr 25, 2013, at 9:38 AM, Martin Mailand <martin@tuxadero.com> wrote:
>>> 
>>>> Hi Sage,
>>>> 
>>>> On 25.04.2013 18:17, Sage Weil wrote:
>>>>> What is the output from 'ceph osd tree' and the contents of your
>>>>> [mon*] sections of ceph.conf?
>>>>> 
>>>>> Thanks!
>>>>> sage
>>>> 
>>>> 
>>>> root@store1:~# ceph osd tree
>>>> 
>>>> # id	weight	type name	up/down	reweight
>>>> -1	24	root default
>>>> -3	24		rack unknownrack
>>>> -2	4			host store1
>>>> 0	1				osd.0	up	1	
>>>> 1	1				osd.1	down	1	
>>>> 2	1				osd.2	up	1	
>>>> 3	1				osd.3	up	1	
>>>> -4	4			host store3
>>>> 10	1				osd.10	up	1	
>>>> 11	1				osd.11	up	1	
>>>> 8	1				osd.8	up	1	
>>>> 9	1				osd.9	up	1	
>>>> -5	4			host store4
>>>> 12	1				osd.12	up	1	
>>>> 13	1				osd.13	up	1	
>>>> 14	1				osd.14	up	1	
>>>> 15	1				osd.15	up	1	
>>>> -6	4			host store5
>>>> 16	1				osd.16	up	1	
>>>> 17	1				osd.17	up	1	
>>>> 18	1				osd.18	up	1	
>>>> 19	1				osd.19	up	1	
>>>> -7	4			host store6
>>>> 20	1				osd.20	up	1	
>>>> 21	1				osd.21	up	1	
>>>> 22	1				osd.22	up	1	
>>>> 23	1				osd.23	up	1	
>>>> -8	4			host store2
>>>> 4	1				osd.4	up	1	
>>>> 5	1				osd.5	up	1	
>>>> 6	1				osd.6	up	1	
>>>> 7	1				osd.7	up	1	
>>>> 
>>>> 
>>>> 
>>>> [global]
>>>>        auth cluster requierd = none
>>>>        auth service required = none
>>>>        auth client required = none
>>>> #       log file = ""
>>>>        log_max_recent=100
>>>>        log_max_new=100
>>>> 
>>>> [mon]
>>>>        mon data = /data/mon.$id
>>>> [mon.a]
>>>>        mon host = store1
>>>>        mon addr = 192.168.195.31:6789
>>>> [mon.b]
>>>>        mon host = store3
>>>>        mon addr = 192.168.195.33:6789
>>>> [mon.c]
>>>>        mon host = store5
>>>>        mon addr = 192.168.195.35:6789
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

