From: David Zafman <dzafman@redhat.com>
Subject: run-tox-ceph-disk
Date: Wed, 7 Jun 2017 17:27:36 -0700
Message-ID: <062dfae7-eb33-9eb3-b2ad-34497bc0c1c2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751382AbdFHA1h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Jun 2017 20:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06FF63E9
        for <ceph-devel@vger.kernel.org>; Thu,  8 Jun 2017 00:27:37 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <ldachary@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


failure on my Ubuntu 14.04 build machine

14: command: Running command: /home/dzafman/ceph/build/bin/ceph 
--cluster ceph --name client.bootstrap-osd --keyring 
td/test-ceph-disk/bootstrap-osd/ceph.keyring osd create --concise 
c29864d7-e3ce-4c9b-8ad7-a8066df1313b
14: Traceback (most recent call last):
14:   File "/src/ceph/src/ceph-disk/.tox/py27/bin/ceph-disk", line 11, 
in <module>
14:     load_entry_point('ceph-disk', 'console_scripts', 'ceph-disk')()
14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 5680, in run
14:     main(sys.argv[1:])
14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 5631, in main
14:     args.func(args)
14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 3711, in 
main_activate
14:     init=args.mark_init,
14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 3531, in 
activate_dir
14:     (osd_id, cluster) = activate(path, activate_key_template, init)
14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 3623, in 
activate
14:     keyring=keyring,
14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 1034, in 
allocate_osd_id
14:     raise Error('ceph osd create failed', e, e.output)
14: ceph_disk.main.Error: Error: ceph osd create failed: Command 
'/home/dzafman/ceph/build/bin/ceph' returned non-zero exit status 1: *** 
DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
14: Traceback (most recent call last):
14:   File "/home/dzafman/ceph/build/bin/ceph", line 132, in <module>
14:     from ceph_daemon import admin_socket, DaemonWatcher, Termsize
14:   File "/home/dzafman/ceph/src/pybind/ceph_daemon.py", line 21, in 
<module>
14:     from prettytable import PrettyTable, HEADER
14: ImportError: No module named prettytable

