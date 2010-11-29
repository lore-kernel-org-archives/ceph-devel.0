From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Mon, 29 Nov 2010 11:53:54 +0800
Message-ID: <1291002834.1872.120.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <1291001398.1872.107.camel@cephhost>  <1291001962.1872.113.camel@cephhost>
	 <1291002250.1872.116.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:45339 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754510Ab0K2DxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Nov 2010 22:53:04 -0500
In-Reply-To: <1291002250.1872.116.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@newdream.net>, yehuda <yehuda@hq.newdream.net>, gregf@hq.newdream.net, colinm <colinm@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org, mllv <mllv@tnsoft.com.cn>

HTML ---> TEXT,re-send
=================================================

Hi , 

I've recently been using FFSB and iozone to do performance test with Ceph v0.23 on my platform.
 FFSB configuration file and ceph.conf attached .

I am using one server(172.16.10.171) for the MDS and MON daemons and client host,
one server(172.16.10.42) is for OSD0 ,one server(172.16.10.65) is for OSD1.
The three machines all have Gigabit ethernet cards and connect with Gigabit Router.
The disks are formatted using ext4 in no-journal mode and btrfs mode.

The following is my patform infos and test results:
ceph: 0.23
OS:ubuntu 10.10 x86_64 ,2.6.35-22-generic kernel.

Ethernet: one Gigabit

MON MDS CLIENT  HOST:
CPU: Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
Memory: 2GB
cleint:
mount.ceph 172.16.10.171:6789:/  /mnt/ceph

OSD0 host:
CPU:Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
Memory: 2GB

OSD1 host:
CPU:AMD Athlon(tm) 64 X2 Dual Core Processor 3600+
Memory: 4GB


1) here are FFSB test result on ceph+btrfs disk

                                                        8 thread
16 threads                                32 threads 
large_file_create   14.7 MB/sec         16.4 MB/sec         17.8 MB/sec 
sequential_reads    15.5 MB/sec        16 MB/sec           17 MB/sec 
random_reads        490 KB/sec        594 KB/sec           664 KB/sec 
random_writes       57.2 MB/sec          68.4 MB/sec         72.1 MB/sec
mailserver       		  
		Read:85.8KB/sec		Read : 236KB/sec   Read:286KB/sec 
		Write : 36KB/sec	Write : 132KB/sec  Write:129KB/sec


2) For comparison, here are the FFSB test result on ceph+ext4 disk with no journal

                    8 thread           16 threads            32 threads 
large_file_create   7.92 MB/sec         8.09 MB/sec           8.46 MB/sec 
sequential_reads    8.19 MB/sec         8.77 MB/sec           8.14 MB/sec 
random_reads        786 KB/sec          556 KB/sec            170 KB/sec 
random_writes       52.9 MB/sec         63 MB/sec             59.1 MB/sec
mailserver       		  
		  Read:456KB/sec	Read : 249KB/sec   Read:485KB/sec 
		  Write : 228KB/sec	Write : 120KB/sec  Write:226KB/sec

3) here are iozone test result on ceph+btrfs disk,file size 6GB , Output is in Kbytes/sec

	Iozone: Performance Test of File I/O
	        Version $Revision: 3.353 $
		Compiled for 64 bit mode.
		Build: linux-ia64 

	Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
	             Al Slater, Scott Rhine, Mike Wisner, Ken Goss
	             Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
	             Randy Dunlap, Mark Montague, Dan Million, Gavin Brebner,
	             Jean-Marc Zucconi, Jeff Blomberg, Benny Halevy, Dave Boone,
	             Erik Habbinga, Kris Strecker, Walter Wong, Joshua Root,
	             Fabrice Bacchella, Zhenghua Xue, Qin Li.

	Run began: Fri Nov 26 09:00:33 2010

	Include close in write timing
	Include fsync in write timing
	Auto Mode
	Using minimum file size of 6291456 kilobytes.
	Using maximum file size of 6291456 kilobytes.
	Excel chart generation enabled
	Command line used: ./benchmark/iozone/iozone_x86_64 -c -e -a -n 6144M -g 6144M -i 0 -i 1 -i 2 -f /mnt/ceph/f1 -Rb ./benchmark/iozone/iozone.201011260900.xls
	Output is in Kbytes/sec
	Time Resolution = 0.000001 seconds.
	Processor cache size set to 1024 Kbytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
                                                            random  random    bkwd   record   stride                                   
              KB  reclen   write rewrite    read    reread    read   write    read  rewrite     read   fwrite frewrite   fread  freread
         6291456      64    6627    6417     9898    10334    3629    5908                                                          
         6291456     128    6803    7182    10200    10582    5106    6268                                                          
         6291456     256    6734    7249    10821    11224    7348    7135                                                          
         6291456     512    7109    7213    10538    10682    9392    7788                                                          
         6291456    1024    6932    7616    11204    10873    8673    8467                                                          
         6291456    2048    7896    7669    11025     9981   10258    7770                                                          
         6291456    4096    6933    7084    10590    10703   10450    7758                                                          
         6291456    8192    7215    7192    10490    10700   11110    7838                                                          
         6291456   16384    6557    6646    10224    11179   10738    7062                                                          

