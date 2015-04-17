From: Sage Weil <sage@newdream.net>
Subject: Re: Regarding newstore performance
Date: Thu, 16 Apr 2015 17:38:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504161718020.18547@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD79CFB@SACMBXIP01.sdcorp.global.sandisk.com> <CACJqLybLO=ut70O7Mf_RCnJwzBPAH45OBnGLdHesdnRziCUUiQ@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A0A1@SACMBXIP01.sdcorp.global.sandisk.com>
 <6F3FA899187F0043BA1827A69DA2F7CC021CE207@shsmsx102.ccr.corp.intel.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A350@SACMBXIP01.sdcorp.global.sandisk.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A4EF@SACMBXIP01.sdcorp.global.sandisk.com>
 <552FFCAE.1040303@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54797 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbDQAiT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 20:38:19 -0400
In-Reply-To: <552FFCAE.1040303@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 16 Apr 2015, Mark Nelson wrote:
> On 04/16/2015 01:17 AM, Somnath Roy wrote:
> > Here is the data with omap separated to another SSD and after 1000GB of fio
> > writes (same profile)..
> > 
> > omap writes:
> > -------------
> > 
> > Total host writes in this period = 551020111 ------ ~2101 GB
> > 
> > Total flash writes in this period = 1150679336
> > 
> > data writes:
> > -----------
> > 
> > Total host writes in this period = 302550388 --- ~1154 GB
> > 
> > Total flash writes in this period = 600238328
> > 
> > So, actual data write WA is ~1.1 but omap overhead is ~2.1 and adding those
> > getting ~3.2 WA overall.

This all suggests that getting rocksdb to not rewrite the wal 
entries at all will be the big win.  I think Xiaoxi had tunable 
suggestions for that?  I didn't grok the rocksdb terms immediately so 
they didn't make a lot of sense at the time.. this is probably a good 
place to focus, though.  The rocksdb compaction stats should help out 
there.

But... today I ignored this entirely and put rocksdb in tmpfs and focused 
just on the actual wal IOs done to the fragments files after the fact.  
For simplicity I focused just on 128k random writes into 4mb objects.

fio can get ~18 mb/sec on my disk with iodepth=1.  Interestingly, setting 
iodepth=16 makes no different *until* I also set thinktime=10 (us, or 
almost any value really) and thinktime_blocks=16, at which point it goes 
up with the iodepth.  I'm not quite sure what is going on there but it 
seems to be preventing the elevator and/or disk from reordering writes and 
make more efficient sweeps across the disk.  In any case, though, with 
that tweaked I can get up to ~30mb/sec with qd 16, ~40mb/sec with qd 64.  
Similarly, with qa 1 and thinktime of 250us, it drops to like 15mb/sec, 
which is basically what I was getting from newstore.  Here's my fio 
config:

	http://fpaste.org/212110/42923089/

Conclusion: we need multiple threads (or libaio) to get lots of IOs in 
flight so that the block layer and/or disk can reorder and be efficient.  
I added a threadpool for doing wal work (newstore wal threads = 8 by 
default) and it makes a big difference.  Now I am getting more like 
19mb/sec w/ 4 threads and client (smalliobench) qd 16.  It's not going up 
much from there as I scale threads or qd, strangely; not sure why yet.

But... that's a big improvement over a few days ago (~8mb/sec).  And on 
this drive filestore with journal on ssd gets ~8.5mb/sec.  So we're 
winning, yay!

I tabled the libaio patch for now since it was getting spurious EINVAL and 
would consistently SIGBUG from io_getevents() when ceph-osd did dlopen() 
on the rados plugins (weird!).

Mark, at this point it is probably worth checking that you can reproduce 
these results?  If so, we can redo the io size sweep.  I picked 8 wal 
threads since that was enough to help and going higher didn't seem to make 
much difference, but at some point we'll want to be more careful about 
picking that number.  We could also use libaio here, but I'm not sure it's 
worth it.  And this approach is somewhat orthogonal to the idea of 
efficiently passing the kernel things to fdatasync.

Anyway, next up is probably wrangling rocksdb's log!

sage
