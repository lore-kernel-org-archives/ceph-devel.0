From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Bug while creating new cluster
Date: Thu, 9 Jun 2011 18:23:57 -0700
Message-ID: <BANLkTikTp-hDEHtMmqnxp6Y2K8tBJXVRiQ@mail.gmail.com>
References: <0a039c525aee33b4199342fb05256aa8@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45864 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab1FJBX7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 21:23:59 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4AFF4C692
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 18:23:59 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id C6AC2C12E
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 18:23:58 -0700 (PDT)
Received: by eyx24 with SMTP id 24so737184eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jun 2011 18:23:57 -0700 (PDT)
In-Reply-To: <0a039c525aee33b4199342fb05256aa8@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

What version of the code are you using? Master was broken for a couple
hours today but should be fixed now.

On Thu, Jun 9, 2011 at 6:17 PM, Dyweni - Ceph-Devel
<YS3fpFE2ykfB@dyweni.com> wrote:
> Hi All,
>
> Just tripped over this bug:
>
> *** Caught signal (Segmentation fault) **
> =A0in thread 0xb6fff6d0
> =A0ceph version 0.28.2-310-gb6e5c08
> (commit:b6e5c080a273dfbc679a2db2772f8b58f72bc517)
> =A01: (ceph::BackTrace::BackTrace(int)+0x24) [0x83033c4]
> =A02: /usr/bin/cmon() [0x83320f5]
> =A03: [0xb786f400]
> =A04: (Monitor::Monitor(std::string, MonitorStore*, Messenger*, MonMa=
p*)+0xc)
> [0x81ef61e]
> =A05: (main()+0x57e) [0x81dec66]
> =A06: (__libc_start_main()+0xe2) [0xb7016cc2]
> =A07: /usr/bin/cmon() [0x81de4a1]
> /usr/sbin/mkcephfs: line 257: =A0 673 Segmentation fault =A0 =A0 =A0(=
core dumped)
> $BINDIR/cmon -c $conf --mkfs -i $id --monmap $dir/monmap --osdmap
> $dir/osdmap -k $dir/keyring.mon
> failed: 'ssh ceph4 /usr/sbin/mkcephfs -d /tmp/mkfs.ceph.707 --init-da=
emon
> mon.4'
>
>
> (gdb) bt
> #0 =A00xb786f424 in __kernel_vsyscall ()
> #1 =A00xb7862e10 in raise (sig=3D11) at
> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:42
> #2 =A00x08331fad in reraise_fatal (signum=3D11) at common/signal.cc:6=
1
> #3 =A00x08332173 in handle_fatal_signal (signum=3D11) at common/signa=
l.cc:108
> #4 =A0<signal handler called>
> #5 =A00x081ef61e in Monitor::Monitor (this=3D0xbfed27f0, nm=3D..., s=3D=
0xbfed2e70,
> m=3D0x0, map=3D0xbfed2d14) at mon/Monitor.cc:104
> #6 =A00x081dec66 in main (argc=3D12, argv=3D0xbfed3064) at cmon.cc:11=
2
>
>
> (gdb) p this
> $1 =3D (Monitor * const) 0xbfed27f0
> (gdb) p nm
> $2 =3D {static npos =3D <optimized out>, _M_dataplus =3D {<std::alloc=
ator<char>> =3D
> {<__gnu_cxx::new_allocator<char>> =3D {<No data fields>}, <No data fi=
elds>},
> =A0 =A0_M_p =3D 0xbfed2ec0 "\354K\360\tLNA\b"}}
> (gdb) p s
> $3 =3D (MonitorStore *) 0xbfed2e70
> (gdb) p map
> $4 =3D (MonMap *) 0xbfed2d14
> (gdb) p *map
> $5 =3D {epoch =3D 1, fsid =3D {fsid =3D
> "=3D\000\346\331\021t\221\351y\335[\252\343\227\330\304"}, mon_addr =3D=
 {_M_t =3D
> {
> =A0 =A0 =A0_M_impl =3D
> {<std::allocator<std::_Rb_tree_node<std::pair<std::basic_string<char,
> std::char_traits<char>, std::allocator<char> > const, entity_addr_t> =
> >> =3D
> {<__gnu_cxx::new_allocator<std::_Rb_tree_node<std::pair<std::basic_st=
ring<char,
> std::char_traits<char>, std::allocator<char> > const, entity_addr_t> =
> >> =3D
> {<No data fields>}, <No data fields>},
> =A0 =A0 =A0 =A0_M_key_compare =3D {<std::binary_function<std::basic_s=
tring<char,
> std::char_traits<char>, std::allocator<char> >, std::basic_string<cha=
r,
> std::char_traits<char>, std::allocator<char> >, bool>> =3D {<No data =
fields>},
> <No data fields>}, _M_header =3D {_M_color =3D std::_S_red, _M_parent=
 =3D
> 0x9f05088,
> =A0 =A0 =A0 =A0 =A0_M_left =3D 0x9f05088, _M_right =3D 0x9f05088}, _M=
_node_count =3D 1}}},
> last_changed =3D {tv =3D {tv_sec =3D 1307667829, tv_nsec =3D 46585200=
0}}, created =3D
> {
> =A0 =A0tv =3D {tv_sec =3D 1307667829, tv_nsec =3D 465852000}},
> =A0rank_name =3D {<std::_Vector_base<std::basic_string<char,
> std::char_traits<char>, std::allocator<char> >,
> std::allocator<std::basic_string<char, std::char_traits<char>,
> std::allocator<char> > > >> =3D {
> =A0 =A0 =A0_M_impl =3D {<std::allocator<std::basic_string<char,
> std::char_traits<char>, std::allocator<char> > >> =3D
> {<__gnu_cxx::new_allocator<std::basic_string<char, std::char_traits<c=
har>,
> std::allocator<char> > >> =3D {<No data fields>}, <No data fields>}, =
_M_start
> =3D 0x9f05128, _M_finish =3D 0x9f0512c,
> =A0 =A0 =A0 =A0_M_end_of_storage =3D 0x9f0512c}}, <No data fields>}, =
rank_addr =3D
> {<std::_Vector_base<entity_addr_t, std::allocator<entity_addr_t> >> =3D=
 {
> =A0 =A0 =A0_M_impl =3D {<std::allocator<entity_addr_t>> =3D
> {<__gnu_cxx::new_allocator<entity_addr_t>> =3D {<No data fields>}, <N=
o data
> fields>},
> =A0 =A0 =A0 =A0_M_start =3D 0x9f05138, _M_finish =3D 0x9f051c0, _M_en=
d_of_storage =3D
> 0x9f051c0}}, <No data fields>}}
>
>
>
>
> Thanks,
> Dyweni
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
