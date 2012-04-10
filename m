From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: scaling issues
Date: Tue, 10 Apr 2012 13:01:56 -0600
Message-ID: <4F8483A4.7020502@sandia.gov>
References: <4F59414B.3000403@sandia.gov>
 <Pine.LNX.4.64.1203081625030.21631@cobra.newdream.net>
 <4F5A5C65.6030705@sandia.gov> <4F5A9064.3020400@sandia.gov>
 <4F845E30.6070006@sandia.gov>
 <Pine.LNX.4.64.1204100933250.18921@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:45080 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab2DJTDh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 15:03:37 -0400
In-Reply-To: <Pine.LNX.4.64.1204100933250.18921@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/10/2012 10:39 AM, Sage Weil wrote:
> On Tue, 10 Apr 2012, Jim Schutt wrote:
>> On 03/09/2012 04:21 PM, Jim Schutt wrote:
>>> On 03/09/2012 12:39 PM, Jim Schutt wrote:
>>>> On 03/08/2012 05:26 PM, Sage Weil wrote:
>>>>> On Thu, 8 Mar 2012, Jim Schutt wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've been trying to scale up a Ceph filesystem to as big
>>>>>> as I have hardware for - up to 288 OSDs right now.
>>>>>>
>>>>>> (I'm using commit ed0f605365e - tip of master branch from
>>>>>> a few days ago.)
>>>>>>
>>>>>> My problem is that I cannot get a 288 OSD filesystem to go active
>>>>>> (that's with 1 mon and 1 MDS). Pretty quickly I start seeing
>>>>>> "mds e4 e4: 1/1/1 up {0=cs33=up:creating(laggy or crashed)}".
>>>>>> Note that as this is happening all the OSDs and the MDS are
>>>>>> essentially idle; only the mon is busy.
>>>>>>
>>>>>> While tailing the mon log I noticed there was a periodic pause;
>>>>>> after adding a little more debug printing, I learned that the
>>>>>> pause was due to encoding pg_stat_t before writing the pg_map to disk.
>>>>>>
>>>>>> Here's the result of a scaling study I did on startup time for
>>>>>> a freshly created filesystem. I normally run 24 OSDs/server on
>>>>>> these machines with no trouble, for small numbers of OSDs.
>>
>> [snip]
>>
>>>
>>> I recompiled with -g -O2, and got this:
>>>
>>> OSDs size of pg_stat_t
>>>       latest  encode
>>>               time
>>>
>>> 48  2976461  0.052731
>>> 72  4472477  0.107187
>>> 96  5969477  0.194690
>>> 120 7466021  0.311586
>>> 144 8963141  0.465111
>>> 168 10460317 0.680222
>>> 192 11956709 0.713398
>>> 240 14950437 1.159426
>>> 288 17944413 1.714004
>>>
>>> It seems that encoding time still isn't proportional to the
>>> size of pgmap/latest. However, things have improved enough
>>> that my 288 OSD filesystem goes active pretty quickly (~90 sec),
>>> so I can continue testing at that scale.
>
> A fix for this was just merged into master last night.

That's great!

>
>> I'm still having trouble at 288 OSDs with under heavy write load
>> (166 linux clients running dd simultaneously).  I'm currently
>> running with master branch from last week - commit e792cd938897.
>>
>> The symptom is that the cluster cycles between "up:active"
>> and "up:active(laggy or crashed)".  When the cluster goes into
>> "laggy or crashed" the client caps go stale, and cluster throughput
>> (as monitored by vmstat on OSD servers) trails off to zero.  After a
>> short idle period, the cluster goes back "up:active", clients
>> renew their caps, and cluster throughput goes back to its maximum
>> until the next cycle starts.
>>
>> I believe this is a scaling issue because when I use pg_bits = 5
>> and pgp_bits = 5 (instead of the default 6) to build the filesystem,
>> I can write>20 TB using the same test, with no instances of the
>> cluster going  "laggy or crashed".  Perhaps it is related to
>> the encoding time for pg_stat_t that I reported above?
>
> Yeah, that sounds like the culprit to me.  Can you try with the latest
> master?

I'm 24 TB into a 25 TB run with pg_bits = 6, and the cluster
has been up:active the whole time.  Seems fixed to me!

<checks running ceph -w output>

Interesting. One of my servers just died.

FWIW, when all 24 OSDs on that server dropped out, the cluster went
"up:active(laggy or crashed)" for about 8 minutes while recovery started,
then went back "up:active" while recovery is finishing.

I thought you'd be interested to know - is that behavior unremarkable?

FWIW, here's what happened on that server:

[510342.517157] ------------[ cut here ]------------
[510342.521855] kernel BUG at fs/btrfs/extent_io.c:3982!
[510342.526894] invalid opcode: 0000 [#1] SMP
[510342.531102] CPU 4
[510342.533028] Modules linked in: btrfs zlib_deflate ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_addr ipv6 ib_sa iw_cxgb4 dm_mirror dm_region_hash dm_log dm_round_robin dm_multipath scsi_dh vhost_net macvtap macvlan tun kvm uinput sg sd_mod joydev ata_piix libata button microcode mpt2sas scsi_transport_sas raid_class scsi_mod serio_raw pcspkr mlx4_ib ib_mad ib_core mlx4_en mlx4_core cxgb4 i2c_i801 i2c_core iTCO_wdt iTCO_vendor_support ehci_hcd uhci_hcd ioatdma dm_mod i7core_edac edac_core nfs nfs_acl auth_rpcgss fscache lockd sunrpc tg3 bnx2 igb dca e1000 [last unloaded: scsi_wait_scan]
[510342.587836]
[510342.589412] Pid: 16609, comm: kworker/4:2 Not tainted 3.3.1-00162-gd8b2857 #15 Supermicro X8DTH-i/6/iF/6F/X8DTH
[510342.599601] RIP: 0010:[<ffffffffa057924c>]  [<ffffffffa057924c>] btrfs_release_extent_buffer_page.clone.0+0x2c/0x130 [btrfs]
[510342.610893] RSP: 0018:ffff88015fb6ba10  EFLAGS: 00010202
[510342.616277] RAX: 0000000000000004 RBX: ffff880ab81865a0 RCX: ffff880174bc0230
[510342.623476] RDX: ffff8801335bf9b1 RSI: 00000000000d0fb8 RDI: ffff880ab81865a0
[510342.630675] RBP: ffff88015fb6ba40 R08: 0000000000000038 R09: 0000000000000003
[510342.637874] R10: 0000000000000008 R11: ffff8804658c9e40 R12: ffff88015fb6a000
[510342.645069] R13: ffff880ab81865a0 R14: 000000000000000e R15: ffff88015fb6bc10
[510342.652268] FS:  0000000000000000(0000) GS:ffff880627c80000(0000) knlGS:0000000000000000
[510342.660418] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[510342.666234] CR2: ffffffffff600400 CR3: 0000000001a05000 CR4: 00000000000006e0
[510342.673427] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[510342.680627] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[510342.687827] Process kworker/4:2 (pid: 16609, threadinfo ffff88015fb6a000, task ffff880102ca4410)
[510342.696669] Stack:
[510342.698769]  ffff880100000000 ffff880ab81865a0 ffff88015fb6a000 ffff8806057d2eb0
[510342.706297]  000000000000000e ffff88015fb6bc10 ffff88015fb6ba70 ffffffffa05793f2
[510342.713825]  ffff88015fb6bb80 ffff880ab81865a0 ffff88015fb6bb50 0000000000000008
[510342.721362] Call Trace:
[510342.723912]  [<ffffffffa05793f2>] release_extent_buffer+0xa2/0xe0 [btrfs]
[510342.730790]  [<ffffffffa05795b4>] free_extent_buffer+0x34/0x80 [btrfs]
[510342.737407]  [<ffffffffa057a126>] btree_write_cache_pages+0x246/0x410 [btrfs]
[510342.744637]  [<ffffffffa054e96a>] btree_writepages+0x3a/0x50 [btrfs]
[510342.751060]  [<ffffffff810fc421>] do_writepages+0x21/0x40
[510342.756537]  [<ffffffff810f0b0b>] __filemap_fdatawrite_range+0x5b/0x60
[510342.763136]  [<ffffffff810f0de3>] filemap_fdatawrite_range+0x13/0x20
[510342.769568]  [<ffffffffa0554ecf>] btrfs_write_marked_extents+0x7f/0xe0 [btrfs]
[510342.776867]  [<ffffffffa0554f5e>] btrfs_write_and_wait_marked_extents+0x2e/0x60 [btrfs]
[510342.784951]  [<ffffffffa0554fbb>] btrfs_write_and_wait_transaction+0x2b/0x50 [btrfs]
[510342.792768]  [<ffffffffa055604c>] btrfs_commit_transaction+0x7ac/0xa10 [btrfs]
[510342.800060]  [<ffffffff81079540>] ? set_next_entity+0x90/0xa0
[510342.805875]  [<ffffffff8105f5d0>] ? wake_up_bit+0x40/0x40
[510342.811365]  [<ffffffffa0556590>] ? btrfs_end_transaction+0x20/0x20 [btrfs]
[510342.818403]  [<ffffffffa05565af>] do_async_commit+0x1f/0x30 [btrfs]
[510342.824748]  [<ffffffffa0556590>] ? btrfs_end_transaction+0x20/0x20 [btrfs]
[510342.831774]  [<ffffffff81058680>] process_one_work+0x140/0x490
[510342.837673]  [<ffffffff8105a417>] worker_thread+0x187/0x3f0
[510342.843319]  [<ffffffff8105a290>] ? manage_workers+0x120/0x120
[510342.849225]  [<ffffffff8105f02e>] kthread+0x9e/0xb0
[510342.854176]  [<ffffffff81486c64>] kernel_thread_helper+0x4/0x10
[510342.860168]  [<ffffffff8147d84a>] ? retint_restore_args+0xe/0xe
[510342.866161]  [<ffffffff8105ef90>] ? kthread_freezable_should_stop+0x80/0x80
[510342.873198]  [<ffffffff81486c60>] ? gs_change+0xb/0xb
[510342.878322] Code: 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 66 66 66 66 90 8b 47 38 49 89 fd 85 c0 75 0c 48 8b 47 20 4c 8d 7f 20 84 c0 79 04 <0f> 0b eb fe 48 8b 47 20 a8 04 75 f4 48 8b 07 49 89 c4 4c 03 67
[510342.898331] RIP  [<ffffffffa057924c>] btrfs_release_extent_buffer_page.clone.0+0x2c/0x130 [btrfs]
[510342.907294]  RSP <ffff88015fb6ba10>
[510342.911241] ---[ end trace 62013c6b6e2e5135 ]---

I'm running 3.3.1 + Chris Mason's btrfs for-linus branch (commit bc3f116fec194f,
just before merge into 3.4-rc1).  This kernel also has the ceph for-next branch
(commit c666601a935b, just before merge into 3.4-rc1), but that shouldn't matter
for this.

>
>> The problem with using pg_bits = 5 is that the data distribution
>> is not particularly even; after writing 20 TB to 288 OSDs I see
>> (max OSD use)/(min OSD use) = ~2. Even with pg_bits = 6 after
>> writing 20 TB I see (max OSD use)/(min OSD use) = ~1.5.
>> I think I'd like that variability to be even smaller.
>
> There is some infrastructure in the monitor to correct for the statistical
> imbalance, but it isn't triggered automatically yet.  It's probably time
> to look at that.

FWIW I've noticed while learning about how Ceph hashes objects into
PGs and onto OSDs that Bob Jenkins has a hash function newer than
what Ceph is using; see http://burtleburtle.net/bob/c/lookup3.c.

I haven't been able to find any comparisons of the older hash
to this newer one, wrt. uniformity; I wonder if it would be
more suitable, and thus reduce the imbalance without the need
for correction?

>
>> AFAICS I'm getting 3 pools of (n_OSDs<<  pg_bits) PGs, one pool
>> each for each of CEPH_DATA_RULE, CEPH_METADATA_RULE, and
>> CEPH_RBD_RULE.  So, for 288 OSDs I get 3*(288<<6) = 55296 PGs,
>> plus a few thousand more for the localized PGs.
>>
>> I can't seem to find any use of CEPH_RBD_RULE in the code, other
>> than to create that pool.  What am I missing?  I'd like to just
>> not create that pool to reduce my PG count - what problems might
>> that cause?
>
> None.   We create the rbd pool by default but it isn't used by the
> filesystem; it's just the default pool used by the 'rbd' command line
> tool.

OK, thanks for verifying.
>
>> Also, what would be the downside if I tried to not create the
>> CEPH_METADATA_RULE pool, and just put everything into the
>> CEPH_DATA_RULE pool?  That way I could run with just one pool.
>
> You could do that too.  The idea was that people might want a different
> replication level or placement for metadata (faster nodes, more replicas,
> whatever).

Again, thanks for verifying.

>
> But.. try with master first, as the PG scaling issue needs fixing
> regardless, is hopefully fixed now, and will probably make all of this
> moot... :)

I'll keep those tricks in mind if I ever get enough hardware
that the number of PGs becomes an issue again.

>
>> In the longer run, can anything be done to keep the monitor
>> daemon responsive when running with thousands of OSDs under a
>> heavy write load?
>
> Right now the monitor is being used to aggregate usage information, which
> is probably not the best use of its time.  I don't expect it will become a
> real problem for a while, though (as long as we avoid bugs like this one).

Hmm, if I did a few runs with bigger pg_bits values, that would give
some idea of how far away that time is, right?

>
> Thanks!

Thanks for the timely bug fix!  I really appreciate it.

-- Jim

> sage
>
>


