From: Loic Dachary <loic@dachary.org>
Subject: Re: run-tox-ceph-disk
Date: Thu, 8 Jun 2017 09:38:05 +0200
Message-ID: <e7901bfc-9e21-e226-fa6c-eabfee817ce8@dachary.org>
References: <062dfae7-eb33-9eb3-b2ad-34497bc0c1c2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40794 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdFHHiI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2017 03:38:08 -0400
In-Reply-To: <062dfae7-eb33-9eb3-b2ad-34497bc0c1c2@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi David,

On 06/08/2017 02:27 AM, David Zafman wrote:
> 
> failure on my Ubuntu 14.04 build machine
> 
> 14: command: Running command: /home/dzafman/ceph/build/bin/ceph --cluster ceph --name client.bootstrap-osd --keyring td/test-ceph-disk/bootstrap-osd/ceph.keyring osd create --concise c29864d7-e3ce-4c9b-8ad7-a8066df1313b
> 14: Traceback (most recent call last):
> 14:   File "/src/ceph/src/ceph-disk/.tox/py27/bin/ceph-disk", line 11, in <module>
> 14:     load_entry_point('ceph-disk', 'console_scripts', 'ceph-disk')()
> 14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 5680, in run
> 14:     main(sys.argv[1:])
> 14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 5631, in main
> 14:     args.func(args)
> 14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 3711, in main_activate
> 14:     init=args.mark_init,
> 14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 3531, in activate_dir
> 14:     (osd_id, cluster) = activate(path, activate_key_template, init)
> 14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 3623, in activate
> 14:     keyring=keyring,
> 14:   File "/src/ceph/src/ceph-disk/ceph_disk/main.py", line 1034, in allocate_osd_id
> 14:     raise Error('ceph osd create failed', e, e.output)
> 14: ceph_disk.main.Error: Error: ceph osd create failed: Command '/home/dzafman/ceph/build/bin/ceph' returned non-zero exit status 1: *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 14: Traceback (most recent call last):
> 14:   File "/home/dzafman/ceph/build/bin/ceph", line 132, in <module>
> 14:     from ceph_daemon import admin_socket, DaemonWatcher, Termsize
> 14:   File "/home/dzafman/ceph/src/pybind/ceph_daemon.py", line 21, in <module>
> 14:     from prettytable import PrettyTable, HEADER
> 14: ImportError: No module named prettytable

As of 9e3d7d9fc1888ee6dc4e404b82f13bc709fa4a1c dated late April you need to dnf install -y python-prettytable for the ceph CLI to work.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
