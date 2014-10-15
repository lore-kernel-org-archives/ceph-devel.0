From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params
Date: Wed, 15 Oct 2014 02:59:56 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D0144A9B3@shsmsx102.ccr.corp.intel.com>
References: <54348A89.1060906@redhat.com> <20141008183234.19a24ac1@doppio>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com>
 <54358409.8040709@profihost.ag>
 <622F4407872BA447A16110F65453358C033B02A3E23F@FMSAMAIL.fmsa.local>
 <20141014132242.3812bcd1@doppio>
 <alpine.DEB.2.00.1410140612300.31128@cobra.newdream.net>
 <20141014163806.4b3babc0@doppio>
 <75674D092A819E4189E91166C74CB90D0144A660@shsmsx102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1410141918200.10462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34414 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536AbaJOC77 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 22:59:59 -0400
In-Reply-To: <alpine.DEB.2.00.1410141918200.10462@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andreas Bluemle <andreas.bluemle@itxperts.de>, Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>, Stefan Priebe <s.priebe@profihost.ag>, Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Zhang, Jian" <jian.zhang@intel.com>

Hi sage ,

With latest master , we do set 'osd_enable_op_tracker = false' , we tested up to 7 rbd clients in our test , but after two clients, the iops is stable at ~23K, there is no performance gain with more clients

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Wednesday, October 15, 2014 10:23 AM
To: Shu, Xinxin
Cc: Andreas Bluemle; Paul Von-Stamwitz; Stefan Priebe; Somnath Roy; ceph-devel@vger.kernel.org; Zhang, Jian
Subject: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params

On Wed, 15 Oct 2014, Shu, Xinxin wrote:
> Hi all , recently we tested 4K random write performance on our full 
> SSD setup (12 x Intel DC3700) , but peak performance is ~23K IOPS, 
> which is much lower than hardware capability , with detail latency 
> breakdown , we found that most of latency comes from osd queue , we 
> have noticed the optimizations on osd queue , and tried latest master 
> on our setup , but there is a performance regression , we also checked 
> the qlock and pg lock with perf counter, the waiting count and latency 
> are very small, the attached pdf shows the details , any suggestion 
> will be appreciated ?

I would start by making sure 'osd enable op tracker = false' if it isn't already.

The other thing to keep in mind is that a lot of the work has enabled OSD perforamnce to scale as the clients increase.  It looks like your test has a single client.  Can you try running 2, 4, 8 clients and see if the per-OSD throughput goes up?

Digging into the code with a tool like vtune would be extremely helpful, I think.  There is a lot of time spent in do_op (osd prepare and osd queue) that fujitsu has called out but we haven't narrowed down where the time is being spent.

sage


> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Andreas Bluemle
> Sent: Tuesday, October 14, 2014 10:38 PM
> To: Sage Weil
> Cc: Paul Von-Stamwitz; Stefan Priebe; Somnath Roy; 
> ceph-devel@vger.kernel.org
> Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot 
> params
> 
> Hi Sage,
> 
> [embedded below]
> 
> On Tue, 14 Oct 2014 06:13:58 -0700 (PDT) Sage Weil <sage@newdream.net> wrote:
> 
> > On Tue, 14 Oct 2014, Andreas Bluemle wrote:
> > > Hi,
> > > 
> > > 
> > > On Wed, 8 Oct 2014 16:55:38 -0700
> > > Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com> wrote:
> > > 
> > > >  
> > > > > > Hi,
> > > > > >
> > > > > > as mentioned during today's meeting, here are the kernel 
> > > > > > boot parameters
> > > > > which I found to provide the basis for good performance results:
> > > > > >
> > > > > >    processor.max_cstate=0
> > > > > >    intel_idle.max_cstate=0
> > > > > >
> > > > > > I understand these to basically turn off any power saving 
> > > > > > modes of the
> > > > > CPU; the CPU's we are using are like
> > > > > >   Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz
> > > > > >   Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
> > > > > >
> > > > > > At the BIOS level, we
> > > > > >   - turn off Hyperthraeding
> > > > > >   - turn off Turbo mode (in order ot not leave the
> > > > > > specifications)
> > > > > >   - turn on frequency floor override
> > > > > >
> > > > > > We also assert that
> > > > > >   /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> > > > > >   is set to "performance"
> > > > > >
> > > > > > Using above we see a constant frequency at the maximum level 
> > > > > > allowed by
> > > > > the CPU (except Turbo mode).
> > > > > 
> > > > > How much performance do we gain by this? Till now i thought 
> > > > > it's just 1-3% so i'm still running ondemand govenor plus 
> > > > > power savings.
> > > > 
> > > > As always, it depends. I saw noticeable increases in some 
> > > > throughput tests (though I can't recall the % gain.) More 
> > > > important to me was that it made my fio results much more 
> > > > consistent. As we measure improvements, these settings remove 
> > > > some of the "system noise".
> > > > 
> > > > Best,
> > > > Paul
> > > > 
> > > 
> > > There were two different aspects which showed improvemnt:
> > >  - code was executed faster
> > >  - thread switching delays were reduced significantly
> > > 
> > > See the attached grahics. They show processing of a 4 kB write
> > > request: processing at the Pipe::Reader is roughly 200 us in both 
> > > pictures, and sth. like 20 us at the OSD::Dispatcher. So there is 
> > > not much of a benefit here.
> > > 
> > > But the delay between the end of the Pipe::Reader and the start of 
> > > the OSD::Dispatcher threads reduced really significantly.
> > 
> > This test had a single outstanding IO, right?  The question for me 
> > is if this reflect latencies we'd see under a realistic workload, 
> > where the are more IOs in flight and the CPUs aren't likely to be in 
> > low power states. I'm not sure how low the load needs to be before 
> > those states kick in and these latencies start to appear...
> > 
> > sage
> 
> Yes and no...
> 
> Yes: the test was a fio sequential write, 4k per write, with a single IO in flight.
> 
> No: this means that on a given object in the osd file store with the default size of 4 MByte, 1024 subsequent write requests will hit that object - and hence the corresponding ceph-osd daemon. So even though the system as a whole was not very busy, the ceph-osd daemon assigned to the file object under pressure was fairly busy.
> 
> The intention of the test was to eliminate additional latencies because of queues building up.
> 
> What the test shows is the contribution of the various processing 
> steps within ceph-osd to the overall latency for an individual write 
> requres when CPU power state related effects have been eliminated,
> 
> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
> 
> -- 
> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
> ITXperts GmbH                       http://www.itxperts.de
> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
> 
> Company details: http://www.itxperts.de/imprint.htm
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
