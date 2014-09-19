From: Sage Weil <sweil@redhat.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Fri, 19 Sep 2014 08:28:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409190826260.18018@cobra.newdream.net>
References: <260f7b0e-3db6-4c27-814a-9d2d690cd965@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44192 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990AbaISP2G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 11:28:06 -0400
In-Reply-To: <260f7b0e-3db6-4c27-814a-9d2d690cd965@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Xinxin Shu <xinxin.shu@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Haomai Wang <haomaiwang@gmail.com>

On Fri, 19 Sep 2014, Alexandre DERUMIER wrote:
> >>Crazy, I've 56 SSDs and can?t go above 20 000 iops.
> 
> I just notice than my fio benchmark is cpu bound...
> 
> I can reach around 40000iops. Don't have more client machines for the moment to bench

A quick aside on the fio testing: Mark noticed a few weeks back that the 
fio rbd driver is doing quite the right thing when you turn up the number 
of threads: each one issues its own IOs but they touch the same blocks in 
the image (or something like that).  See

	http://tracker.ceph.com/issues/9391

It would be great to get this fixed in fio...

sage


> 
> 
> ----- Mail original ----- 
> 
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag> 
> ?: "Xinxin Shu" <xinxin.shu@intel.com>, "Somnath Roy" <Somnath.Roy@sandisk.com>, "Alexandre DERUMIER" <aderumier@odiso.com>, "Haomai Wang" <haomaiwang@gmail.com> 
> Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org 
> Envoy?: Vendredi 19 Septembre 2014 15:31:14 
> Objet: Re: severe librbd performance degradation in Giant 
> 
> Am 19.09.2014 um 15:02 schrieb Shu, Xinxin: 
> > 12 x Intel DC 3700 200GB, every SSD has two OSDs. 
> 
> Crazy, I've 56 SSDs and can?t go above 20 000 iops. 
> 
> Gr??e Stefan 
> 
> > Cheers, 
> > xinxin 
> > 
> > -----Original Message----- 
> > From: Stefan Priebe [mailto:s.priebe@profihost.ag] 
> > Sent: Friday, September 19, 2014 2:54 PM 
> > To: Shu, Xinxin; Somnath Roy; Alexandre DERUMIER; Haomai Wang 
> > Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org 
> > Subject: Re: severe librbd performance degradation in Giant 
> > 
> > Am 19.09.2014 03:08, schrieb Shu, Xinxin: 
> >> I also observed performance degradation on my full SSD setup , I can 
> >> got ~270K IOPS for 4KB random read with 0.80.4 , but with latest 
> >> master , I only got ~12K IOPS 
> > 
> > This are impressive numbers. Can you tell me how many OSDs you have and which SSDs you use? 
> > 
> > Thanks, 
> > Stefan 
> > 
> > 
> >> Cheers, 
> >> xinxin 
> >> 
> >> -----Original Message----- 
> >> From: ceph-devel-owner@vger.kernel.org 
> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy 
> >> Sent: Friday, September 19, 2014 2:03 AM 
> >> To: Alexandre DERUMIER; Haomai Wang 
> >> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org 
> >> Subject: RE: severe librbd performance degradation in Giant 
> >> 
> >> Alexandre, 
> >> What tool are you using ? I used fio rbd. 
> >> 
> >> Also, I hope you have Giant package installed in the client side as well and rbd_cache =true is set on the client conf file. 
> >> FYI, firefly librbd + librados and Giant cluster will work seamlessly and I had to make sure fio rbd is really loading giant librbd (if you have multiple copies around , which was in my case) for reproducing it. 
> >> 
> >> Thanks & Regards 
> >> Somnath 
> >> 
> >> -----Original Message----- 
> >> From: Alexandre DERUMIER [mailto:aderumier@odiso.com] 
> >> Sent: Thursday, September 18, 2014 2:49 AM 
> >> To: Haomai Wang 
> >> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org; Somnath Roy 
> >> Subject: Re: severe librbd performance degradation in Giant 
> >> 
> >>>> According http://tracker.ceph.com/issues/9513, do you mean that rbd 
> >>>> cache will make 10x performance degradation for random read? 
> >> 
> >> Hi, on my side, I don't see any degradation performance on read (seq or rand) with or without. 
> >> 
> >> firefly : around 12000iops (with or without rbd_cache) giant : around 
> >> 12000iops (with or without rbd_cache) 
> >> 
> >> (and I can reach around 20000-30000 iops on giant with disabling optracker). 
> >> 
> >> 
> >> rbd_cache only improve write performance for me (4k block ) 
> >> 
> >> 
> >> 
> >> ----- Mail original ----- 
> >> 
> >> De: "Haomai Wang" <haomaiwang@gmail.com> 
> >> ?: "Somnath Roy" <Somnath.Roy@sandisk.com> 
> >> Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" 
> >> <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org 
> >> Envoy?: Jeudi 18 Septembre 2014 04:27:56 
> >> Objet: Re: severe librbd performance degradation in Giant 
> >> 
> >> According http://tracker.ceph.com/issues/9513, do you mean that rbd cache will make 10x performance degradation for random read? 
> >> 
> >> On Thu, Sep 18, 2014 at 7:44 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote: 
> >>> Josh/Sage, 
> >>> I should mention that even after turning off rbd cache I am getting ~20% degradation over Firefly. 
> >>> 
> >>> Thanks & Regards 
> >>> Somnath 
> >>> 
> >>> -----Original Message----- 
> >>> From: Somnath Roy 
> >>> Sent: Wednesday, September 17, 2014 2:44 PM 
> >>> To: Sage Weil 
> >>> Cc: Josh Durgin; ceph-devel@vger.kernel.org 
> >>> Subject: RE: severe librbd performance degradation in Giant 
> >>> 
> >>> Created a tracker for this. 
> >>> 
> >>> http://tracker.ceph.com/issues/9513 
> >>> 
> >>> Thanks & Regards 
> >>> Somnath 
> >>> 
> >>> -----Original Message----- 
> >>> From: ceph-devel-owner@vger.kernel.org 
> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy 
> >>> Sent: Wednesday, September 17, 2014 2:39 PM 
> >>> To: Sage Weil 
> >>> Cc: Josh Durgin; ceph-devel@vger.kernel.org 
> >>> Subject: RE: severe librbd performance degradation in Giant 
> >>> 
> >>> Sage, 
> >>> It's a 4K random read. 
> >>> 
> >>> Thanks & Regards 
> >>> Somnath 
> >>> 
> >>> -----Original Message----- 
> >>> From: Sage Weil [mailto:sweil@redhat.com] 
> >>> Sent: Wednesday, September 17, 2014 2:36 PM 
> >>> To: Somnath Roy 
> >>> Cc: Josh Durgin; ceph-devel@vger.kernel.org 
> >>> Subject: RE: severe librbd performance degradation in Giant 
> >>> 
> >>> What was the io pattern? Sequential or random? For random a slowdown makes sense (tho maybe not 10x!) but not for sequentail.... 
> >>> 
> >>> s 
> >>> 
> >>> On Wed, 17 Sep 2014, Somnath Roy wrote: 
> >>> 
> >>>> I set the following in the client side /etc/ceph/ceph.conf where I am running fio rbd. 
> >>>> 
> >>>> rbd_cache_writethrough_until_flush = false 
> >>>> 
> >>>> But, no difference. BTW, I am doing Random read, not write. Still this setting applies ? 
> >>>> 
> >>>> Next, I tried to tweak the rbd_cache setting to false and I *got back* the old performance. Now, it is similar to firefly throughput ! 
> >>>> 
> >>>> So, loks like rbd_cache=true was the culprit. 
> >>>> 
> >>>> Thanks Josh ! 
> >>>> 
> >>>> Regards 
> >>>> Somnath 
> >>>> 
> >>>> -----Original Message----- 
> >>>> From: Josh Durgin [mailto:josh.durgin@inktank.com] 
> >>>> Sent: Wednesday, September 17, 2014 2:20 PM 
> >>>> To: Somnath Roy; ceph-devel@vger.kernel.org 
> >>>> Subject: Re: severe librbd performance degradation in Giant 
> >>>> 
> >>>> On 09/17/2014 01:55 PM, Somnath Roy wrote: 
> >>>>> Hi Sage, 
> >>>>> We are experiencing severe librbd performance degradation in Giant over firefly release. Here is the experiment we did to isolate it as a librbd problem. 
> >>>>> 
> >>>>> 1. Single OSD is running latest Giant and client is running fio rbd on top of firefly based librbd/librados. For one client it is giving ~11-12K iops (4K RR). 
> >>>>> 2. Single OSD is running Giant and client is running fio rbd on top of Giant based librbd/librados. For one client it is giving ~1.9K iops (4K RR). 
> >>>>> 3. Single OSD is running latest Giant and client is running Giant based ceph_smaiobench on top of giant librados. For one client it is giving ~11-12K iops (4K RR). 
> >>>>> 4. Giant RGW on top of Giant OSD is also scaling. 
> >>>>> 
> >>>>> 
> >>>>> So, it is obvious from the above that recent librbd has issues. I will raise a tracker to track this. 
> >>>> 
> >>>> For giant the default cache settings changed to: 
> >>>> 
> >>>> rbd cache = true 
> >>>> rbd cache writethrough until flush = true 
> >>>> 
> >>>> If fio isn't sending flushes as the test is running, the cache will stay in writethrough mode. Does the difference remain if you set rbd cache writethrough until flush = false ? 
> >>>> 
> >>>> Josh 
> >>>> 
> >>>> ________________________________ 
> >>>> 
> >>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies). 
> >>>> 
> >>>> -- 
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> >>>> in the body of a message to majordomo@vger.kernel.org More majordomo 
> >>>> info at http://vger.kernel.org/majordomo-info.html 
> >>>> 
> >>>> 
> >>> -- 
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> >>> in the body of a message to majordomo@vger.kernel.org More majordomo 
> >>> info at http://vger.kernel.org/majordomo-info.html 
> >>> -- 
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> >>> in the body of a message to majordomo@vger.kernel.org More majordomo 
> >>> info at http://vger.kernel.org/majordomo-info.html 
> >> 
> >> 
> >> 
> >> -- 
> >> Best Regards, 
> >> 
> >> Wheat 
> >> -- 
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at http://vger.kernel.org/majordomo-info.html 
> >> N r y b X ?v ^ )?{.n + z ]z {ay ?? ,j f h z w j:+v w j m zZ+ ?j" ! i 
> >> N r y b X ?v ^ )?{.n + z ]z {ay ?? ,j f h z w 
> > j:+v w j m zZ+ ?j" !tml= 
> >> 
> > N???????????????r??????y?????????b???X???????v???^???)?{.n???+?????????z???]z?????????{ay????????,j??????f?????????h?????????z??????w??????????????????j:+v?????????w???j???m????????????????????????zZ+????????????????j"??????!tml= 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
