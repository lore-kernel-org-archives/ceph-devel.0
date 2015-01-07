From: Sage Weil <sweil@redhat.com>
Subject: RE: Ceph data consistency
Date: Tue, 6 Jan 2015 18:18:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501061817490.3041@cobra.newdream.net>
References: <54A2609D.1010302@sadziu.pl> <085BC98701B92B4C86AE7696562D284D0B9CE2F3@SACMBXIP03.sdcorp.global.sandisk.com> <54A2AB4B.6000206@sadziu.pl> <CALurOm0wGEJ5MSrscUvVi_J3fyDevGbT3A11291qTLYTZejr_w@mail.gmail.com>
 <6AA21C22F0A5DA478922644AD2EC308C8FF2B2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41430 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757819AbbAGCS0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Jan 2015 21:18:26 -0500
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C8FF2B2@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph@sadziu.pl" <ceph@sadziu.pl>, "Vijayendra.Shamanna@sandisk.com" <Vijayendra.Shamanna@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 7 Jan 2015, Ma, Jianpeng wrote:
> > ---------- Forwarded message ----------
> > From: Pawe? Sadowski <ceph@sadziu.pl>
> > Date: 2014-12-30 21:40 GMT+08:00
> > Subject: Re: Ceph data consistency
> > To: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>,
> > "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> > 
> > 
> > On 12/30/2014 01:40 PM, Vijayendra Shamanna wrote:
> > > Hi,
> > >
> > > There is a sync thread (sync_entry in FileStore.cc) which triggers
> > > periodically and executes sync_filesystem() to ensure that the data is
> > > consistent. The journal entries are trimmed only after a successful
> > > sync_filesystem() call
> > 
> > sync_filesystem() always returns zero and journal will be trimmed.
> > Executing sync()/syncfs() with dirty data in disk buffers will result in data loss
> > ("lost page write due to I/O error").
> > 
> Hi sage:
> 
> From the git log, I see at first sync_filesystem() return the result of syncfs().
> But in this commit 808c644248e486f44:
>     Improve use of syncfs.
>     Test syncfs return value and fallback to btrfs sync and then sync.
> The author hope if syncfs() met error and sync() can resolve. Because sync() don't return result 
> So it only return zero.
> But which error can handle by this way? AFAK, no.
> I suggest it directly return result of syncfs().

Yeah, that sounds right!

sage


> 
> Jianpeng Ma
> Thanks!
> 
> 
> > I was doing some experiments simulating disk errors using Device Mapper
> > "error" target. In this setup OSD was writing to broken disk without crashing.
> > Every 5 seconds (filestore_max_sync_interval) kernel logs that some data were
> > discarded due to IO error.
> > 
> > 
> > > Thanks
> > > Viju
> > >> -----Original Message-----
> > >> From: ceph-devel-owner@vger.kernel.org
> > >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Pawel Sadowski
> > >> Sent: Tuesday, December 30, 2014 1:52 PM
> > >> To: ceph-devel@vger.kernel.org
> > >> Subject: Ceph data consistency
> > >>
> > >> Hi,
> > >>
> > >> On our Ceph cluster from time to time we have some inconsistent PGs (after
> > deep-scrub). We have some issues with disk/sata cables/lsi controller causing
> > IO errors from time to time (but that's not the point in this case).
> > >>
> > >> When IO error occurs on OSD journal partition everything works as is should
> > -> OSD is crashed and that's ok - Ceph will handle that.
> > >>
> > >> But when IO error occurs on OSD data partition during journal flush OSD
> > continue to work. After calling *writev* (in buffer::list::write_fd) OSD does
> > check return code from this call but does NOT verify if write has been successful
> > to disk (data are still only >in memory and there is no fsync). That way OSD
> > thinks that data has been stored on disk but it might be discarded (during sync
> > dirty page will be reclaimed and you'll see "lost page write due to I/O error" in
> > dmesg).
> > >>
> > >> Since there is no checksumming of data I just wanted to make sure that this
> > is by design. Maybe there is a way to tell OSD to call fsync after write and have
> > data consistent?
> > 
> > --
> > PS
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body
> > of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
