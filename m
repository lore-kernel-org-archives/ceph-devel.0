From: Michal Jarzabek <stiopa@gmail.com>
Subject: make check, src/test/ceph-disk.sh fails on Mint
Date: Sat, 16 May 2015 16:49:08 +0100
Message-ID: <CAEFDAA6rAJeS80+Qrg=orzug++YWmGee31KYu1=pLy2s3HDYiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34999 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbbEPPtJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 May 2015 11:49:09 -0400
Received: by wicmx19 with SMTP id mx19so26829457wic.0
        for <ceph-devel@vger.kernel.org>; Sat, 16 May 2015 08:49:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Is there any simple way to fix this? I'm not really familiar with python...

DEBUG:ceph-disk:ceph osd.0 data dir is ready at
/home/stiopa/development/ceph/ceph/src/test-ceph-disk/dir
DEBUG:ceph-disk:Creating symlink test-ceph-disk/osd/ceph-0 ->
/home/stiopa/development/ceph/ceph/src/test-ceph-disk/dir
ttest_mark_init: 203: ceph-detect-init
Traceback (most recent call last):
  File "/home/stiopa/development/ceph/ceph/src/virtualenv-test-ceph-disk/bin/ceph-detect-init",
line 9, in <module>
    load_entry_point('ceph-detect-init==1.0.1', 'console_scripts',
'ceph-detect-init')()
  File "/home/stiopa/development/ceph/ceph/src/ceph-detect-init/ceph_detect_init/main.py",
line 56, in run
    print(ceph_detect_init.get(args.use_rhceph).init)
  File "/home/stiopa/development/ceph/ceph/src/ceph-detect-init/ceph_detect_init/__init__.py",
line 34, in get
    release=release)
ceph_detect_init.exc.UnsupportedPlatform: Platform is not supported.:
LinuxMint rebecca 17.1
test_mark_init: 203: test -f
/home/stiopa/development/ceph/ceph/src/test-ceph-disk/dir/
test_mark_init: 203: return 1
run: 620: status=1
run: 621: set +x

Thanks,
Michal
