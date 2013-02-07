From: sheng qiu <herbert1984106@gmail.com>
Subject: ceph mkfs failed
Date: Thu, 7 Feb 2013 11:59:28 -0600
Message-ID: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:61077 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759261Ab3BGR73 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 12:59:29 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so3188563iak.24
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 09:59:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i am trying to port a local file system other than ext3,ext4,btrfs to
manage the OSD. There are some reasons for us to do it.
the mkcephfs stopped at this point:

2013-02-07 11:39:32.009889 7effe43d17a0 -1 filestore(/mnt/osd.0) mkfs
failed to create leveldb: IO error:
/mnt/osd.0/current/omap/MANIFEST-000001: Invalid argument
2013-02-07 11:39:32.009907 7effe43d17a0 -1 OSD::mkfs: FileStore::mkfs
failed with error -1
2013-02-07 11:39:32.009949 7effe43d17a0 -1  ** ERROR: error creating
empty object store in /mnt/osd.0: (1) Operation not permitted
failed: 'ssh root@mon-mds /usr/local/sbin/mkcephfs -d
/tmp/mkfs.ceph.2686 --init-daemon osd.0'

look into the code, it failed at os/FileStore.cc -->  leveldb::Status
status = leveldb::DB::Open(options, omap_dir, &db);

Does anyone have any suggestions?

Thanks,
Sheng

-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