4) For comparison, here are the iozone test result on ceph+ext4 disk with no journal,file size 6GB , Output is in Kbytes/sec

	Iozone: Performance Test of File I/O
	        Version $Revision: 3.353 $
		Compiled for 64 bit mode.
		Build: linux-ia64 

	Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
	             Al Slater, Scott Rhine, Mike Wisner, Ken Goss
	             Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
	             Randy Dunlap, Mark Montague, Dan Million, Gavin Brebner,
	             Jean-Marc Zucconi, Jeff Blomberg, Benny Halevy, Dave Boone,
	             Erik Habbinga, Kris Strecker, Walter Wong, Joshua Root,
	             Fabrice Bacchella, Zhenghua Xue, Qin Li.

	Run began: Thu Nov 25 08:42:25 2010

	Include close in write timing
	Include fsync in write timing
	Auto Mode
	Using minimum file size of 6291456 kilobytes.
	Using maximum file size of 6291456 kilobytes.
	Excel chart generation enabled
	Command line used: ./benchmark/iozone/iozone_x86_64 -c -e -a -n 6144M -g 6144M -i 0 -i 1 -i 2 -f /mnt/ceph/f1 -Rb ./benchmark/iozone/iozone.201011250841.xls
	Output is in Kbytes/sec
	Time Resolution = 0.000001 seconds.
	Processor cache size set to 1024 Kbytes.
	Processor cache line size set to 32 bytes.
	File stride size set to 17 * record size.
                                                            random  random    bkwd   record   stride                                   
              KB  reclen   write rewrite    read    reread    read   write    read  rewrite     read   fwrite frewrite   fread  freread
         6291456      64    7214    7128     9847     9991    3112    4168                                                          
         6291456     128    7514    7367    10601    10281    4667    6041                                                          
         6291456     256    7420    7414    11041    11238    6933    7860                                                          
         6291456     512    8190    8120    11449    11166    9001    7959                                                          
         6291456    1024    7611    7702    10497    10391    7497    8887                                                          
         6291456    2048    7516    7408     9908    10254    8639    8387                                                          
         6291456    4096    7355    7453    10383    10598    9469    7554                                                          
         6291456    8192    7415    7651    10244    10240    9868    8450                                                          
         6291456   16384    7200    7166     9877     9778    9829    8228         


Are these results reasonable ? which seem  too slow , maybe,i do something wrong. 
Could you give me some ceph performance test results for the reference ?

Any ideas ,please let me know ,thanks.

Jeff.Wu




=============================ceph.conf =======================================

;
; Sample ceph ceph.conf file.
;
; This file defines cluster membership, the various locations
; that Ceph stores data, and any other runtime options.

; If a 'host' is defined for a daemon, the start/stop script will
; verify that it matches the hostname (or else ignore it).  If it is
; not defined, it is assumed that the daemon is intended to start on
; the current host (e.g., in a setup with a startup.conf on each
; node).

; global
[global]
	; enable secure authentication
	; auth supported = cephx
	keyring = /etc/ceph/keyring.bin
; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
	mon data = /opt/ceph/data/mon$id

	; logging, for debugging monitor crashes, in order of
	; their likelihood of being helpful :)
	;debug ms = 20
	;debug mon = 20
	;debug paxos = 20
	;debug auth = 20

[mon0]
	host = ubuntu-mon0
	mon addr = 172.16.10.171:6789

