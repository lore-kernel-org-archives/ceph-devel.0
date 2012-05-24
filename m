From: "Jim Schutt" <jaschut@sandia.gov>
Subject: mkcephfs regression in current master branch
Date: Thu, 24 May 2012 13:39:45 -0600
Message-ID: <4FBE8E81.90005@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:55367 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab2EXTkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 15:40:12 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1B2772684DF
	for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 13:40:11 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 13:40:00 -0600
Received: from mail.sandia.gov (exch04.sandia.gov [134.253.103.4] (may
 be forged)) by mailgate2.sandia.gov (8.14.4/8.14.4) with ESMTP id
 q4OJdjkL029541 for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012
 13:39:45 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

In my testing I make repeated use of the "manual" mkcephfs
sequence described in the man page:

    master# mkdir /tmp/foo
    master# mkcephfs -c /etc/ceph/ceph.conf --prepare-monmap -d /tmp/foo
    osdnode# mkcephfs --init-local-daemons osd -d /tmp/foo
    mdsnode# mkcephfs --init-local-daemons mds -d /tmp/foo
    master# mkcephfs --prepare-mon -d /tmp/foo
    monnode# mkcephfs --init-local-daemons mon -d /tmp/foo

Using current master branch (commit ca79f45a33f9), the
"mkcephfs --init-local-daemons osd" phase breaks like this:

2012-05-24 13:24:06.325905 7fdcd61d4780 -1 filestore(/ram/mnt/ceph/data.osd.0) could not find 23c2fcde/osd_superblock/0 in index: (2) No such file or directory
2012-05-24 13:24:06.326768 7fdcd1ee2700 -1 filestore(/ram/mnt/ceph/data.osd.0) async snap create 'snap_1' transid 0 got (17) File exists
os/FileStore.cc: In function 'void FileStore::sync_entry()' thread 7fdcd1ee2700 time 2012-05-24 13:24:06.326792
os/FileStore.cc: 3564: FAILED assert(0 == "async snap ioctl error")
  ceph version 0.47.1-157-gb003815 (commit:b003815c222add8bdcf645d9ba4ef7e13f34587e)
  1: (FileStore::sync_entry()+0x34f0) [0x68e190]
  2: (FileStore::SyncThread::entry()+0xd) [0x6a2abd]
  3: (Thread::_entry_func(void*)+0x1b9) [0x803499]
  4: (()+0x77f1) [0x7fdcd58637f1]
  5: (clone()+0x6d) [0x7fdcd4cb4ccd]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
2012-05-24 13:24:06.327991 7fdcd1ee2700 -1 os/FileStore.cc: In function 'void FileStore::sync_entry()' thread 7fdcd1ee2700 time 2012-05-24 13:24:06.326792
os/FileStore.cc: 3564: FAILED assert(0 == "async snap ioctl error")

FWIW, with commit 598dea12411 (filestore: mkfs: only
create snap_0 if we created current_op_seq) reverted,
I am able to create a new filesystem using the above
sequence, and a typical "mkcephfs --init-local-daemons osd"
looks like this:

2012-05-24 13:06:25.918663 7fe7ac829780 -1 filestore(/ram/mnt/ceph/data.osd.0) could not find 23c2fcde/osd_superblock/0 in index: (2) No such file or directory
2012-05-24 13:06:26.301738 7fe7ac829780 -1 created object store /ram/mnt/ceph/data.osd.0 journal /dev/mapper/cs32s01p2 for osd.0 fsid f8cc9fa2-a300-45a1-ae6d-e0c0ef418d0f
creating private key for osd.0 keyring /mnt/ceph/misc.osd.0/keyring.osd.0
creating /mnt/ceph/misc.osd.0/keyring.osd.0

Thanks -- Jim

