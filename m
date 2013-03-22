From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [ceph-users] ceph 0.59 cephx problem
Date: Fri, 22 Mar 2013 13:47:55 +0000
Message-ID: <514C610B.6000306@inktank.com>
References: <514B098C.80604@iti.cs.uni-magdeburg.de> <514B2B9D.7040804@iti.cs.uni-magdeburg.de> <514C2BE6.1010901@inktank.com> <20130322133628.GA28214@geri.cs.uni-magdeburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:45830 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3CVNsK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 09:48:10 -0400
Received: by mail-ee0-f52.google.com with SMTP id b15so2223838eek.11
        for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 06:48:09 -0700 (PDT)
In-Reply-To: <20130322133628.GA28214@geri.cs.uni-magdeburg.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steffen Thorhauer <thorhaue@iti.cs.uni-magdeburg.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

(Re-CC'ing the list)

On 03/22/2013 01:36 PM, Steffen Thorhauer wrote:
> I was upgrading from 0.58 to ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e759)
> Upgrading from 0.57 to 0.58 was an easy one, so I was suprised with the problems

v0.59 is the first dev release with a major monitor rework.  We've 
tested it thoroughly over the past weeks, but different usages tend to 
trigger different behaviours, so you might just have hit one of those 
buggers.

> It seems to me, that I make an fatal error, that I dont understand.
> I had 5 working mons (mon.{0-4]). After the upgrade of the first node I
> lost the mon.4 with the cephx error. Then I upgraded all of the nodes and
> I lost the mon.0 with the starting error.

The v0.59 monitors is unable to communicate with the <=0.58 monitors, so 
that's likely why the monitor appeared to be lost: you would need at 
least a majority of monitors on v0.59 so they could form a quorum.

> After some restarts it looks like the other mons lost any quorum
> so ceph -s or any kind of ceph commands didn't work anymore.

As long as you have a majority of monitors running v0.59, they ought to 
be able to form a quorum.  If they didn't, then something weird must 
have happened and logs would be much appreciated!

> So I made today the decision to reinstall the test "cluster".

You decided to go back to v0.58, is that it?  Regardless, if you have 
logs that could provide some insight into what happened, we'd really 
appreciate it.

Thanks!

   -Joao