[mon1]
	host = ubuntu-mon0
	mon addr = 172.16.10.171:6790

[mon2]
	host = ubuntu-mon0
	mon addr = 172.16.10.171:6791

; mds
;  You need at least one.  Define two to get a standby.
[mds]
	; where the mds keeps it's secret encryption keys
	keyring = /etc/ceph/keyring.$name

	; mds logging to debug issues.
	;debug ms = 20
	;debug mds = 20

[mds.0]
	host = ubuntu-mon0

[mds.1]
	host = ubuntu-mon0

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data = /opt/ceph/data/osd$id
	;osd journal = /opt/ceph/data/osd$id/journal
	osd class tmp = /var/lib/ceph/tmp

	; Ideally, make this a separate disk or partition.  A few
 	; hundred MB should be enough; more if you have fast or many
 	; disks.  You can use a file under the osd data dir if need be
 	; (e.g. /data/osd$id/journal), but it will be slower than a
 	; separate disk or partition.

        ; This is an example of a file-based journal.
	; osd journal size = 1000 ; journal size, in megabytes
	keyring = /etc/ceph/keyring.$name

	; osd logging to debug osd issues, in order of likelihood of being
	; helpful
	;debug ms = 20
	;debug osd = 20
	;debug filestore = 20
	;debug journal = 20

[osd0]
	host = ubuntu-osd0

	;osd journal size = 1000 ; journal size, in megabytes
	; if 'btrfs devs' is not specified, you're responsible for
	; setting up the 'osd data' dir.  if it is not btrfs, things
	; will behave up until you try to recover from a crash (which
	; usually fine for basic testing).
	; btrfs devs = /dev/sdx

[osd1]
	host = ubuntu-osd1
	;osd data = /opt/data/osd$id
	;osd journal = /opt/data/osd$id/journal
	;filestore journal writeahead = true
	;osd journal size = 1000 ; journal size, in megabytes
	;btrfs devs = /dev/sdy

;[osd2]
	;host = zeta
	;btrfs devs = /dev/sdx

;[osd3]
	;host = eta
	;btrfs devs = /dev/sdy

================================= large_files_create========================================


# Large file creates
# Creating 1024 MB files.

time=300
alignio=1
directio=0

[filesystem0]
	location=%TESTPATH%

	# All created files will be 1024 MB.
	min_filesize=1024M
	max_filesize=1024M
[end0]

[threadgroup0]
	num_threads=32  # 8,16

	create_weight=1

	write_blocksize=4K

	[stats]
		enable_stats=1
		enable_range=1

		msec_range    0.00      0.01
		msec_range    0.01      0.02
		msec_range    0.02      0.05
		msec_range    0.05      0.10
		msec_range    0.10      0.20
		msec_range    0.20      0.50
		msec_range    0.50      1.00
		msec_range    1.00      2.00
		msec_range    2.00      5.00
		msec_range    5.00     10.00
		msec_range   10.00     20.00
		msec_range   20.00     50.00
		msec_range   50.00    100.00
		msec_range  100.00    200.00
		msec_range  200.00    500.00
		msec_range  500.00   1000.00
		msec_range 1000.00   2000.00
		msec_range 2000.00   5000.00
		msec_range 5000.00  10000.00
	[end]
[end0]



================================= mail server ========================================


# Mail server simulation.
# 1024 file

time=300
alignio=1
directio=0

[filesystem0]
	location=%TESTPATH%
	num_files=1024
	num_dirs=100

	# File sizes range from 1kB to 1MB.
	size_weight 1KB 10
	size_weight 2KB 15
	size_weight 4KB 16
	size_weight 8KB 16
	size_weight 16KB 15
	size_weight 32KB 10
	size_weight 64KB 8
	size_weight 128KB 4
	size_weight 256KB 3
	size_weight 512KB 2
	size_weight 1MB 1
[end0]

