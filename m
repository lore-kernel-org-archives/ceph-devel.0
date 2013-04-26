From: David Zafman <david.zafman@inktank.com>
Subject: Re: [ceph-users] cuttlefish countdown -- OSD doesn't get marked out
Date: Fri, 26 Apr 2013 10:02:10 -0700
Message-ID: <A946709D-FE7A-492D-A10B-EC804377C876@inktank.com>
References: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net> <51791C83.3010403@tuxadero.com> <alpine.DEB.2.00.1304250916430.4411@cobra.newdream.net> <51795BE9.60601@tuxadero.com> <541D0EAA-5D6F-42A1-9FF3-1E41815AB73A@inktank.com> <517A3FD2.6080801@tuxadero.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:61661 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab3DZRCP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 13:02:15 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so4234502oag.12
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 10:02:15 -0700 (PDT)
In-Reply-To: <517A3FD2.6080801@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org


The behavior you are seeing is exactly what would be expected if OSDs are not being marked out.  The testing of my fix showed that if a portion of a rack's OSDs go down they will be marked out after the configured amount of time (5 min by default).  Once down OSDs are out the remaining OSDs take responsibility for holding the data assigned to that rack.

Though I didn't look at the data movement, I'm confident that it will work.  You can simply mark your OSDs out manually to verify that missing replicas are replaced.

David Zafman
Senior Developer
http://www.inktank.com




On Apr 26, 2013, at 1:50 AM, Martin Mailand <martin@tuxadero.com> wrote:

> Hi David,
> 
> did you test it with more than one rack as well? In my first problem I
> used two racks, with a custom crushmap, so that the replicas are in the
> two racks (replicationlevel = 2). Than I took one osd down, and expected
> that the remaining osds in this rack would get the now missing replicas
> from the osd of the other rack.
> But nothing happened, the cluster stayed degraded.
> 
> -martin
> 
> 
> On 26.04.2013 02:22, David Zafman wrote:
>> 
>> I filed tracker bug 4822 and have wip-4822 with a fix.  My manual testing shows that it works.  I'm building a teuthology test.
>> 
>> Given your osd tree has a single rack it should always mark OSDs down after 5 minutes by default.
>> 
>> David Zafman
>> Senior Developer
>> http://www.inktank.com
>> 
>> 
>> 
>> 
>> On Apr 25, 2013, at 9:38 AM, Martin Mailand <martin@tuxadero.com> wrote:
>> 
>>> Hi Sage,
>>> 
>>> On 25.04.2013 18:17, Sage Weil wrote:
>>>> What is the output from 'ceph osd tree' and the contents of your 
>>>> [mon*] sections of ceph.conf?
>>>> 
>>>> Thanks!
>>>> sage
>>> 
>>> 
>>> root@store1:~# ceph osd tree
>>> 
>>> # id	weight	type name	up/down	reweight
>>> -1	24	root default
>>> -3	24		rack unknownrack
>>> -2	4			host store1
>>> 0	1				osd.0	up	1	
>>> 1	1				osd.1	down	1	
>>> 2	1				osd.2	up	1	
>>> 3	1				osd.3	up	1	
>>> -4	4			host store3
>>> 10	1				osd.10	up	1	
>>> 11	1				osd.11	up	1	
>>> 8	1				osd.8	up	1	
>>> 9	1				osd.9	up	1	
>>> -5	4			host store4
>>> 12	1				osd.12	up	1	
>>> 13	1				osd.13	up	1	
>>> 14	1				osd.14	up	1	
>>> 15	1				osd.15	up	1	
>>> -6	4			host store5
>>> 16	1				osd.16	up	1	
>>> 17	1				osd.17	up	1	
>>> 18	1				osd.18	up	1	
>>> 19	1				osd.19	up	1	
>>> -7	4			host store6
>>> 20	1				osd.20	up	1	
>>> 21	1				osd.21	up	1	
>>> 22	1				osd.22	up	1	
>>> 23	1				osd.23	up	1	
>>> -8	4			host store2
>>> 4	1				osd.4	up	1	
>>> 5	1				osd.5	up	1	
>>> 6	1				osd.6	up	1	
>>> 7	1				osd.7	up	1	
>>> 
>>> 
>>> 
>>> [global]
>>>       auth cluster requierd = none
>>>       auth service required = none
>>>       auth client required = none
>>> #       log file = ""
>>>       log_max_recent=100
>>>       log_max_new=100
>>> 
>>> [mon]
>>>       mon data = /data/mon.$id
>>> [mon.a]
>>>       mon host = store1
>>>       mon addr = 192.168.195.31:6789
>>> [mon.b]
>>>       mon host = store3
>>>       mon addr = 192.168.195.33:6789
>>> [mon.c]
>>>       mon host = store5
>>>       mon addr = 192.168.195.35:6789
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> 

