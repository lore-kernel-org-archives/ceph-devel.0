From: Patrick Donnelly <pdonnell@redhat.com>
Subject: CMake build errors in modules
Date: Wed, 10 Aug 2016 16:15:47 -0400
Message-ID: <CA+2bHPYVhQPi=vP99HR610CY1nwkfJpAnQZBMN491zMtBj48cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33066 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbcHJUQS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 16:16:18 -0400
Received: by mail-qk0-f175.google.com with SMTP id t7so55240176qkh.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 13:16:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I sometimes get build errors for modules (not always the same module)
about missing headers:

$ (cd build && make)
[...]
[ 25%] rocksdb building
  GEN      util/build_version.cc
make[3]: *** No rule to make target `db/writebuffer.h', needed by
`db/column_family.o'.  Stop.
make[2]: *** [src/CMakeFiles/build_rocksdb] Error 2
make[1]: *** [src/CMakeFiles/build_rocksdb.dir/all] Error 2
make: *** [all] Error 2

What's the right way to fix this? I already tried `git submodule
update` and my working copy was sterile (`git clean -xfd`) before the
build.

-- 
Patrick Donnelly
