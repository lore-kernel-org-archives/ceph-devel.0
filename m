From: Sage Weil <sweil@redhat.com>
Subject: Re:Re:Re: How does rbd-mirror preserve the order of WRITE operations
 that finished on the primary cluster
Date: Mon, 5 Jun 2017 22:22:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706052222060.3646@piezo.novalocal>
References: <70c5c552.66e6.15c766dce68.Coremail.xxhdx1985126@163.com> <CA+aFP1B=M97rVtGcY=v79zg_2rS=+NNcO5FTT32yLCZtky7N7g@mail.gmail.com> <75e21ee8.f334.15c78f23929.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706051616540.3646@piezo.novalocal>
 <428d3e79.3d2.15c7a56a64f.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2038219093-1496701358=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdFEWWi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 18:22:38 -0400
In-Reply-To: <428d3e79.3d2.15c7a56a64f.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: jdillama@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2038219093-1496701358=:3646
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 6 Jun 2017, xxhdx1985126 wrote:
> Thanks for your reply:-)
> 
> The requeueing is protected by PG::lock, however, when the write request is
> add to the transaction queue, it's left for the journaling thread and
> filestore thread, to do the actual write, the OSD's worker thread just
> release the PG::lock and try to retrieve the next req in OSD's work queue,
> which gives the opportunity for later reqs to go before previous reqs. This
> did happened in our experiment.

FileStore should also strictly order the requests via the OpSequencer.

> However, since this experiment was done serveral month ago, I'll upload the
> log if I can find it, or I'll try to reproduce it.

Okay, thanks!

sage


> 
> At 2017-06-06 00:21:34, "Sage Weil" <sweil@redhat.com> wrote:
> >On Mon, 5 Jun 2017, xxhdx1985126 wrote:
> >> 
> >> Uh, sorry, I don't quite follow you. According to my understanding of 
> >> the source code of OSD and our experiment previously mentioned in 
> >> "https://www.mail-archive.com/ceph-users@lists.ceph.com/msg36178.html", 
> >> there exists the following scenario where the actual finishing order of 
> >> the WRITEs that targets the same object is not the same as the order 
> >> they arrived at OSD, which, I think, could be a hint that the order of 
> >> writes from a single client connection to a single OSD is not guranteed:
> >
> >If so, it is a bug that should be fixed in the OSD.  rbd-mirror relying on 
> >OSD ordering to be correct is totally fine--lots of other stuff does too.
> >
> >>       Say three writes that targeting the same object A arrived at an 
> >> OSD in the order: "WRITE A.off 1", "WRITE A.off 2", "WRITE A.off 3". The 
> >> first write, "WRITE A.off 1", acquires the objectcontext lock of object 
> >> A, and is put into a transaction queue to go through the "journaling + 
> >> file system write" procedure. Before it's finished, a thread of 
> >> OSD::osd_op_tp retrieved the second write and attempt to process it 
> >> during which it finds that the objectcontext lock of A is held by a 
> >> previous WRITE and put the second write into A's rwstate::waiters queue. 
> >> It's only when the first write is finished on all replica OSDs that the 
> >> second write is put back into OSD::shardedop_wq to be processed again in 
> >> the future. If, after the second write is put into rwstate::waiters 
> >> queue and the first write is finished on all replica OSDs, in which case 
> >> the first write release the A's objectcontext lock, but before the 
> >> second write is put back into OSD::shardedop_wq, the third write is 
> >> retrieved by OSD's worker thread, it would get processed as no previous 
> >> operation is holding A's objectcontext lock, in which case, the actual 
> >> finishing order of the three writes is "WRITE A.off 1", "WRITE A.off 3", 
> >> "WRITE A.off 2", which is different from the order they arrived.
> >
> >This should not happen.  (If it happened in the past, it was a bug, but I 
> >would expect it is fixed in the latest hammer point release, and in jewel 
> >and master.)  The requeing is done under the PG::lock so that requeueing 
> >preserves ordering.  A fair bit of code and a *lot* of testing goes into 
> >ensuring that this is true.  If you've seen this recently, then a 
> >reproducer or log (and tracker ticket) would be welcome!  When we see any 
> >ordering errors in QA we take them very seriously and fix them quickly.
> >
> >You might be interested in the osd_debug_op_order config option, which we 
> >enable in qa, which asserts if it sees ops from a client arrive out of 
> >order.  The ceph_test_rados workload generate that we use for much of the 
> >rados qa suite also fails if it sees out of order operations.
> >
> >sage
> >
> >> 
> >> In https://www.mail-archive.com/ceph-users@lists.ceph.com/msg36178.html, 
> we showed our experiment result which is exactly as the above scenario shows
> .
> >> 
> >> However, the ceph's version on which we did the experiment and the souce 
> code of which we read was Hammer, 0.94.5. I don't know whether the scenario 
> above may still exists in later versions.
> >> 
> >> Am I right about this? Or am I missing anything? Please help me, I'm real
> ly confused right now. Thank you.
> >> 
> >> At 2017-06-05 20:00:06, "Jason Dillaman" <jdillama@redhat.com> wrote:
> >> >The order of writes from a single client connection to a single OSD is
> >> >guaranteed. The rbd-mirror journal replay process handles one event at
> >> >a time and does not start processing the next event until the IO has
> >> >been started in-flight with librados. Therefore, even though the
> >> >replay process allows 50 - 100 IO requests to be in-flight, those IOs
> >> >are actually well-ordered in terms of updates to a single object.
> >> >
> >> >Of course, such an IO request from the client application / VM would
> >> >be incorrect behavior if they didn't wait for the completion callback
> >> >before issuing the second update.
> >> >
> >> >On Mon, Jun 5, 2017 at 12:05 AM, xxhdx1985126 <xxhdx1985126@163.com> wro
> te:
> >> >> Hi, everyone.
> >> >>
> >> >>
> >> >> Recently, I've been reading the source code of rbd-mirror. I wonder ho
> w rbd-mirror preserves the order of WRITE operations that finished on the pr
> imary cluster. As far as I can understand the code, rbd-mirror fetches I/O o
> perations from the journal on the primary cluster, and replay them on the sl
> ave cluster without checking whether there's already any I/O operations targ
> eting the same object that has been issued to the slave cluster and not yet 
> finished. Since concurrent operations may finish in a different order than t
> hat in which they arrived at the OSD, the order that the WRITE operations fi
> nish on the slave cluster may be different than that on the primay cluster. 
> For example: on the primary cluster, there are two WRITE operation targeting
>  the same object A which are, in the order they finish on the primary cluste
> r, "WRITE A.off data1" and "WRITE A.off data2"; while when they are replayed
>  on the slave cluster, the order may be "WRITE A.off data2" and "WRITE A.off
>  data1", wh
> > ich means that the result of the two operations on the primary cluster is 
> A.off=data2 while, on the slave cluster, the result is A.off=data1.
> >> >>
> >> >>
> >> >> Is this possible?
> >> >>
> >> >>
> >> >>
> >> >
> >> >
> >> >
> >> >-- 
> >> >Jason
> >> N嫥叉靣笡y???氊b瞂???千v豝???藓{.n???壏渮榏z鳐妠ay???蕠跈???j???f＂穐殝鄗
> ???畐ア???⒎???:+v墾妛鑚豰稛???珣赙zZ+凒殠娸???"濟!秈
> 
> 
>  
> 
> 
> 
--8323329-2038219093-1496701358=:3646--
