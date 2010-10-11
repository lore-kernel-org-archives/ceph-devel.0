From: Sage Weil <sage@newdream.net>
Subject: Re: cosd locks up with 100% CPU during mkcephfs
Date: Sun, 10 Oct 2010 20:53:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010102049330.25037@cobra.newdream.net>
References: <006601cb677a$e640d270$b2c27750$@net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44526 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab0JKDua (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Oct 2010 23:50:30 -0400
In-Reply-To: <006601cb677a$e640d270$b2c27750$@net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin <martin@air-maxx.net>
Cc: ceph-devel@vger.kernel.org

Hi Martin,

Can you attach to cosd with gdb and get a backtrace?  Something like

# gdb /usr/bin/cosd `pgrep cosd`
[...]
(gdb) bt

Thanks!
sage


On Sat, 9 Oct 2010, martin wrote:

> Dear Mailinglist Members,
> 
> I have the problem that mkcephfs does not run through. It stops when cosd
> locks up with 100%CPU on the first node - named CEPH1.
> Out of the script:
> fs created label (null) on /dev/sdb1
>         nodesize 4096 leafsize 4096 sectorsize 4096 size 19.99GB Btrfs Btrfs
> v0.19 Scanning for Btrfs filesystems
> monmap.4203                                   100%  477     0.5KB/s   00:00
> --- ssh ceph1  "cd /home/ceph/ceph/ceph-0.21.3/src ; ulimit -c unlimited ;
> /usr/local/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.4203 -i 0
> --mkfs --osd-data /data/osd0"
>  ** WARNING: Ceph is still under heavy development, and is only suitable for
> **
>  **          testing and review.  Do not trust it with important data.
> **
> -> then the script never returns
> Top
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  4691 root      20   0 15164 2228 1864 R 94.8  0.9  25:54.65 cosd
> root@CEPH1:/var/log/ceph# kill 4691
> bash: line 1:  4691 Terminated              /usr/local/bin/cosd -c
> /etc/ceph/ceph.conf --monmap /tmp/monmap.4203 -i 0 --mkfs --osd-data
> /data/osd0
> failed: 'ssh ceph1 /usr/local/bin/cosd -c /etc/ceph/ceph.conf --monmap
> /tmp/monmap.4203 -i 0 --mkfs --osd-data /data/osd0'
> 
> -> I have waited 1hour .. and no success.
> 
> A tail on osd.0.log
> 
> 10.10.09_01:27:52.636060 b77856d0 journal header: block_size 4096 alignment
> 4096 max_size 0
> 10.10.09_01:27:52.636074 b77856d0 journal header: start 4096
> 10.10.09_01:27:52.636086 b77856d0 journal  write_pos 0
> 10.10.09_01:27:52.646211 b77856d0 journal create done
> 10.10.09_01:27:52.646282 b77856d0 filestore(/data/osd0) mkjournal created
> journal on /data/osd0/journal
> 10.10.09_01:27:52.646451 b77856d0 filestore(/data/osd0) mkfs done in
> /data/osd0
> 10.10.09_01:27:52.646467 b77856d0 filestore(/data/osd0) basedir /data/osd0
> journal /data/osd0/journal
> 10.10.09_01:27:52.646738 b77856d0 filestore(/data/osd0) mount detected btrfs
> 10.10.09_01:27:52.646766 b77856d0 filestore(/data/osd0) _do_clone_range 0~1
> 10.10.09_01:27:52.646784 b77856d0 filestore(/data/osd0) mount btrfs
> CLONE_RANGE ioctl is supported
> 10.10.09_01:27:52.656929 b77856d0 filestore(/data/osd0) mount btrfs
> SNAP_CREATE is supported
> 10.10.09_01:27:52.663403 b77856d0 filestore(/data/osd0) mount btrfs
> SNAP_DESTROY is supported
> 10.10.09_01:27:52.663539 b77856d0 filestore(/data/osd0) mount fsid is
> 206080828
> 10.10.09_01:27:52.663655 b77856d0 filestore(/data/osd0) mount found snaps <>
> 10.10.09_01:27:52.663938 b77856d0 filestore(/data/osd0) mount op_seq is 0
> 10.10.09_01:27:52.663956 b77856d0 filestore(/data/osd0) open_journal at
> /data/osd0/journal
> 10.10.09_01:27:52.663985 b77856d0 journal journal_replay fs op_seq 0
> 10.10.09_01:27:52.664008 b77856d0 journal open /data/osd0/journal next_seq 1
> 10.10.09_01:27:52.664038 b77856d0 journal _open journal is not a block
> device, NOT checking disk write cache on /data/osd0/journal
> 10.10.09_01:27:52.664052 b77856d0 journal _open /data/osd0/journal fd 8:
> 8192 bytes, block size 4096 bytes, directio = 1
> 10.10.09_01:27:52.664067 b77856d0 journal read_header
> 10.10.09_01:27:52.665300 b77856d0 journal header: block_size 4096 alignment
> 4096 max_size 0
> 10.10.09_01:27:52.665352 b77856d0 journal header: start 4096
> 10.10.09_01:27:52.665365 b77856d0 journal  write_pos 4096
> 10.10.09_01:27:52.665389 b77856d0 journal open header.fsid = 206080828
> ____________________________________________________________________________
> ___
> 
> 
> I just downloaded http://ceph.newdream.net/download/ceph-0.21.3.tar.gz on a
> Ubuntu 10.10 Server (x32). 
> root@CEPH1:/etc/ceph# uname -a
> Linux CEPH1 2.6.35-22-generic #33-Ubuntu SMP Sun Sep 19 20:34:50 UTC 2010
> i686 GNU/Linux Done configure and make, followed by an install. Then I
> cloned the machine 3 more times, making 4 nodes. /dev/sdb1 is formatted with
> btrfs.
> 
> The nodes are running in VirtualBox
> root@CEPH1:/etc/ceph# cat /etc/hosts
> 127.0.0.1       localhost
> x.x.239.140  CEPH1
> x.x.239.141  CEPH2
> x.x.239.142  CEPH3
> x.x.239.143  CEPH4
> 
> Distributed ssh-keys, so the scripts run through.
> 
> My ceph.conf looks like this:
> root@CEPH1:/etc/ceph# cat ceph.conf
> ; global
> [global]
>         ; enable secure authentication
> auth supported = cephx
> 
> ; monitors
>  [mon]
>         mon data = /data/mon$id
>         debug ms = 1
>         debug mon = 20
>         debug paxos = 20
>         debug auth = 20
> 
> [mon0]
>         host = CEPH1
>         mon addr = x.x.239.140:6789
> 
> [mon1]
>         host = CEPH2
>         mon addr = x.x.239.141:6789
> 
> [mon2]
>         host = CEPH3
>         mon addr = x.x.239.142:6789
> 
> ; mds
> ;  You need at least one.  Define two to get a standby.
> [mds]
>         ; where the mds keeps it's secret encryption keys
>         keyring = /data/keyring.$name
>         ; mds logging to debug issues.
>         debug ms = 1
>         debug mds = 20
> 
> [mds.ceph1]
>         host = ceph1
> [mds.ceph3]
>         host = ceph3
> 
> ; osd
>  [osd]
>         osd data = /data/osd$id
>         osd journal = /data/osd$id/journal
>         debug ms = 1
>         debug osd = 20
>         debug filestore = 20
>         debug journal = 20
> 
> [osd0]
>         host = ceph1
>         btrfs devs = /dev/sdb1
> [osd1]
>         host = ceph2
>         btrfs devs = /dev/sdb1
> [osd2]
>         host = ceph3
>         btrfs devs = /dev/sdb1
> [osd3]
>         host = ceph4
>         btrfs devs = /dev/sdb1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
