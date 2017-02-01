From: Sage Weil <sweil@redhat.com>
Subject: RE: bluestore prefer wal size
Date: Wed, 1 Feb 2017 21:47:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702012147430.3654@piezo.novalocal>
References: <alpine.DEB.2.11.1702011533340.3660@piezo.novalocal> <001001d27cbd$cee2a9f0$6ca7fdd0$@fisk.me.uk> <bb0bdeb6.AEMAHeJMfMsAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYklNO@mailjet.com> <alpine.DEB.2.11.1702012137240.3654@piezo.novalocal>
 <45ba3843.AEEAHxSt8JAAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYkldP@mailjet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdBAVr6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 16:47:58 -0500
In-Reply-To: <45ba3843.AEEAHxSt8JAAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYkldP@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: 'Mark Nelson' <mnelson@redhat.com>, ceph-devel@vger.kernel.org

On Wed, 1 Feb 2017, Nick Fisk wrote:
 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: 01 February 2017 21:39
> > To: Nick Fisk <nick@fisk.me.uk>
> > Cc: 'Mark Nelson' <mnelson@redhat.com>; ceph-devel@vger.kernel.org
> > Subject: RE: bluestore prefer wal size
> > 
> > On Wed, 1 Feb 2017, Nick Fisk wrote:
> > > Further update,
> > >
> > > I set bluestore_debug_omit_block_device_write to true and this gave me
> > > near filestore performance, albeit still with very high write amp on
> > > the SSD's. So its definitely something around that part of the code
> > > waiting on the writes to the spinning disks, puzzled why the commit didn't
> > help.
> > >
> > > I also set debug logging to 20/20 for bdev,bluefs,osd,bluestore and a
> > > grep didn't reveal any of the debug in that commit eg "defering small
> > > 0x". So possibly something isn't working as expected?
> > 
> > Oh, yeah, the option isn't working then.  I saw the line in my debug output..
> > are you sure you set bluestore_prefer_wal_size ?
> 
> Yep 100%, I even did a config show on the admin socket to confirm the value. I will rebuild the OSD's and try again and do a bit more digging to see if I can work out why it's not entering that if statement.

Oh, I know what the problem is.  Will push a fixed patch shortly.

sage

> 
> > 
> > sage
> > 
> > >
> > > Nick
> > >
> > > -----Original Message-----
> > > From: Nick Fisk [mailto:nick@fisk.me.uk]
> > > Sent: 01 February 2017 19:03
> > > To: 'Sage Weil' <sweil@redhat.com>; 'Mark Nelson'
> > <mnelson@redhat.com>
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: RE: bluestore prefer wal size
> > >
> > > Hi Sage,
> > >
> > > First results not looking good. It looks like write IO to the SSD's (sdd and sdi)
> > is now massively amplified, by somewhere in the region of about 10x. But I'm
> > still only getting around 100 4kb's seq write iops from the fio client. This is in
> > comparison to 2500-3000 iops on the SSD's and ~200 iops per spinning disk
> > (sdc,sde,sdg,sdh).
> > >
> > > rbd engine: RBD version: 0.1.11
> > > Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/476KB/0KB /s] [0/119/0 iops]
> > > [eta 00m:00s]
> > > rbd_iodepth32: (groupid=0, jobs=1): err= 0: pid=31171: Wed Feb  1
> > 18:56:51 2017
> > >   write: io=27836KB, bw=475020B/s, iops=115, runt= 60006msec
> > >     slat (usec): min=6, max=142, avg=10.98, stdev= 8.38
> > >     clat (msec): min=1, max=271, avg= 8.61, stdev= 3.63
> > >      lat (msec): min=1, max=271, avg= 8.62, stdev= 3.63
> > >     clat percentiles (msec):
> > >      |  1.00th=[    8],  5.00th=[    9], 10.00th=[    9], 20.00th=[    9],
> > >      | 30.00th=[    9], 40.00th=[    9], 50.00th=[    9], 60.00th=[    9],
> > >      | 70.00th=[    9], 80.00th=[    9], 90.00th=[    9], 95.00th=[    9],
> > >      | 99.00th=[   17], 99.50th=[   25], 99.90th=[   33], 99.95th=[   36],
> > >      | 99.99th=[  273]
> > >     bw (KB  /s): min=  191, max=  480, per=100.00%, avg=464.18, stdev=34.60
> > >     lat (msec) : 2=0.01%, 4=0.04%, 10=97.69%, 20=1.55%, 50=0.69%
> > >     lat (msec) : 500=0.01%
> > >   cpu          : usr=0.13%, sys=0.12%, ctx=7224, majf=0, minf=5
> > >   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%,
> > >=64=0.0%
> > >      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> > >=64=0.0%
> > >      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> > >=64=0.0%
> > >      issued    : total=r=0/w=6959/d=0, short=r=0/w=0/d=0,
> > drop=r=0/w=0/d=0
> > >      latency   : target=0, window=0, percentile=100.00%, depth=1
> > >
> > > I've checked via the admin socket and the prefer wal option is set to 8192.
> > >
> > > Random capture of iostat
> > >
> > > Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz
> > await r_await w_await  svctm  %util
> > > sda               0.00    77.00    0.00    5.50     0.00   338.00   122.91     0.05   11.64
> > 0.00   11.64   8.73   4.80
> > > sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00
> > 0.00    0.00   0.00   0.00
> > > sdc               0.00     0.00    0.00  151.50     0.00   302.00     3.99     0.54    3.59
> > 0.00    3.59   3.58  54.20
> > > sdd               0.00     0.00    0.00 1474.00     0.00  4008.00     5.44     0.09    0.06
> > 0.00    0.06   0.06   9.20
> > > sde               0.00     0.00    0.00  217.00     0.00   434.00     4.00     0.91    4.20
> > 0.00    4.20   4.20  91.20
> > > sdf               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00
> > 0.00    0.00   0.00   0.00
> > > sdg               0.00     0.00    0.00   66.50     0.00   134.00     4.03     0.18    2.68
> > 0.00    2.68   2.68  17.80
> > > sdh               0.00     0.00    0.00  217.00     0.00   434.00     4.00     0.80    3.71
> > 0.00    3.71   3.71  80.40
> > > sdi               0.00     0.00    0.00 1134.00     0.00  3082.00     5.44     0.09    0.08
> > 0.00    0.08   0.07   8.40
> > >
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: 01 February 2017 15:34
> > > To: nick@fisk.me.uk
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: bluestore prefer wal size
> > >
> > > Hey Nick,
> > >
> > > I've updated/improved the prefer wal size PR (that sends small writes
> > > through the wal).  See
> > >
> > > 	https://github.com/ceph/ceph/pull/13217
> > >
> > > if you want to try it out.
> > >
> > > Thanks!
> > > sage
> > >
> > >
> > >
> > >
> > >
> 
> 
> 
