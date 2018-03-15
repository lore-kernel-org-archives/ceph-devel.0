From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: KASAN: use-after-free Read in set_page_dirty_lock
Date: Thu, 15 Mar 2018 16:38:55 +0000
Message-ID: <1521131935.2495.114.camel@decadent.org.uk>
References: <CAHk8ZdsLV=mMRWw-Cf5PDhFAmLO0oQGoY9b2szbbsgi2W+Ow1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cYcsjiJZya2hxK8SPNSD"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <CAHk8ZdsLV=mMRWw-Cf5PDhFAmLO0oQGoY9b2szbbsgi2W+Ow1A@mail.gmail.com>
Resent-Message-ID: <hzNHScTTvFB.A.VoD.IHqqaB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1521131935.2495.114.camel@decadent.org.uk
To: Kaipeng Zeng <kaipeng94@gmail.com>, syzkaller@googlegroups.com
Cc: debian-kernel@lists.debian.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


--=-cYcsjiJZya2hxK8SPNSD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: ceph-devel@vger.kernel.org

On Thu, 2018-03-15 at 23:10 +0800, Kaipeng Zeng wrote:
> KASAN: use-after-free Read in set_page_dirty_lock found by syzkaller.
> Kernel: debian package linux-source-4.14, build with KASAN enable
> P.S. "/root/tmp" is the mount point of cephfs
> Log & repro:
> Syzkaller hit 'KASAN: use-after-free Read in set_page_dirty_lock' bug.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in __read_once_size
> include/linux/compiler.h:178 [inline]
> BUG: KASAN: use-after-free in compound_head
> include/linux/page-flags.h:147 [inline]
> BUG: KASAN: use-after-free in trylock_page include/linux/pagemap.h:468 [i=
nline]
> BUG: KASAN: use-after-free in lock_page include/linux/pagemap.h:478 [inli=
ne]
> BUG: KASAN: use-after-free in set_page_dirty_lock+0x9c/0xa0
> mm/page-writeback.c:2606
> Read of size 8 at addr ffff88007bb63ae0 by task syzkaller929525/563
>=20
> CPU: 2 PID: 563 Comm: syzkaller929525 Not tainted 4.14.17 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/0=
1/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x7b/0xa4 lib/dump_stack.c:53
>  print_address_description+0x73/0x270 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x254/0x370 mm/kasan/report.c:409
>  __read_once_size include/linux/compiler.h:178 [inline]
>  compound_head include/linux/page-flags.h:147 [inline]
>  trylock_page include/linux/pagemap.h:468 [inline]
>  lock_page include/linux/pagemap.h:478 [inline]
>  set_page_dirty_lock+0x9c/0xa0 mm/page-writeback.c:2606
>  ceph_put_page_vector+0x10b/0x180 [libceph]
>  ceph_direct_read_write+0x1126/0x1da0 [ceph]
>  ceph_read_iter+0xc10/0x1280 [ceph]
>  call_read_iter include/linux/fs.h:1767 [inline]
>  generic_file_splice_read+0x396/0x610 fs/splice.c:307
>  do_splice_to+0x104/0x150 fs/splice.c:881
>  do_splice fs/splice.c:1175 [inline]
>  SYSC_splice fs/splice.c:1404 [inline]
>  SyS_splice+0xf58/0x12d0 fs/splice.c:1384
>  system_call_fast_compare_end+0x12/0x75
> RIP: 0033:0x4337a9
> RSP: 002b:00007ffea3f98f78 EFLAGS: 00000216
>=20
> Allocated by task 459:
>  save_stack+0x33/0xa0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xa0/0xd0 mm/kasan/kasan.c:551
>  __do_kmalloc mm/slab.c:3726 [inline]
>  __kmalloc+0x11a/0x620 mm/slab.c:3735
>  kmalloc include/linux/slab.h:499 [inline]
>  load_elf_phdrs+0x16d/0x1d0 fs/binfmt_elf.c:431
>  load_elf_binary+0x930/0x4540 fs/binfmt_elf.c:824
>  search_binary_handler+0x176/0x4b0 fs/exec.c:1640
>  exec_binprm fs/exec.c:1682 [inline]
>  do_execveat_common.isra.30+0xffa/0x1890 fs/exec.c:1804
>  do_execve fs/exec.c:1849 [inline]
>  SYSC_execve fs/exec.c:1930 [inline]
>  SyS_execve+0x39/0x50 fs/exec.c:1925
>  do_syscall_64+0x1e8/0x4e0 arch/x86/entry/common.c:299
>  return_from_SYSCALL_64+0x0/0x65
>=20
> Freed by task 459:
>  save_stack+0x33/0xa0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3504 [inline]
>  kfree+0x88/0x110 mm/slab.c:3821
>  load_elf_binary+0x1952/0x4540 fs/binfmt_elf.c:1096
>  search_binary_handler+0x176/0x4b0 fs/exec.c:1640
>  exec_binprm fs/exec.c:1682 [inline]
>  do_execveat_common.isra.30+0xffa/0x1890 fs/exec.c:1804
>  do_execve fs/exec.c:1849 [inline]
>  SYSC_execve fs/exec.c:1930 [inline]
>  SyS_execve+0x39/0x50 fs/exec.c:1925
>  do_syscall_64+0x1e8/0x4e0 arch/x86/entry/common.c:299
>  return_from_SYSCALL_64+0x0/0x65
>=20
> The buggy address belongs to the object at ffff88007bb63ac0
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 32 bytes inside of
>  512-byte region [ffff88007bb63ac0, ffff88007bb63cc0)
> The buggy address belongs to the page:
> page:ffffea0001eed8c0 count:1 mapcount:0 mapping:ffff88007bb630c0 index:0=
x0
> flags: 0x4ffffc000000100(slab)
> raw: 04ffffc000000100 ffff88007bb630c0 0000000000000000 0000000100000006
> raw: ffffea0001eec0e0 ffffea0001d0c220 ffff88002d4002c0 0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
>  ffff88007bb63980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88007bb63a00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> > ffff88007bb63a80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>=20
>                                                        ^
>  ffff88007bb63b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88007bb63b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> Syzkaller reproducer:
> # {Threaded:false Collide:false Repeat:false Procs:1 Sandbox:
> Fault:false FaultCall:-1 FaultNth:0 EnableTun:false UseTmpDir:false
> HandleSegv:false WaitRepeat:false Debug:false Repro:false}
> mmap(&(0x7f0000000000/0x447000)=3Dnil, 0x447000, 0x3, 0x32,
> 0xffffffffffffffff, 0x0)
> pipe$ceph_fops(&(0x7f00001c2000)=3D{0x0, <r0=3D>0x0})
> r1 =3D open$ceph_fops(&(0x7f000007e000)=3D'/root/tmp/test\x00', 0x44000, =
0x121)
> splice$ceph_fops_in(r1, &(0x7f000009c000-0x8)=3D0x36, r0, 0x0, 0x5, 0x1)
>=20
>=20
> C reproducer:
> // autogenerated by syzkaller (http://github.com/google/syzkaller)
>=20
> #define _GNU_SOURCE
> #include <endian.h>
> #include <stdint.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>=20
> long r[2];
> void loop()
> {
>   memset(r, -1, sizeof(r));
>   syscall(__NR_mmap, 0x20000000, 0x447000, 3, 0x32, -1, 0);
>   if (syscall(__NR_pipe, 0x201c2000) !=3D -1)
>     r[0] =3D *(uint32_t*)0x201c2004;
>   memcpy((void*)0x2007e000, "/root/tmp/test", 15);
>   r[1] =3D syscall(__NR_open, 0x2007e000, 0x44000, 0x121);
>   *(uint64_t*)0x2009bff8 =3D 0x36;
>   syscall(__NR_splice, r[1], 0x2009bff8, r[0], 0, 5, 1);
> }
>=20
> int main()
> {
>   loop();
>   return 0;
> }
>=20
>=20
> Reproducing stats:
> Extracting prog: 5h8m47.118307857s
> Minimizing prog: 35m20.785719207s
> Simplifying prog options: 0s
> Extracting C: 35.310144578s
> Simplifying C: 4m6.310642807s
>=20
--=20
Ben Hutchings
Quantity is no substitute for quality, but it's the only one we've got.

