From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: What is occupying memory on MDS?
Date: Mon, 12 Dec 2016 17:38:05 +0800
Message-ID: <CAGkCoN+s1fxDxKNtazM=asszd3hTBHo2=KHuA8+uXwE64JqjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33682 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754125AbcLLJiq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 04:38:46 -0500
Received: by mail-ua0-f171.google.com with SMTP id 20so76325885uak.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 01:38:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cephers,

I have been using ceph for a long time, but haven't really looked into
the memory usage on MDS before. Now I think it is time. :)

I have a small cluster with 22 OSDs, 2 MDSes (1 active and 1
standby-replay) and 1 kernel CEPHFS client. CEPH version is based on
0.94.9.

At the beginning, MDS memory usage is very low. But after listing
(readdir) 2 huge directories (one directory has 1 million files and
the other has 2 million files) on client, MDS memory usage is
increased to 12GB. And the memory usage won't go down even if the
dentries and inodes have been trimmed to 100000.

I also tried to run "ceph mds 0 heap release" or set
"TCMALLOC_RELEASE_RATE=10" in init file to start MDS, none of them
could release memory as expected.

So what is occupying memory on MDS and tcmalloc can't release them? I
don't think about 100000+ lru dentries and inodes could use so much
memory.


Tasks: 609 total,   1 running, 608 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.1 us,  0.3 sy,  0.0 ni, 98.0 id,  1.6 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem:  65670628 total, 65291332 used,   379296 free,   420028 buffers
KiB Swap:  2088956 total,   457868 used,  1631088 free. 23033388 cached Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+
COMMAND
 78662 root      20   0 12.807g 0.012t   7020 S   0.0 20.0   7:29.03
ceph-mds

[ceph@c166 ~]$ sudo ceph --admin-daemon
/var/run/ceph/ceph-mds.c166.asok perf dump | grep inode
        "inode_max": 100000,
        "inodes": 108665,
        "inodes_top": 0,
        "inodes_bottom": 0,
        "inodes_pin_tail": 108665,
        "inodes_pinned": 108665,
        "inodes_expired": 2910068,
        "inodes_with_caps": 90422,
        "inodes_map": 108667, ---> added by myself
        "exported_inodes": 0,
        "imported_inodes": 0


Thanks.

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com
