From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: CephFS: Jewel release: kernel panic seen while unmounting. Known
 Issue?
Date: Mon, 16 Oct 2017 08:15:53 +0800
Message-ID: <B6E48701-25B0-4A28-AC36-6543C42BD75C@redhat.com>
References: <113598501.593996.1498063632618.ref@mail.yahoo.com>
 <113598501.593996.1498063632618@mail.yahoo.com>
 <825845594.4337327.1507565356087@mail.yahoo.com>
 <1507565571.5289.1.camel@redhat.com>
 <1415045998.1551016.1507936292485@mail.yahoo.com>
 <1507981216.4831.14.camel@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdJPAQB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 15 Oct 2017 20:16:01 -0400
In-Reply-To: <1507981216.4831.14.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Anish Gupta <anish_gupta@yahoo.com>, Milosz Tanski <milosz@adfin.com>, Sage Weil <sweil@redhat.com>, David Howells <dhowells@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



> On 14 Oct 2017, at 19:40, Jeff Layton <jlayton@redhat.com> wrote:
> 
> (re-cc'ing ceph-devel list)
> 
> Not right offhand, but I do have some comments about this code for the
> maintainers. See below:
> 
> On Fri, 2017-10-13 at 23:11 +0000, Anish Gupta wrote:
>> Hello Jeff,
>> 
>> 
>> I did not see the issue with 4.4.14-rc4.
>> 
>> 
>> Would you or Zheng know which set of changes from 4.4 onwards might have helped fix this?
>> PS: I worked with Zheng on chage-id:  62a65f36d016fff32179acdbfcb8b2d8d9e54757
>> 
>> thanks,
>> Anish
>> 
>> 
>> On Monday, October 9, 2017, 9:12:54 AM PDT, Jeff Layton <jlayton@redhat.com> wrote:
>> 
>> 
>> On Mon, 2017-10-09 at 16:09 +0000, Anish Gupta wrote:
>> 
>>> 
>>> 
>>> Hello Ceph gurus,
>>> 
>>> I was running a script in a loop that was doing the following:
>>> 
>>>> Loop:
>>>>     mount 2 different ceph "clients" using their own shares and secret keys and FSCache
>>>>     write data into a sub-directory of client1
>>>>         let i=0; while (($i<10)); do sudo dd if=/dev/urandom of=data_file_$i bs=10M count=1; let i=$i+1; done
>>>>     write data into client 2 using same as previous step.
>>>>     read data from client 1        
>>>>           cp -r /client1/data/ /tmp/scratch1_dir
>>>>     read data from client 2 
>>>>       cp -r /client2/data/ /tmp/scratch2_dir
>>>>     unmount the 2 clients
>>>> 
>>>> 
>>>> 
>>> 
>>> Linux Kernel:  4.4.0-81-generic
>>> $ ceph --version
>>> ceph version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185)
>>> 
>>> Only one script of above loop was running and after 4th iteration ran into this bug:
>>> 
>>> Back trace looks like this:
>>> [2183922.263463] ------------[ cut here ]------------
>>> [2183922.264771] kernel BUG at /root/ubuntu-xenial/fs/ceph/mds_client.c:1258!
>>> [2183922.264771] invalid opcode: 0000 [#1] SMP
>>> [2183922.264771] Modules linked in: nfs lockd grace xt_nat ceph(OE) libceph libcrc32c veth ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_recent ipt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user xfrm_algo iptable_nat nf_nat_ipv4 br_netfilter bridge stp llc overlay binfmt_misc cachefiles(OE) fscache(OE) xt_multiport xenfs xen_privcmd ppdev nls_utf8 isofs intel_rapl crct10dif_pclmul crc32_pclmul ghash_clmulni_intel nvidia_uvm(POE) aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd input_leds joydev serio_raw i2c_piix4 8250_fintek parport_pc parport mac_hid xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp xt_addrtype nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ip6table_filter ip6_tables nf_conntrack_net
 bios_ns nf_conntrack_broadcast
>>> [2183922.264771]  nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack iptable_filter ip_tables x_tables sunrpc autofs4 hid_generic usbhid hid nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) drm_kms_helper syscopyarea sysfillrect sysimgblt psmouse fb_sys_fops drm pata_acpi floppy fjes
>>> [2183922.264771] CPU: 0 PID: 19728 Comm: umount Tainted: P          OE  4.4.0-81-generic #104-Ubuntu
>>> [2183922.264771] Hardware name: Xen HVM domU, BIOS 4.6.1-xs137595 03/23/2017
>>> [2183922.264771] task: ffff880d3aa12a00 ti: ffff880f321a0000 task.ti: ffff880f321a0000
>>> [2183922.264771] RIP: 0010:[<ffffffffc12218ac>]  [<ffffffffc12218ac>] remove_session_caps+0x13c/0x150 [ceph]
>>> [2183922.264771] RSP: 0018:ffff880f321a3d38  EFLAGS: 00010202
>>> [2183922.264771] RAX: 0000000000000001 RBX: ffff8809976b7000 RCX: ffff8807c1ee5028
>>> [2183922.264771] RDX: 0000000000000039 RSI: ffff880f321a3d00 RDI: ffff880f3978a608
>>> [2183922.264771] RBP: ffff880f321a3d78 R08: ffff880f321a0000 R09: 0000000000000000
>>> [2183922.264771] R10: 0000000000032800 R11: 0000000000000000 R12: ffff8809976b7540
>>> [2183922.264771] R13: ffff8807c1ee5168 R14: ffff8809976b7548 R15: ffff8809976b2800
>>> [2183922.264771] FS:  00007f4fb7e28840(0000) GS:ffff880f42a00000(0000) knlGS:0000000000000000
>>> [2183922.264771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [2183922.264771] CR2: 00007f4fb7656170 CR3: 0000000f34af2000 CR4: 00000000003406f0
>>> [2183922.264771] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [2183922.264771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [2183922.264771] Stack:
>>> [2183922.264771]  0000010007dee895 fffffffffffffffe 0000000039d663f2 ffff880f3978a400
>>> [2183922.264771]  0000000000000000 ffff8809976b7000 ffff880f3978a408 ffff8809976b7020
>>> [2183922.264771]  ffff880f321a3df0 ffffffffc12268f8 ffff88007bb9d200 00000001976b2e08
>>> [2183922.264771] Call Trace:
>>> [2183922.264771]  [<ffffffffc12268f8>] ceph_mdsc_close_sessions+0x1d8/0x2e0 [ceph]
>>> [2183922.264771]  [<ffffffff8122bf27>] ? evict_inodes+0x177/0x1a0
>>> [2183922.264771]  [<ffffffffc12031b3>] ceph_put_super+0x23/0x50 [ceph]
>>> [2183922.264771]  [<ffffffff812115df>] generic_shutdown_super+0x6f/0x100
>>> [2183922.264771]  [<ffffffffc1203136>] ceph_kill_sb+0x36/0x90 [ceph]
>>> [2183922.264771]  [<ffffffff81211ac3>] deactivate_locked_super+0x43/0x70
>>> [2183922.264771]  [<ffffffff81211f9c>] deactivate_super+0x5c/0x60
>>> [2183922.264771]  [<ffffffff8123000f>] cleanup_mnt+0x3f/0x90
>>> [2183922.264771]  [<ffffffff812300a2>] __cleanup_mnt+0x12/0x20
>>> [2183922.264771]  [<ffffffff8109f031>] task_work_run+0x81/0xa0
>>> [2183922.264771]  [<ffffffff81003242>] exit_to_usermode_loop+0xc2/0xd0
>>> [2183922.264771]  [<ffffffff81003c6e>] syscall_return_slowpath+0x4e/0x60
>>> [2183922.264771]  [<ffffffff81840bd0>] int_ret_from_sys_call+0x25/0x8f
>>> [2183922.264771] Code: 2e 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 48 89 fa 48 c7 c6 80 79 23 c1 48 c7 c7 40 4d 24 c1 e8 59 2c 20 c0 e9 f9 fe ff ff <0f> 0b 0f 0b e8 4b f8 e5 bf 90 66 2e 0f 1f 84 00 00 00 00 00 0f
>>> [2183922.264771] RIP  [<ffffffffc12218ac>] remove_session_caps+0x13c/0x150 [ceph]
>>> [2183922.264771]  RSP <ffff880f321a3d38>
>>> [2183922.307469] ---[ end trace e6fc86f4c2c986fd ]---
>>> [2183922.263463] ------------[ cut here ]------------
>>> [2183922.264771] kernel BUG at /root/ubuntu-xenial/fs/ceph/mds_client.c:1258!
>>> [2183922.264771] invalid opcode: 0000 [#1] SMP
>>> [2183922.264771] Modules linked in: nfs lockd grace xt_nat ceph(OE) libceph libcrc32c veth ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_recent ipt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user xfrm_algo iptable_nat nf_nat_ipv4 br_netfilter bridge stp llc overlay binfmt_misc cachefiles(OE) fscache(OE) xt_multiport xenfs xen_privcmd ppdev nls_utf8 isofs intel_rapl crct10dif_pclmul crc32_pclmul ghash_clmulni_intel nvidia_uvm(POE) aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd input_leds joydev serio_raw i2c_piix4 8250_fintek parport_pc parport mac_hid xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp xt_addrtype nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ip6table_filter ip6_tables nf_conntrack_net
 bios_ns nf_conntrack_broadcast
>>> [2183922.264771]  nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack iptable_filter ip_tables x_tables sunrpc autofs4 hid_generic usbhid hid nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) drm_kms_helper syscopyarea sysfillrect sysimgblt psmouse fb_sys_fops drm pata_acpi floppy fjes
>>> [2183922.264771] CPU: 0 PID: 19728 Comm: umount Tainted: P          OE  4.4.0-81-generic #104-Ubuntu
>>> [2183922.264771] Hardware name: Xen HVM domU, BIOS 4.6.1-xs137595 03/23/2017
>>> [2183922.264771] task: ffff880d3aa12a00 ti: ffff880f321a0000 task.ti: ffff880f321a0000
>>> [2183922.264771] RIP: 0010:[<ffffffffc12218ac>]  [<ffffffffc12218ac>] remove_session_caps+0x13c/0x150 [ceph]
>>> [2183922.264771] RSP: 0018:ffff880f321a3d38  EFLAGS: 00010202
>>> [2183922.264771] RAX: 0000000000000001 RBX: ffff8809976b7000 RCX: ffff8807c1ee5028
>>> [2183922.264771] RDX: 0000000000000039 RSI: ffff880f321a3d00 RDI: ffff880f3978a608
>>> [2183922.264771] RBP: ffff880f321a3d78 R08: ffff880f321a0000 R09: 0000000000000000
>>> [2183922.264771] R10: 0000000000032800 R11: 0000000000000000 R12: ffff8809976b7540
>>> [2183922.264771] R13: ffff8807c1ee5168 R14: ffff8809976b7548 R15: ffff8809976b2800
>>> [2183922.264771] FS:  00007f4fb7e28840(0000) GS:ffff880f42a00000(0000) knlGS:0000000000000000
>>> [2183922.264771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [2183922.264771] CR2: 00007f4fb7656170 CR3: 0000000f34af2000 CR4: 00000000003406f0
>>> [2183922.264771] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [2183922.264771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [2183922.264771] Stack:
>>> [2183922.264771]  0000010007dee895 fffffffffffffffe 0000000039d663f2 ffff880f3978a400
>>> [2183922.264771]  0000000000000000 ffff8809976b7000 ffff880f3978a408 ffff8809976b7020
>>> [2183922.264771]  ffff880f321a3df0 ffffffffc12268f8 ffff88007bb9d200 00000001976b2e08
>>> [2183922.264771] Call Trace:
>>> [2183922.264771]  [<ffffffffc12268f8>] ceph_mdsc_close_sessions+0x1d8/0x2e0 [ceph]
>>> [2183922.264771]  [<ffffffff8122bf27>] ? evict_inodes+0x177/0x1a0
>>> [2183922.264771]  [<ffffffffc12031b3>] ceph_put_super+0x23/0x50 [ceph]
>>> [2183922.264771]  [<ffffffff812115df>] generic_shutdown_super+0x6f/0x100
>>> [2183922.264771]  [<ffffffffc1203136>] ceph_kill_sb+0x36/0x90 [ceph]
>>> [2183922.264771]  [<ffffffff81211ac3>] deactivate_locked_super+0x43/0x70
>>> [2183922.264771]  [<ffffffff81211f9c>] deactivate_super+0x5c/0x60
>>> [2183922.264771]  [<ffffffff8123000f>] cleanup_mnt+0x3f/0x90
>>> [2183922.264771]  [<ffffffff812300a2>] __cleanup_mnt+0x12/0x20
>>> [2183922.264771]  [<ffffffff8109f031>] task_work_run+0x81/0xa0
>>> [2183922.264771]  [<ffffffff81003242>] exit_to_usermode_loop+0xc2/0xd0
>>> [2183922.264771]  [<ffffffff81003c6e>] syscall_return_slowpath+0x4e/0x60
>>> [2183922.264771]  [<ffffffff81840bd0>] int_ret_from_sys_call+0x25/0x8f
>>> [2183922.264771] Code: 2e 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 48 89 fa 48 c7 c6 80 79 23 c1 48 c7 c7 40 4d 24 c1 e8 59 2c 20 c0 e9 f9 fe ff ff <0f> 0b 0f 0b e8 4b f8 e5 bf 90 66 2e 0f 1f 84 00 00 00 00 00 0f
>>> [2183922.264771] RIP  [<ffffffffc12218ac>] remove_session_caps+0x13c/0x150 [ceph]
>>> [2183922.264771]  RSP <ffff880f321a3d38>
>>> [2183922.307469] ---[ end trace e6fc86f4c2c986fd ]---
>>> 
>>> This is different from a previous one that Zheng had looked into few months back as it seems to 
>>> point that s_nr_caps still remains > 0 ?
>>> 
>>> 1
>>> 1218 /*
>>> 1219  * caller must hold session s_mutex
>>> 1220  */
>>> 1221 static void remove_session_caps(struct ceph_mds_session *session)
>>> 1222 {
>>> 1223        dout("remove_session_caps on %p\n", session);
>>> 1224        iterate_session_caps(session, remove_session_caps_cb, NULL);
>>> 1225        
>>> 1226        spin_lock(&session->s_cap_lock);
>>> 1227        if (session->s_nr_caps > 0) {
>>> 1228                struct super_block *sb = session->s_mdsc->fsc->sb;
>>> 1229                struct inode *inode;
>>> 1230                struct ceph_cap *cap, *prev = NULL;
>>> 1231                struct ceph_vino vino;
>>> 1232                /*
>>> 1233                  * iterate_session_caps() skips inodes that are being
>>> 1234                  * deleted, we need to wait until deletions are complete.
>>> 1235                  * __wait_on_freeing_inode() is designed for the job,
>>> 1236                  * but it is not exported, so use lookup inode function
>>> 1237                  * to access it.
>>> 1238                  */
>>> 1239                while (!list_empty(&session->s_caps)) {
>>> 1240                        cap = list_entry(session->s_caps.next,
>>> 1241                                          struct ceph_cap, session_caps);
>>> 1242                        if (cap == prev) 
>>> 1243                                break;
>>> 1244                        prev = cap;
>>> 1245                        vino = cap->ci->i_vino;
>>> 1246                        spin_unlock(&session->s_cap_lock);
>>> 1247                        
>>> 1248                        inode = ceph_find_inode(sb, vino);
>>> 1249                        iput(inode);
>>> 1250                        
>>> 1251                        spin_lock(&session->s_cap_lock);
>>> 1252                }      
>>> 1253        }      
>>> 1254        
>>> 1255        // drop cap expires and unlock s_cap_lock
>>> 1256        cleanup_cap_releases(session->s_mdsc, session);
>>> 1257        
>>> 1258        BUG_ON(session->s_nr_caps > 0);
>>> 1259        BUG_ON(!list_empty(&session->s_cap_flushing));
>>> 1260 }      
>>> 1261 
>>> 
>>> Easily reproducible multiple times.
>> 
> 
> FWIW, the locking in this function looks really wrong.
> 
> Both s_caps list and s_nr_caps are protected by the s_cap_lock. That
> function drops that lock in the middle of walking the list to call
> ceph_find_inode. What prevents concurrent alterations to that list? 
> 

when remove_session_caps() is being called, no one should add caps to the session. It’s only
possible that there are concurrent freeing inodes. what’s the problem here?

Regards
Yan, Zheng


> Maybe some extra serialization was added that papered over this problem
> recently?
> 
> 
>>> 
>>> 
>> 
>> 4.4.0 is pretty ancient. Is it reproducible vs. a more recent kernel? Say, something v4.14-rc ish?
>> -- 
>> Jeff Layton <jlayton@redhat.com
>>> 
> 
> -- 
> Jeff Layton <jlayton@redhat.com>

