From: Sage Weil <sage@newdream.net>
Subject: Re: osd stops working with cep-0.21.3
Date: Thu, 23 Sep 2010 08:07:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009230806130.16100@cobra.newdream.net>
References: <AANLkTikzFomxEJNGjxpG+JDZtL-ZMpwh0OnyEa4VXRTf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52617 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab0IWPF6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 11:05:58 -0400
In-Reply-To: <AANLkTikzFomxEJNGjxpG+JDZtL-ZMpwh0OnyEa4VXRTf@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Stefan,

On Thu, 23 Sep 2010, Stefan Majer wrote:

> Hi,
> 
> we saw on one of our OSDs (16 in total) the followin assert.
> 
> osd/OSD.cc: In function 'void OSD::start_recovery_op(PG*, const sobject_t&)':
> osd/OSD.cc:4250: FAILED assert(recovery_oids.count(soid) == 0)
>  1: (PG::start_recovery_op(sobject_t const&)+0x127) [0x525627]
>  2: (ReplicatedPG::recover_object_replicas(sobject_t const&)+0x191) [0x482881]
>  3: (ReplicatedPG::recover_replicas(int)+0x2db) [0x482ddb]
>  4: (ReplicatedPG::start_recovery_ops(int)+0x92) [0x4832f2]
>  5: (OSD::do_recovery(PG*)+0x1e3) [0x4b8cf3]
>  6: (ThreadPool::worker()+0x291) [0x5ac5d1]
>  7: (ThreadPool::WorkThread::entry()+0xd) [0x4ec93d]
>  8: (Thread::_entry_func(void*)+0x7) [0x46eee7]
>  9: (()+0x77e1) [0x7f952e6917e1]
>  10: (clone()+0x6d) [0x7f952d8b551d]
> 
> Any hints to further nail down this problem.

Without logs, it's hard to tell what caused it.  Has it only happened the 
one time?  Did the OSD behave when it was restarted?

Generally speaking, 'debug osd = 20' and 'debug ms = 1' would have the 
context needed to identify the problem, but it's a lot of a logging and 
will slow things down some.  

sage
