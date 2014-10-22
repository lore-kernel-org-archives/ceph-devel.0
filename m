From: Sage Weil <sage@newdream.net>
Subject: RE: The Async messenger benchmark with latest master
Date: Wed, 22 Oct 2014 14:01:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410221400390.29946@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282298FF@SACMBXIP02.sdcorp.global.sandisk.com> <CACJqLybtHOyPw8+2bcFGZoScoKxH7QqENi0NKUzfwuYk=D8axw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F1D8@SACMBXIP02.sdcorp.global.sandisk.com>
 <CACJqLyaqDypZpN6wqYg7aGoGbOOQJcsKcRUGk23yxTRf4sRUng@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F290@SACMBXIP02.sdcorp.global.sandisk.com> <CACJqLya+ietkH=WV-c710z1P7BaO9TmTqMSdhiDP_4ncoNo84Q@mail.gmail.com> <alpine.DEB.2.00.1410221051580.29946@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F3C7@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39735 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbaJVVBx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 17:01:53 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F3C7@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 22 Oct 2014, Somnath Roy wrote:
> Sage,
> So, with krbd as client, should I use 'ms_type = random' in the cluster side to test Async messenger in the cluster side?
> BTW, what this option does ? It will pick Async first and fall back to old messenger in case any problem ?

You can just use ms_type = async.  random will randomly choose between the 
two, the idea being you can spin up a big (test) cluster with ms_type = 
random and you'll test interoperability between the two without 
manually specifying which daemon uses which implementation.

sage



> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net] 
> Sent: Wednesday, October 22, 2014 10:53 AM
> To: Haomai Wang
> Cc: Somnath Roy; ceph-devel@vger.kernel.org
> Subject: Re: The Async messenger benchmark with latest master
> 
> On Thu, 23 Oct 2014, Haomai Wang wrote:
> > It should be but I'm not convinced of the current impl of 
> > AsyncMessenger. It's possible that exists some corner situations which 
> > may break
> 
> The 'ms_type = random' option we added should give us some confidnece that this is true (by doing QA on mixes old both messenger implementations).
> 
> sage
> 
> 
> > 
> > On Thu, Oct 23, 2014 at 1:18 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > > Thanks Haomai, I will try this branch out.
> > > BTW, will it be compatible with the client which is not using this async messenger for example krbd ?
> > >
> > > Regards
> > > Somnath
> > >
> > > -----Original Message-----
> > > From: Haomai Wang [mailto:haomaiwang@gmail.com]
> > > Sent: Wednesday, October 22, 2014 10:02 AM
> > > To: Somnath Roy
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: Re: The Async messenger benchmark with latest master
> > >
> > > ms_type = async is needed to add [global] section in ceph.conf
> > >
> > > No other options are needed
> > >
> > > On Thu, Oct 23, 2014 at 12:02 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > >> Hi Haomai/Sage,
> > >>
> > >> I just figured it out that Async messenger is not yet in master. 
> > >> So, I didn't really test the async messenger :-(
> > >>
> > >> I saw here is the pull request.
> > >>
> > >> https://github.com/ceph/ceph/pull/2768
> > >>
> > >> I want to test this out and I have some questions regarding this.
> > >>
> > >> 1.  The branch I should test out is the following, right ?
> > >>
> > >> https://github.com/ceph/ceph/tree/wip-msgr
> > >>
> > >> 2. Will Async messenger by default enabled ? OR I need to add some config option for that ?
> > >>
> > >> 3. Other than ms_event_op_threads , is there any tunable parameter I should be playing with ?
> > >>
> > >> Thanks & Regards
> > >> Somnath
> > >>
> > >> -----Original Message-----
> > >> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> > >> Sent: Saturday, October 18, 2014 10:15 PM
> > >> To: Somnath Roy
> > >> Cc: ceph-devel@vger.kernel.org
> > >> Subject: Re: The Async messenger benchmark with latest master
> > >>
> > >> Thanks Somnath!
> > >>
> > >> I have another simple performance test for async messenger:
> > >>
> > >> For 4k object read, master branch used 4.46s to complete tests, async Messenger used 3.14s For 4k object write, master branch used 10.6s to complete, async Messenger used 6.6s!!
> > >>
> > >> Detailf results see below, 4k object read is a simple ceph client 
> > >> program which will read 5000 objects and 4k object write will write
> > >> 5000 objects.
> > >> I increased "ms_event_op_threads" to 10 compared to the default value is 2.
> > >> Maybe Somnath can do it and tests again, I think we can get more improvements for your tests.
> > >>
> > >> Master Branch(6fa686c8c42937dd069591f16de92e954d8ed34d):
> > >>
> > >> [root@ceph-test src]# for i in `seq 1 3`; do date && 
> > >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 && 
> > >> sleep 3; done
> > >>
> > >> Fri Oct 17 17:10:39 UTC 2014
> > >>
> > >> Used Time:4.461581
> > >>
> > >> Fri Oct 17 17:10:44 UTC 2014
> > >>
> > >> Used Time:4.388572
> > >>
> > >> Fri Oct 17 17:10:48 UTC 2014
> > >>
> > >> Used Time:4.448157
> > >>
> > >> [root@ceph-test src]#
> > >>
> > >> [root@ceph-test src]# for i in `seq 1 3`; do date && 
> > >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 && 
> > >> sleep 3; doneFri Oct 17 17:11:23 UTC 2014
> > >>
> > >> Used Time:10.638783
> > >>
> > >> Fri Oct 17 17:11:33 UTC 2014
> > >>
> > >> Used Time:10.793231
> > >>
> > >> Fri Oct 17 17:11:44 UTC 2014
> > >>
> > >> Used Time:10.908003
> > >>
> > >>
> > >> Master Branch with AsyncMessenger:
> > >>
> > >> [root@ceph-test src]# for i in `seq 1 3`; do date && 
> > >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 && 
> > >> sleep 3; done
> > >>
> > >> Sun Oct 19 06:01:50 UTC 2014
> > >>
> > >> Used Time:3.155506
> > >>
> > >> Sun Oct 19 06:01:53 UTC 2014
> > >>
> > >> Used Time:3.134961
> > >>
> > >> Sun Oct 19 06:01:56 UTC 2014
> > >>
> > >> Used Time:3.135814
> > >>
> > >> [root@ceph-test src]# for i in `seq 1 3`; do date && 
> > >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 && 
> > >> sleep 3; done
> > >>
> > >> Sun Oct 19 06:02:03 UTC 2014
> > >>
> > >> Used Time:6.536319
> > >>
> > >> Sun Oct 19 06:02:10 UTC 2014
> > >>
> > >> Used Time:6.648738
> > >>
> > >> Sun Oct 19 06:02:16 UTC 2014
> > >>
> > >> Used Time:6.585156
> > >>
> > >> On Sat, Oct 18, 2014 at 4:37 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > >>> Hi Sage/Haomai,
> > >>>
> > >>> I did some 4K Random Read benchmarking with latest master having Async messenger changes and result looks promising.
> > >>>
> > >>> My configuration:
> > >>> ---------------------
> > >>>
> > >>> 1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg 
> > >>> cluster wide Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, dual socket, HT enabled, 40 cores.
> > >>> Used krbd as client.
> > >>>
> > >>>
> > >>> 1 clinet node with 3 rbd images on 3 different pools:
> > >>> ------------------------------------------------------------------
> > >>> -
> > >>> Master :
> > >>> ---------
> > >>>
> > >>> ~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB
> > >>>
> > >>>     lat (usec) : 4=0.01%, 10=0.01%, 50=0.01%, 100=0.01%, 250=0.03%
> > >>>     lat (usec) : 500=0.86%, 750=3.72%, 1000=7.19%
> > >>>     lat (msec) : 2=39.17%, 4=41.45%, 10=7.26%, 20=0.24%, 50=0.06%
> > >>>     lat (msec) : 100=0.03%, 250=0.01%, 500=0.01%
> > >>>
> > >>> cpu: ~1-2 % idle
> > >>>
> > >>> Giant:
> > >>> ------
> > >>>
> > >>> ~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB
> > >>>
> > >>>     lat (usec) : 250=0.01%, 500=0.51%, 750=2.71%, 1000=6.03%
> > >>>     lat (msec) : 2=34.32%, 4=45.74%, 10=10.46%, 20=0.21%, 50=0.02%
> > >>>     lat (msec) : 100=0.01%, 250=0.01%
> > >>>
> > >>> cpu: ~2% idle
> > >>>
> > >>> 2 clients with 3 rbd images each on 3 different pools:
> > >>> ------------------------------------------------------------------
> > >>> -
> > >>>
> > >>> Master :
> > >>> ---------
> > >>>
> > >>> ~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB
> > >>>
> > >>>     lat (usec) : 250=0.03%, 500=0.63%, 750=2.67%, 1000=5.21%
> > >>>     lat (msec) : 2=25.12%, 4=36.19%, 10=24.80%, 20=3.16%, 50=1.34%
> > >>>     lat (msec) : 100=0.66%, 250=0.18%, 500=0.01%
> > >>>
> > >>> cpu: ~0-1 % idle
> > >>>
> > >>> Giant:
> > >>> --------
> > >>> ~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB
> > >>>
> > >>>     lat (usec) : 250=0.01%, 500=0.25%, 750=1.47%, 1000=3.45%
> > >>>     lat (msec) : 2=21.22%, 4=36.69%, 10=30.63%, 20=4.28%, 50=1.70%
> > >>>     lat (msec) : 100=0.28%, 250=0.02%, 500=0.01%
> > >>>
> > >>> cpu: ~1% idle
> > >>>
> > >>>
> > >>> So, in summary the master with Async messenger has improved both in iops and latency.
> > >>>
> > >>> Thanks & Regards
> > >>> Somnath
> > >>>
> > >>> ________________________________
> > >>>
> > >>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > >>>
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > >>> in the body of a message to majordomo@vger.kernel.org More 
> > >>> majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>
> > >>
> > >>
> > >> --
> > >> Best Regards,
> > >>
> > >> Wheat
> > >
> > >
> > >
> > > --
> > > Best Regards,
> > >
> > > Wheat
> > 
> > 
> > 
> > --
> > Best Regards,
> > 
> > Wheat
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
