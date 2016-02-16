From: "Willem Jan Withagen (EcoRacks)" <wjw@ecoracks.nl>
Subject: Problems whilst running ceph-disk/run-tox.sh
Date: Tue, 16 Feb 2016 15:41:01 +0100
Message-ID: <56C334FD.1010601@ecoracks.nl>
Reply-To: wjw@ecoracks.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:37598 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbcBPOt6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Feb 2016 09:49:58 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 626DE153402
	for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 15:41:32 +0100 (CET)
Received: from smtp.digiware.nl ([127.0.0.1])
	by rack1.digiware.nl (rack1.digiware.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 69kpeAM1ERqx for <ceph-devel@vger.kernel.org>;
	Tue, 16 Feb 2016 15:41:02 +0100 (CET)
Received: from [192.168.101.175] (vpn.ecoracks.nl [31.223.170.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 66CCA1534E8
	for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 15:41:02 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Apart from the trouble this testscript is giving on general....

I'd like to shre two observations:
In  TestCephDisk.test_list_dmcrypt_data
========
        for seq in xrange(TMP_MAX):
            name = names.next()
            file = _os.path.join(dir, prefix + name + suffix)
            try:
>               _os.mkdir(file, 0700)
E               OSError: [Errno 13] Permission denied:
'/var/lib/ceph/tmp/mnt.j5qCU5'
=========
Which was due to the previous run (as root) , so directories were owned
by root.

And once I fixed that one, by chown-ing stuff:
=========
E               assert [{'partitions...: '/dev/Xda'}] ==
[{'partitions'...: '/dev/Xda'}]
E                 At index 0 diff: {'partitions': [{'mount': None,
'type': 'data', 'is_partition': True, 'state': 'unprepared', 'fs_type':
None, 'uuid': '56244cf5-83ef-4984-888a-2d8b8e0e04b2', 'dmcrypt':
{'holders': ['dm-0'], 'type': 'plain'}, 'ptype':
'4fbd7e29-9d25-41b8-afd0-5ec00ceff05d', 'path': '/dev/Xda1'}], 'path':
'/dev/Xda'} != {'partitions': [{'type': 'data', 'state': 'active',
'dmcrypt': {'holders': ['dm-0'], 'type': 'plain'}, 'mount': '/', 'uuid':
'56244cf5-83ef-4984-888a-2d8b8e0e04b2', 'is_partition': True, 'fs_type':
'xfs', 'ceph_fsid': None, 'whoami': None, 'ptype':
'4fbd7e29-9d25-41b8-afd0-5ec00ceff05d', 'path': '/dev/Xda1'}], 'path':
'/dev/Xda'}
E                 Full diff:
E                 - [{'partitions': [{'dmcrypt': {'holders': ['dm-0'],
'type': 'plain'},
E                 + [{'partitions': [{'ceph_fsid': None,
E                 +                   'dmcrypt': {'holders': ['dm-0'],
'type': 'plain'},
E                 -                   'fs_type': None,
E                 ?                              ^^^^
E                 +                   'fs_type': 'xfs',
E                 ?                              ^^^^^
E                 'is_partition': True,
E                 -                   'mount': None,
E                 ?                            ^^^^
E                 +                   'mount': '/',
E                 ?                            ^^^
E                 'path': '/dev/Xda1',
E                 'ptype': '4fbd7e29-9d25-41b8-afd0-5ec00ceff05d',
E                 -                   'state': 'unprepared',
E                 ?                             ^^^^ -----
E                 +                   'state': 'active',
E                 ?                             ^^^^^
E                 'type': 'data',
E                 -                   'uuid':
'56244cf5-83ef-4984-888a-2d8b8e0e04b2'}],
E                
?                                                                 --
E                 +                   'uuid':
'56244cf5-83ef-4984-888a-2d8b8e0e04b2',
E                 +                   'whoami': None}],
E                 'path': '/dev/Xda'}]

tests/test_main.py:347: AssertionError
----------------------------- Captured stderr call
-----------------------------
DEBUG:ceph_disk.main:main_list: /dev/Xda1 ptype =
4fbd7e29-9d25-41b8-afd0-5ec00ceff05d uuid =
56244cf5-83ef-4984-888a-2d8b8e0e04b2
INFO:ceph_disk.main:Running command: /usr/sbin/blkid -s TYPE /dev/dm-0
DEBUG:ceph_disk.main:Mounting /dev/dm-0 on /var/lib/ceph/tmp/mnt.jzy74c
with options
INFO:ceph_disk.main:Running command: /usr/bin/mount -t xfs -o  --
/dev/dm-0 /var/lib/ceph/tmp/mnt.jzy74c
mount: only root can use "--options" option
DEBUG:ceph_disk.main:main_list: {'Xda': ['Xda1']}, uuid_map =
{'56244cf5-83ef-4984-888a-2d8b8e0e04b2': '/dev/Xda1'}, space_map = {}
INFO:ceph_disk.main:list_dev(dev = /dev/Xda1, ptype =
4fbd7e29-9d25-41b8-afd0-5ec00ceff05d)
INFO:ceph_disk.main:Running command: /usr/sbin/blkid -s TYPE /dev/dm-0
=========

Thusfar I've grown used to the fact that script can be run as non-root.
Not sure if that was just coincidence, or by design.

And if by design, it would be nice to separate root and non-root scripts...

--WjW


