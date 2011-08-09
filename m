From: Fyodor Ustinov <ufm@ufm.su>
Subject: msgpool osd_op_reply alloc failed
Date: Tue, 09 Aug 2011 12:42:38 +0300
Message-ID: <4E41010E.2000008@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:36122 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500Ab1HIJml (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Aug 2011 05:42:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 1FB92600247
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 12:42:39 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JBqLsw5LPToZ for <ceph-devel@vger.kernel.org>;
	Tue,  9 Aug 2011 12:42:39 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 021FA600245
	for <ceph-devel@vger.kernel.org>; Tue,  9 Aug 2011 12:42:38 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Kernel 3.0.0 from your git.
ceph - 0.32 from your rep.
vm.min_free_kbytes=262144

root@backup-ext:/clients# cat /proc/meminfo
MemTotal:        1022508 kB
MemFree:          397612 kB
Buffers:           35776 kB
Cached:           360608 kB
SwapCached:        68272 kB
Active:           107196 kB
Inactive:         469768 kB
Active(anon):      59920 kB
Inactive(anon):   120892 kB
Active(file):      47276 kB
Inactive(file):   348876 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       1046524 kB
SwapFree:         782812 kB


Many-many messages like that in dmesg.

[147619.416732] libceph: msg_new can't create type 0 front 512
[147619.416889] libceph: msgpool osd_op_reply alloc failed
[147863.512003] libceph: msg_new can't allocate 512 bytes
[147863.512103] libceph: msg_new can't create type 0 front 512
[147863.512196] libceph: msgpool osd_op_reply alloc failed
[147983.765570] libceph: msg_new can't allocate 512 bytes
[147983.765707] libceph: msg_new can't create type 0 front 512
[147983.765802] libceph: msgpool osd_op_reply alloc failed
[148023.232787] libceph: msg_new can't allocate 512 bytes
[148023.232889] libceph: msg_new can't create type 0 front 512
[148023.232983] libceph: msgpool osd_op_reply alloc failed
[148159.418068] libceph: msg_new can't allocate 512 bytes
[148159.418224] libceph: msg_new can't create type 0 front 512
[148159.418330] libceph: msgpool osd_op_reply alloc failed

WBR,
     Fyodor.

