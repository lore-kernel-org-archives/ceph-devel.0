From: mowang da <whooya.xxl@gmail.com>
Subject: ping_pong test of ceph
Date: Wed, 28 Sep 2011 15:33:53 +0800
Message-ID: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35251 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1I1Hdz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 03:33:55 -0400
Received: by bkbzt4 with SMTP id zt4so7727474bkb.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 00:33:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all:

l used ping_pong tool to test ceph, as shown below :
1.If it supports coherent byte range locks between cluster nodes
2.How fast it handles lock contention
3.If it supports coherent read/write IO between nodes
4.How fast it handles contended IO between nodes
5.If it supports coherent mmap between nodes
6.How fast the mmap coherence works

the ping_pong code is here:
http://junkcode.samba.org/ftp/unpacked/junkcode/ping_pong.c

l start by running ping_pong on just one of the kernel client mount
point like this:

ping_pong /mnt/test.dat 3

it lock very fast :

T02-OSD161:/usr/src/ping_pong# ./ping_pong /mnt/test.dat 3
=A0 =A01664 locks/sec

but when l start a second copy of ping_pong on another kernel client
node in my cluster, there have been some errors:

T02-OSD186:/usr/src/getosd# ./ping_pong /mnt/test.dat 3
lock at 0 failed! - Interrupted system call
lock at 0 failed! - Interrupted system call
lock at 0 failed! - Interrupted system call
lock at 2 failed! - Interrupted system call
lock at 1 failed! - Interrupted system call
lock at 2 failed! - Interrupted system call

ls this a bug of ceph ,or l do something wrong?

thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
