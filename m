From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: vstart -d -n not working in 0.25.1
Date: Thu, 17 Mar 2011 16:01:13 -0700
Message-ID: <24DF3893-B686-4B01-AA71-BB249BBF5625@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:52082 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab1CQXBR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 19:01:17 -0400
Received: from [192.168.51.138] (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id D307A1009C5C
	for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 16:01:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am having difficulties getting the standalone "test setup" working with 0.25.1, which was working with 0.24. Here is the following output from "./vstart -d -n".

The logs don't seem to have anything interesting, and no cmon,cmds, or cosd is running after this startup script runs.

Thanks,
Noah

nwatkins@kyoto:~/Projects/ceph/src$ ./vstart.sh -d -n
** going verbose **
=== mon.a === 
Stopping Ceph mon.a on kyoto...done
=== mon.b === 
Stopping Ceph mon.b on kyoto...done
=== mon.c === 
Stopping Ceph mon.c on kyoto...done
=== mds.a === 
Stopping Ceph mds.a on kyoto...done
=== mds.b === 
Stopping Ceph mds.b on kyoto...done
=== mds.c === 
Stopping Ceph mds.c on kyoto...done
=== osd.0 === 
Stopping Ceph osd0 on kyoto...done
hostname kyoto
ip ::1 127.0.1.1 128.114.52.36
./osdmaptool: osdmap file '/tmp/ceph_osdmap.13428'
./osdmaptool: writing epoch 1 to /tmp/ceph_osdmap.13428
./monmaptool --create --clobber --add a ::1 127.0.1.1 128.114.52.36:6789 --add b ::1 127.0.1.1 128.114.52.36:6790 --add c ::1 127.0.1.1 128.114.52.36:6791 --print /tmp/ceph_monmap.13428
./monmaptool: invalid ip:port '::1'
./cmon --mkfs -c ceph.conf -i a --monmap=/tmp/ceph_monmap.13428 --osdmap=/tmp/ceph_osdmap.13428
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
2011-03-17 15:58:24.828602 7f24aa4f6720 can't open /tmp/ceph_monmap.13428: error 2: No such file or directory
./cmon --mkfs -c ceph.conf -i b --monmap=/tmp/ceph_monmap.13428 --osdmap=/tmp/ceph_osdmap.13428
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
2011-03-17 15:58:24.837414 7fd5396dc720 can't open /tmp/ceph_monmap.13428: error 2: No such file or directory
./cmon --mkfs -c ceph.conf -i c --monmap=/tmp/ceph_monmap.13428 --osdmap=/tmp/ceph_osdmap.13428
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
2011-03-17 15:58:24.843145 7fc9858a5720 can't open /tmp/ceph_monmap.13428: error 2: No such file or directory
rm: cannot remove `/tmp/ceph_monmap.13428': No such file or directory
./cmon -i a -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
problem opening monitor store in dev/mon.a: No such file or directory
./cmon -i b -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
problem opening monitor store in dev/mon.b: No such file or directory
./cmon -i c -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
problem opening monitor store in dev/mon.c: No such file or directory
Loading class: .libs/libcls_rbd.so.1.0.0: rbd 1.3 x86-64
2011-03-17 15:58:25.899218 7f3e5b64d720 read 201250 bytes from .libs/libcls_rbd.so.1.0.0
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
2011-03-17 15:58:25.899496 7f3e5b64d720 ceph_tool_common_init failed.
mkfs osd0
./cosd -i 0 -c ceph.conf --mkfs
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
start osd0
./cosd -i 0 -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
creating dev/mds.a.keyring
2011-03-17 15:58:25.939144 7f0b91296720 read 149 bytes from dev/mds.a.keyring
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
2011-03-17 15:58:25.939304 7f0b91296720 ceph_tool_common_init failed.
./cmds -i a -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
creating dev/mds.b.keyring
2011-03-17 15:58:25.960736 7fcecc22a720 read 149 bytes from dev/mds.b.keyring
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
2011-03-17 15:58:25.960898 7fcecc22a720 ceph_tool_common_init failed.
./cmds -i b -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
creating dev/mds.c.keyring
2011-03-17 15:58:25.982370 7ffbe4871720 read 149 bytes from dev/mds.c.keyring
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
2011-03-17 15:58:25.982534 7ffbe4871720 ceph_tool_common_init failed.
./cmds -i c -c ceph.conf
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
./ceph -c ceph.conf mds set_max_mds 3
unable to ceph.conf mon addr for mon.a (::1)
unable to ceph.conf mon addr for mon.b (::1)
unable to ceph.conf mon addr for mon.c (::1)
unable to find any monitors in conf
2011-03-17 15:58:25.997401 7f3031f33720 ceph_tool_common_init failed.
started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for debug output.

