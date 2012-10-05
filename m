From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: ceph-mon not starting - AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe
 error: (38) Function not implemented
Date: Fri, 05 Oct 2012 18:35:20 +0100
Message-ID: <506F1A58.3070205@inktank.com>
References: <506D9148.9040106@smart-weblications.de> <506ED188.5020905@smart-weblications.de> <506ED404.1000306@inktank.com> <alpine.DEB.2.00.1210050819320.6121@cobra.newdream.net> <506F031F.9050405@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41019 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab2JERfm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Oct 2012 13:35:42 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1531502eek.19
        for <ceph-devel@vger.kernel.org>; Fri, 05 Oct 2012 10:35:41 -0700 (PDT)
In-Reply-To: <506F031F.9050405@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/05/2012 04:56 PM, Smart Weblications GmbH - Florian Wiessner wrote:
> Am 05.10.2012 17:24, schrieb Sage Weil:
>> On Fri, 5 Oct 2012, Joao Eduardo Luis wrote:
>>> On 10/05/2012 01:24 PM, Smart Weblications GmbH - Florian Wiessner wrote:
>>>> Am 04.10.2012 15:38, schrieb Smart Weblications GmbH - Florian Wiessner:
>>>>> Hi,
>>>>>
>>>>>
>>>>> i have a ceph cluster with 2 osds, 3 mons.. one of the monitors does not start
>>>>> anymore:
>>>>>
>>>>> 2012-10-04 13:36:29.501178 7f7e123f9780 -1 asok(0x14ac000)
>>>>> AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe error: (38)
>>>>> Function not implemented
>>>>> 2012-10-04 13:36:29.535018 7f7e123f9780  1 mon.2@-1(probing) e1 init fsid
>>>>> 5b59811a-d235-488f-9b9b-953db7e5028b
>>>>> 2012-10-04 13:36:29.541171 7f7e123f9780 -1 mon/Paxos.cc: In function 'bool
>>>>> Paxos::is_consistent()' thread 7f7e123f9780 time 2012-10-04 13:36:29.536744
>>>>> mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping == 1))
>>>
>>> This assertion means the monitor was killed or failed either during
>>> slurping (while catching up with the other monitors) or while performing
>>> some kind of update. So it ended up in an inconsistent state.
>>
>> The monitor is supposed to take note of when it is slurping and may be 
>> temporarily inconsistent by writing a 'slurping' file with '1' in it in 
>> the paxos subdirectory(ies), so some bug triggered this.  A simple 
>> workaround is to do
>>
>>   echo 1 > $mondata/osdmap/slurping
>>   echo 1 > $mondata/pgmap/slurping
>>   echo 1 > $mondata/monmap/slurping
>>   echo 1 > $mondata/logm/slurping
>>   echo 1 > $mondata/auth/slurping
>>
>> and it will go through the recovery steps.  It would be helpful if you 
>> could tar up a copy of the mon directory first, though, along with any 
>> log files on that host, so we can try to figure out what went wrong.
>>
> 
> unfortunatelly, i deleted the logs for the monitor, as i did not see anything
> special except this assertion...
> 
> 
> i'll send mon-directory directly to Sage with a seperate mail.
> 

Just following up on this, do you remember why this monitor went down
initially (the time before you were unable to start it)? Did it fail?
Was it killed? Were you upgrading it from a version prior to argonaut?

  -Joao

