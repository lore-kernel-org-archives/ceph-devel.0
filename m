From: Sage Weil <sage@newdream.net>
Subject: Re: Trouble with rbd
Date: Fri, 6 May 2011 09:27:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105060922300.9905@cobra.newdream.net>
References: <4DC317A2.6080806@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47826 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1EFQ0d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 12:26:33 -0400
In-Reply-To: <4DC317A2.6080806@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi Fyodor,

I'm seeing problems with the latest rbd in my environment as well.  
Looking into it.

sage



On Fri, 6 May 2011, Fyodor Ustinov wrote:
> Hi!
> 
> Latest 64 bit kernel (2.6.39-rc6, but with latest ubuntu 2.6.38-8 - the same).
> 
> Very similar to that rbd or libceph ruin the memory.
> 
> 1. Make rbd.
> 
> rbd create tmt --size 102400
> 
> 
> 
> 2. Attach and make disk
> 
> modprobe rbd
> 
> echo "xx.xx.xx.xx name=admin rbd tmt" > /sys/bus/rbd/add
> 
> mkfs.ext4 -E lazy_itable_init=0 /dev/rbd0
> 
> mount /dev/rbd0 /mnt
> 
> 
> 
> 3. start test - start iozone + bonnie++ + rsync.
> 
> root@stb1:/mnt# iozone -a -n4g -g20g
>         Iozone: Performance Test of File I/O
>                 Version $Revision: 3.373 $
>                 Compiled for 64 bit mode.
>                 Build: linux-AMD64
> [...]
> 
>         Auto Mode
>         Using minimum file size of 4194304 kilobytes.
>         Using maximum file size of 20971520 kilobytes.
>         Command line used: iozone -a -n4g -g20g
>         Output is in Kbytes/sec
>         Time Resolution = 0.000001 seconds.
>         Processor cache size set to 1024 Kbytes.
>         Processor cache line size set to 32 bytes.
>         File stride size set to 17 * record size.
>                                                             random  random
> bkwd   record   stride
>               KB  reclen   write rewrite    read    reread    read   write
> read  rewrite     read   fwrite frewrite   fread  freread
>          4194304      64  120955   66607    25500    28465   14384   89028
> 42840  5504993    84387   111439   124649
> 
> Error in file: Found ?170aba407000ffc? Expecting ?3a3a3a3a3a3a3a3a? addr
> 7fb85eb06000
> Error in file: Position 3984547840
> Record # 60799 Record size 64 kb
> where 7fb85eb06000 loop 24576
> root@stb1:/mnt#
> 
> umount /mnt
> 
> root@stb1:~# fsck -f /dev/rbd0
> fsck from util-linux-ng 2.17.2
> e2fsck 1.41.14 (22-Dec-2010)
> Pass 1: Checking inodes, blocks, and sizes
> Inode 1850570 is in use, but has dtime set.  Fix<y>? /dev/rbd0: e2fsck
> canceled.
> root@stb1:~#
> 
> 
> 
> So.
> 
> No errors in logs on stb1
> 
> But format /dev/rbd0 by ocfs2 and the same test make nice show in syslog -
> very nicely fluttering out in all directions errors in all that you can
> imagine. Like that:
> May  5 22:36:57 stb1 kernel: [13683.907928] BUG: Bad page state in process
> iozone  pfn:5ba7e
> May  5 22:36:57 stb1 kernel: [13683.907936] page:ffffea000140cb90 count:1
> mapcount:0 mapping:          (null) index:0xa0f63
> May  5 22:36:57 stb1 kernel: [13683.907941] page flags: 0x100000000000000()
> May  5 22:36:57 stb1 kernel: [13683.907945] Pid: 2752, comm: iozone Not
> tainted 2.6.39-rc6-ufm #1
> May  5 22:36:57 stb1 kernel: [13683.907947] Call Trace:
> May  5 22:36:57 stb1 kernel: [13683.907953]  [<ffffffff8110e90b>] ?
> dump_page+0x9b/0xd0
> May  5 22:36:57 stb1 kernel: [13683.907956]  [<ffffffff8110ea09>]
> bad_page+0xc9/0x120
> May  5 22:36:57 stb1 kernel: [13683.907959]  [<ffffffff8110f258>]
> get_page_from_freelist+0x6f8/0x7a0
> May  5 22:36:57 stb1 kernel: [13683.907963]  [<ffffffff8118dd74>] ?
> __find_get_block_slow.clone.11+0x44/0x140
> May  5 22:36:57 stb1 kernel: [13683.907967]  [<ffffffff8110fb28>]
> __alloc_pages_nodemask+0x118/0x8a0
> May  5 22:36:57 stb1 kernel: [13683.907971]  [<ffffffff81084517>] ?
> bit_waitqueue+0x17/0xd0
> May  5 22:36:57 stb1 kernel: [13683.907973]  [<ffffffff8108463f>] ?
> wake_up_bit+0x2f/0x40
> May  5 22:36:57 stb1 kernel: [13683.907976]  [<ffffffff8123dfa4>] ?
> do_get_write_access+0x2e4/0x490
> May  5 22:36:57 stb1 kernel: [13683.907979]  [<ffffffff8123c807>] ?
> start_this_handle.clone.7+0x417/0x4a0
> May  5 22:36:57 stb1 kernel: [13683.908000]  [<ffffffffa02b2492>] ?
> ocfs2_inode_cache_unlock+0x12/0x20 [ocfs2]
> May  5 22:36:57 stb1 kernel: [13683.908004]  [<ffffffff81144b05>]
> alloc_pages_current+0xa5/0x110
> May  5 22:36:57 stb1 kernel: [13683.908006]  [<ffffffff81107eef>]
> __page_cache_alloc+0x8f/0xa0
> May  5 22:36:57 stb1 kernel: [13683.908009]  [<ffffffff8110895c>]
> find_or_create_page+0x4c/0xb0
> May  5 22:36:57 stb1 kernel: [13683.908019]  [<ffffffffa0291c1d>]
> ocfs2_write_begin_nolock+0x15dd/0x1bf0 [ocfs2]
> May  5 22:36:57 stb1 kernel: [13683.908032]  [<ffffffffa02b21e0>] ?
> ocfs2_find_actor+0x140/0x140 [ocfs2]
> May  5 22:36:57 stb1 kernel: [13683.908043]  [<ffffffffa0292326>]
> ocfs2_write_begin+0xf6/0x210 [ocfs2]
> May  5 22:36:57 stb1 kernel: [13683.908046]  [<ffffffff81107489>]
> generic_file_buffered_write+0x109/0x250
> May  5 22:36:57 stb1 kernel: [13683.908059]  [<ffffffffa02b1d44>]
> ocfs2_file_aio_write+0x7c4/0x810 [ocfs2]
> May  5 22:36:57 stb1 kernel: [13683.908070]  [<ffffffffa0292663>] ?
> ocfs2_write_end_nolock+0x223/0x380 [ocfs2]
> May  5 22:36:57 stb1 kernel: [13683.908073]  [<ffffffff8115fcb2>]
> do_sync_write+0xd2/0x110
> May  5 22:36:57 stb1 kernel: [13683.908077]  [<ffffffff812ab318>] ?
> apparmor_file_permission+0x18/0x20
> May  5 22:36:57 stb1 kernel: [13683.908080]  [<ffffffff812770dc>] ?
> security_file_permission+0x2c/0xb0
> May  5 22:36:57 stb1 kernel: [13683.908111]  [<ffffffff811600e1>] ?
> rw_verify_area+0x61/0xf0
> May  5 22:36:57 stb1 kernel: [13683.908115]  [<ffffffff81160426>]
> vfs_write+0xc6/0x180
> May  5 22:36:57 stb1 kernel: [13683.908117]  [<ffffffff81160741>]
> sys_write+0x51/0x90
> May  5 22:36:57 stb1 kernel: [13683.908120]  [<ffffffff815d5b8e>] ?
> common_interrupt+0xe/0x13
> May  5 22:36:57 stb1 kernel: [13683.908125]  [<ffffffff815dd902>]
> system_call_fastpath+0x16/0x1b
> 
> May  5 22:37:39 stb1 kernel: [13726.005858] BUG: Bad page state in process
> swapper  pfn:22eff
> May  5 22:37:39 stb1 kernel: [13726.005866] page:ffffea00007a47c8 count:0
> mapcount:-127 mapping:          (null) index:0xd9772
> May  5 22:37:39 stb1 kernel: [13726.005871] page flags: 0x100000000000000()
> May  5 22:37:39 stb1 kernel: [13726.005882] Pid: 0, comm: swapper Tainted: G
> B       2.6.39-rc6-ufm #1
> May  5 22:37:39 stb1 kernel: [13726.005884] Call Trace:
> May  5 22:37:39 stb1 kernel: [13726.005885] <IRQ>  [<ffffffff8110e90b>] ?
> dump_page+0x9b/0xd0
> May  5 22:37:39 stb1 kernel: [13726.005894]  [<ffffffff8110ea09>]
> bad_page+0xc9/0x120
> May  5 22:37:39 stb1 kernel: [13726.005897]  [<ffffffff8110eb4f>]
> free_pages_prepare+0xef/0x100
> May  5 22:37:39 stb1 kernel: [13726.005900]  [<ffffffff81110419>]
> free_hot_cold_page+0x49/0x470
> May  5 22:37:39 stb1 kernel: [13726.005902]  [<ffffffff81113770>]
> __put_single_page+0x20/0x30
> May  5 22:37:39 stb1 kernel: [13726.005904]  [<ffffffff811138bd>]
> put_page+0x2d/0x40
> May  5 22:37:39 stb1 kernel: [13726.005909]  [<ffffffff8152a0d1>]
> __pskb_trim_head+0xd1/0x120
> May  5 22:37:39 stb1 kernel: [13726.005911]  [<ffffffff8152ad70>]
> tcp_trim_head+0x70/0x120
> May  5 22:37:39 stb1 kernel: [13726.005914]  [<ffffffff81526b47>]
> tcp_ack+0x547/0x1de0
> May  5 22:37:39 stb1 kernel: [13726.005916]  [<ffffffff8152c100>] ?
> tcp_write_xmit+0x1d0/0x990
> May  5 22:37:39 stb1 kernel: [13726.005920]  [<ffffffff8114fd60>] ?
> kmem_cache_free+0x20/0x110
> May  5 22:37:39 stb1 kernel: [13726.005923]  [<ffffffff8152940d>]
> tcp_rcv_established+0x44d/0x830
> May  5 22:37:39 stb1 kernel: [13726.005926]  [<ffffffff81530af9>]
> tcp_v4_do_rcv+0x189/0x430
> May  5 22:37:39 stb1 kernel: [13726.005928]  [<ffffffff8153315c>] ?
> tcp_v4_rcv+0x65c/0x900
> May  5 22:37:39 stb1 kernel: [13726.005932]  [<ffffffff8107d05f>] ?
> queue_work+0x1f/0x30
> May  5 22:37:39 stb1 kernel: [13726.005935]  [<ffffffff81533149>]
> tcp_v4_rcv+0x649/0x900
> May  5 22:37:39 stb1 kernel: [13726.005939]  [<ffffffff8150f72d>]
> ip_local_deliver_finish+0xdd/0x2a0
> May  5 22:37:39 stb1 kernel: [13726.005941]  [<ffffffff8150fab8>]
> ip_local_deliver+0x88/0x90
> May  5 22:37:39 stb1 kernel: [13726.005944]  [<ffffffff8150f401>]
> ip_rcv_finish+0x141/0x390
> May  5 22:37:39 stb1 kernel: [13726.005946]  [<ffffffff8150fcdc>]
> ip_rcv+0x21c/0x2e0
> May  5 22:37:39 stb1 kernel: [13726.005950]  [<ffffffff814dbe7b>]
> __netif_receive_skb+0x55b/0x680
> May  5 22:37:39 stb1 kernel: [13726.005953]  [<ffffffff814dc308>]
> netif_receive_skb+0x58/0x80
> May  5 22:37:39 stb1 kernel: [13726.005955]  [<ffffffff814dc470>]
> napi_skb_finish+0x50/0x70
> May  5 22:37:39 stb1 kernel: [13726.005957]  [<ffffffff814dc9e5>]
> napi_gro_receive+0xb5/0xc0
> May  5 22:37:39 stb1 kernel: [13726.005976]  [<ffffffffa003e3eb>]
> e1000_receive_skb+0x5b/0x90 [e1000]
> May  5 22:37:39 stb1 kernel: [13726.005980]  [<ffffffffa0040c3e>]
> e1000_clean_rx_irq+0x25e/0x4b0 [e1000]
> May  5 22:37:39 stb1 kernel: [13726.005983]  [<ffffffffa00417a9>]
> e1000_clean+0x229/0x620 [e1000]
> May  5 22:37:39 stb1 kernel: [13726.005986]  [<ffffffff814dd41d>] ?
> dev_hard_start_xmit+0x2cd/0x6d0
> May  5 22:37:39 stb1 kernel: [13726.005990]  [<ffffffff81036e39>] ?
> default_spin_lock_flags+0x9/0x10
> May  5 22:37:39 stb1 kernel: [13726.005993]  [<ffffffff814dcbe8>]
> net_rx_action+0x128/0x270
> May  5 22:37:39 stb1 kernel: [13726.005996]  [<ffffffff81069ea8>]
> __do_softirq+0xa8/0x1c0
> May  5 22:37:39 stb1 kernel: [13726.005999]  [<ffffffff8102dc72>] ?
> ack_apic_level+0x72/0x1a0
> May  5 22:37:39 stb1 kernel: [13726.006003]  [<ffffffff815deb1c>]
> call_softirq+0x1c/0x30
> May  5 22:37:39 stb1 kernel: [13726.006006]  [<ffffffff8100d385>]
> do_softirq+0x65/0xa0
> May  5 22:37:39 stb1 kernel: [13726.006008]  [<ffffffff8106a23e>]
> irq_exit+0x8e/0xa0
> May  5 22:37:39 stb1 kernel: [13726.006010]  [<ffffffff815df376>]
> do_IRQ+0x66/0xe0
> May  5 22:37:39 stb1 kernel: [13726.006013]  [<ffffffff815d5b93>]
> common_interrupt+0x13/0x13
> May  5 22:37:39 stb1 kernel: [13726.006014] <EOI>  [<ffffffff810360cb>] ?
> native_safe_halt+0xb/0x10
> May  5 22:37:39 stb1 kernel: [13726.006020]  [<ffffffff81012f31>]
> default_idle+0x41/0xe0
> May  5 22:37:39 stb1 kernel: [13726.006023]  [<ffffffff8100a266>]
> cpu_idle+0xa6/0xf0
> May  5 22:37:39 stb1 kernel: [13726.006027]  [<ffffffff815b4dc5>]
> rest_init+0x75/0x80
> May  5 22:37:39 stb1 kernel: [13726.006031]  [<ffffffff81adfc38>]
> start_kernel+0x3e1/0x3ec
> May  5 22:37:39 stb1 kernel: [13726.006034]  [<ffffffff81adf347>]
> x86_64_start_reservations+0x132/0x136
> May  5 22:37:39 stb1 kernel: [13726.006036]  [<ffffffff81adf44c>]
> x86_64_start_kernel+0x101/0x110
> 
> May  5 22:37:39 stb1 kernel: [13726.049368] BUG: Bad page state in process
> rs:main Q:Reg  pfn:7b6e2
> May  5 22:37:39 stb1 kernel: [13726.049376] page:ffffea0001b00170 count:0
> mapcount:-127 mapping:          (null) index:0xda771
> May  5 22:37:39 stb1 kernel: [13726.049381] page flags: 0x100000000000000()
> May  5 22:37:39 stb1 kernel: [13726.049385] Pid: 2683, comm: rs:main Q:Reg
> Tainted: G    B       2.6.39-rc6-ufm #1
> May  5 22:37:39 stb1 kernel: [13726.049387] Call Trace:
> May  5 22:37:39 stb1 kernel: [13726.049388] <IRQ>  [<ffffffff8110e90b>] ?
> dump_page+0x9b/0xd0
> May  5 22:37:39 stb1 kernel: [13726.049397]  [<ffffffff8110ea09>]
> bad_page+0xc9/0x120
> May  5 22:37:39 stb1 kernel: [13726.049399]  [<ffffffff8110eb4f>]
> free_pages_prepare+0xef/0x100
> May  5 22:37:39 stb1 kernel: [13726.049403]  [<ffffffff81110419>]
> free_hot_cold_page+0x49/0x470
> May  5 22:37:39 stb1 kernel: [13726.049405]  [<ffffffff81113770>]
> __put_single_page+0x20/0x30
> May  5 22:37:39 stb1 kernel: [13726.049407]  [<ffffffff811138bd>]
> put_page+0x2d/0x40
> May  5 22:37:39 stb1 kernel: [13726.049411]  [<ffffffff814cecc4>]
> skb_release_data+0xb4/0xe0
> May  5 22:37:39 stb1 kernel: [13726.049413]  [<ffffffff814ced0e>]
> __kfree_skb+0x1e/0xa0
> May  5 22:37:39 stb1 kernel: [13726.049417]  [<ffffffff81526a44>]
> tcp_ack+0x444/0x1de0
> May  5 22:37:39 stb1 kernel: [13726.049420]  [<ffffffff8152bfa6>] ?
> tcp_write_xmit+0x76/0x990
> May  5 22:37:39 stb1 kernel: [13726.049429]  [<ffffffffa014f001>] ?
> put_osd_con+0x11/0x20 [libceph]
> May  5 22:37:39 stb1 kernel: [13726.049431]  [<ffffffff8152940d>]
> tcp_rcv_established+0x44d/0x830
> May  5 22:37:39 stb1 kernel: [13726.049435]  [<ffffffff81530af9>]
> tcp_v4_do_rcv+0x189/0x430
> May  5 22:37:39 stb1 kernel: [13726.049438]  [<ffffffff8153315c>] ?
> tcp_v4_rcv+0x65c/0x900
> May  5 22:37:39 stb1 kernel: [13726.049441]  [<ffffffff81533149>]
> tcp_v4_rcv+0x649/0x900
> May  5 22:37:39 stb1 kernel: [13726.049445]  [<ffffffff8150f72d>]
> ip_local_deliver_finish+0xdd/0x2a0
> May  5 22:37:39 stb1 kernel: [13726.049448]  [<ffffffff8150fab8>]
> ip_local_deliver+0x88/0x90
> May  5 22:37:39 stb1 kernel: [13726.049450]  [<ffffffff8150f401>]
> ip_rcv_finish+0x141/0x390
> May  5 22:37:39 stb1 kernel: [13726.049452]  [<ffffffff8150fcdc>]
> ip_rcv+0x21c/0x2e0
> May  5 22:37:39 stb1 kernel: [13726.049456]  [<ffffffff814dbe7b>]
> __netif_receive_skb+0x55b/0x680
> May  5 22:37:39 stb1 kernel: [13726.049459]  [<ffffffff814dc308>]
> netif_receive_skb+0x58/0x80
> May  5 22:37:39 stb1 kernel: [13726.049461]  [<ffffffff814dc470>]
> napi_skb_finish+0x50/0x70
> May  5 22:37:39 stb1 kernel: [13726.049463]  [<ffffffff814dc9e5>]
> napi_gro_receive+0xb5/0xc0
> May  5 22:37:39 stb1 kernel: [13726.049470]  [<ffffffffa003e3eb>]
> e1000_receive_skb+0x5b/0x90 [e1000]
> May  5 22:37:39 stb1 kernel: [13726.049474]  [<ffffffffa0040c3e>]
> e1000_clean_rx_irq+0x25e/0x4b0 [e1000]
> May  5 22:37:39 stb1 kernel: [13726.049477]  [<ffffffffa00417a9>]
> e1000_clean+0x229/0x620 [e1000]
> May  5 22:37:39 stb1 kernel: [13726.049482]  [<ffffffff81053412>] ?
> update_shares+0xc2/0x110
> May  5 22:37:39 stb1 kernel: [13726.049484]  [<ffffffff814dcbe8>]
> net_rx_action+0x128/0x270
> May  5 22:37:39 stb1 kernel: [13726.049488]  [<ffffffff81069ea8>]
> __do_softirq+0xa8/0x1c0
> May  5 22:37:39 stb1 kernel: [13726.049491]  [<ffffffff8102dc72>] ?
> ack_apic_level+0x72/0x1a0
> May  5 22:37:39 stb1 kernel: [13726.049495]  [<ffffffff815deb1c>]
> call_softirq+0x1c/0x30
> May  5 22:37:39 stb1 kernel: [13726.049497]  [<ffffffff8100d385>]
> do_softirq+0x65/0xa0
> May  5 22:37:39 stb1 kernel: [13726.049500]  [<ffffffff8106a23e>]
> irq_exit+0x8e/0xa0
> May  5 22:37:39 stb1 kernel: [13726.049502]  [<ffffffff815df376>]
> do_IRQ+0x66/0xe0
> May  5 22:37:39 stb1 kernel: [13726.049505]  [<ffffffff815d5b93>]
> common_interrupt+0x13/0x13
> May  5 22:37:39 stb1 kernel: [13726.049506] <EOI>  [<ffffffff811fdece>] ?
> ext4_mark_iloc_dirty+0xae/0x5c0
> May  5 22:37:39 stb1 kernel: [13726.049512]  [<ffffffff811fdea8>] ?
> ext4_mark_iloc_dirty+0x88/0x5c0
> May  5 22:37:39 stb1 kernel: [13726.049515]  [<ffffffff812035ed>] ?
> ext4_dirty_inode+0x3d/0x60
> May  5 22:37:39 stb1 kernel: [13726.049517]  [<ffffffff811fe501>]
> ext4_mark_inode_dirty+0x81/0x210
> May  5 22:37:39 stb1 kernel: [13726.049521]  [<ffffffff81218f59>] ?
> ext4_journal_start_sb+0x69/0x170
> May  5 22:37:39 stb1 kernel: [13726.049525]  [<ffffffff8118cefe>] ?
> __block_commit_write.clone.12+0x8e/0xd0
> May  5 22:37:39 stb1 kernel: [13726.049528]  [<ffffffff812035ed>]
> ext4_dirty_inode+0x3d/0x60
> May  5 22:37:39 stb1 kernel: [13726.049530]  [<ffffffff81186580>]
> __mark_inode_dirty+0x40/0x210
> May  5 22:37:39 stb1 kernel: [13726.049533]  [<ffffffff8118f1ab>]
> generic_write_end+0x6b/0xa0
> May  5 22:37:39 stb1 kernel: [13726.049535]  [<ffffffff8120216b>]
> ext4_da_write_end+0xdb/0x340
> May  5 22:37:39 stb1 kernel: [13726.049538]  [<ffffffff811074fb>]
> generic_file_buffered_write+0x17b/0x250
> May  5 22:37:39 stb1 kernel: [13726.049541]  [<ffffffff810685f6>] ?
> current_fs_time+0x16/0x60
> May  5 22:37:39 stb1 kernel: [13726.049544]  [<ffffffff81109159>]
> __generic_file_aio_write+0x229/0x440
> May  5 22:37:39 stb1 kernel: [13726.049546]  [<ffffffff811093df>]
> generic_file_aio_write+0x6f/0xe0
> May  5 22:37:39 stb1 kernel: [13726.049549]  [<ffffffff811f7739>]
> ext4_file_write+0x69/0x280
> May  5 22:37:39 stb1 kernel: [13726.049553]  [<ffffffff8115fcb2>]
> do_sync_write+0xd2/0x110
> [...]
> and so on.
> 
> WBR,
>     Fyodor.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
