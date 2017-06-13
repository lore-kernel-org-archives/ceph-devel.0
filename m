From: =?UTF-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Subject: Re: ceph osd memory free problem
Date: Tue, 13 Jun 2017 15:26:44 +0800
Message-ID: <CAE5T3NwroY56evSx3zG1XgExfWaO72TUwmxNMnd82T=6N7Kv6Q@mail.gmail.com>
References: <CAE5T3Nw4Ok6xcpWgOsRCj+NC5AiswUGShQmXRzxrJ_cNSPgCHw@mail.gmail.com>
 <robbat2-20170612T060139-811827739Z@orbis-terrarum.net> <CAE5T3Nx+Tt54BLJfzCEigu9dQkgYWpo8=7Rab74LCXfuT3ozZg@mail.gmail.com>
 <20170613053728.GJ23586@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33848 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbdFMH0r (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 03:26:47 -0400
Received: by mail-lf0-f41.google.com with SMTP id v20so63512941lfa.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 00:26:46 -0700 (PDT)
In-Reply-To: <20170613053728.GJ23586@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: robbat2@gentoo.org
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Robin,
Sorry the OOM log is too old and is deleted by log daemon process.
When it occurs next time, I will share it.

In one of our ceph osd server node ,memory use info as show below:
[root@yxy ~]# free -m
             total       used       free     shared    buffers     cached
Mem:         96732      94609       2122          0        108       1385
-/+ buffers/cache:      93115       3617
Swap:         8191         39       8152

There left only 3GB free memory.

[root@yxy ~]# df -i
Filesystem        Inodes  IUsed     IFree IUse% Mounted on
/dev/sda3       54321152 110338  54210814    1% /
tmpfs           12381814      5  12381809    1% /dev/shm
/dev/sda1         128016     43    127973    1% /boot
/dev/sdb2      243164032 601809 242562223    1% /data/osd/osd.350
/dev/sdc2      243164032 699422 242464610    1% /data/osd/osd.351
/dev/sdd2      243164032 665658 242498374    1% /data/osd/osd.352
/dev/sde2      243164032 605706 242558326    1% /data/osd/osd.353
/dev/sdf2      243164032 631910 242532122    1% /data/osd/osd.354
/dev/sdg2      243164032 658487 242505545    1% /data/osd/osd.355
/dev/sdh2      243164032 601828 242562204    1% /data/osd/osd.356
/dev/sdi2      243164032 630928 242533104    1% /data/osd/osd.357
/dev/sdj2      243164032 645877 242518155    1% /data/osd/osd.358
/dev/sdk2      243164032 622181 242541851    1% /data/osd/osd.359
/dev/sdl2       56030080   5071  56025009    1% /data/osd/osd.635

slabtop s -c:

Active / Total Objects (% used) : 40600596 / 43488385 (93.4%)
Active / Total Slabs (% used) : 3844327 / 3844353 (100.0%)
Active / Total Caches (% used) : 123 / 202 (60.9%)
Active / Total Size (% used) : 14249828.03K / 14859724.49K (95.9%)
Minimum / Average / Maximum Object : 0.02K / 0.34K / 4096.00K
OBJS ACTIVE USE OBJ SIZE SLABS OBJ/SLAB CACHE SIZE NAME
6170440 6107321 98% 1.00K 1542610 4 6170440K xfs_inode         (almost
all the file in osds are cached)
13812300 13582998 98% 0.38K 1381230 10 5524920K xfs_buf
6432700 5806283 90% 0.19K 321635 20 1286540K dentry
5206420 4781120 91% 0.19K 260321 20 1041284K size-192
6290344 6107277 97% 0.06K 106616 59 426464K xfs_ifork
466088 247699 53% 0.55K 66584 7 266336K radix_tree_node
2912240 2836455 97% 0.06K 49360 59 197440K size-64
1166573 246580 21% 0.10K 31529 37 126116K buffer_head
27729 27414 98% 2.61K 9243 3 73944K task_struct
95988 84458 87% 0.64K 15998 6 63992K proc_inode_cache
302850 276121 91% 0.12K 10095 30 40380K size-128
36780 35438 96% 1.00K 9195 4 36780K size-1024
31104 30020 96% 0.98K 7776 4 31104K ext4_inode_cache
13208 12792 96% 1.69K 3302 4 26416K TCP
66538 36790 55% 0.22K 3914 17 15656K xfs_ili
29704 26991 90% 0.50K 3713 8 14852K task_xstate
67184 63566 94% 0.20K 3536 19 14144K vm_area_struct

[root@yxy ~]# cat /proc/meminfo
MemTotal:       99054512 kB
MemFree:         2173968 kB
Buffers:          111508 kB
Cached:          1421108 kB
SwapCached:         6804 kB
Active:         16991760 kB
Inactive:        3066960 kB
Active(anon):   16178216 kB
Inactive(anon):  2350572 kB
Active(file):     813544 kB
Inactive(file):   716388 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       8388604 kB
SwapFree:        8348372 kB
Dirty:              1144 kB
Writeback:             0 kB
AnonPages:      18519372 kB
Mapped:            51948 kB
Shmem:              2620 kB
Slab:           15442692 kB
SReclaimable:    7959432 kB
SUnreclaim:      7483260 kB
KernelStack:      217992 kB
PageTables:       108692 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    57915860 kB
Committed_AS:   58524072 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      489872 kB
VmallocChunk:   34304711680 kB
HardwareCorrupted:     0 kB
AnonHugePages:   5941248 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:        4096 kB
DirectMap2M:     2084864 kB
DirectMap1G:    98566144 kB

2017-06-13 13:37 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
> On Mon, Jun 12, 2017 at 02:37:48PM +0800, =E4=BA=8E=E7=9B=B8=E6=B4=8B wro=
te:
>> Appreciate to receive you reply, Robin Hugh.
>> I have also try to adjust the vm configuration before ,but get no effect=
.
>>
>> Now I will accept your method to do "echo 2 "> drop_caches
> That's strictly a workaround.
>
> The OTHER way we can recover memory is to stop the OSD process for a
> given filesystem, umount the filesystem, (not just remount), mount it
> again and restart the OSD process.
>
> Can you share some of your OOM messages, and we can try and confirm if
> it's the same issue? Also possibly fixed in much newer kernels, but I thi=
nk
> BlueStore is going to make the bug irrelevant as well by avoiding XFS sys=
tems
> with lots of inodes.
>
> In our case, each XFS filesystem has ~6M inodes (over ~52k directories), =
and
> this hugely impacts slab.
>
> From "slabtop -s c", to sort by size:
>   OBJS   ACTIVE    USE OBJ-SIZE  SLABS OBJ/SLAB CACHE-SIZE NAME
>  4017576  1872371  46%    2.00K 251186       16   8037952K kmalloc-2048
> 19057016 17725140  93%    0.38K 455004       42   7280064K mnt_cache
>  4952967  2288054  46%    1.06K 167276       30   5352832K xfs_inode
>  5346579  2380752  44%    0.57K 191958       28   3071328K radix_tree_nod=
e
>  6701565  6694510  99%    0.10K 171835       39    687340K buffer_head
>  7478016  2597615  34%    0.06K 116844       64    467376K kmalloc-64
>   832624   256901  30%    0.50K  26021       32    416336K kmalloc-512
>    71220    68291  95%    3.50K   7916        9    253312K task_struct
>   238380   104089  43%    1.00K   7487       32    239584K kmalloc-1024
>   896658   612456  68%    0.19K  21349       42    170792K dentry
>   121930   116536  95%    0.61K   3616       52    115712K proc_inode_cac=
he
>
>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
