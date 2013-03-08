From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Fri, 8 Mar 2013 14:12:40 +1100
Message-ID: <20130308031240.GA14859@onthe.net.au>
References: <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
 <20130223000843.GA10200@onthe.net.au>
 <alpine.DEB.2.00.1302221612230.5703@cobra.newdream.net>
 <20130223005724.GB8844@onthe.net.au>
 <alpine.DEB.2.00.1302221728550.19172@cobra.newdream.net>
 <20130223014908.GA9749@onthe.net.au>
 <alpine.DEB.2.00.1302221751200.19172@cobra.newdream.net>
 <20130223020253.GA11899@onthe.net.au>
 <20130301020239.GA16236@onthe.net.au>
 <alpine.DEB.2.00.1302282059550.21965@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:54286 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab3CHDMp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 22:12:45 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302282059550.21965@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 28, 2013 at 09:00:24PM -0800, Sage Weil wrote:
> On Fri, 1 Mar 2013, Chris Dunlop wrote:
>> On Sat, Feb 23, 2013 at 01:02:53PM +1100, Chris Dunlop wrote:
>>> On Fri, Feb 22, 2013 at 05:52:11PM -0800, Sage Weil wrote:
>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>> On Fri, Feb 22, 2013 at 05:30:04PM -0800, Sage Weil wrote:
>>>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>>>> On Fri, Feb 22, 2013 at 04:13:21PM -0800, Sage Weil wrote:
>>>>>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>>>>>> On Fri, Feb 22, 2013 at 03:43:22PM -0800, Sage Weil wrote:
>>>>>>>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>>>>>>>> On Fri, Feb 22, 2013 at 01:57:32PM -0800, Sage Weil wrote:
>>>>>>>>>>>> I just looked at the logs.  I can't tell what happend to cause that 10 
>>>>>>>>>>>> second delay.. strangely, messages were passing from 0 -> 1, but nothing 
>>>>>>>>>>>> came back from 1 -> 0 (although 1 was queuing, if not sending, them).
>>>>>>>>> 
>>>>>>>>> Is there any way of telling where they were delayed, i.e. in the 1's output
>>>>>>>>> queue or 0's input queue?
>>>>>>>> 
>>>>>>>> Yeah, if you bump it up to 'debug ms = 20'.  Be aware that that will 
>>>>>>>> generate a lot of logging, though.
>>>>>>> 
>>>>>>> I really don't want to load the system with too much logging, but I'm happy
>>>>>>> modifying code...  Are there specific interesting debug outputs which I can
>>>>>>> modify so they're output under "ms = 1"?
>>>>>> 
>>>>>> I'm basically interested in everything in writer() and write_message(), 
>>>>>> and reader() and read_message()...
>>>>> 
>>>>> Like this?
>>>> 
>>>> Yeah.  You could do 2 instead of 1 so you can turn it down.  I suspect 
>>>> that this is the lions share of what debug 20 will spam to the log, but 
>>>> hopefully the load is manageable!
>>> 
>>> Good idea on the '2'. I'll get that installed and wait for it to happen again.
>> 
>> FYI...
>> 
>> To avoid running out of disk space for the massive logs, I
>> started using logrotate on the ceph logs every two hours, which
>> does a 'service ceph reload' to re-open the log files.
>> 
>> In the week since doing that I haven't seen any 'slow requests'
>> at all (the load has stayed the same as before the change),
>> which means the issue with the osds dropping out, then the
>> system not recovering properly, also hasn't happened.
>> 
>> That's a bit suspicious, no?
> 
> I suspect the logging itself is changing the timing.  Let's wait and see 
> if we get lucky... 

We got "lucky"...

ceph-mon.0.log:
2013-03-08 03:46:44.786682 7fcc62172700  1 -- 192.168.254.132:0/20298 --> 192.168.254.133:6801/23939 -- osd_ping(ping e815 stamp 2013-03-08 03:46:44.786679) v2 -- ?+0 0x765b180 con 0x6ab6160
  [no ping_reply logged, then later...]
2013-03-08 03:46:56.211993 7fcc71190700 -1 osd.0 815 heartbeat_check: no reply from osd.1 since 2013-03-08 03:46:35.986327 (cutoff 2013-03-08 03:46:36.211992)

ceph-mon.1.log:
2013-03-08 03:46:44.786848 7fe6f47a4700  1 -- 192.168.254.133:6801/23939 <== osd.0 192.168.254.132:0/20298 178549 ==== osd_ping(ping e815 stamp 2013-03-08 03:46:44.786679) v2 ==== 47+0+0 (1298645350 0 0) 0x98256c0 con 0x7bd2160
2013-03-08 03:46:44.786880 7fe6f47a4700  1 -- 192.168.254.133:6801/23939 --> 192.168.254.132:0/20298 -- osd_ping(ping_reply e815 stamp 2013-03-08 03:46:44.786679) v2 -- ?+0 0x29876c0 con 0x7bd2160

Interestingly, the matching ping_reply from osd.1 never appears in the
osd.0 log, in contrast to the previous incident upthread where the
"missing" ping replies were all seen in a rush (but after osd.1 had been
marked down).

The missing ping_reply caused osd.1 to get marked down, then it marked
itself up again a bit later ("map e818 wrongly marked me down"). However
the system still hadn't recovered before 07:46:29 when a 'service ceph
restart' was done on the machine holding mon.b5 and osd.1, bringing things
back to life.

Before the restart:

# ceph -s
   health HEALTH_WARN 273 pgs peering; 2 pgs recovery_wait; 273 pgs stuck inactive; 576 pgs stuck unclean; recovery 43/293224 degraded (0.015%)
   monmap e9: 3 mons at {b2=10.200.63.130:6789/0,b4=10.200.63.132:6789/0,b5=10.200.63.133:6789/0}, election epoch 898, quorum 0,1,2 b2,b4,b5
   osdmap e825: 2 osds: 2 up, 2 in
    pgmap v3545580: 576 pgs: 301 active, 2 active+recovery_wait, 273 peering; 560 GB data, 1348 GB used, 2375 GB / 3724 GB avail; 43/293224 degraded (0.015%)
   mdsmap e1: 0/0/1 up

After the restart:

# ceph -s
   health HEALTH_WARN 19 pgs recovering; 24 pgs recovery_wait; 43 pgs stuck unclean; recovery 66/293226 degraded (0.023%)
   monmap e9: 3 mons at {b2=10.200.63.130:6789/0,b4=10.200.63.132:6789/0,b5=10.200.63.133:6789/0}, election epoch 902, quorum 0,1,2 b2,b4,b5
   osdmap e828: 2 osds: 2 up, 2 in
    pgmap v3545603: 576 pgs: 533 active+clean, 24 active+recovery_wait, 19 active+recovering; 560 GB data, 1348 GB used, 2375 GB / 3724 GB avail; 0B/s rd, 8135KB/s wr, 224op/s; 66/293226 degraded (0.023%)
   mdsmap e1: 0/0/1 up

Logs covering 00:00 to 09:00 are in:

https://www.dropbox.com/sh/7nq7gr2u2deorcu/Nvw3FFGiy2

Cheers,

Chris