--=-cYcsjiJZya2hxK8SPNSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqqoZ8ACgkQ57/I7JWG
EQkT1A//ZvhsTCHZAXKEZlDMQ9nmjfAPfN6MT+g+KBpEsyKQTB4TohSEcce61oQM
0ZeqROkMOAJx28jeKeyA5ogjVtSqVwsdO55kyYWKmQkP38A0aHP2wadNPKsW0+mh
i2UrGsf3W8c8xlj3QZYheG8a3VlMWi+CI8dIzDeQOtMsAJLgitqarRYHL6DwCqoB
uWfOPHvT0okWgTQHasQY8R1zyNB/cNX6sUNLoB2vaWzHR71kl1HrHqTuSTzsmrlm
zaKRFmX5vL4M+NIpoockMeUhMdLmfojyoBLWLUdjZzp8M6SWbIFVT7b34WM2hPh5
xGgsAgKVvyZ6eraeZ1hpzjoFY1ISRcRmSSbbDlBicnLJ+gyy4ALrBq/sn0zDqZPu
fYprduR8OIHE5vHLuNNmQF1rKwZW5MXkSZbTj7owctkNN/pzEszUCJziwrngUxlB
4S0c9I3+YyTeIvr0+BpeHvfsJStieDOtN1MB7LQqhkMqP8C4ekkOm+rMMGIZk7hH
xiACzzqmGfLtSQT6xF4PHIbj4SM65yUSn7AX7vhtiUZ+mt6PCHcdvkRd7jPeowRD
Uor1035PXFM5uTslLgsXvw4Dx2ZKS7J8CIPqRMKcNTdWfd+Tv3MZQ0jbwq14Rkog
YmDkJfFvFrdiwwTScud5+RcbmfJJ2gDWce1CJfuKuL/Lxnuktzg=
=mfmy
-----END PGP SIGNATURE-----

--=-cYcsjiJZya2hxK8SPNSD--
