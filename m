From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Why does ceph-osd not daemonize in ceph-disk
Date: Fri, 11 Nov 2016 13:50:14 +0100
Message-ID: <7dbf8d17-ef39-26c5-73f3-d9eb8e7c58c7@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:11553 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756399AbcKKMuU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 07:50:20 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 9571C27281
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 13:50:16 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

As one of the last steps to complete my first run op porting I need to
get ceph-disk working...
But I'm getting a stall in test_activate for the OSD. why doesn't the
activation of the OSD background and the script continues.

--WjW

During testing is starts ceph-osd like:

function test_activate() {
    local to_prepare=$1
    local to_activate=$2
    local osd_uuid=$($uuidgen)

    ${CEPH_DISK} $CEPH_DISK_ARGS \
        prepare --osd-uuid $osd_uuid $to_prepare || return 1

    $timeout $TIMEOUT ${CEPH_DISK} $CEPH_DISK_ARGS \
        activate \
        --mark-init=none \
        $to_activate || return 1

    test_pool_read_write $osd_uuid || return 1
}

Which results in script output:

activate: ceph osd.0 data dir is ready at testdir/test-ceph-disk/dir
command_check_call: Running command_check: ../build/bin/ceph-osd
--cluster=ceph --id=0 --osd-data=testdir/test-ceph-disk/dir
--osd-journal=testdir/test-ceph-disk/dir/journal
starting osd.0 at - osd_data testdir/test-ceph-disk/dir
testdir/test-ceph-disk/dir/journal

And is the processtable this looks like:

/usr/bin/timeout 360
/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin/coverage run
--append --source=ceph_disk --
/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin/ceph-disk --verbose
--prepend-to-path= --statedir=testdir/test-ceph-disk
--sysconfdir=testdir/test-ceph-disk activate --mark-init=none
testdir/test-ceph-disk/dir

and:

 CEPH_BIN=/usr/srcs/Ceph/work/ceph/build/bin
CEPH_ROOT=/usr/srcs/Ceph/work/ceph CEPH_CONF=/dev/null
LD_LIBRARY_PATH=/usr/srcs/Ceph/work/ceph/build/lib
CEPH_BUILD_VIRTUALENV=/tmp
VIRTUAL_ENV=/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27
PATH=/tmp/ceph-disk-virtualenv/bin:/tmp/ceph-detect-init-virtualenv/bin:.:../build/bin:/usr/srcs/Ceph/work/ceph/build/bin:.:/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin:/tmp/ceph-disk-virtualenv/bin:/home/wjw/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:.:/usr/srcs/Ceph/work/ceph/build/bin:/usr/srcs/Ceph/work/ceph/src
PYTHONHASHSEED=648437795 CEPH_LIB=/usr/srcs/Ceph/work/ceph/build/lib
CEPH_DISK=/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin/coverage
run --append --source=ceph_disk --
/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin/ceph-disk
PWD=/usr/srcs/Ceph/work/ceph/build CEPH_ARGS=
--fsid=19836d4d-ad32-429e-bf30-588f9d8d18d1 --auth-supported=none
--mon-host=127.0.0.1:7451 --chdir= --journal-dio=false
--erasure-code-dir=/usr/srcs/Ceph/work/ceph/build/lib
--plugin-dir=/usr/srcs/Ceph/work/ceph/build/lib
--log-file=testdir/test-ceph-disk/$name.log
--pid-file=testdir/test-ceph-disk/$name.pidfile
--osd-class-dir=/usr/srcs/Ceph/work/ceph/build/lib
--run-dir=testdir/test-ceph-disk --osd-failsafe-full-ratio=.99
--osd-journal-size=100 --debug-osd=20 --debug-bdev=20
--debug-bluestore=20 --osd-max-object-name-len=460
--osd-max-object-namespace-len=64  SHLVL=1 CEPH_MON=127.0.0.1:7451
_=/usr/bin/timeout ../build/bin/ceph-osd --cluster=ceph --id=0
--osd-data=testdir/test-ceph-disk/dir
--osd-journal=testdir/test-ceph-disk/dir/journal

And is the osd.0.log I see:
2016-11-11 13:41:36.562422 b678000  2 osd.0 0 boot
2016-11-11 13:41:36.614480 b678000  0 osd.0 0 done with init, starting
boot process
2016-11-11 13:41:36.614532 b678000  1 osd.0 0 We are healthy, booting
2016-11-11 13:41:36.614535 b678000 10 osd.0 0 start_boot - have maps 0..0
2016-11-11 13:41:36.616877 ba89b00 10 osd.0 0 _preboot _preboot mon has
osdmaps 1..5
2016-11-11 13:41:36.618842 b7d6d80 10 osd.0 5 _preboot _preboot mon has
osdmaps 1..5
2016-11-11 13:41:36.618846 b7d6d80 10 osd.0 5 _send_boot
2016-11-11 13:41:36.724501 b7d6d80 10 osd.0 6 boot_epoch is 6
2016-11-11 13:41:36.724505 b7d6d80  1 osd.0 6 state: booting -> active

So the OSD should actually finish and go into background.
But the command stalls, and aborts after the shell timeout.
