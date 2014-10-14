From: Sage Weil <sage@newdream.net>
Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params
Date: Tue, 14 Oct 2014 06:13:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410140612300.31128@cobra.newdream.net>
References: <54348A89.1060906@redhat.com> <20141008183234.19a24ac1@doppio> <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com> <54358409.8040709@profihost.ag> <622F4407872BA447A16110F65453358C033B02A3E23F@FMSAMAIL.fmsa.local>
 <20141014132242.3812bcd1@doppio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34976 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbaJNNN7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 09:13:59 -0400
In-Reply-To: <20141014132242.3812bcd1@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>, Stefan Priebe <s.priebe@profihost.ag>, Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 14 Oct 2014, Andreas Bluemle wrote:
> Hi,
> 
> 
> On Wed, 8 Oct 2014 16:55:38 -0700
> Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com> wrote:
> 
> >  
> > > > Hi,
> > > >
> > > > as mentioned during today's meeting, here are the kernel boot
> > > > parameters
> > > which I found to provide the basis for good performance results:
> > > >
> > > >    processor.max_cstate=0
> > > >    intel_idle.max_cstate=0
> > > >
> > > > I understand these to basically turn off any power saving modes
> > > > of the
> > > CPU; the CPU's we are using are like
> > > >   Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz
> > > >   Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
> > > >
> > > > At the BIOS level, we
> > > >   - turn off Hyperthraeding
> > > >   - turn off Turbo mode (in order ot not leave the specifications)
> > > >   - turn on frequency floor override
> > > >
> > > > We also assert that
> > > >   /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> > > >   is set to "performance"
> > > >
> > > > Using above we see a constant frequency at the maximum level
> > > > allowed by
> > > the CPU (except Turbo mode).
> > > 
> > > How much performance do we gain by this? Till now i thought it's
> > > just 1-3% so i'm still running ondemand govenor plus power savings.
> > 
> > As always, it depends. I saw noticeable increases in some throughput
> > tests (though I can't recall the % gain.) More important to me was
> > that it made my fio results much more consistent. As we measure
> > improvements, these settings remove some of the "system noise".
> > 
> > Best,
> > Paul
> > 
> 
> There were two different aspects which showed improvemnt:
>  - code was executed faster
>  - thread switching delays were reduced significantly
> 
> See the attached grahics. They show processing of a 4 kB write
> request: processing at the Pipe::Reader is roughly 200 us in both
> pictures, and sth. like 20 us at the OSD::Dispatcher. So there
> is not much of a benefit here.
> 
> But the delay between the end of the Pipe::Reader and the start
> of the OSD::Dispatcher threads reduced really significantly.

This test had a single outstanding IO, right?  The question for me is if 
this reflect latencies we'd see under a realistic workload, where the are 
more IOs in flight and the CPUs aren't likely to be in low power states.  
I'm not sure how low the load needs to be before those states kick in and 
these latencies start to appear...

sage
