From: Hosfore <computer_masi@126.com>
Subject: low performance of ceph, why ?
Date: Thu, 26 Jul 2012 14:53:26 +0000 (UTC)
Message-ID: <loom.20120726T151236-360@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33442 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab2GZPBO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Jul 2012 11:01:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SuPXt-0006mc-Hg
	for ceph-devel@vger.kernel.org; Thu, 26 Jul 2012 17:01:09 +0200
Received: from 166.111.68.172 ([166.111.68.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 17:00:09 +0200
Received: from computer_masi by 166.111.68.172 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 17:00:09 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now I configure a small cluster of ceph, with mon and mds on the same machine, 
two osds on another two machine, and I have configure the data and journal dir 
on two disks separately. But the test result of mdtest is so poor as below:
------------------------------------------------------------------------------
fs90:/mnt/ceph # mdtest -d /mnt/ceph/tt3 -n 200 -i 2 -w 0
-- started at 07/26/2012 22:37:08 --

mdtest-1.8.3 was launched with 1 total task(s) on 1 nodes
Command line used: mdtest -d /mnt/ceph/tt3 -n 200 -i 2 -w 0
Path: /mnt/ceph
FS: 1.8 TiB   Used FS: 5.8%   Inodes: 0.0 Mi   Used Inodes: 100.0%

1 tasks, 200 files/directories

SUMMARY: (of 2 iterations)
   Operation                  Max        Min       Mean    Std Dev
   ---------                  ---        ---       ----    -------
   Directory creation:   2218.451   1138.848   1678.650    539.802
   Directory stat    : 870187.552 840541.884 855364.718  14822.834
   Directory removal :   2830.938   2828.647   2829.793      1.146
   File creation     :   1987.224   1972.523   1979.873      7.350
   File stat         : 854237.067 850771.602 852504.335   1732.732
   File removal      :   2651.082   2164.132   2407.607    243.475
   Tree creation     :   1680.410   1559.801   1620.105     60.305
   Tree removal      :      1.011      0.578      0.794      0.216

-- finished at 07/26/2012 22:37:11 --
-----------------------------------------------------------------------------

The file system of osd disk is ext4. So is the config of mds or osd leads to 
this poor result ? I have try this test on the local ext3 file system and the 
dir creation speed is usually more than 10000 times per second. My ceph.conf 
is as below:
-------------------------------------------------------------------------------
[global]

[mon]
        mon data = /data/mon$id

        ; some minimal logging (just message traffic) to aid debugging
        debug ms = 1

[mon.0]
        host = fs98
        mon addr = 10.0.2.98:6789

[mds]
        ; where the mds keeps it's secret encryption keys
        keyring = /data/keyring.$name
       ; where the mds keeps it's secret encryption keys
        keyring = /data/keyring.$name
        mds cache size = 3000000

[mds.alpha]
        host = fs98

[osd]
        ; This is where the btrfs volume will be mounted.
        osd data = /data
        filestore xattr use omap = true

        osd journal = /ceph/journal
        osd journal size = 512

[osd.0]
        host = fs97
[osd.1]
        host= fs91

-------------------------------------------------------------------------------

