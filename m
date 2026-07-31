Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C23793B1
	for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481774; cv=none; b=VgcANYjuuLAzRoIzjdSa4/kJBBpMty6iyp6XRXj9H4fCcteYrd5LQdi/h2q68y5E4nanvm/n8u8qPosrflBult1JdfMJeWKAm0mdNbYyk1zkvOR9rt53i7oiJX8nU1gvB45fLshQPtyYEzGxrNYpwBI2M5GLcVNY+gSEtG0sW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481774; c=relaxed/simple;
	bh=BGdvz7AuKqJqgWteXG2FyESZcoQUein1XaOA//oZFes=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GIuIqQ1FiCDcKM2IBW8MItUYn6gHi1dJ7NkP5OBFSYcwADBMipzkA4wPTOKWwGzPN/QRS6+5Wu+ci/O34WQId9xo7xzHPQC/E11Roy8dohHKKsPbgUIxiZp28UdY3PsCkeZS+U1KtK/m2ArlPbt2U6oRDLiLB8wNq0B6C2FEZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4a416619e8dso677107b6e.1
        for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2026 00:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481768; x=1786086568;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TxOFRqDiLyKxI4NvkM6WuuKVCWvMgpQ+aQoyI5Utq4=;
        b=LnyBAuWdz1zcJgY2oYX28hdbonVTsLk0DY0dMtUm+NZA2YOHrd51OLCUssUDws4Mb9
         U4vHgZsQAfjhYXv4boVnoD81H2D39n8WyrhTQDrNvl7wh+rGt+xKY4ddycThpe/f1FHv
         e5qK9xbew1IzOo+LxXaJ3W35H+n6F5aKXf4imoqDBjCrwvvUn6Sv6ImddnLsxnlojIlH
         Dpdj3zLv8rGlPvD2lQi4TXBvmxQzNUihjhCbPHukhShRUhA9DjkqPkk7oOJhGC9NtOnC
         IZJkLJYEg23nThtnqNacM1FFfmLkrhZzx+oMXEisaJI8tvctQ5CKrdjUTPjK03kFRLVQ
         Ly/g==
X-Forwarded-Encrypted: i=1; AHgh+Rog/T7wKpfWXwfVgSdzUnpMg9Rd4F7v95cMy4AXOwfDKCywvXNFWwBJyrGE37sBnTi9it/WKmUcwOLk@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyotPPWN5SxwpkkaK96xyTRPCZgpRCmlKrA92BWvzgWGEKfWb
	KM9zB6cagG4ZsemR7WxYwTH0wFMTLMSmnSwtxyYEs2TOcJrcPj9YD6h6h/z9GdVokdd1sO0o5L/
	clw1eIFNzgxyhRB0ZW8T10+bEvBwQvPzLmjZNc5aw7lbbtrB4V2MVOvzEHg8=
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a8:b0:490:17f1:ac3b with SMTP id
 5614622812f47-4ae31a41dcdmr830283b6e.18.1785481768223; Fri, 31 Jul 2026
 00:09:28 -0700 (PDT)
Date: Fri, 31 Jul 2026 00:09:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6c4a28.77639fcc.3d4fd0.001f.GAE@google.com>
Subject: [syzbot] [ceph?] WARNING in ceph_con_v2_try_read
From: syzbot <syzbot+87c7c2d63c44e41c77a3@syzkaller.appspotmail.com>
To: amarkuze@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4235cb24ec1e Merge tag 'vfs-7.2-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129ba7b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=87c7c2d63c44e41c77a3
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d96499580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12eaf2ea580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/906b09e16f16/disk-4235cb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cb120bc3818/vmlinux-4235cb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/880615d1b5d5/bzImage-4235cb24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87c7c2d63c44e41c77a3@syzkaller.appspotmail.com

------------[ cut here ]------------
!iov_iter_count(&con->v2.in_iter)
WARNING: net/ceph/messenger_v2.c:3129 at populate_in_iter net/ceph/messenger_v2.c:3129 [inline], CPU#0: kworker/0:2/188
WARNING: net/ceph/messenger_v2.c:3129 at ceph_con_v2_try_read+0x6634/0x6810 net/ceph/messenger_v2.c:3159, CPU#0: kworker/0:2/188
Modules linked in:
CPU: 0 UID: 0 PID: 188 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: ceph-msgr ceph_con_workfn
RIP: 0010:populate_in_iter net/ceph/messenger_v2.c:3129 [inline]
RIP: 0010:ceph_con_v2_try_read+0x6634/0x6810 net/ceph/messenger_v2.c:3159
Code: 8d 3d 70 31 d5 04 43 0f b6 04 3e 84 c0 48 8b 54 24 38 0f 85 85 00 00 00 8b 32 67 48 0f b9 3a e9 40 ff ff ff e8 3d cd 31 f6 90 <0f> 0b 90 41 bd c3 ff ff ff e9 32 ff ff ff e8 29 cd 31 f6 90 0f 0b
RSP: 0018:ffffc90002f574a0 EFLAGS: 00010293
RAX: ffffffff8b9536c3 RBX: 0000000000000000 RCX: ffff888020b05d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f57a78 R08: ffff888033ca86a7 R09: ffff888033ca869b
R10: dffffc0000000000 R11: ffffed10067950d5 R12: fffff520005eaee4
R13: 0000000000000000 R14: 0000000000000010 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124f4e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c5aa0fff8 CR3: 00000000251ca000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ceph_con_workfn+0x1f5/0x14a0 net/ceph/messenger.c:1575
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
