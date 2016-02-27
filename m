From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Get rados to build, and run, with the current Cython version.
Date: Sat, 27 Feb 2016 13:35:33 +0100
Message-ID: <56D19815.8010902@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57111 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756331AbcB0MgH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 27 Feb 2016 07:36:07 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id B9D4B153402
	for <ceph-devel@vger.kernel.org>; Sat, 27 Feb 2016 13:36:02 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 3A21F1534ED
	for <ceph-devel@vger.kernel.org>; Sat, 27 Feb 2016 13:35:34 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


I'm running into a rather blocking issue with testing on FreeBSD due
to the cythonifying of rados. (would have prefered an option to not use
cython... )

One of the first tests after all unittests is:
	ceph-disk/run-tox.sh

It runs at the end:  bash -x tests/ceph-disk.sh

Which tries to execute:
DEBUG:ceph_disk.main:Cluster uuid is cddc1351-dcf1-11e5-8cd4-1c6f6582ec12
INFO:ceph_disk.main:Running command: ../ceph-osd --cluster=ceph
--show-config-value=fsid
DEBUG:ceph_disk.main:Cluster name is ceph
DEBUG:ceph_disk.main:OSD uuid is ceac49dd-dcf1-11e5-8cd4-1c6f6582ec12
DEBUG:ceph_disk.main:Allocating OSD id...
INFO:ceph_disk.main:Running command: ../ceph --cluster ceph --name
client.bootstrap-osd --keyring test-ceph-disk/bootstrap-osd/ceph.
keyring osd create --concise ceac49dd-dcf1-11e5-8cd4-1c6f6582ec12
Traceback (most recent call last):
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/.tox/py27/bin/ceph-disk",
line 9, in <module>
    load_entry_point('ceph-disk', 'console_scripts', 'ceph-disk')()
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
4601, in run
    main(sys.argv[1:])
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
4553, in main
    args.func(args)
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
3061, in main_activate
    init=args.mark_init,
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
2882, in activate_dir
    (osd_id, cluster) = activate(path, activate_key_template, init)
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
2974, in activate
    keyring=keyring,
  File "/usr/srcs/Ceph/work/ceph/src/ceph-disk/ceph_disk/main.py", line
925, in allocate_osd_id
    raise Error('ceph osd create failed', e, e.output)
Error: Error: ceph osd create failed: Command '../ceph' returned
non-zero exit status 1: *** DEVELOPER MODE: setting PATH, PYTHONPAT
H and LD_LIBRARY_PATH ***
Traceback (most recent call last):
  File "../ceph", line 108, in <module>
    import rados
  File "rados.pyx", line 363, in init rados
(/usr/srcs/Ceph/work/ceph/src/build/rados.c:48031)
NameError: name 'errno' is not defined

Now I've changed some code at File "rados.pyx", line 363 because FreeBSD
does not have ENODATA, and in includes/compat.h it is defined to be
ENOATTR with a define. Otherwise it would not even compile.

But the cython translation/compilation does not pick up on this?
ENOATTR is just another define in /usr/include/errno.h so it should find
it. But it does not.

What is the way forward here?

--WjW
