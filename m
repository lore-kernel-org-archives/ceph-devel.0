From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: Regarding newstore performance
Date: Fri, 17 Apr 2015 14:08:30 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC021CEFFA@shsmsx102.ccr.corp.intel.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD79CFB@SACMBXIP01.sdcorp.global.sandisk.com>
 <CACJqLybLO=ut70O7Mf_RCnJwzBPAH45OBnGLdHesdnRziCUUiQ@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A0A1@SACMBXIP01.sdcorp.global.sandisk.com>
 <6F3FA899187F0043BA1827A69DA2F7CC021CE207@shsmsx102.ccr.corp.intel.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A350@SACMBXIP01.sdcorp.global.sandisk.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A4EF@SACMBXIP01.sdcorp.global.sandisk.com>
 <552FFCAE.1040303@redhat.com>
 <alpine.DEB.2.00.1504161718020.18547@cobra.newdream.net>
 <5530F843.6050708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21342 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934097AbbDQOIh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Apr 2015 10:08:37 -0400
In-Reply-To: <5530F843.6050708@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I tried to spilit the DB/data/WAL into 3 different SSD, the IOSTAT looks like below:

SDB is the data while SDC is db and SDD is the WAL of RocksDB.
The IO pattern is 4KB random write(QD=8) ontop of a pre-filled RBD, using fio-librbd.

The result looks strange,
1. in SDB(data part), we are expecting 4KB IO but actually we only get 2KB(4Sector).
2. There are not that much data written to Level 0+, only 0.53MB/s
3. Note that the avgqu-sz is very low compared to QD=8 in FIO, seems the problem is that we cannot commit the WAL fast enough.


My code base is 6e9b2fce30cf297e60454689c6fb406b6e786889,

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          15.77    0.00    8.87    2.06    0.00   73.30

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00    10.60    0.00   49.60     0.00    21.56   890.39     6.68  134.76    0.00  134.76   1.16   5.76
sdb               0.00     0.00    0.00 1627.30     0.00     3.22     4.05     0.11    0.07    0.00    0.07   0.06  10.52
sdc               0.00     0.00    0.20    4.30     0.00     0.53   239.33     0.00    1.07    2.00    1.02   0.71   0.32
sdd               0.00   612.00    0.00 1829.50     0.00     9.41    10.53     0.85    0.46    0.00    0.46   0.46  84.68


/dev/sdc1      156172796  2740620 153432176   2% /root/ceph-0-db
/dev/sdd1      195264572    41940 195222632   1% /root/ceph-0-db-wal
/dev/sdb1      156172796 10519532 145653264   7% /var/lib/ceph/osd/ceph-0

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com] 
Sent: Friday, April 17, 2015 8:11 PM
To: Sage Weil
Cc: Somnath Roy; Chen, Xiaoxi; Haomai Wang; ceph-devel
Subject: Re: Regarding newstore performance



On 04/16/2015 07:38 PM, Sage Weil wrote:
> On Thu, 16 Apr 2015, Mark Nelson wrote:
>> On 04/16/2015 01:17 AM, Somnath Roy wrote:
>>> Here is the data with omap separated to another SSD and after 1000GB 
>>> of fio writes (same profile)..
>>>
>>> omap writes:
>>> -------------
>>>
>>> Total host writes in this period = 551020111 ------ ~2101 GB
>>>
>>> Total flash writes in this period = 1150679336
>>>
>>> data writes:
>>> -----------
>>>
>>> Total host writes in this period = 302550388 --- ~1154 GB
>>>
>>> Total flash writes in this period = 600238328
>>>
>>> So, actual data write WA is ~1.1 but omap overhead is ~2.1 and 
>>> adding those getting ~3.2 WA overall.
>
> This all suggests that getting rocksdb to not rewrite the wal entries 
> at all will be the big win.  I think Xiaoxi had tunable suggestions 
> for that?  I didn't grok the rocksdb terms immediately so they didn't 
> make a lot of sense at the time.. this is probably a good place to 
> focus, though.  The rocksdb compaction stats should help out there.
>
> But... today I ignored this entirely and put rocksdb in tmpfs and 
> focused just on the actual wal IOs done to the fragments files after the fact.
> For simplicity I focused just on 128k random writes into 4mb objects.
>
> fio can get ~18 mb/sec on my disk with iodepth=1.  Interestingly, 
> setting
> iodepth=16 makes no different *until* I also set thinktime=10 (us, or 
> almost any value really) and thinktime_blocks=16, at which point it 
> goes up with the iodepth.  I'm not quite sure what is going on there 
> but it seems to be preventing the elevator and/or disk from reordering 
> writes and make more efficient sweeps across the disk.  In any case, 
> though, with that tweaked I can get up to ~30mb/sec with qd 16, ~40mb/sec with qd 64.
> Similarly, with qa 1 and thinktime of 250us, it drops to like 
> 15mb/sec, which is basically what I was getting from newstore.  Here's 
> my fio
> config:
>
> 	http://fpaste.org/212110/42923089/


Yikes!  That is a great observation Sage!

>
> Conclusion: we need multiple threads (or libaio) to get lots of IOs in 
> flight so that the block layer and/or disk can reorder and be efficient.
> I added a threadpool for doing wal work (newstore wal threads = 8 by
> default) and it makes a big difference.  Now I am getting more like 
> 19mb/sec w/ 4 threads and client (smalliobench) qd 16.  It's not going 
> up much from there as I scale threads or qd, strangely; not sure why yet.
>
> But... that's a big improvement over a few days ago (~8mb/sec).  And 
> on this drive filestore with journal on ssd gets ~8.5mb/sec.  So we're 
> winning, yay!
>
> I tabled the libaio patch for now since it was getting spurious EINVAL 
> and would consistently SIGBUG from io_getevents() when ceph-osd did 
> dlopen() on the rados plugins (weird!).
>
> Mark, at this point it is probably worth checking that you can 
> reproduce these results?  If so, we can redo the io size sweep.  I 
> picked 8 wal threads since that was enough to help and going higher 
> didn't seem to make much difference, but at some point we'll want to 
> be more careful about picking that number.  We could also use libaio 
> here, but I'm not sure it's worth it.  And this approach is somewhat 
> orthogonal to the idea of efficiently passing the kernel things to fdatasync.

Absolutely!  I'll get some tests running now.  Looks like everyone is jumping on the libaio bandwagon which naively seems like the right way to me too.  Can you talk a little bit more about how you'd see fdatasync work in this case though vs the threaded implementation?

>
> Anyway, next up is probably wrangling rocksdb's log!

I jumped on #rocksdb on freenode yesterday to ask about it, but I think we'll probably just need to hit the mailing list.

>
> sage
>
