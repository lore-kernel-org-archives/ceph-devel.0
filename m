From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: osd/OSDMap.h: 330: FAILED assert(is_up(osd))
Date: Wed, 18 Jul 2012 09:29:48 -0600
Message-ID: <5006D66C.50006@sandia.gov>
References: <5005CFDE.5010100@sandia.gov>
 <CA+4uBUZ1j6dx3Z68_BG=eS+nas+mf75Dqf9qV+-0C_UFC=oDAA@mail.gmail.com>
 <5005DEFC.7020701@sandia.gov>
 <CA+4uBUb237Z-dqyCTe49Ce73Csxz_Kop7U9vbYj35L9CLXiNag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53306 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab2GRPa3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 11:30:29 -0400
In-Reply-To: <CA+4uBUb237Z-dqyCTe49Ce73Csxz_Kop7U9vbYj35L9CLXiNag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/17/2012 06:03 PM, Samuel Just wrote:
> master should now have a fix for that, let me know how it goes.  I opened
> bug #2798 for this issue.
>

Hmmm, it seems handle_osd_ping() now runs into a case
where for the first ping it gets, service.osdmap can be empty?

      0> 2012-07-18 09:17:23.977497 7fffe6ec6700 -1 *** Caught signal (Segmentation fault) **
  in thread 7fffe6ec6700

  ceph version 0.48argonaut-419-g4e1d973 (commit:4e1d973e466cd45138f004e84ab8631d9b2a60fa)
  1: /usr/bin/ceph-osd() [0x723c39]
  2: (()+0xf4a0) [0x7ffff76584a0]
  3: (OSD::handle_osd_ping(MOSDPing*)+0x7d4) [0x5d7894]
  4: (OSD::heartbeat_dispatch(Message*)+0x71) [0x5d8111]
  5: (SimpleMessenger::DispatchQueue::entry()+0x583) [0x7d5103]
  6: (SimpleMessenger::dispatch_entry()+0x15) [0x7d6485]
  7: (SimpleMessenger::DispatchThread::entry()+0xd) [0x79523d]
  8: (()+0x77f1) [0x7ffff76507f1]
  9: (clone()+0x6d) [0x7ffff6aa1ccd]

gdb has this to say:

(gdb) bt
#0  0x00007ffff765836b in raise (sig=11) at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
#1  0x0000000000724067 in reraise_fatal (signum=11) at global/signal_handler.cc:58
#2  handle_fatal_signal (signum=11) at global/signal_handler.cc:104
#3  <signal handler called>
#4  get_epoch (this=0x15d0000, m=0x1587000) at ./osd/OSDMap.h:210
#5  OSD::handle_osd_ping (this=0x15d0000, m=0x1587000) at osd/OSD.cc:1711
#6  0x00000000005d8111 in OSD::heartbeat_dispatch (this=0x15d0000, m=0x1587000) at osd/OSD.cc:2769
#7  0x00000000007d5103 in ms_deliver_dispatch (this=0x1472960) at msg/Messenger.h:504
#8  SimpleMessenger::DispatchQueue::entry (this=0x1472960) at msg/SimpleMessenger.cc:367
#9  0x00000000007d6485 in SimpleMessenger::dispatch_entry (this=0x1472880) at msg/SimpleMessenger.cc:384
#10 0x000000000079523d in SimpleMessenger::DispatchThread::entry (this=<value optimized out>) at ./msg/SimpleMessenger.h:807
#11 0x00007ffff76507f1 in start_thread (arg=0x7fffe6ec6700) at pthread_create.c:301
#12 0x00007ffff6aa1ccd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
(gdb) f 5
#5  OSD::handle_osd_ping (this=0x15d0000, m=0x1587000) at osd/OSD.cc:1711
1711					m->stamp);
(gdb) l
1706		}
1707	      }
1708	      Message *r = new MOSDPing(monc->get_fsid(),
1709					curmap->get_epoch(),
1710					MOSDPing::PING_REPLY,
1711					m->stamp);
1712	      hbserver_messenger->send_message(r, m->get_connection());
1713	
1714	      if (curmap->is_up(from)) {
1715		note_peer_epoch(from, m->map_epoch);
(gdb) p curmap
$1 = std::tr1::shared_ptr (empty) 0x0

-- Jim

> Thanks for the info!
> -Sam
>
> On Tue, Jul 17, 2012 at 2:54 PM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> On 07/17/2012 03:44 PM, Samuel Just wrote:
>>>
>>> Not quite.  OSDService::get_osdmap() returns the most recently
>>> published osdmap.  Generally, OSD::osdmap is safe to use when you are
>>> holding the osd lock.  Otherwise, OSDService::get_osdmap() should be
>>> used.  There are a few other things that should be fixed surrounding
>>> this issue as well, I'll put some time into it today.  The map_lock
>>> should probably be removed all together.
>>
>>
>> Thanks for taking a look.  Let me know when
>> you get something, and I'll take it for a spin.
>>
>> Thanks -- Jim
>>
>>> -Sam
>>
>>
>>
>
>


