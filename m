From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Thu, 25 Jul 2013 08:19:59 +0200
Message-ID: <51F0C38F.1080408@profihost.ag>
References: <51EF7CC8.9070507@profihost.ag> <alpine.DEB.2.00.1307241616040.32311@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:32792 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab3GYGUI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 02:20:08 -0400
In-Reply-To: <alpine.DEB.2.00.1307241616040.32311@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 25.07.2013 01:19, schrieb Sage Weil:
> On Wed, 24 Jul 2013, Stefan Priebe - Profihost AG wrote:
>> 2013-07-24 08:41:56.097385 7fae6384a780 -1 mon/OSDMonitor.cc: In
>> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
>> 7fae6384a780 time 2013-07-24 08:41:56.096683
>> mon/OSDMonitor.cc: 156: FAILED assert(latest_full > 0)
>>
>>  ceph version 0.61.6-15-g85db066 (85db0667307ac803c753d16fa374dd2fc29d76f3)
>>  1: (OSDMonitor::update_from_paxos(bool*)+0x2413) [0x50f5a3]
>>  2: (PaxosService::refresh(bool*)+0xe6) [0x4f2c66]
>>  3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x48f7b7]
>>  4: (Monitor::init_paxos()+0xe5) [0x48f955]
>>  5: (Monitor::preinit()+0x679) [0x4bba79]
>>  6: (main()+0x36b0) [0x484bb0]
>>  7: (__libc_start_main()+0xfd) [0x7fae619a6c8d]
>>  8: /usr/bin/ceph-mon() [0x4801e9]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
> 
> This is fixed in the cuttlefish branch as of earlier this afternoon.  I've 
> spent most of the day expanding the automated test suite to include 
> upgrade combinations to trigger this and *finally* figured out that this 
> particular problem seems to surface on clusters that upgraded from bobtail 
> -> cuttlefish but not clusters created on cuttlefish.

Thanks!


> If you've run into this issue, please use the cuttlefish branch build for 
> now.  We will have a release out in the next day or so that includes this 
> and a few other pending fixes.
> 
> I'm sorry we missed this one!  The upgrade test matrix I've been working 
> on today should catch this type of issue in the future.

Thanks!

Stefan
