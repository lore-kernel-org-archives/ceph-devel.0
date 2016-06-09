From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: RocksDB tuning
Date: Thu, 9 Jun 2016 14:35:53 +0000
Message-ID: <BLUPR0201MB15247BF8C313A40224D5485BE85F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
 <BLUPR0201MB1524D8A9D42F7C50646D0AE8E85E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <a3216e58-d591-50ae-f2f2-0cbb7cdaa7bb@redhat.com>
 <fb82e615-0762-0843-9a9f-cbc4686e35ba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0081.outbound.protection.outlook.com ([65.55.169.81]:27648
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752636AbcFIOf6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2016 10:35:58 -0400
In-Reply-To: <fb82e615-0762-0843-9a9f-cbc4686e35ba@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

I think the behavior is not surprising.

Small random writes represent the largest ratio of metadata to data being written. Hence RocksDB compaction will be at a maximum.

It's well known that the write-amplification of LSM databases is quite high. What isn't discussed is that the read amplification for LSM databases is also high.

All of these issues stem from LSM being generally optimized for HDD.  

ZetaScale is the answer to this problem when running on flash, I believe we're getting very close to generating pull requests for it.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Thursday, June 09, 2016 6:46 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Manavalan Krishnan
> <Manavalan.Krishnan@sandisk.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: RocksDB tuning
> 
> On 06/09/2016 08:37 AM, Mark Nelson wrote:
> > Hi Allen,
> >
> > On a somewhat related note, I wanted to mention that I had forgotten
> > that chhabaremesh's min_alloc_size commit for different media types
> > was committed into master:
> >
> >
> https://github.com/ceph/ceph/commit/8185f2d356911274ca679614611dc335
> e3
> > efd187
> >
> >
> > IE those tests appear to already have been using a 4K min alloc size
> > due to non-rotational NVMe media.  I went back and verified that
> > explicitly changing the min_alloc size (in fact all of them to be
> > sure) to 4k does not change the behavior from graphs I showed
> > yesterday.  The rocksdb compaction stalls due to excessive reads
> > appear (at least on the
> > surface) to be due to metadata traffic during heavy small random writes.
> 
> Sorry, this was worded poorly.  Traffic due to compaction of metadata (ie not
> leaked WAL data) during small random writes.
> 
> Mark
> 
> >
> > Mark
> >
> > On 06/08/2016 06:52 PM, Allen Samuels wrote:
> >> Let's make a patch that creates actual Ceph parameters for these
> >> things so that we don't have to edit the source code in the future.
> >>
> >>
> >> Allen Samuels
> >> SanDisk |a Western Digital brand
> >> 2880 Junction Avenue, San Jose, CA 95134
> >> T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >>
> >>
> >>> -----Original Message-----
> >>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >>> owner@vger.kernel.org] On Behalf Of Manavalan Krishnan
> >>> Sent: Wednesday, June 08, 2016 3:10 PM
> >>> To: Mark Nelson <mnelson@redhat.com>; Ceph Development <ceph-
> >>> devel@vger.kernel.org>
> >>> Subject: RocksDB tuning
> >>>
> >>> Hi Mark
> >>>
> >>> Here are the tunings that we used to avoid the IOPs choppiness caused
> by
> >>> rocksdb compaction.
> >>>
> >>> We need to add the following options in src/kv/RocksDBStore.cc before
> >>> rocksdb::DB::Open in RocksDBStore::do_open
> opt.IncreaseParallelism(16);
> >>>   opt.OptimizeLevelStyleCompaction(512 * 1024 * 1024);
> >>>
> >>>
> >>>
> >>> Thanks
> >>> Mana
> >>>
> >>>
> >>>>
> >>>
> >>> PLEASE NOTE: The information contained in this electronic mail
> >>> message is
> >>> intended only for the use of the designated recipient(s) named above.
> >>> If the
> >>> reader of this message is not the intended recipient, you are hereby
> >>> notified
> >>> that you have received this message in error and that any review,
> >>> dissemination, distribution, or copying of this message is strictly
> >>> prohibited. If
> >>> you have received this communication in error, please notify the
> >>> sender by
> >>> telephone or e-mail (as shown above) immediately and destroy any and
> all
> >>> copies of this message in your possession (whether hard copies or
> >>> electronically stored copies).
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>> in the
> >>> body of a message to majordomo@vger.kernel.org More majordomo
> info at
> >>> http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
