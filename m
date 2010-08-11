From: Sage Weil <sage@newdream.net>
Subject: Re: MonitorStore.cc assert
Date: Wed, 11 Aug 2010 09:06:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008110904410.6194@cobra.newdream.net>
References: <14C7F4F06DB5814AB0DE29716C4F6D670C562AB6@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56709 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab0HKQGB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 12:06:01 -0400
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D670C562AB6@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 11 Aug 2010, Smets, Jan (Jan) wrote:
> I was not using ceph at that time, and my clocks are drifting somehow ...
>
> Last logs seen:
> 
> 10.08.10_22:55:02.051810 7fdbdaac9710 log [WRN] : lease_expire from mon0 was sent from future time 10.08.10_22:55:03.346407, clocks not synchronized
> ...
> 10.08.11_00:16:49.492554 7fe740de6710 mds0.2  last tick was 90.001027 > 5 seconds ago, laggy_until 0.000000, setting laggy flag
> 
> 
> 
> 
> mon/MonitorStore.cc: In function 'int MonitorStore::write_bl_ss(ceph::bufferlist&, const char*, const char*, bool, bool)':
> mon/MonitorStore.cc:273: FAILED assert(!err)
>  1: (Paxos::stash_latest(unsigned long, ceph::buffer::list&)+0x170) [0x47a780]
>  2: (LogMonitor::update_from_paxos()+0x7bd) [0x4ca5cd]
>  3: (Monitor::_ms_dispatch(Message*)+0x851) [0x46d791]
>  4: (Monitor::ms_dispatch(Message*)+0x57) [0x4799b7]
>  5: (SimpleMessenger::dispatch_entry()+0x79b) [0x453b6b]
>  6: (SimpleMessenger::DispatchThread::entry()+0x1f) [0x44abbf]
>  7: (Thread::_entry_func(void*)+0xa) [0x45d4da]
>  8: (()+0x68ba) [0x7fdbdcd9b8ba]
>  9: (clone()+0x6d) [0x7fdbdbfb601d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

Usually this error means your disk filled up (ENOSPC).  Probably because 
it's filling up the logs about clock drift.  :)  We'll add something to 
throttle those.

In the meantime, you can zap the plaintext logs (rm $mon_data/log*) 
safely.

sage
