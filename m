From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD rebind connects to ports of other OSDs
Date: Tue, 20 Dec 2016 19:39:48 +0100
Message-ID: <5e69eb3a-9c9d-9876-f4c5-81dccaafb171@digiware.nl>
References: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
 <42cd4fbb-6539-fe43-2b45-45d7958ddcce@digiware.nl>
 <alpine.DEB.2.11.1612201521120.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:23712 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754010AbcLTSj4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Dec 2016 13:39:56 -0500
In-Reply-To: <alpine.DEB.2.11.1612201521120.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-12-2016 16:23, Sage Weil wrote:
> On Tue, 20 Dec 2016, Willem Jan Withagen wrote:
>> On 20-12-2016 11:21, Willem Jan Withagen wrote:
>>> Hi,
>>>
>>> I've been banging my head against the wall for some time now.
>>> But rebinding OSD.0 (in cephtool-test-mon.sh) does not quite work.
>>>
>>> When rebinding it connects to the ports of OSD.1 because those ports are
>>> the first not in the avoid_list. That should be refused since these
>>> sockets belong to a different process.
>>> UNLESS SO_REUSEPORT is set:
>>>  SO_REUSEPORT allows completely duplicate bindings by multiple processes
>>>  if they all set SO_REUSEPORT before binding the port.  This option
>>>  permits multiple instances of a program to each receive UDP/IP
>>>  multicast or broadcast datagrams destined for the bound port.
>>>
>>> Which seems that that happens.
>>> Output from sockstat in this state:
>>> wjw      ceph-osd-0   43305 14 tcp4   *:6800                *:*
>>> wjw      ceph-osd-0   43305 15 tcp4   127.0.0.1:6804        *:*
>>> wjw      ceph-osd-0   43305 16 tcp4   127.0.0.1:6805        *:*
>>> wjw      ceph-osd-0   43305 45 tcp4   127.0.0.1:6806        *:*
>>> wjw      ceph-osd-1   43318 14 tcp4   *:6804                *:*
>>> wjw      ceph-osd-1   43318 15 tcp4   *:6805                *:*
>>> wjw      ceph-osd-1   43318 16 tcp4   *:6806                *:*
>>> wjw      ceph-osd-1   43318 17 tcp4   *:6807                *:*
>>>
>>> Which clearly demonstrates the mess.
>>> How ever that option is nowhere set in the ceph-code, neither is it a
>>> setting that "just" gets set.
>>>
>>> Any suggestions where to look for this option to get set in an
>>> incidental/bug way would be much appreciated.
>>> Or a suggestion on how to easily debug this.
>>
>> Right,
>>
>> Compatibility in this area is rather thin. :)
>>
>> For the question skip to the end.
>>
>> So I'm going to need some functional description, to see if I can get it
>> right.
>>
>> Osd starts and build a few messengers with SO_REUSEADDR on the socket.
>>         On Linux used ports are being reported in use.
>> 	As on FreeBSD during startup. Ports are nicely iterated thru
>> 	and sequential ports are selected.
>> So that is how it should be.
>>
>> Now when the osd has gone down and comes up, it reports:
>>   log_channel(cluster) log [WRN] : map e18 wrongly marked me down
>> on ./src/osd/OSD.cc:7120
>>
>> Then it starts rebinding on its messenger connections:
>>         int r = cluster_messenger->rebind(avoid_ports)
>> on ./src/osd/OSD.cc:7192.
>> It calls shutdown_connections() to shutdown all of its connections.
>>
>> Somewhere down the line is SO_REUSEADDR set again on the socket and the
>> socket is bound.
>>  - Linux grabs the next available ports at the end, because its own
>>    channels are to be avoided and the rest is taken.
>>
>>  - On FreeBSD the first port available is taken. If that is 6800,
>>    than that is taken. Even if the socket is owned by a different
>>    process. Which (per man-page) would require SO_REUSEPORT.
>>
>> If I disable SO_REUSEADDR in NetHandler::create_socket()
>> ====
>>   /* Make sure connection-intensive things like the benchmark
>>    * will be able to close/open sockets a zillion of times */
>>   if (reuse_addr) {
>>     if (::setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &on,sizeof(on))==-1){
>>       lderr(cct) << __func__ << " setsockopt SO_REUSEADDR failed: "
>>                  << strerror(errno) << dendl;
>>       close(s);
>>       return -errno;
>>     }
>>   }
>> ====
>> Then things start to work "as expected" and ports are refused when it
>> has a listener connected.
>>
>> Doing this has the disadvantage that it is not possible to immediately
>> kill and restart the OSD because the ports are not yet release in the
>> netstat table.... But that is an overseeable issue, and that time can be
>> shorted by setting a sysctl.
>>
>> So the question is:
>>  - how much rebinding is required.....
> 
> I think it's just for tests.  My recollection is that we did this just 
> because we can run out of ports since we can't reuse one until the tcp 
> finwait2 (or whatever) timeout expires.
> 
>>  - And why do we set SO_REUSEADDR if we are going to add the ports to
>>  	avoid_ports. And thus a complete new port is required.
> 
> I suspect it's safe to drop the option if the Linux vs FreeBSD semantics 
> are in fact different.

When I exclude the SO_REUSEADDR my Jenkins goes back to normal.
Will submit a PR.

--WjW

-------- Forwarded Message --------
Subject: Jenkins build is back to normal : ceph-master #107
Date: Tue, 20 Dec 2016 18:54:51 +0100 (CET)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/107/
