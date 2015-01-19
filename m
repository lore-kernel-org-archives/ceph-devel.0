From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Mon, 19 Jan 2015 10:28:51 +0100
Message-ID: <20150119102851.5032c467@doppio>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com>
	<3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827792D@SACMBXIP02.sdcorp.global.sandisk.com>
	<20150115114325.50a69138@doppio>
	<alpine.DEB.2.00.1501150913400.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:36924 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbASJ3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 04:29:06 -0500
In-Reply-To: <alpine.DEB.2.00.1501150913400.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

I tried both "ceph osd reweight-by-pg 110" and
"ceph osd reweight-by-pg 105". The first reweight shows:
   SUCCESSFUL reweight-by-pg:
       average 684.250000,  overload 752.675000.
       reweighted: osd.1 [1.000000 -> 0.901505])

The second reweight shows:
   SUCCESSFUL reweight-by-pg:
      average 684.250000, overload 718.462500.
      reweighted: osd.1 [0.901505 -> 0.853180],
                  osd.4 [1.000000 -> 0.941193],
                  osd.10 [1.000000 -> 0.945084],

So only the 2nd reweight directly affected osd.10
(where osd.10 was the one where message count throttle
hits had concentrated on).

Running my test profile showed some relief on the
message count throttle hits after each of the reweigth
commands on pool rbd. However: I now encounter hits
on the other pools.

So my guess is that it is the specific combination of my
load profile and the distribution of placement groups
which causes the message count throttle to hit. And
I was only lucky in some sense when modifiying the number
of placement group and achieving a well-behaving distribution.


Regards

Andreas Bluemle
   
On Thu, 15 Jan 2015 09:15:32 -0800 (PST)
Sage Weil <sage@newdream.net> wrote:

