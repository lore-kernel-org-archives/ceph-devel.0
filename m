Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303539A067
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113456; cv=none; b=PJlXeLucAGQkdaKbq0O1iJv/2XCpmEREZ9FCWTDILwiZQfJcOGf98R4v0Ov7XUNZvSgy0rZOVBrT0zsrPmSsZKvHu9pJkAKKS0EIYLGYF8yUOT1+kigo7lTlbab4bmEx8j0u2YSWe+QZOoLY4AGxcTpHb+JTYwxnH9rtsAXSlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113456; c=relaxed/simple;
	bh=2B6Lvh2gq0td/Nuyyb9lJpzZql0drgeYyn2o0s94bys=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fsdb3zGnh+5jIAHUdZz3KpSFLl45RBSkkMsxCBWaRTtQH14ZVcXA3TBgyACD9Vu8bbgWohqcdd63IT7eLdFloY9WVSLser8R1LVTOBnh8B/4sVy4n5I2y0U5Skym7cltUtmPrBMstGaJpLw/DkQPEbv87OttCDslA4TjDNY2pXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6a196857c7aso3444116eaf.2
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2026 07:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113450; x=1786718250;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4w3Typ/F1IVihoiFzds1ZFKB8zwCEvgvAxAaRrIaPDM=;
        b=Him3L4rZX285Tvto/62DZc+7AWQwQnzaoF3EHhUTc3M47oAfNi/EDyDgRKenyKt+3G
         rpz1vcQvl+4G5GuWy4LPrCz5m4uwy2zS2mXJxtCf8+xiKhUmrNTvABk2JIOjbexTTBbg
         kZAq4YAt5GHcoJCTikN/kmL0wsulFj3EYG4nVBKi0jbubv9X+4Gf6rH44jfqMkgtZ4Ua
         avvFTGStAq+6kuTra11L0PS/A9MYMqumKmQ+OXPFOKDgXo/aoVG0SwjOP2COFQGPgNA7
         /vpc3ZWBR/MDVrQhPzqPoNQ636yB/ptISPheOyVSE+PPT+O6dMIgro5o35YW6eUxB5Tj
         btIg==
X-Forwarded-Encrypted: i=1; AHgh+RrogPDen70cQ48gEdFQA+/dDf6FfZaE2cKYIjYzlhYnzdmqelNmX6956m1BUJQttcA6SXOsKLUSkVQq@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWLwxoSQAvtpyxZ3NpZTw+bLv9A/+Zi4kG+zeFKVuSx+q3bx7
	P9HgEmHSputwMdCY9V8199K9eDAzpaF1RYqOqM6DinpPVTj26yqS7SO1gWuLkhRXb1QQkD99Raa
	I0FcJUCPG6dcS9T9T5T52PaZLDd2ATzZcpKHy+6DeZJFeFDZgwZvQxrmcGAk=
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1990:b0:6ae:84e6:2de0 with SMTP id
 006d021491bc7-6b042143dd7mr270707eaf.26.1786113450239; Fri, 07 Aug 2026
 07:37:30 -0700 (PDT)
Date: Fri, 07 Aug 2026 07:37:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a75edaa.01d0871a.3a0d52.004b.GAE@google.com>
Subject: [syzbot] [ceph?] WARNING in ceph_con_v1_try_read
From: syzbot <syzbot+21f8628595b2061c438d@syzkaller.appspotmail.com>
To: amarkuze@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075b74841bd0 Linux 7.2-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118743b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=21f8628595b2061c438d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1085de32580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1485de32580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/678e77cc37b9/disk-075b7484.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc9f771e7069/vmlinux-075b7484.xz
kernel image: https://storage.googleapis.com/syzbot-assets/71a5d4620b85/bzImage-075b7484.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21f8628595b2061c438d@syzkaller.appspotmail.com

------------[ cut here ]------------
con->v1.connect_seq != le32_to_cpu(con->v1.in_reply.connect_seq)
WARNING: net/ceph/messenger_v1.c:902 at process_connect net/ceph/messenger_v1.c:901 [inline], CPU#0: kworker/0:2/198
WARNING: net/ceph/messenger_v1.c:902 at ceph_con_v1_try_read+0x3335/0x6eb0 net/ceph/messenger_v1.c:1366, CPU#0: kworker/0:2/198
Modules linked in:
CPU: 0 UID: 0 PID: 198 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: ceph-msgr ceph_con_workfn
RIP: 0010:process_connect net/ceph/messenger_v1.c:901 [inline]
RIP: 0010:ceph_con_v1_try_read+0x3335/0x6eb0 net/ceph/messenger_v1.c:1366
Code: 45 31 e4 e9 3f d1 ff ff e8 68 a6 be f6 90 0f 0b 90 e9 cd d3 ff ff e8 5a a6 be f6 90 0f 0b 90 e9 dd e6 ff ff e8 4c a6 be f6 90 <0f> 0b 90 e9 f4 e7 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 30 d1
RSP: 0018:ffffc90003c5f180 EFLAGS: 00010293
RAX: ffffffff8b073574 RBX: 0000000000000001 RCX: ffff88802137dd00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003c5fa78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 000000000000000d R12: ffff88803e894488
R13: fffff5200078be70 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4e8ed7d58 CR3: 0000000045d70000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ceph_con_workfn+0x208/0x14a0 net/ceph/messenger.c:1577
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
