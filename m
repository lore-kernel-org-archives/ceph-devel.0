From: Fyodor Ustinov <ufm@ufm.su>
Subject: ceph fs
Date: Thu, 12 May 2011 21:29:20 +0300
Message-ID: <201105122129.20828.ufm@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:38334 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195Ab1ELS3Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 May 2011 14:29:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 6F6796005A9
	for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 21:29:22 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3TJysYjkgUm for <ceph-devel@vger.kernel.org>;
	Thu, 12 May 2011 21:29:22 +0300 (EEST)
Received: from amd.localnet (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 992056005A6
	for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 21:29:21 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Like previous, but ceph fs instead of rbd.
(i.e. iozone with 4G file).


[  783.295035] ceph: loaded (mds proto 32)
[  783.300122] libceph: client4125 fsid ff352dfd-078c-e65f-a769-d25abb384d92
[  783.300642] libceph: mon0 77.120.112.193:6789 session established
[  941.278185] libceph: msg_new can't create type 0 front 4096
[  941.278456] libceph: msgpool osd_op alloc failed
[  941.278539] libceph: msg_new can't create type 0 front 512
[  941.278606] libceph: msgpool osd_op_reply alloc failed
[  941.278670] libceph: msg_new can't create type 0 front 4096
[  941.278737] libceph: msgpool osd_op alloc failed
[  941.278808] libceph: msg_new can't create type 0 front 512
[  941.278875] libceph: msgpool osd_op_reply alloc failed
[  941.279011] libceph: msg_new can't create type 0 front 4096
[  941.279079] libceph: msgpool osd_op alloc failed
[  941.279153] libceph: msg_new can't create type 0 front 512
[  941.279220] libceph: msgpool osd_op_reply alloc failed
[  941.279286] libceph: msg_new can't create type 0 front 4096
[  941.279352] libceph: msgpool osd_op alloc failed
[  941.279422] libceph: msg_new can't create type 0 front 512
[  941.279623] libceph: msgpool osd_op_reply alloc failed
[  941.279692] libceph: msg_new can't create type 0 front 4096
[  941.279897] libceph: msgpool osd_op alloc failed
[  941.280042] libceph: msg_new can't create type 0 front 512
[  941.280300] libceph: msgpool osd_op_reply alloc failed
[  941.280418] libceph: msg_new can't create type 0 front 4096
[  941.280534] libceph: msgpool osd_op alloc failed
[  941.280793] libceph: msg_new can't create type 0 front 512
[  941.280958] libceph: msgpool osd_op_reply alloc failed
[  941.281074] libceph: msg_new can't create type 0 front 4096
[  941.281236] libceph: msgpool osd_op alloc failed

WBR,
    Fyodor.