>
> -Steffen
>
> Btw. ceph rbd, adding/removing osds works great.
>
>> On Fri, Mar 22, 2013 at 10:01:10AM +0000, Joao Eduardo Luis wrote:
>> On 03/21/2013 03:47 PM, Steffen Thorhauer wrote:
>>> I think, I was impatient and should wait for the v.59 announcement. It
>>> seems I should upgrading all monitors.
>>>   After upgrading all nodes I have on 2 monitors errors like:
>>> === mon.0 ===
>>> Starting Ceph mon.0 on u124-161-ceph...
>>> mon fs missing 'monmap/latest' and 'mkfs/monmap'
>>> failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i 0 --pid-file
>>> /var/run/ceph/mon.0.pid -c /etc/ceph/ceph.conf '
>>>
>>> Steffen
>>
>> Which version are you upgrading from?
>>
>> Also, could you provide us with some logs of those monitors with 'debug
>> mon = 20' ?
>>
>>    -Joao
>>
>>>
>>>
>>> On 03/21/2013 02:22 PM, Steffen Thorhauer wrote:
>>>> Hi,
>>>> I just upgraded one node of my ceph "cluster". I wanted upgrade node
>>>> after node.
>>>> osd on this node  has no problem. but the mon (mon.4) has
>>>> authorization problems.
>>>> I did'nt change any config, just made an  apt-get upgrade .
>>>> ceph -s
>>>>    health HEALTH_WARN 1 mons down, quorum 0,1,2,3 0,1,2,3
>>>>    monmap e2: 5 mons at
>>>> {0=10.37.124.161:6789/0,1=10.37.124.162:6789/0,2=10.37.124.163:6789/0,3=10.37.124.164:6789/0,4=10.37.124.167:6789/0},
>>>> election epoch 162, quorum 0,1,2,3 0,1,2,3
>>>>    osdmap e4839: 16 osds: 16 up, 16 in
>>>>     pgmap v195213: 3144 pgs: 3144 active+clean; 255 GB data, 820 GB
>>>> used, 778 GB / 1599 GB avail
>>>>    mdsmap e54723: 1/1/1 up {0=0=up:active}, 3 up:standby
>>>>
>>>>
>>>> but the mon.4 log file look like:
>>>>
>>>> 2013-03-21 12:45:15.701747 7f45412c6780  2 mon.4@-1(probing) e2 init
>>>> 2013-03-21 12:45:15.702051 7f45412c6780 10 mon.4@-1(probing) e2 bootstrap
>>>> 2013-03-21 12:45:15.702094 7f45412c6780 10 mon.4@-1(probing) e2
>>>> unregister_cluster_logger - not registered
>>>> 2013-03-21 12:45:15.702121 7f45412c6780 10 mon.4@-1(probing) e2
>>>> cancel_probe_timeout (none scheduled)
>>>> 2013-03-21 12:45:15.702147 7f45412c6780  0 mon.4@-1(probing) e2 my
>>>> rank is now 4 (was -1)
>>>> 2013-03-21 12:45:15.702190 7f45412c6780 10 mon.4@4(probing) e2 reset_sync
>>>> 2013-03-21 12:45:15.702213 7f45412c6780 10 mon.4@4(probing) e2 reset
>>>> 2013-03-21 12:45:15.702238 7f45412c6780 10 mon.4@4(probing) e2
>>>> timecheck_finish
>>>> 2013-03-21 12:45:15.702286 7f45412c6780 10 mon.4@4(probing) e2
>>>> cancel_probe_timeout (none scheduled)
>>>> 2013-03-21 12:45:15.702312 7f45412c6780 10 mon.4@4(probing) e2
>>>> reset_probe_timeout 0x24d6580 after 2 seconds
>>>> 2013-03-21 12:45:15.702387 7f45412c6780 10 mon.4@4(probing) e2 probing
>>>> other monitors
>>>> 2013-03-21 12:45:15.703459 7f453a15f700 10 mon.4@4(probing) e2
>>>> ms_get_authorizer for mon
>>>> 2013-03-21 12:45:15.703641 7f453a15f700 10 cephx: build_service_ticket
>>>> service mon secret_id 18446744073709551615 ticket_info.ticket.name=mon.
>>>> 2013-03-21 12:45:15.703642 7f453a361700 10 mon.4@4(probing) e2
>>>> ms_get_authorizer for mon
>>>> 2013-03-21 12:45:15.703694 7f453a361700 10 cephx: build_service_ticket
>>>> service mon secret_id 18446744073709551615 ticket_info.ticket.name=mon.
>>>> 2013-03-21 12:45:15.703869 7f453a260700 10 mon.4@4(probing) e2
>>>> ms_get_authorizer for mon
>>>> 2013-03-21 12:45:15.703957 7f453a260700 10 cephx: build_service_ticket
>>>> service mon secret_id 18446744073709551615 ticket_info.ticket.name=mon.
>>>> 2013-03-21 12:45:15.704244 7f453a05e700 10 mon.4@4(probing) e2
>>>> ms_get_authorizer for mon
>>>> 2013-03-21 12:45:15.704306 7f453a05e700 10 cephx: build_service_ticket
>>>> service mon secret_id 18446744073709551615 ticket_info.ticket.name=mon.
>>>> 2013-03-21 12:45:15.704323 7f453a361700  0 cephx: verify_reply
>>>> coudln't decrypt with error: error decoding block for decryption
>>>> 2013-03-21 12:45:15.704333 7f453a361700  0 -- 10.37.124.167:6789/0 >>
>>>> 10.37.124.161:6789/0 pipe(0x24f3c80 sd=29 :42310 s=1 pgs=0 cs=0
>>>> l=0).failed verifying authorize reply
>>>> 2013-03-21 12:45:15.704404 7f453a361700  0 -- 10.37.124.167:6789/0 >>
>>>> 10.37.124.161:6789/0 pipe(0x24f3c80 sd=29 :42310 s=1 pgs=0 cs=0
>>>> l=0).fault
>>>> 2013-03-21 12:45:15.704429 7f453a15f700  0 cephx: verify_reply
>>>> coudln't decrypt with error: error decoding block for decryption
>>>> 2013-03-21 12:45:15.704483 7f453a15f700  0 -- 10.37.124.167:6789/0 >>
>>>> 10.37.124.163:6789/0 pipe(0x24f3500 sd=31 :60255 s=1 pgs=0 cs=0
>>>> l=0).failed verifying authorize reply
>>>> 2013-03-21 12:45:15.704517 7f453a260700  0 cephx: verify_reply
>>>> coudln't decrypt with error: error decoding block for decryption
>>>> 2013-03-21 12:45:15.704578 7f453a15f700  0 -- 10.37.124.167:6789/0 >>
>>>> 10.37.124.163:6789/0 pipe(0x24f3500 sd=31 :60255 s=1 pgs=0 cs=0
>>>> l=0).fault
>>>> 2013-03-21 12:45:15.704529 7f453a260700  0 -- 10.37.124.167:6789/0 >>
>>>> 10.37.124.162:6789/0 pipe(0x24f3a00 sd=30 :55445 s=1 pgs=0 cs=0
>>>> l=0).failed verifying authorize reply
>>>>
>>>> What now??
>>>>
>>>> Regards,
>>>>   Steffen
>>>>
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

