From: Sage Weil <sage@inktank.com>
Subject: RE: Seperate metadata disk for OSD
Date: Sat, 12 Jan 2013 08:57:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301120852140.22766@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC5D36A6@SHSMSX102.ccr.corp.intel.com> <CAAM7YA=h2tWx_NyiDm32jNxq=oQXQfAD5HN0tc0vQz1-srp-aA@mail.gmail.com> <50F166CC.40009@inktank.com> <6F3FA899187F0043BA1827A69DA2F7CC5D36D2@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50829 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab3ALQ5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jan 2013 11:57:19 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5D36D2@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "Yan, Zheng " <yanzheng@21cn.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 12 Jan 2013, Chen, Xiaoxi wrote:
> Hi Zheng?
> 	I have put XFS log to a separate disk, indeed it provide some performance gain but not that significant.
> 	Ceph's metadata is somehow separate(it's some files reside in OSD's disk), therefore,it cannot be helped by neither XFS journal log nor OSD's journal.That's why I am trying to put ceph's metadata(/data/osd.x/meta folder ) to a separate SSD disk.
> To Nelson,
> 	I did the experiment with just 1 client, if using more clients, the gain will not be that much.
> 	It looks to me that a single write from client side become 3 writes to disk is somehow a big overhead for in-place-update filesystem such like XFS since it introduce more seeks.Out-of-place-update filesystem will not suffer a lot for such pattern,I didn?t find this problem when I using BTRFS as backend filesystem. But forBTRFS, fragmentation is another performance killer, for a single RBD volume, if you did a lot of random write on it, the sequential read performance will drop to 30% of a new RBD volume. This make BTRFS unusable in production.
> 	Separate Ceph meta seems quite easy to me ( I just mount a partition to /data/osd.X/meta), is it right  ? is there any potential problem in it? 

Unfortunately, yes.  The ceph journal and fs sync are carefully timed.  
The ceph-osd assumes that syncfs(2) on the $osd_data/current/commit_op_seq 
file will sync everything, but if meta/ is another fs that isnt true.  At 
the every least, the code needs to be modified to sync that as well.

That said, there is a lot of improvement that can be had here.  The three 
things we write are:

 the pg log
 the pg info, spread across the pg dir xattr and that pginfo file
 the actual io

The pg log could go in leveldb, which would translate those writes into 
a single sequential stream across the entire OSD.  And the PG info 
separate between the xattr and the file is far from optimal: most of that 
data doesn't actually change on each write.  What little does is very 
small, and could be moved into the xattr, avoiding touching the file 
(which means an inode + data block write) at all.

We need to look a bit more closely to see how difficult that will really 
be to implement, but I think it is promising!

sage


> 
> 																														Xiaoxi
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com] 
> Sent: 2013?1?12? 21:36
> To: Yan, Zheng 
> Cc: Chen, Xiaoxi; ceph-devel@vger.kernel.org
> Subject: Re: Seperate metadata disk for OSD
> 
> Hi Xiaoxi and Zheng,
> 
> We've played with both of these some internally, but not for a production deployment. Mostly just for diagnosing performance problems. 
>   It's been a while since I last played with this, but I hadn't seen a whole lot of performance improvements at the time.  That may have been due to the hardware in use, or perhaps other parts of Ceph have improved to the point where this matters now!
> 
> On a side note, Btrfs also had a google summer of code project to let you put metadata on an external device.  Originally I think that was supposed to make it into 3.7, but am not sure if that happened.
> 
> Mark
> 
> On 01/12/2013 06:21 AM, Yan, Zheng wrote:
> > On Sat, Jan 12, 2013 at 2:57 PM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
> >>
> >> Hi list,
> >>          For a rbd write request, Ceph need to do 3 writes:
> >> 2013-01-10 13:10:15.539967 7f52f516c700 10 filestore(/data/osd.21) 
> >>_do_transaction on 0x327d790
> >> 2013-01-10 13:10:15.539979 7f52f516c700 15 filestore(/data/osd.21) 
> >>write meta/516b801c/pglog_2.1a/0//-1 36015~147
> >> 2013-01-10 13:10:15.540016 7f52f516c700 15 filestore(/data/osd.21) 
> >>path: /data/osd.21/current/meta/DIR_C/pglog\u2.1a__0_516B801C__none
> >> 2013-01-10 13:10:15.540164 7f52f516c700 15 filestore(/data/osd.21) 
> >>write meta/28d2f4a8/pginfo_2.1a/0//-1 0~496
> >> 2013-01-10 13:10:15.540189 7f52f516c700 15 filestore(/data/osd.21) 
> >>path: /data/osd.21/current/meta/DIR_8/pginfo\u2.1a__0_28D2F4A8__none
> >> 2013-01-10 13:10:15.540217 7f52f516c700 10 filestore(/data/osd.21) 
> >>_do_transaction on 0x327d708
> >> 2013-01-10 13:10:15.540222 7f52f516c700 15 filestore(/data/osd.21) 
> >>write 2.1a_head/8abf341a/rb.0.106e.6b8b4567.0000000002d3/head//2 
> >>3227648~524288
> >> 2013-01-10 13:10:15.540245 7f52f516c700 15 filestore(/data/osd.21) 
> >>path: 
> >>/data/osd.21/current/2.1a_head/rb.0.106e.6b8b4567.0000000002d3__head_8
> >>ABF341A__2
> >>l
> >>          If using XFS as backend file system and running xfs on top of traditional sata disk, it will introduce a lot of seeks and therefore reduce bandwidth, a blktrace is available here :( http://ww3.sinaimg.cn/mw690/6e1aee47jw1e0qsbxbvddj.jpg) to demonstrate this issue.( single client running dd on top of a new RBD volumes).
> >>          Then I tried to move /osd.X/current/meta to a separate disk, the bandwidth boosted.(look blktrace at http://ww4.sinaimg.cn/mw690/6e1aee47jw1e0qsadz1bij.jpg).
> >>          I haven't test other access pattern or something else, but it looks to me that moving such meta to a separate disk (ssd or sata with btrfs) will benefit ceph write performance, is it true? Will ceph introduce this feature in the future?  Is there any potential problem for such hack?
> >>
> >
> > Did you try putting XFS metadata log a separate and fast device 
> > (mkfs.xfs -l logdev=/dev/sdbx,size=10000b). I think it will boost 
> > performance too.
> >
> > Regards
> > Yan, Zheng
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
