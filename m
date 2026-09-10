Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D81496D39
	for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071149; cv=none; b=O5S4ypsnhgRE1UqPv6dvVs4JrAnsK9TXs9O93CsxVYYfFWDuH9qAppW1mE8hVATTaBSNobe82Ru+x90MZTdepd1rcrJIzz8tbjiO0Dp59sdKHsu1ula4y16sRugB2o5FHCCGnduwUyWICKG/fyoccTrYQazTdhPa62TsKa6nvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071149; c=relaxed/simple;
	bh=e0BXK8n7phBFvVA9KmzzBbWtJNCBZRJ0Sm7uaQAdxfA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Otm8G1R6nanlfKZGZ8cKBQsfIzxt+ye15PqXrPwKBgIFPO8BH9QmBhInqo3sBTiTaLODTSay+uHqc/HmE7hJnVHl8JKTP7t25frizD0O/2HIJl0vlYa7lEOCLpmNv7k6bqihbb7qIYCL0/SufTE20z+I+TDqsZ3AmA0auK/b+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6bf51cef9d3so49497eaf.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 13:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071146; x=1789675946;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5HmvppgMxkNy1w8k0yZJbD7xSt/louhCSDC60IEkIU=;
        b=dYMrJFnWCDRVQ19hDueznB9djdG088uHH7znEH3rQHnR+vD3npQGL0dCBMzwT9xZzJ
         frRTeKCf6TGAKma4MIFZe/9cajLITN75DxifMTenmQG9ZwD6tdRnv+J/ofG6PVBMmd3G
         PIafF6diVXb8zrmm1U6t/yCskLihoJsICz4olcu+OA9cRK5Fx+KRe23z+h8yxabzV/Ov
         vI2whU6G6EHR14F2U0MdCxMVMjWkbDmyoWpvQmGlqVBa/w5H37JQgAkrIMwoks0FzqdE
         /GAhynXQFLBEQ4B/LaNyn4N776t0lQRKoAYXwEdnnxU/xBNGRJOyQjVNpLlaW3The0sY
         JAOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzc7wQ2tGTKIdqevXiAGg05BJvgqzW3B26U2povWlHMRnBYJ9svG7PyITHG8apQYVVdl7J44J1JSQ1K@vger.kernel.org
X-Gm-Message-State: AFuF++mCrQqpVYL344wP0DWs0IQ1O3AFht7xpwP2frfEGUnzH6HoCf2i
	N7TrZtSwMIrq5GPXS8mGlICfwTeR9L/mwrvMpGM00UhW58Ng5tOg14nByNbLkhdbFclOS/F0uKv
	5vbnjAVQ2NT8G13qDUhACpFonp4lyQiUucLGZmZGiJ2y6EsSRBC209Q8TbFk=
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a393:b0:6b7:8396:f3c7 with SMTP id
 006d021491bc7-6c0bbce6f26mr372455eaf.41.1789071146454; Thu, 10 Sep 2026
 13:12:26 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa30f2a.f81106d8.2ab401.0013.GAE@google.com>
Subject: [syzbot] [ceph?] kernel BUG in __open_session
From: syzbot <syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com>
To: amarkuze@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ef0905580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8c5c3949d762a91=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1dbed5969931c19d3=
eb5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13d1fe0158000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10cb14d1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d90=
0f083ada3/non_bootable_disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f77d29903f3/vmlinux-=
50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23b2961d9c5d/bzI=
mage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com

libceph: resolve '127.0.0.=03' (ret=3D-3): failed
------------[ cut here ]------------
kernel BUG at net/ceph/mon_client.c:211!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 5924 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(ful=
l)=20
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2 04/01/2014
RIP: 0010:pick_new_mon net/ceph/mon_client.c:211 [inline]
RIP: 0010:__open_session+0x60f/0x740 net/ceph/mon_client.c:245
Code: f6 44 89 e7 e8 72 1e 27 fa 89 c5 e9 2b fb ff ff e8 96 4b 7e f6 c7 83 =
b4 09 00 00 0a 00 00 00 e9 22 fc ff ff e8 82 4b 7e f6 90 <0f> 0b e8 9a 86 f=
1 f6 e9 7b fa ff ff 4c 89 f7 e8 8d 86 f1 f6 e9 16
RSP: 0018:ffffc900039a7be0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888037864290 RCX: 0000000000000000
RDX: ffff888033b68000 RSI: ffffffff8b8dca8e RDI: ffff888033b68000
RBP: ffff88802a3b4d80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000ffffffff R14: ffff888037864400 R15: ffff888037864298
FS:  00005555720c7500(0000) GS:ffff8880d5d5a000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e267f24d48 CR3: 0000000036162000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ceph_monc_open_session+0x46/0x60 net/ceph/mon_client.c:534
 __ceph_open_session+0x135/0x590 net/ceph/ceph_common.c:798
 ceph_real_mount fs/ceph/super.c:1173 [inline]
 ceph_get_tree+0xd98/0x1fd0 fs/ceph/super.c:1362
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 vfs_cmd_create+0xd7/0x2a0 fs/fsopen.c:231
 vfs_fsconfig_locked fs/fsopen.c:295 [inline]
 __do_sys_fsconfig+0x55a/0xcb0 fs/fsopen.c:463
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb99b9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff76419958 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007feb99e25fa0 RCX: 00007feb99b9e159
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007feb99c3503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feb99e25fac R14: 00007feb99e25fa0 R15: 00007feb99e25fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pick_new_mon net/ceph/mon_client.c:211 [inline]
RIP: 0010:__open_session+0x60f/0x740 net/ceph/mon_client.c:245
Code: f6 44 89 e7 e8 72 1e 27 fa 89 c5 e9 2b fb ff ff e8 96 4b 7e f6 c7 83 =
b4 09 00 00 0a 00 00 00 e9 22 fc ff ff e8 82 4b 7e f6 90 <0f> 0b e8 9a 86 f=
1 f6 e9 7b fa ff ff 4c 89 f7 e8 8d 86 f1 f6 e9 16
RSP: 0018:ffffc900039a7be0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888037864290 RCX: 0000000000000000
RDX: ffff888033b68000 RSI: ffffffff8b8dca8e RDI: ffff888033b68000
RBP: ffff88802a3b4d80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000ffffffff R14: ffff888037864400 R15: ffff888037864298
FS:  00005555720c7500(0000) GS:ffff8880d5d5a000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e267f24d48 CR3: 0000000036162000 CR4: 0000000000352ef0


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