> On Thu, 15 Jan 2015, Andreas Bluemle wrote:
> > Hi,
> > 
> > I went from using v0.88 to v0.90 and can confirm the
> > that performance is similar between these two versions.
> > 
> > I am using config settings similar to the values given by
> > Somnath.
> > 
> > There is one difference in my settings: where Somanth has disabled
> > message throttling both for the number of messages and the amount
> > of message data, I am using the settiings:
> > 
> >   "osd_client_message_size_cap": "524288000"   (default)
> >   "osd_client_message_cap": "3000"             (default is 100)
> > 
> > With my test profile (small, i.e. 4k, random writes), the message
> > size throttle is no problem - but the message count throttle
> > is worth to look at:
> > 
> > with my test profile I hit this throttle - but this seems to depend
> > on the number of placement groups (or the distribution achieved
> > by different placement group set).
> > 
> > I have configured my cluster (3 nodes, 12 osds) with 3 rbd pools:
> >    rbd with 768 pgs (default)
> >    rbd2 with 3000 pgs
> >    rbd3 with 769 pgs
> > 
> > I don't see any hits of message count throttle on rbd2 and rbd3 -
> > but on rbd, I see the message throttle hits about 3.750 times
> > during a test with a total of 262.144 client write request within a
> > period of approx. 35 seconds. All of the hits of the message count
> > throttle happen on a single osd; there is no hit of the message
> > count throttle on any of the other 11 osds. 
> 
> The difference between rbd and rbd3 is pretty surprising.. it makes
> me think that the rbd distribution is just a bit unlucky.  Can you
> try this?
> 
>  ceph osd reweight-by-pg 110
> 
> or possibly 105 and see if that changes things?
> 
> > Sage: yesterday, you had been asking for a value of the message
> > count throttle where my tests start to run smoothly - and I can't
> > give an answer. It depends on the distribution of I/O requests
> > achieved by the specific set of pg's - and vice versa, a different
> > pattern of I/O requests will change the behavior again.
> 
> Understood.  This is actually good news, I think.. it's not the
> throttle itself that's problematic but that the rbd distrbution is
> too inbalanced.
> 
> Thanks!
> sage
> 
> 
> 
> 
> > 
> > 
> > 
> > Regards
> > 
> > Andreas Bluemle
> > 
> > On Wed, 14 Jan 2015 22:44:01 +0000
> > Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > 
> > > Stephen,
> > > You may want to tweak the following parameter(s) in your ceph.conf
> > > file and see if it is further improving your performance or not.
> > > 
> > > debug_lockdep = 0/0
> > > debug_context = 0/0
> > > debug_crush = 0/0
> > > debug_buffer = 0/0
> > > debug_timer = 0/0
> > > debug_filer = 0/0
> > > debug_objecter = 0/0
> > > debug_rados = 0/0
> > > debug_rbd = 0/0
> > > debug_journaler = 0/0
> > > debug_objectcatcher = 0/0
> > > debug_client = 0/0
> > > debug_osd = 0/0
> > > debug_optracker = 0/0
> > > debug_objclass = 0/0
> > > debug_filestore = 0/0
> > > debug_journal = 0/0
> > > debug_ms = 0/0
> > > debug_monc = 0/0
> > > debug_tp = 0/0
> > > debug_auth = 0/0
> > > debug_finisher = 0/0
> > > debug_heartbeatmap = 0/0
> > > debug_perfcounter = 0/0
> > > debug_asok = 0/0
> > > debug_throttle = 0/0
> > > debug_mon = 0/0
> > > debug_paxos = 0/0
> > > debug_rgw = 0/0
> > > osd_op_num_threads_per_shard = 2 //You may want to try with 1 as
> > > well osd_op_num_shards = 10    //Depends on your cpu util
> > > ms_nocrc = true
> > > cephx_sign_messages = false
> > > cephx_require_signatures = false
> > > ms_dispatch_throttle_bytes = 0
> > > throttler_perf_counter = false
> > > 
> > > [osd]
> > > osd_client_message_size_cap = 0
> > > osd_client_message_cap = 0
> > > osd_enable_op_tracker = false
> > > 
> > > Also, run more clients (in your case rados bench) and see if it is
> > > scaling or not (it should, till it saturates your cpu).
> > > 
> > > But, your observation on RHEL7 vs UBUNTU 14.04 LTS is
> > > interesting !
> > > 
> > > Thanks & Regards
> > > Somnath
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org
> > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Blinick,
> > > Stephen L Sent: Wednesday, January 14, 2015 2:32 PM To: Ceph
> > > Development Subject: RE: Memstore performance improvements v0.90
> > > vs v0.87
> > > 
> > > I went back and grabbed 87 and built it on RHEL7 as well, and
> > > performance is also similar (much better).  I've also run it on a
> > > few systems (Dual socket 10-core E5v2,  Dual socket 6-core
> > > E5v3).  So, it's related to my switch to RHEL7, and not to the
> > > code changes between v0.90 and v0.87.     Will post when I get
> > > more data.
> > > 
> > > Thanks,
> > > 
> > > Stephen
> > > 
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org
> > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Blinick,
> > > Stephen L Sent: Wednesday, January 14, 2015 12:06 AM To: Ceph
> > > Development Subject: Memstore performance improvements v0.90 vs
> > > v0.87
> > > 
> > > In the process of moving to a new cluster (RHEL7 based) I grabbed
> > > v0.90, compiled RPM's and re-ran the simple local-node memstore
> > > test I've run on .80 - .87.  It's a single Memstore OSD and a
> > > single Rados Bench client locally on the same node.  Increasing
> > > queue depth and measuring latency /IOPS.  So far, the
> > > measurements have been consistent across different hardware and
> > > code releases (with about a 30% improvement with the OpWQ
> > > Sharding changes that came in after Firefly).
> > > 
> > > These are just very early results, but I'm seeing a very large
> > > improvement in latency and throughput with v90 on RHEL7.   Next
> > > I'm working to get lttng installed and working in RHEL7 to
> > > determine where the improvement is.   On previous levels, these
> > > measurements have been roughly the same using a real (fast)
> > > backend (i.e. NVMe flash), and I will verify here as well.   Just
> > > wondering if anyone else has measured similar improvements?
> > > 
> > > 
> > > 100% Reads or Writes, 4K Objects, Rados Bench
> > > 
> > > ========================
> > > V0.87: Ubuntu 14.04LTS
> > > 
> > > *Writes*
> > > #Thr    IOPS    Latency(ms)
> > > 1       618.80          1.61
> > > 2       1401.70         1.42
> > > 4       3962.73         1.00
> > > 8       7354.37         1.10
> > > 16      7654.67         2.10
> > > 32      7320.33         4.37
> > > 64      7424.27         8.62
> > > 
> > > *Reads*
> > > #thr    IOPS    Latency(ms)
> > > 1       837.57          1.19
> > > 2       1950.00         1.02
> > > 4       6494.03         0.61
> > > 8       7243.53         1.10
> > > 16      7473.73         2.14
> > > 32      7682.80         4.16
> > > 64      7727.10         8.28
> > > 
> > > 
> > > ========================
> > > V0.90:  RHEL7
> > > 
> > > *Writes*
> > > #Thr    IOPS    Latency(ms)
> > > 1       2558.53         0.39
> > > 2       6014.67         0.33
> > > 4       10061.33        0.40
> > > 8       14169.60        0.56
> > > 16      14355.63        1.11
> > > 32      14150.30        2.26
> > > 64      15283.33        4.19
> > > 
> > > *Reads*
> > > #Thr    IOPS    Latency(ms)
> > > 1       4535.63         0.22
> > > 2       9969.73         0.20
> > > 4       17049.43        0.23
> > > 8       19909.70        0.40
> > > 16      20320.80        0.79
> > > 32      19827.93        1.61
> > > 64      22371.17        2.86
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html -- To unsubscribe from
> > > this list: send the line "unsubscribe ceph-devel" in the body of
> > > a message to majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> > > 
> > > ________________________________
> > > 
> > > PLEASE NOTE: The information contained in this electronic mail
> > > message is intended only for the use of the designated
> > > recipient(s) named above. If the reader of this message is not
> > > the intended recipient, you are hereby notified that you have
> > > received this message in error and that any review,
> > > dissemination, distribution, or copying of this message is
> > > strictly prohibited. If you have received this communication in
> > > error, please notify the sender by telephone or e-mail (as shown
> > > above) immediately and destroy any and all copies of this message
> > > in your possession (whether hard copies or electronically stored
> > > copies).
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> > 
> > 
> > -- 
> > Andreas Bluemle
> > mailto:Andreas.Bluemle@itxperts.de ITXperts
> > GmbH                       http://www.itxperts.de Balanstrasse 73,
> > Geb. 08            Phone: (+49) 89 89044917 D-81541 Muenchen
> > (Germany)          Fax:   (+49) 89 89044910
> > 
> > Company details: http://www.itxperts.de/imprint.htm
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