[threadgroup0]
	num_threads=32 # 8,16

	readall_weight=4
	create_fsync_weight=2
	delete_weight=1

	write_size=4KB
	write_blocksize=4KB

	read_size=4KB
	read_blocksize=4KB

	[stats]
		enable_stats=1
		enable_range=1

		msec_range    0.00      0.01
		msec_range    0.01      0.02
		msec_range    0.02      0.05
		msec_range    0.05      0.10
		msec_range    0.10      0.20
		msec_range    0.20      0.50
		msec_range    0.50      1.00
		msec_range    1.00      2.00
		msec_range    2.00      5.00
		msec_range    5.00     10.00
		msec_range   10.00     20.00
		msec_range   20.00     50.00
		msec_range   50.00    100.00
		msec_range  100.00    200.00
		msec_range  200.00    500.00
		msec_range  500.00   1000.00
		msec_range 1000.00   2000.00
		msec_range 2000.00   5000.00
		msec_range 5000.00  10000.00
	[end]
[end0]


================================= random reads========================================
# Large file random reads.
# 256 files, 100MB per file.

time=300  # 5 min
alignio=1

[filesystem0]
	location=%TESTPATH%
	num_files=256
	min_filesize=100M  # 100 MB
	max_filesize=100M
	reuse=1
[end0]

[threadgroup0]
	num_threads=32 # 8,16

	read_random=1
	read_weight=1

	read_size=1M  # 1 MB
	read_blocksize=4k

	[stats]
		enable_stats=1
		enable_range=1

		msec_range    0.00      0.01
		msec_range    0.01      0.02
		msec_range    0.02      0.05
		msec_range    0.05      0.10
		msec_range    0.10      0.20
		msec_range    0.20      0.50
		msec_range    0.50      1.00
		msec_range    1.00      2.00
		msec_range    2.00      5.00
		msec_range    5.00     10.00
		msec_range   10.00     20.00
		msec_range   20.00     50.00
		msec_range   50.00    100.00
		msec_range  100.00    200.00
		msec_range  200.00    500.00
		msec_range  500.00   1000.00
		msec_range 1000.00   2000.00
		msec_range 2000.00   5000.00
		msec_range 5000.00  10000.00
	[end]
[end0]


================================= random writes========================================

# Large file random writes.
# 256 files, 100MB per file.

time=300  # 5 min
alignio=1

[filesystem0]
        location=%TESTPATH%
        num_files=256
        min_filesize=100M  # 100 MB
        max_filesize=100M
        reuse=1
[end0]

[threadgroup0]
        num_threads=32 # 8,16

        write_random=1
        write_weight=1

        write_size=1M  # 1 MB
        write_blocksize=4k

        [stats]
                enable_stats=1
                enable_range=1

                msec_range    0.00      0.01
                msec_range    0.01      0.02
                msec_range    0.02      0.05
                msec_range    0.05      0.10
                msec_range    0.10      0.20
                msec_range    0.20      0.50
                msec_range    0.50      1.00
                msec_range    1.00      2.00
                msec_range    2.00      5.00
                msec_range    5.00     10.00
                msec_range   10.00     20.00
                msec_range   20.00     50.00
                msec_range   50.00    100.00
                msec_range  100.00    200.00
                msec_range  200.00    500.00
                msec_range  500.00   1000.00
                msec_range 1000.00   2000.00
                msec_range 2000.00   5000.00
                msec_range 5000.00  10000.00
        [end]
[end0]

================================= sequential reads========================================


# Large file sequential reads.
# 256 files, 100MB per file.

time=300  # 5 min
alignio=1

[filesystem0]
	location=%TESTPATH%
	num_files=256
	min_filesize=100M  # 100 MB
	max_filesize=100M  # 100 MB
	reuse=1
[end0]

[threadgroup0]
	num_threads=32 # 8,16
	read_weight=1
	read_size=1M  # 1 MB
	read_blocksize=4k

	[stats]
		enable_stats=1
		enable_range=1

		msec_range    0.00      0.01
		msec_range    0.01      0.02
		msec_range    0.02      0.05
		msec_range    0.05      0.10
		msec_range    0.10      0.20
		msec_range    0.20      0.50
		msec_range    0.50      1.00
		msec_range    1.00      2.00
		msec_range    2.00      5.00
		msec_range    5.00     10.00
		msec_range   10.00     20.00
		msec_range   20.00     50.00
		msec_range   50.00    100.00
		msec_range  100.00    200.00
		msec_range  200.00    500.00
		msec_range  500.00   1000.00
		msec_range 1000.00   2000.00
		msec_range 2000.00   5000.00
		msec_range 5000.00  10000.00
	[end]
[end0]

==================================================================

