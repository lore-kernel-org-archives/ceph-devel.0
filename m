From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: CephFS: Jewel release: kernel panic seen while unmounting. Known Issue?
Date: Tue, 17 Oct 2017 11:38:12 +0800
Message-ID: <CAAM7YAnDPsyTYDsvEPnbsWuiOZu+LvgTcu_egc95NbJ1W9pRmA@mail.gmail.com>
References: <113598501.593996.1498063632618.ref@mail.yahoo.com>
 <113598501.593996.1498063632618@mail.yahoo.com> <825845594.4337327.1507565356087@mail.yahoo.com>
 <1507565571.5289.1.camel@redhat.com> <1415045998.1551016.1507936292485@mail.yahoo.com>
 <1507981216.4831.14.camel@redhat.com> <B6E48701-25B0-4A28-AC36-6543C42BD75C@redhat.com>
 <1508161480.5023.10.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:55346 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754964AbdJQDiN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Oct 2017 23:38:13 -0400
Received: by mail-oi0-f48.google.com with SMTP id g125so597434oib.12
        for <ceph-devel@vger.kernel.org>; Mon, 16 Oct 2017 20:38:13 -0700 (PDT)
In-Reply-To: <1508161480.5023.10.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Anish Gupta <anish_gupta@yahoo.com>, Milosz Tanski <milosz@adfin.com>, Sage Weil <sweil@redhat.com>, David Howells <dhowells@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 16, 2017 at 9:44 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Mon, 2017-10-16 at 08:15 +0800, Yan, Zheng wrote:
>> > On 14 Oct 2017, at 19:40, Jeff Layton <jlayton@redhat.com> wrote:
>> >
>> > (re-cc'ing ceph-devel list)
>> >
>> > Not right offhand, but I do have some comments about this code for the
>> > maintainers. See below:
>> >
>> > On Fri, 2017-10-13 at 23:11 +0000, Anish Gupta wrote:
>> > > Hello Jeff,
>> > >
>> > >
>> > > I did not see the issue with 4.4.14-rc4.
>> > >
>> > >
>> > > Would you or Zheng know which set of changes from 4.4 onwards might =
have helped fix this?
>> > > PS: I worked with Zheng on chage-id:  62a65f36d016fff32179acdbfcb8b2=
d8d9e54757
>> > >
>> > > thanks,
>> > > Anish
>> > >
>> > >
>> > > On Monday, October 9, 2017, 9:12:54 AM PDT, Jeff Layton <jlayton@red=
hat.com> wrote:
>> > >
>> > >
>> > > On Mon, 2017-10-09 at 16:09 +0000, Anish Gupta wrote:
>> > >
>> > > >
>> > > >
>> > > > Hello Ceph gurus,
>> > > >
>> > > > I was running a script in a loop that was doing the following:
>> > > >
>> > > > > Loop:
>> > > > >     mount 2 different ceph "clients" using their own shares and =
secret keys and FSCache
>> > > > >     write data into a sub-directory of client1
>> > > > >         let i=3D0; while (($i<10)); do sudo dd if=3D/dev/urandom=
 of=3Ddata_file_$i bs=3D10M count=3D1; let i=3D$i+1; done
>> > > > >     write data into client 2 using same as previous step.
>> > > > >     read data from client 1
>> > > > >           cp -r /client1/data/ /tmp/scratch1_dir
>> > > > >     read data from client 2
>> > > > >       cp -r /client2/data/ /tmp/scratch2_dir
>> > > > >     unmount the 2 clients
>> > > > >
>> > > > >
>> > > > >
>> > > >
>> > > > Linux Kernel:  4.4.0-81-generic
>> > > > $ ceph --version
>> > > > ceph version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185)
>> > > >
>> > > > Only one script of above loop was running and after 4th iteration =
ran into this bug:
>> > > >
>> > > > Back trace looks like this:
>> > > > [2183922.263463] ------------[ cut here ]------------
>> > > > [2183922.264771] kernel BUG at /root/ubuntu-xenial/fs/ceph/mds_cli=
ent.c:1258!
>> > > > [2183922.264771] invalid opcode: 0000 [#1] SMP
>> > > > [2183922.264771] Modules linked in: nfs lockd grace xt_nat ceph(OE=
) libceph libcrc32c veth ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_recent i=
pt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user xfrm_algo iptable_nat nf_nat=
_ipv4 br_netfilter bridge stp llc overlay binfmt_misc cachefiles(OE) fscach=
e(OE) xt_multiport xenfs xen_privcmd ppdev nls_utf8 isofs intel_rapl crct10=
dif_pclmul crc32_pclmul ghash_clmulni_intel nvidia_uvm(POE) aesni_intel aes=
_x86_64 lrw gf128mul glue_helper ablk_helper cryptd input_leds joydev serio=
_raw i2c_piix4 8250_fintek parport_pc parport mac_hid xt_hl ip6t_rt nf_conn=
track_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_comm=
on xt_LOG xt_limit xt_tcpudp xt_addrtype nf_conntrack_ipv4 nf_defrag_ipv4 x=
t_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns nf_conntrack=
_broadcast
>> > > > [2183922.264771]  nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack =
iptable_filter ip_tables x_tables sunrpc autofs4 hid_generic usbhid hid nvi=
dia_drm(POE) nvidia_modeset(POE) nvidia(POE) drm_kms_helper syscopyarea sys=
fillrect sysimgblt psmouse fb_sys_fops drm pata_acpi floppy fjes
>> > > > [2183922.264771] CPU: 0 PID: 19728 Comm: umount Tainted: P        =
  OE  4.4.0-81-generic #104-Ubuntu
>> > > > [2183922.264771] Hardware name: Xen HVM domU, BIOS 4.6.1-xs137595 =
03/23/2017
>> > > > [2183922.264771] task: ffff880d3aa12a00 ti: ffff880f321a0000 task.=
ti: ffff880f321a0000
>> > > > [2183922.264771] RIP: 0010:[<ffffffffc12218ac>]  [<ffffffffc12218a=
c>] remove_session_caps+0x13c/0x150 [ceph]
>> > > > [2183922.264771] RSP: 0018:ffff880f321a3d38  EFLAGS: 00010202
>> > > > [2183922.264771] RAX: 0000000000000001 RBX: ffff8809976b7000 RCX: =
ffff8807c1ee5028
>> > > > [2183922.264771] RDX: 0000000000000039 RSI: ffff880f321a3d00 RDI: =
ffff880f3978a608
>> > > > [2183922.264771] RBP: ffff880f321a3d78 R08: ffff880f321a0000 R09: =
0000000000000000
>> > > > [2183922.264771] R10: 0000000000032800 R11: 0000000000000000 R12: =
ffff8809976b7540
>> > > > [2183922.264771] R13: ffff8807c1ee5168 R14: ffff8809976b7548 R15: =
ffff8809976b2800
>> > > > [2183922.264771] FS:  00007f4fb7e28840(0000) GS:ffff880f42a00000(0=
000) knlGS:0000000000000000
>> > > > [2183922.264771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > > [2183922.264771] CR2: 00007f4fb7656170 CR3: 0000000f34af2000 CR4: =
00000000003406f0
>> > > > [2183922.264771] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> > > > [2183922.264771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>> > > > [2183922.264771] Stack:
>> > > > [2183922.264771]  0000010007dee895 fffffffffffffffe 0000000039d663=
f2 ffff880f3978a400
>> > > > [2183922.264771]  0000000000000000 ffff8809976b7000 ffff880f3978a4=
08 ffff8809976b7020
>> > > > [2183922.264771]  ffff880f321a3df0 ffffffffc12268f8 ffff88007bb9d2=
00 00000001976b2e08
>> > > > [2183922.264771] Call Trace:
>> > > > [2183922.264771]  [<ffffffffc12268f8>] ceph_mdsc_close_sessions+0x=
1d8/0x2e0 [ceph]
>> > > > [2183922.264771]  [<ffffffff8122bf27>] ? evict_inodes+0x177/0x1a0
>> > > > [2183922.264771]  [<ffffffffc12031b3>] ceph_put_super+0x23/0x50 [c=
eph]
>> > > > [2183922.264771]  [<ffffffff812115df>] generic_shutdown_super+0x6f=
/0x100
>> > > > [2183922.264771]  [<ffffffffc1203136>] ceph_kill_sb+0x36/0x90 [cep=
h]
>> > > > [2183922.264771]  [<ffffffff81211ac3>] deactivate_locked_super+0x4=
3/0x70
>> > > > [2183922.264771]  [<ffffffff81211f9c>] deactivate_super+0x5c/0x60
>> > > > [2183922.264771]  [<ffffffff8123000f>] cleanup_mnt+0x3f/0x90
>> > > > [2183922.264771]  [<ffffffff812300a2>] __cleanup_mnt+0x12/0x20
>> > > > [2183922.264771]  [<ffffffff8109f031>] task_work_run+0x81/0xa0
>> > > > [2183922.264771]  [<ffffffff81003242>] exit_to_usermode_loop+0xc2/=
0xd0
>> > > > [2183922.264771]  [<ffffffff81003c6e>] syscall_return_slowpath+0x4=
e/0x60
>> > > > [2183922.264771]  [<ffffffff81840bd0>] int_ret_from_sys_call+0x25/=
0x8f
>> > > > [2183922.264771] Code: 2e 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5=
d c3 48 89 fa 48 c7 c6 80 79 23 c1 48 c7 c7 40 4d 24 c1 e8 59 2c 20 c0 e9 f=
9 fe ff ff <0f> 0b 0f 0b e8 4b f8 e5 bf 90 66 2e 0f 1f 84 00 00 00 00 00 0f
>> > > > [2183922.264771] RIP  [<ffffffffc12218ac>] remove_session_caps+0x1=
3c/0x150 [ceph]
>> > > > [2183922.264771]  RSP <ffff880f321a3d38>
>> > > > [2183922.307469] ---[ end trace e6fc86f4c2c986fd ]---
>> > > > [2183922.263463] ------------[ cut here ]------------
>> > > > [2183922.264771] kernel BUG at /root/ubuntu-xenial/fs/ceph/mds_cli=
ent.c:1258!
>> > > > [2183922.264771] invalid opcode: 0000 [#1] SMP
>> > > > [2183922.264771] Modules linked in: nfs lockd grace xt_nat ceph(OE=
) libceph libcrc32c veth ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_recent i=
pt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user xfrm_algo iptable_nat nf_nat=
_ipv4 br_netfilter bridge stp llc overlay binfmt_misc cachefiles(OE) fscach=
e(OE) xt_multiport xenfs xen_privcmd ppdev nls_utf8 isofs intel_rapl crct10=
dif_pclmul crc32_pclmul ghash_clmulni_intel nvidia_uvm(POE) aesni_intel aes=
_x86_64 lrw gf128mul glue_helper ablk_helper cryptd input_leds joydev serio=
_raw i2c_piix4 8250_fintek parport_pc parport mac_hid xt_hl ip6t_rt nf_conn=
track_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_comm=
on xt_LOG xt_limit xt_tcpudp xt_addrtype nf_conntrack_ipv4 nf_defrag_ipv4 x=
t_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns nf_conntrack=
_broadcast
>> > > > [2183922.264771]  nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack =
iptable_filter ip_tables x_tables sunrpc autofs4 hid_generic usbhid hid nvi=
dia_drm(POE) nvidia_modeset(POE) nvidia(POE) drm_kms_helper syscopyarea sys=
fillrect sysimgblt psmouse fb_sys_fops drm pata_acpi floppy fjes
>> > > > [2183922.264771] CPU: 0 PID: 19728 Comm: umount Tainted: P        =
  OE  4.4.0-81-generic #104-Ubuntu
>> > > > [2183922.264771] Hardware name: Xen HVM domU, BIOS 4.6.1-xs137595 =
03/23/2017
>> > > > [2183922.264771] task: ffff880d3aa12a00 ti: ffff880f321a0000 task.=
ti: ffff880f321a0000
>> > > > [2183922.264771] RIP: 0010:[<ffffffffc12218ac>]  [<ffffffffc12218a=
c>] remove_session_caps+0x13c/0x150 [ceph]
>> > > > [2183922.264771] RSP: 0018:ffff880f321a3d38  EFLAGS: 00010202
>> > > > [2183922.264771] RAX: 0000000000000001 RBX: ffff8809976b7000 RCX: =
ffff8807c1ee5028
>> > > > [2183922.264771] RDX: 0000000000000039 RSI: ffff880f321a3d00 RDI: =
ffff880f3978a608
>> > > > [2183922.264771] RBP: ffff880f321a3d78 R08: ffff880f321a0000 R09: =
0000000000000000
>> > > > [2183922.264771] R10: 0000000000032800 R11: 0000000000000000 R12: =
ffff8809976b7540
>> > > > [2183922.264771] R13: ffff8807c1ee5168 R14: ffff8809976b7548 R15: =
ffff8809976b2800
>> > > > [2183922.264771] FS:  00007f4fb7e28840(0000) GS:ffff880f42a00000(0=
000) knlGS:0000000000000000
>> > > > [2183922.264771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > > [2183922.264771] CR2: 00007f4fb7656170 CR3: 0000000f34af2000 CR4: =
00000000003406f0
>> > > > [2183922.264771] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> > > > [2183922.264771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>> > > > [2183922.264771] Stack:
>> > > > [2183922.264771]  0000010007dee895 fffffffffffffffe 0000000039d663=
f2 ffff880f3978a400
>> > > > [2183922.264771]  0000000000000000 ffff8809976b7000 ffff880f3978a4=
08 ffff8809976b7020
>> > > > [2183922.264771]  ffff880f321a3df0 ffffffffc12268f8 ffff88007bb9d2=
00 00000001976b2e08
>> > > > [2183922.264771] Call Trace:
>> > > > [2183922.264771]  [<ffffffffc12268f8>] ceph_mdsc_close_sessions+0x=
1d8/0x2e0 [ceph]
>> > > > [2183922.264771]  [<ffffffff8122bf27>] ? evict_inodes+0x177/0x1a0
>> > > > [2183922.264771]  [<ffffffffc12031b3>] ceph_put_super+0x23/0x50 [c=
eph]
>> > > > [2183922.264771]  [<ffffffff812115df>] generic_shutdown_super+0x6f=
/0x100
>> > > > [2183922.264771]  [<ffffffffc1203136>] ceph_kill_sb+0x36/0x90 [cep=
h]
>> > > > [2183922.264771]  [<ffffffff81211ac3>] deactivate_locked_super+0x4=
3/0x70
>> > > > [2183922.264771]  [<ffffffff81211f9c>] deactivate_super+0x5c/0x60
>> > > > [2183922.264771]  [<ffffffff8123000f>] cleanup_mnt+0x3f/0x90
>> > > > [2183922.264771]  [<ffffffff812300a2>] __cleanup_mnt+0x12/0x20
>> > > > [2183922.264771]  [<ffffffff8109f031>] task_work_run+0x81/0xa0
>> > > > [2183922.264771]  [<ffffffff81003242>] exit_to_usermode_loop+0xc2/=
0xd0
>> > > > [2183922.264771]  [<ffffffff81003c6e>] syscall_return_slowpath+0x4=
e/0x60
>> > > > [2183922.264771]  [<ffffffff81840bd0>] int_ret_from_sys_call+0x25/=
0x8f
>> > > > [2183922.264771] Code: 2e 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5=
d c3 48 89 fa 48 c7 c6 80 79 23 c1 48 c7 c7 40 4d 24 c1 e8 59 2c 20 c0 e9 f=
9 fe ff ff <0f> 0b 0f 0b e8 4b f8 e5 bf 90 66 2e 0f 1f 84 00 00 00 00 00 0f
>> > > > [2183922.264771] RIP  [<ffffffffc12218ac>] remove_session_caps+0x1=
3c/0x150 [ceph]
>> > > > [2183922.264771]  RSP <ffff880f321a3d38>
>> > > > [2183922.307469] ---[ end trace e6fc86f4c2c986fd ]---
>> > > >
>> > > > This is different from a previous one that Zheng had looked into f=
ew months back as it seems to
>> > > > point that s_nr_caps still remains > 0 ?
>> > > >
>> > > > 1
>> > > > 1218 /*
>> > > > 1219  * caller must hold session s_mutex
>> > > > 1220  */
>> > > > 1221 static void remove_session_caps(struct ceph_mds_session *sess=
ion)
>> > > > 1222 {
>> > > > 1223        dout("remove_session_caps on %p\n", session);
>> > > > 1224        iterate_session_caps(session, remove_session_caps_cb, =
NULL);
>> > > > 1225
>> > > > 1226        spin_lock(&session->s_cap_lock);
>> > > > 1227        if (session->s_nr_caps > 0) {
>> > > > 1228                struct super_block *sb =3D session->s_mdsc->fs=
c->sb;
>> > > > 1229                struct inode *inode;
>> > > > 1230                struct ceph_cap *cap, *prev =3D NULL;
>> > > > 1231                struct ceph_vino vino;
>> > > > 1232                /*
>> > > > 1233                  * iterate_session_caps() skips inodes that a=
re being
>> > > > 1234                  * deleted, we need to wait until deletions a=
re complete.
>> > > > 1235                  * __wait_on_freeing_inode() is designed for =
the job,
>> > > > 1236                  * but it is not exported, so use lookup inod=
e function
>> > > > 1237                  * to access it.
>> > > > 1238                  */
>> > > > 1239                while (!list_empty(&session->s_caps)) {
>> > > > 1240                        cap =3D list_entry(session->s_caps.nex=
t,
>> > > > 1241                                          struct ceph_cap, ses=
sion_caps);
>> > > > 1242                        if (cap =3D=3D prev)
>> > > > 1243                                break;
>> > > > 1244                        prev =3D cap;
>> > > > 1245                        vino =3D cap->ci->i_vino;
>> > > > 1246                        spin_unlock(&session->s_cap_lock);
>> > > > 1247
>> > > > 1248                        inode =3D ceph_find_inode(sb, vino);
>> > > > 1249                        iput(inode);
>> > > > 1250
>> > > > 1251                        spin_lock(&session->s_cap_lock);
>> > > > 1252                }
>> > > > 1253        }
>> > > > 1254
>> > > > 1255        // drop cap expires and unlock s_cap_lock
>> > > > 1256        cleanup_cap_releases(session->s_mdsc, session);
>> > > > 1257
>> > > > 1258        BUG_ON(session->s_nr_caps > 0);
>> > > > 1259        BUG_ON(!list_empty(&session->s_cap_flushing));
>> > > > 1260 }
>> > > > 1261
>> > > >
>> > > > Easily reproducible multiple times.
>> >
>> > FWIW, the locking in this function looks really wrong.
>> >
>> > Both s_caps list and s_nr_caps are protected by the s_cap_lock. That
>> > function drops that lock in the middle of walking the list to call
>> > ceph_find_inode. What prevents concurrent alterations to that list?
>> >
>>
>> when remove_session_caps() is being called, no one should add caps to th=
e session. It=E2=80=99s only
>> possible that there are concurrent freeing inodes. what=E2=80=99s the pr=
oblem here?
>>
>
> It looks like Anish's box hit this:
>
>         BUG_ON(session->s_nr_caps > 0);
>
> I get that we're tearing down the session and that no new caps should be
> added, but what is the mechanism that prevents it?
>
> For instance, fill_inode is not done under the session->s_mutex,
> AFAICT.
>
> I don't see what would prevent fill_inode running concurrently on
> another CPU racing in and adding caps to the session after
> cleanup_cap_releases drops the spinlock here.
>

I think this race can happen in theory. But it's likely to cause the
oops. because if there were pending request replies, umounting should
return -EBUSY,

Regads
Yan, Zheng


> --
> Jeff Layton <jlayton@redhat.com>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
