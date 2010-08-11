From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: RE: MonitorStore.cc assert
Date: Wed, 11 Aug 2010 09:08:09 +0200
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D670C562ABB@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
References: <14C7F4F06DB5814AB0DE29716C4F6D670C562AB6@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail6.alcatel.fr ([64.208.49.42]:58966 "EHLO smail6.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab0HKHIM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 03:08:12 -0400
Received: from FRMRSSXCHHUB03.dc-m.alcatel-lucent.com (FRMRSSXCHHUB03.dc-m.alcatel-lucent.com [135.120.45.63])
	by smail6.alcatel.fr (8.14.3/8.14.3/ICT) with ESMTP id o7B788nD027108
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 11 Aug 2010 09:08:09 +0200
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D670C562AB6@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

And also something similar on my other server

10.08.11_00:14:54.656802 7fbdf3c14710 log [WRN] : lease_expire from mon0 was sent from future time 10.08.11_00:14:58.132006, clocks not synchronized
10.08.11_00:14:54.656814 7fbdf3c14710 log [WRN] :
mon/MonitorStore.cc: In function 'int MonitorStore::write_bl_ss(ceph::bufferlist&, const char*, const char*, bool, bool)':
mon/MonitorStore.cc:273: FAILED assert(!err)
 1: (Paxos::store_state(MMonPaxos*)+0xe6) [0x47b5d6]
 2: (Paxos::handle_commit(MMonPaxos*)+0x3e) [0x47b8fe]
 3: (Paxos::dispatch(PaxosServiceMessage*)+0x18b) [0x47fe4b]
 4: (Monitor::_ms_dispatch(Message*)+0x82d) [0x46d76d]
 5: (Monitor::ms_dispatch(Message*)+0x57) [0x4799b7]
 6: (SimpleMessenger::dispatch_entry()+0x79b) [0x453b6b]
 7: (SimpleMessenger::DispatchThread::entry()+0x1f) [0x44abbf]
 8: (Thread::_entry_func(void*)+0xa) [0x45d4da]
 9: (()+0x68ba) [0x7fbdf5ee68ba]
 10: (clone()+0x6d) [0x7fbdf510101d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

- Jan
 

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Smets, 
> Jan (Jan)
> Sent: woensdag 11 augustus 2010 9:06
> To: ceph-devel@vger.kernel.org
> Subject: MonitorStore.cc assert
> 
> I was not using ceph at that time, and my clocks are drifting 
> somehow ...
> 
> Last logs seen:
> 
> 10.08.10_22:55:02.051810 7fdbdaac9710 log [WRN] : 
> lease_expire from mon0 was sent from future time 
> 10.08.10_22:55:03.346407, clocks not synchronized
> ...
> 10.08.11_00:16:49.492554 7fe740de6710 mds0.2  last tick was 
> 90.001027 > 5 seconds ago, laggy_until 0.000000, setting laggy flag
> 
> 
> 
> 
> mon/MonitorStore.cc: In function 'int 
> MonitorStore::write_bl_ss(ceph::bufferlist&, const char*, 
> const char*, bool, bool)':
> mon/MonitorStore.cc:273: FAILED assert(!err)
>  1: (Paxos::stash_latest(unsigned long, 
> ceph::buffer::list&)+0x170) [0x47a780]
>  2: (LogMonitor::update_from_paxos()+0x7bd) [0x4ca5cd]
>  3: (Monitor::_ms_dispatch(Message*)+0x851) [0x46d791]
>  4: (Monitor::ms_dispatch(Message*)+0x57) [0x4799b7]
>  5: (SimpleMessenger::dispatch_entry()+0x79b) [0x453b6b]
>  6: (SimpleMessenger::DispatchThread::entry()+0x1f) [0x44abbf]
>  7: (Thread::_entry_func(void*)+0xa) [0x45d4da]
>  8: (()+0x68ba) [0x7fdbdcd9b8ba]
>  9: (clone()+0x6d) [0x7fdbdbfb601d]
>  NOTE: a copy of the executable, or `objdump -rdS 
> <executable>` is needed to interpret this.
> 
> Executable is the one from:
> 
> ii  ceph                                
> 0.21~rc-unstable201007281541-3ed08a33-1~bpo50+1 distributed 
> storage and file system
> 
> 
> At your service.
>  - Jan
> --
> To unsubscribe from this list: send the line "unsubscribe 
> ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 