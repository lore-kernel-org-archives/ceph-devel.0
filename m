From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: vstart problem in master branch
Date: Thu, 31 Mar 2011 11:04:36 -0700
Message-ID: <054B710EFF18497CB0B964DC9819B556@gmail.com>
References: <B6DAFB0C-A321-499A-A21E-7CA59EFCDA5B@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37743 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836Ab1CaSEl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 14:04:41 -0400
Received: by iwn34 with SMTP id 34so2638937iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2011 11:04:40 -0700 (PDT)
In-Reply-To: <B6DAFB0C-A321-499A-A21E-7CA59EFCDA5B@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

I think that's the user_xattr error (if you don't have user xattrs enabled on the mount).

If not there were some issues on master yesterday or two days ago that I think are fixed now; somebody else should know more about what those were.
-Greg
On Thursday, March 31, 2011 at 10:59 AM, Noah Watkins wrote: 
> Just updated master branch, and I'm getting the following errors when starting:
> 
> #> mkdir -p dev/osd0
> #> mkdir log out
> #> ./vstart --localhost -d -n
> 
> ... (full log below) ...
> 
> ./cosd -i 0 -c ceph.conf --mkfs
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:32.349925 7fdeb7d5d720 OSD::mkfs: couldn't mount FileStore: error -95
> 2011-03-31 10:55:32.349943 7fdeb7d5d720 ** ERROR: error creating empty object store in dev/osd0: error 95: Operation not supported
> start osd0
> ./cosd -i 0 -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:32.365058 7f48ac9b0720 ** ERROR: unable to open OSD superblock on dev/osd0: error 2: No such file or directory
> 
> Thanks,
> Noah Watkins
> 
> 
> ##############################################################################
> nwatkins@kyoto:~/Projects/ceph/src$ ./vstart.sh --localhost -d -n
> ** going verbose **
> === mon.a === 
> Stopping Ceph mon.a on kyoto...done
> === mon.b === 
> Stopping Ceph mon.b on kyoto...done
> === mon.c === 
> Stopping Ceph mon.c on kyoto...done
> === mds.a === 
> Stopping Ceph mds.a on kyoto...done
> === mds.b === 
> Stopping Ceph mds.b on kyoto...done
> === mds.c === 
> Stopping Ceph mds.c on kyoto...done
> === osd.0 === 
> Stopping Ceph osd.0 on kyoto...done
> ip 127.0.0.1
> ./osdmaptool: osdmap file '/tmp/ceph_osdmap.1490'
> ./osdmaptool: writing epoch 1 to /tmp/ceph_osdmap.1490
> 
> WARNING: hostname resolves to loopback; remote hosts will not be able to
>  connect. either adjust /etc/hosts, or edit this script to use your
>  machine's real IP.
> 
> ./monmaptool --create --clobber --add a 127.0.0.1:6789 --add b 127.0.0.1:6790 --add c 127.0.0.1:6791 --print /tmp/ceph_monmap.1490
> ./monmaptool: monmap file /tmp/ceph_monmap.1490
> ./monmaptool: generated fsid 83ec8eb8-3b51-3ab4-972d-d541dc853b09
> epoch 1
> fsid 83ec8eb8-3b51-3ab4-972d-d541dc853b09
> last_changed 2011-03-31 10:55:26.336245
> created 2011-03-31 10:55:26.336245
> 0: 127.0.0.1:6789/0 mon.a
> 1: 127.0.0.1:6790/0 mon.b
> 2: 127.0.0.1:6791/0 mon.c
> ./monmaptool: writing epoch 1 to /tmp/ceph_monmap.1490 (3 monitors)
> ./cmon --mkfs -c ceph.conf -i a --monmap=/tmp/ceph_monmap.1490 --osdmap=/tmp/ceph_osdmap.1490
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:26.942732 7fd4e3c5c720 auth: error reading file: .ceph_keyring
> ./cmon: created monfs at "dev/mon.a" for mon.a
> ./cmon --mkfs -c ceph.conf -i b --monmap=/tmp/ceph_monmap.1490 --osdmap=/tmp/ceph_osdmap.1490
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:27.740559 7f812724c720 auth: error reading file: .ceph_keyring
> ./cmon: created monfs at "dev/mon.b" for mon.b
> ./cmon --mkfs -c ceph.conf -i c --monmap=/tmp/ceph_monmap.1490 --osdmap=/tmp/ceph_osdmap.1490
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:28.482552 7ff1aba35720 auth: error reading file: .ceph_keyring
> ./cmon: created monfs at "dev/mon.c" for mon.c
> ./cmon -i a -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> starting mon.a rank 0 at 127.0.0.1:6789/0 mon_data "dev/mon.a" fsid 83ec8eb8-3b51-3ab4-972d-d541dc853b09
> ./cmon -i b -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> starting mon.b rank 1 at 127.0.0.1:6790/0 mon_data "dev/mon.b" fsid 83ec8eb8-3b51-3ab4-972d-d541dc853b09
> ./cmon -i c -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> starting mon.c rank 2 at 127.0.0.1:6791/0 mon_data "dev/mon.c" fsid 83ec8eb8-3b51-3ab4-972d-d541dc853b09
> Loading class: .libs/libcls_rbd.so.1.0.0: rbd 1.3 x86-64
> 2011-03-31 10:55:29.694509 7f3052ac1720 read 187586 bytes from .libs/libcls_rbd.so.1.0.0
> 2011-03-31 10:55:31.504132 mon <- [class,add,rbd,1.3,x86-64,changed]
> 2011-03-31 10:55:32.009383 mon0 -> 'updated' (0)
> mkfs osd0
> ./cosd -i 0 -c ceph.conf --mkfs
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:32.349925 7fdeb7d5d720 OSD::mkfs: couldn't mount FileStore: error -95
> 2011-03-31 10:55:32.349943 7fdeb7d5d720 ** ERROR: error creating empty object store in dev/osd0: error 95: Operation not supported
> start osd0
> ./cosd -i 0 -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> 2011-03-31 10:55:32.365058 7f48ac9b0720 ** ERROR: unable to open OSD superblock on dev/osd0: error 2: No such file or directory
> creating dev/mds.a.keyring
> 2011-03-31 10:55:32.378374 7f0c0000e720 read 149 bytes from dev/mds.a.keyring
> 2011-03-31 10:55:32.663506 mon <- [auth,add,mds.a]
> 2011-03-31 10:55:32.984165 mon2 -> 'added key for mds.a' (0)
> ./cmds -i a -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> starting mds.a at 0.0.0.0:6800/1924
> creating dev/mds.b.keyring
> 2011-03-31 10:55:33.022148 7f515e177720 read 149 bytes from dev/mds.b.keyring
> 2011-03-31 10:55:33.024974 mon <- [auth,add,mds.b]
> 2011-03-31 10:55:33.359127 mon1 -> 'added key for mds.b' (0)
> ./cmds -i b -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> starting mds.b at 0.0.0.0:6801/1947
> creating dev/mds.c.keyring
> 2011-03-31 10:55:33.389347 7fe0bade3720 read 149 bytes from dev/mds.c.keyring
> 2011-03-31 10:55:33.390946 mon <- [auth,add,mds.c]
> 2011-03-31 10:55:33.733775 mon2 -> 'added key for mds.c' (0)
> ./cmds -i c -c ceph.conf
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  ** testing and review. Do not trust it with important data. **
> starting mds.c at 0.0.0.0:6802/1970
> ./ceph -c ceph.conf mds set_max_mds 3
> 2011-03-31 10:55:33.755911 mon <- [mds,set_max_mds,3]
> 2011-03-31 10:55:34.126169 mon1 -> 'max_mds = 3' (0)
> started. stop.sh to stop. see out/* (e.g. 'tail -f out/????') for debug output.--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

