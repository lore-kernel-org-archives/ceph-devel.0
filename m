From: Maxim Mikheev <mikhmv@datintsol.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 06:37:21 -0500
Message-ID: <4ED37271.8030504@biodatomics.com>
References: <4ED10636.6070705@biodatomics.com> <4ED36701.3060107@widodh.nl>
Reply-To: max@biodatomics.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040409000900070505000503"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58510 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab1K1LhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 06:37:24 -0500
Received: by vcbfk14 with SMTP id fk14so3528260vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 03:37:23 -0800 (PST)
In-Reply-To: <4ED36701.3060107@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Maxim Mikheev <mikhmv@datintsol.com>, ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409000900070505000503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wido,

Thank you for your answer! I really appreciate it.

root@s1-2core:~# ceph -s
2011-11-28 05:55:29.690342    pg v384857: 594 pgs: 594 active+clean; 254 
GB data, 522 GB used, 673 GB / 1351 GB avail
2011-11-28 05:55:29.691363   mds e182: 1/1/1 up {0=a=up:active}
2011-11-28 05:55:29.691392   osd e465: 3 osds: 3 up, 3 in full
2011-11-28 05:55:29.691443   log 2011-11-27 14:05:41.157654 osd.0 
192.168.2.10:6800/4059 417 : [INF] 2.a6 scrub ok
2011-11-28 05:55:29.691503   mon e1: 1 mons at {a=192.168.2.11:6789/0}

I run in one terminal:
root@s1-2core:~# mount -t ceph -o 
name=admin,secretfile=/etc/ceph/mycluster.secret 192.168.2.11:/ /root/mnt
mount error 5 = Input/output error

in dmesg new lines:
[203473.279209] libceph: client7843 fsid 
c09c2197-3976-3779-d7b1-26700db70b68
[203473.279428] libceph: mon0 192.168.2.11:6789 session established

All related to ceph and /dev/sda3 lines in dmesg:
[   21.805559] device fsid cf737bad-a4d2-4fbb-9e70-252d4c2f3334 devid 1 
transid 148962 /dev/sda3
[   51.572129] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[   51.587234] ceph: loaded (mds proto 32)
[   51.598655] libceph: client7709 fsid c09c2197-3976-3779-d7b1-26700db70b68
[   51.598875] libceph: mon0 192.168.2.11:6789 session established
[  245.149999] libceph: client7710 fsid c09c2197-3976-3779-d7b1-26700db70b68
[  245.150219] libceph: mon0 192.168.2.11:6789 session established
[  534.421654] libceph: client7719 fsid c09c2197-3976-3779-d7b1-26700db70b68
[  534.421696] libceph: mon0 192.168.2.11:6789 session established
[ 2007.419285] fsck.btrfs[3727]: segfault at c9 ip 0000000000412f2d sp 
00007fffafb96738 error 4 in btrfsck[400000+1f000]
[ 2209.940609] end_request: I/O error, dev fd0, sector 0
[ 2250.326600] device fsid 209ccabc-11e0-495d-ae5a-216768304fda devid 1 
transid 7 /dev/sda3
[ 5538.641217] fsck.btrfs[5345]: segfault at b4 ip 000000000040f486 sp 
00007fffe8468890 error 4 in btrfsck[400000+1f000]
[ 5559.655594] fsck.btrfs[5351]: segfault at c4 ip 000000000040df31 sp 
00007fffe8539790 error 4 in btrfsck[400000+1f000]
[43735.359711] libceph: client7822 fsid c09c2197-3976-3779-d7b1-26700db70b68
[43735.359930] libceph: mon0 192.168.2.11:6789 session established
[203473.279209] libceph: client7843 fsid 
c09c2197-3976-3779-d7b1-26700db70b68
[203473.279428] libceph: mon0 192.168.2.11:6789 session established
root@s1-2core:~#

You can find full dmesg as an attachment.

Looks likes some errors on btrfs under ceph. you can find results of 
fsck /dev/sda3 as an attachment.
My ceph configuration is following:
1 mon, 1 mds and 3 osd on different nodes.
All nodes has similar errors on btrfs.

Help, please, to recover ceph.

Thanks,
     Max

On 11/28/2011 05:48 AM, Wido den Hollander wrote:
> Hi,
>
> On 11/26/2011 04:31 PM, Maxim Mikheev wrote:
>> Hi Everyone,
>>
>> My ceph instance was too slow and I tried to benchmark it with bonnie++.
>> Benchmark finished with error message and Ceph died.
>> I cannot mount ceph on any computers:
>> root@s3-2core:~# mount -t ceph -o
>> name=admin,secretfile=/etc/ceph/mycluster.secret 192.168.2.11:/ 
>> /root/mnt/
>> mount error 5 = Input/output error
>
> What does your "dmesg" show? Any additional information?
>
>>
>> I have 250Gb data in ceph, I can generate this data again but it will
>> take around 2 weeks.
>>
>> The question how can I reanimate ceph? I like the idea of ceph but
>> unfortunately I am not alone in the project an we are close to give up
>> on using it.
>> I just recently start to use it and don't know what kind of information
>> I should submit. Here are what I know:
>>
>> root@s2-8core:~# ceph health
>> 2011-11-26 10:20:32.565809 mon <- [health]
>> 2011-11-26 10:20:32.566140 mon.0 -> 'HEALTH_OK' (0)
>
> Although the cluster seems healthy, what does 'ceph -s' show?
>
> Wido
>
>> --------------------------------------------------------------------------------------------------- 
>>
>>
>> # ceph osd dump -o -
>> 2011-11-26 10:04:46.922947 mon <- [osd,dump]
>> 2011-11-26 10:04:46.935616 mon.0 -> 'dumped osdmap epoch 465' (0)
>> epoch 465
>> fsid c09c2197-3976-3779-d7b1-26700db70b68
>> created 2011-11-04 12:43:26.390483
>> modifed 2011-11-25 22:21:17.275421
>> flags full
>>
>> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 192
>> pgp_num 192 lpg_num 2 lpgp_num 2 last_change 5 owner 0
>> crash_replay_interval 60
>> removed_snaps [2~2]
>> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num
>> 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 192
>> pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>>
>> max_osd 3
>> osd.0 up in weight 1 up_from 462 up_thru 462 down_at 303
>> last_clean_interval [292,298) lost_at 461 192.168.2.10:6800/4059
>> 192.168.2.10:6801/4059 192.168.2.10:6802/4059
>> osd.1 up in weight 1 up_from 296 up_thru 462 down_at 295
>> last_clean_interval [281,294) lost_at 199 192.168.2.11:6801/3363
>> 192.168.2.11:6805/3363 192.168.2.11:6806/3363
>> osd.2 up in weight 1 up_from 272 up_thru 462 down_at 268
>> last_clean_interval [257,267) 192.168.2.12:6800/1097
>> 192.168.2.12:6801/1097 192.168.2.12:6802/1097
>>
>>
>> wrote 1081 byte payload to -
>> ---------------------------------------------------------------------------------------------------- 
>>
>>
>> root@s2-8core:~# cat /etc/ceph/ceph.conf
>> [global]
>> auth supported = cephx
>> keyring = /etc/ceph/mycluster.keyring
>> max open files = 131072
>> log file = /var/log/ceph/$name.log
>> pid file = /var/run/ceph/$name.pid
>> [mon]
>> keyring = /etc/ceph/$name.keyring
>> mon data = /srv/mon.$id
>> debug ms = 1
>> [mon.a]
>> host = s2-8core
>> mon addr = 192.168.2.11:6789
>> [mds]
>> keyring = /etc/ceph/$name.keyring
>> [mds.a]
>> host = s2-8core
>> [osd]
>> keyring = /etc/ceph/$name.keyring
>> osd data = /srv/osd.$id
>> osd journal = /srv/osd.$id/journal
>> osd journal size = 1000 ; journal size, in megabytes
>> [osd.0]
>> host = s1-2core
>> [osd.1]
>> host = s2-8core
>> [osd.2]
>> host = s3-2core
>>
>> Thank you in an advance,
>> Max
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>


-- 
Maxim Mikheev, President
BioDatomics
173 Fairfax Rd, Pittsburgh, 15221, PA
Phone: (412) 475-8886
Fax:   (470) 201-6233
Email: max@biodatomics.com
Web-site: www.biodatomics.com
LinkedIn: http://www.linkedin.com/in/maxmikheev

Confidentiality Notice: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and may contain confidential and privileged information. Any unauthorized review, use, disclosure or distribution is prohibited. If you are not the intended recipient, please contact the sender by reply e-mail and destroy all copies of the original message.


--------------040409000900070505000503
Content-Type: text/plain; charset=UTF-8;
 name="fsck.brtfs.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="fsck.brtfs.txt"

﻿root@s1-2core:~# fsck.btrfs /dev/sda3
parent transid verify failed on 20971520 wanted 1304 found 1138
parent transid verify failed on 20971520 wanted 1304 found 1138
parent transid verify failed on 20975616 wanted 1304 found 1138
parent transid verify failed on 20975616 wanted 1304 found 1138
parent transid verify failed on 20992000 wanted 1304 found 1138
parent transid verify failed on 20992000 wanted 1304 found 1138
parent transid verify failed on 164287451136 wanted 1303 found 1141
parent transid verify failed on 164287451136 wanted 1303 found 1141
leaf parent key incorrect 102987640832
bad block 102987640832
leaf parent key incorrect 164287430656
bad block 164287430656
leaf parent key incorrect 29446144
bad block 29446144
leaf parent key incorrect 29564928
bad block 29564928
leaf parent key incorrect 30715904
bad block 30715904
leaf parent key incorrect 67977637888
bad block 67977637888
leaf parent key incorrect 68017377280
bad block 68017377280
leaf parent key incorrect 89821204480
bad block 89821204480
leaf parent key incorrect 89828941824
bad block 89828941824
leaf parent key incorrect 95324016640
bad block 95324016640
leaf parent key incorrect 95325392896
bad block 95325392896
leaf parent key incorrect 95333859328
bad block 95333859328
leaf parent key incorrect 95340507136
bad block 95340507136
leaf parent key incorrect 95344488448
bad block 95344488448
leaf parent key incorrect 95344611328
bad block 95344611328
leaf parent key incorrect 95349321728
bad block 95349321728
leaf parent key incorrect 95349567488
bad block 95349567488
leaf parent key incorrect 95352758272
bad block 95352758272
leaf parent key incorrect 95352778752
bad block 95352778752
leaf parent key incorrect 95352782848
bad block 95352782848
leaf parent key incorrect 95352786944
bad block 95352786944
leaf parent key incorrect 95352791040
bad block 95352791040
leaf parent key incorrect 95352795136
bad block 95352795136
leaf parent key incorrect 95352803328
bad block 95352803328
leaf parent key incorrect 95352807424
bad block 95352807424
leaf parent key incorrect 95352811520
bad block 95352811520
leaf parent key incorrect 95352815616
bad block 95352815616
leaf parent key incorrect 95352819712
bad block 95352819712
leaf parent key incorrect 95352823808
bad block 95352823808
leaf parent key incorrect 95352827904
bad block 95352827904
leaf parent key incorrect 95352848384
bad block 95352848384
bad block 95352852480
Extent back ref already exists for 838369280 parent 0 root 2 
Extent back ref already exists for 982433792 parent 0 root 2 
Extent back ref already exists for 75714170880 parent 0 root 2 
Extent back ref already exists for 68072947712 parent 0 root 2 
Extent back ref already exists for 68042022912 parent 0 root 2 
Extent back ref already exists for 889384960 parent 0 root 2 
Extent back ref already exists for 875724800 parent 0 root 2 
Extent back ref already exists for 54819807232 parent 0 root 2 
Extent back ref already exists for 75725271040 parent 0 root 2 
Extent back ref already exists for 54859915264 parent 0 root 2 
Extent back ref already exists for 68025958400 parent 0 root 2 
Extent back ref already exists for 54819815424 parent 0 root 2 
Extent back ref already exists for 54819819520 parent 0 root 2 
Extent back ref already exists for 54819823616 parent 0 root 2 
Extent back ref already exists for 68045828096 parent 0 root 2 
Extent back ref already exists for 75601833984 parent 0 root 2 
leaf parent key incorrect 95352864768
bad block 95352864768
leaf parent key incorrect 95352868864
bad block 95352868864
leaf parent key incorrect 95352877056
bad block 95352877056
leaf parent key incorrect 95352881152
bad block 95352881152
leaf 124977725440 items 34 free space 1411 generation 894 owner 2
fs uuid 209ccabc-11e0-495d-ae5a-216768304fda
chunk uuid 1f35f508-6469-4e82-b9b5-1c6d5d771827
	item 0 key (54854967296 EXTENT_ITEM 4096) itemoff 3944 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (24234 c 24024) level 0
		tree block backref root 265
	item 1 key (54854971392 EXTENT_ITEM 4096) itemoff 3893 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54274285568) level 0
		tree block backref root 7
	item 2 key (54854979584 EXTENT_ITEM 4096) itemoff 3842 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54270091264) level 0
		tree block backref root 7
	item 3 key (54854983680 EXTENT_ITEM 4096) itemoff 3791 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54270091264) level 0
		tree block backref root 7
	item 4 key (54854987776 EXTENT_ITEM 4096) itemoff 3740 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54280577024) level 0
		tree block backref root 7
	item 5 key (54854995968 EXTENT_ITEM 4096) itemoff 3689 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54282674176) level 0
		tree block backref root 7
	item 6 key (54855000064 EXTENT_ITEM 4096) itemoff 3638 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54280577024) level 0
		tree block backref root 7
	item 7 key (54855008256 EXTENT_ITEM 4096) itemoff 3587 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54280577024) level 0
		tree block backref root 7
	item 8 key (54855012352 EXTENT_ITEM 4096) itemoff 3536 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54305857536) level 0
		tree block backref root 7
	item 9 key (54855016448 EXTENT_ITEM 4096) itemoff 3485 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54317961216) level 0
		tree block backref root 7
	item 10 key (54855020544 EXTENT_ITEM 4096) itemoff 3434 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54301822976) level 0
		tree block backref root 7
	item 11 key (54855024640 EXTENT_ITEM 4096) itemoff 3383 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54317338624) level 0
		tree block backref root 7
	item 12 key (54855032832 EXTENT_ITEM 4096) itemoff 3332 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54317338624) level 0
		tree block backref root 7
	item 13 key (54855041024 EXTENT_ITEM 4096) itemoff 3281 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54338134016) level 0
		tree block backref root 7
	item 14 key (54855327744 EXTENT_ITEM 4096) itemoff 3230 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (33882763264 a8 1048576) level 0
		tree block backref root 2
	item 15 key (54856269824 EXTENT_ITEM 4096) itemoff 3179 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (92368896 a8 4096) level 0
		tree block backref root 2
	item 16 key (54856499200 EXTENT_ITEM 4096) itemoff 3128 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54342504448) level 0
		tree block backref root 7
	item 17 key (54856503296 EXTENT_ITEM 4096) itemoff 3077 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54346203136) level 0
		tree block backref root 7
	item 18 key (54856507392 EXTENT_ITEM 4096) itemoff 3026 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54351974400) level 0
		tree block backref root 7
	item 19 key (54856511488 EXTENT_ITEM 4096) itemoff 2975 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54354079744) level 0
		tree block backref root 7
	item 20 key (54856863744 EXTENT_ITEM 4096) itemoff 2924 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 56568209408) level 0
		tree block backref root 7
	item 21 key (54856871936 EXTENT_ITEM 4096) itemoff 2873 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54370410496) level 0
		tree block backref root 7
	item 22 key (54856880128 EXTENT_ITEM 4096) itemoff 2822 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54379302912) level 0
		tree block backref root 7
	item 23 key (54856884224 EXTENT_ITEM 4096) itemoff 2771 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54376148992) level 0
		tree block backref root 7
	item 24 key (54857109504 EXTENT_ITEM 4096) itemoff 2720 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54506541056) level 0
		tree block backref root 7
	item 25 key (54857142272 EXTENT_ITEM 4096) itemoff 2669 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 56606568448) level 0
		tree block backref root 7
	item 26 key (54857748480 EXTENT_ITEM 4096) itemoff 2618 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 54570024960) level 0
		tree block backref root 7
	item 27 key (54857936896 EXTENT_ITEM 4096) itemoff 2567 itemsize 51
		extent refs 1 gen 369 flags 2
		tree block key (18446744073709551606 80 50370027520) level 0
		tree block backref root 7
	item 28 key (54858924032 EXTENT_ITEM 4096) itemoff 2516 itemsize 51
		extent refs 1 gen 370 flags 2
		tree block key (18446744073709551606 80 56691302400) level 0
		tree block backref root 7
	item 29 key (54858928128 EXTENT_ITEM 4096) itemoff 2465 itemsize 51
		extent refs 1 gen 370 flags 2
		tree block key (18446744073709551606 80 56695336960) level 0
		tree block backref root 7
	item 30 key (54858932224 EXTENT_ITEM 4096) itemoff 2414 itemsize 51
		extent refs 1 gen 370 flags 2
		tree block key (18446744073709551606 80 56699371520) level 0
		tree block backref root 7
	item 31 key (54859005952 EXTENT_ITEM 4096) itemoff 2363 itemsize 51
		extent refs 1 gen 370 flags 2
		tree block key (24206 60 22) level 0
		tree block backref root 265
	item 32 key (54859010048 EXTENT_ITEM 4096) itemoff 2312 itemsize 51
		extent refs 1 gen 370 flags 2
		tree block key (24207 54 1873862908) level 0
		tree block backref root 265
	item 33 key (54859038720 EXTENT_ITEM 4096) itemoff 2261 itemsize 51
		extent refs 1 gen 370 flags 2
		tree block key (18446744073709551606 80 52469059584) level 0
		tree block backref root 7
failed to find block number 54855479296
Aborted
root@s1-2core:~# 

--------------040409000900070505000503
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.0-13-server (buildd@crested) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #22-Ubuntu SMP Wed Nov 2 15:09:08 UTC 2011 (Ubuntu 3.0.0-13.22-server 3.0.6)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.0.0-13-server root=UUID=edaf9c52-aa3e-45e0-b219-725ffef8b5c3 ro
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cf780000 (usable)
[    0.000000]  BIOS-e820: 00000000cf780000 - 00000000cf78e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cf78e000 - 00000000cf7e0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cf7e0000 - 00000000cf800000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.4 present.
[    0.000000] DMI: System manufacturer P5E-VM HDMI/P5E-VM HDMI, BIOS 0301    10/30/2007
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x230000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   1 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   2 base 000000000 mask E00000000 write-back
[    0.000000]   3 base 200000000 mask FE0000000 write-back
[    0.000000]   4 base 220000000 mask FF0000000 write-back
[    0.000000]   5 base 0CF800000 mask FFF800000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 3328MB, range: 256MB, type UC
[    0.000000] reg 1, base: 3584MB, range: 512MB, type UC
[    0.000000] reg 2, base: 0GB, range: 8GB, type WB
[    0.000000] reg 3, base: 8GB, range: 512MB, type WB
[    0.000000] reg 4, base: 8704MB, range: 256MB, type WB
[    0.000000] reg 5, base: 3320MB, range: 8MB, type UC
[    0.000000] total RAM covered: 8184M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 16M 	num_reg: 7  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 1GB, type WB
[    0.000000] reg 2, base: 3GB, range: 256MB, type WB
[    0.000000] reg 3, base: 3320MB, range: 8MB, type UC
[    0.000000] reg 4, base: 4GB, range: 4GB, type WB
[    0.000000] reg 5, base: 8GB, range: 512MB, type WB
[    0.000000] reg 6, base: 8704MB, range: 256MB, type WB
[    0.000000] e820 update range: 00000000cf800000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcf780 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000cf780000
[    0.000000]  0000000000 - 00cf600000 page 2M
[    0.000000]  00cf600000 - 00cf780000 page 4k
[    0.000000] kernel direct mapping tables up to cf780000 @ cf77a000-cf780000
[    0.000000] init_memory_mapping: 0000000100000000-0000000230000000
[    0.000000]  0100000000 - 0230000000 page 2M
[    0.000000] kernel direct mapping tables up to 230000000 @ 22fff6000-230000000
[    0.000000] RAMDISK: 364b2000 - 37251000
[    0.000000] ACPI: RSDP 00000000000fbcb0 00014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 00000000cf780000 00040 (v01 A_M_I_ OEMRSDT  10000730 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000cf780200 00084 (v02 A_M_I_ OEMFACP  10000730 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000cf7805c0 08A37 (v01  A0867 A0867001 00000001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000cf78e000 00040
[    0.000000] ACPI: APIC 00000000cf780390 0006C (v01 A_M_I_ OEMAPIC  10000730 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000cf780400 0003C (v01 A_M_I_ OEMMCFG  10000730 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000cf78e040 00081 (v01 A_M_I_ AMI_OEM  10000730 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cf789000 00038 (v01 A_M_I_ OEMHPET  10000730 MSFT 00000097)
[    0.000000] ACPI: GSCI 00000000cf78e0d0 02024 (v01 A_M_I_ GMCHSCI  10000730 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000cf789040 000B0 (v01 A_M_I_ OEMOSFR  10000730 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000230000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000230000000
[    0.000000]   NODE_DATA [000000022fffb000 - 000000022fffffff]
[    0.000000]  [ffffea0000000000-ffffea0007bfffff] PMD -> [ffff880227600000-ffff88022e7fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00230000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000cf780
[    0.000000]     0: 0x00100000 -> 0x00230000
[    0.000000] On node 0 totalpages: 2094863
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3922 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 831416 pages, LIFO batch:31
[    0.000000]   Normal zone: 17024 pages used for memmap
[    0.000000]   Normal zone: 1228160 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000cf780000 - 00000000cf78e000
[    0.000000] PM: Registered nosave memory: 00000000cf78e000 - 00000000cf7e0000
[    0.000000] PM: Registered nosave memory: 00000000cf7e0000 - 00000000cf800000
[    0.000000] PM: Registered nosave memory: 00000000cf800000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at cf800000 (gap: cf800000:2f600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88022fc00000 s79616 r8192 d22784 u524288
[    0.000000] pcpu-alloc: s79616 r8192 d22784 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2063498
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.0.0-13-server root=UUID=edaf9c52-aa3e-45e0-b219-725ffef8b5c3 ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8166532k/9175040k available (6187k kernel code, 795588k absent, 212920k reserved, 6935k data, 904k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:16640 nr_irqs:712 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 67108864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3005.828 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using timer frequency.. 6011.65 BogoMIPS (lpj=12023312)
[    0.004010] pid_max: default: 32768 minimum: 301
[    0.004029] Security Framework initialized
[    0.004045] AppArmor: AppArmor initialized
[    0.004048] Yama: becoming mindful.
[    0.004644] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.009385] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.010848] Mount-cache hash table entries: 256
[    0.010975] Initializing cgroup subsys cpuacct
[    0.010983] Initializing cgroup subsys memory
[    0.010991] Initializing cgroup subsys devices
[    0.010994] Initializing cgroup subsys freezer
[    0.010997] Initializing cgroup subsys net_cls
[    0.011000] Initializing cgroup subsys blkio
[    0.011007] Initializing cgroup subsys perf_event
[    0.011029] Disabled fast string operations
[    0.011034] CPU: Physical Processor ID: 0
[    0.011036] CPU: Processor Core ID: 0
[    0.011039] mce: CPU supports 6 MCE banks
[    0.011047] CPU0: Thermal monitoring enabled (TM2)
[    0.011052] using mwait in idle threads.
[    0.012317] ACPI: Core revision 20110413
[    0.016011] ftrace: allocating 26005 entries in 102 pages
[    0.020336] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.062815] CPU0: Intel(R) Core(TM)2 Duo CPU     E6850  @ 3.00GHz stepping 0b
[    0.064003] Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.
[    0.064003] PEBS disabled due to CPU errata.
[    0.064003] ... version:                2
[    0.064003] ... bit width:              40
[    0.064003] ... generic registers:      2
[    0.064003] ... value mask:             000000ffffffffff
[    0.064003] ... max period:             000000007fffffff
[    0.064003] ... fixed-purpose events:   3
[    0.064003] ... event mask:             0000000700000003
[    0.064003] Booting Node   0, Processors  #1
[    0.064003] smpboot cpu 1: start_ip = 9a000
[    0.152022] Brought up 2 CPUs
[    0.152028] Total of 2 processors activated (12022.70 BogoMIPS).
[    0.153025] devtmpfs: initialized
[    0.153025] PM: Registering ACPI NVS region at cf78e000 (335872 bytes)
[    0.153040] print_constraints: dummy: 
[    0.153062] Time:  2:31:36  Date: 11/26/11
[    0.153091] NET: Registered protocol family 16
[    0.153175] ACPI: bus type pci registered
[    0.153219] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.153224] PCI: not using MMCONFIG
[    0.153226] PCI: Using configuration type 1 for base access
[    0.153836] Trying to unpack rootfs image as initramfs...
[    0.153900] bio: create slab <bio-0> at 0
[    0.157016] ACPI: EC: Look up EC in DSDT
[    0.158021] ACPI: Executed 1 blocks of module-level executable AML code
[    0.160380] ACPI: SSDT 00000000cf790100 001D2 (v01    AMI   CPU1PM 00000001 INTL 20060113)
[    0.160629] ACPI: Dynamic OEM Table Load:
[    0.160633] ACPI: SSDT           (null) 001D2 (v01    AMI   CPU1PM 00000001 INTL 20060113)
[    0.160744] ACPI: SSDT 00000000cf7902e0 00143 (v01    AMI   CPU2PM 00000001 INTL 20060113)
[    0.160985] ACPI: Dynamic OEM Table Load:
[    0.160989] ACPI: SSDT           (null) 00143 (v01    AMI   CPU2PM 00000001 INTL 20060113)
[    0.161098] ACPI: Interpreter enabled
[    0.161102] ACPI: (supports S0 S1 S3 S4 S5)
[    0.161118] ACPI: Using IOAPIC for interrupt routing
[    0.161136] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.161457] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.199960] ACPI: No dock devices found.
[    0.199967] HEST: Table not found.
[    0.199970] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.200042] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.200140] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.200142] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.200144] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.200146] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff] (ignored)
[    0.200148] pci_root PNP0A08:00: host bridge window [mem 0xcf800000-0xffffffff] (ignored)
[    0.200156] pci 0000:00:00.0: [8086:2980] type 0 class 0x000600
[    0.200186] pci 0000:00:02.0: [8086:2982] type 0 class 0x000300
[    0.200194] pci 0000:00:02.0: reg 10: [mem 0xfe800000-0xfe8fffff]
[    0.200202] pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.200206] pci 0000:00:02.0: reg 20: [io  0xcc00-0xcc07]
[    0.200227] pci 0000:00:02.1: [8086:2983] type 0 class 0x000380
[    0.200234] pci 0000:00:02.1: reg 10: [mem 0xfe900000-0xfe9fffff]
[    0.200286] pci 0000:00:1a.0: [8086:2937] type 0 class 0x000c03
[    0.200321] pci 0000:00:1a.0: reg 20: [io  0xc480-0xc49f]
[    0.200358] pci 0000:00:1a.1: [8086:2938] type 0 class 0x000c03
[    0.200393] pci 0000:00:1a.1: reg 20: [io  0xc800-0xc81f]
[    0.200429] pci 0000:00:1a.2: [8086:2939] type 0 class 0x000c03
[    0.200463] pci 0000:00:1a.2: reg 20: [io  0xc880-0xc89f]
[    0.200506] pci 0000:00:1a.7: [8086:293c] type 0 class 0x000c03
[    0.200524] pci 0000:00:1a.7: reg 10: [mem 0xfe7fbc00-0xfe7fbfff]
[    0.200586] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.200590] pci 0000:00:1a.7: PME# disabled
[    0.200609] pci 0000:00:1b.0: [8086:293e] type 0 class 0x000403
[    0.200621] pci 0000:00:1b.0: reg 10: [mem 0xfe7f4000-0xfe7f7fff 64bit]
[    0.200665] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.200668] pci 0000:00:1b.0: PME# disabled
[    0.200685] pci 0000:00:1c.0: [8086:2940] type 1 class 0x000604
[    0.200728] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.200731] pci 0000:00:1c.0: PME# disabled
[    0.200750] pci 0000:00:1c.4: [8086:2948] type 1 class 0x000604
[    0.200797] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.200800] pci 0000:00:1c.4: PME# disabled
[    0.200816] pci 0000:00:1c.5: [8086:294a] type 1 class 0x000604
[    0.200860] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.200863] pci 0000:00:1c.5: PME# disabled
[    0.200881] pci 0000:00:1d.0: [8086:2934] type 0 class 0x000c03
[    0.200916] pci 0000:00:1d.0: reg 20: [io  0xc000-0xc01f]
[    0.200951] pci 0000:00:1d.1: [8086:2935] type 0 class 0x000c03
[    0.200988] pci 0000:00:1d.1: reg 20: [io  0xc080-0xc09f]
[    0.201024] pci 0000:00:1d.2: [8086:2936] type 0 class 0x000c03
[    0.201059] pci 0000:00:1d.2: reg 20: [io  0xc400-0xc41f]
[    0.201102] pci 0000:00:1d.7: [8086:293a] type 0 class 0x000c03
[    0.201119] pci 0000:00:1d.7: reg 10: [mem 0xfe7fb800-0xfe7fbbff]
[    0.201182] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.201185] pci 0000:00:1d.7: PME# disabled
[    0.201201] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    0.201248] pci 0000:00:1f.0: [8086:2916] type 0 class 0x000601
[    0.201318] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 0003)
[    0.201352] pci 0000:00:1f.2: [8086:2920] type 0 class 0x000101
[    0.201364] pci 0000:00:1f.2: reg 10: [io  0xac00-0xac07]
[    0.201371] pci 0000:00:1f.2: reg 14: [io  0xa880-0xa883]
[    0.201377] pci 0000:00:1f.2: reg 18: [io  0xa800-0xa807]
[    0.201384] pci 0000:00:1f.2: reg 1c: [io  0xa480-0xa483]
[    0.201391] pci 0000:00:1f.2: reg 20: [io  0xa400-0xa40f]
[    0.201397] pci 0000:00:1f.2: reg 24: [io  0xa080-0xa08f]
[    0.201427] pci 0000:00:1f.3: [8086:2930] type 0 class 0x000c05
[    0.201439] pci 0000:00:1f.3: reg 10: [mem 0xfe7fb400-0xfe7fb4ff 64bit]
[    0.201456] pci 0000:00:1f.3: reg 20: [io  0x0400-0x041f]
[    0.201482] pci 0000:00:1f.5: [8086:2926] type 0 class 0x000101
[    0.201494] pci 0000:00:1f.5: reg 10: [io  0xbc00-0xbc07]
[    0.201500] pci 0000:00:1f.5: reg 14: [io  0xb880-0xb883]
[    0.201506] pci 0000:00:1f.5: reg 18: [io  0xb800-0xb807]
[    0.201513] pci 0000:00:1f.5: reg 1c: [io  0xb480-0xb483]
[    0.201519] pci 0000:00:1f.5: reg 20: [io  0xb400-0xb40f]
[    0.201525] pci 0000:00:1f.5: reg 24: [io  0xb080-0xb08f]
[    0.201583] pci 0000:00:1c.0: PCI bridge to [bus 03-03]
[    0.201588] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
[    0.201591] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.201596] pci 0000:00:1c.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
[    0.201642] pci 0000:02:00.0: [197b:2368] type 0 class 0x000101
[    0.201669] pci 0000:02:00.0: reg 10: [io  0xdc00-0xdc07]
[    0.201681] pci 0000:02:00.0: reg 14: [io  0xd880-0xd883]
[    0.201693] pci 0000:02:00.0: reg 18: [io  0xd800-0xd807]
[    0.201706] pci 0000:02:00.0: reg 1c: [io  0xd480-0xd483]
[    0.201718] pci 0000:02:00.0: reg 20: [io  0xd400-0xd40f]
[    0.201783] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.201795] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.201799] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.201802] pci 0000:00:1c.4:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.201807] pci 0000:00:1c.4:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.201853] pci 0000:01:00.0: [1969:1048] type 0 class 0x000200
[    0.201873] pci 0000:01:00.0: reg 10: [mem 0xfeac0000-0xfeafffff 64bit]
[    0.201920] pci 0000:01:00.0: reg 30: [mem 0xfeaa0000-0xfeabffff pref]
[    0.201949] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.201954] pci 0000:01:00.0: PME# disabled
[    0.201969] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.201979] pci 0000:00:1c.5: PCI bridge to [bus 01-01]
[    0.201983] pci 0000:00:1c.5:   bridge window [io  0xf000-0x0000] (disabled)
[    0.201986] pci 0000:00:1c.5:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.201991] pci 0000:00:1c.5:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.202021] pci 0000:04:03.0: [1106:3044] type 0 class 0x000c00
[    0.202036] pci 0000:04:03.0: reg 10: [mem 0xfebff800-0xfebfffff]
[    0.202045] pci 0000:04:03.0: reg 14: [io  0xec00-0xec7f]
[    0.202096] pci 0000:04:03.0: supports D2
[    0.202098] pci 0000:04:03.0: PME# supported from D2 D3hot D3cold
[    0.202101] pci 0000:04:03.0: PME# disabled
[    0.202136] pci 0000:00:1e.0: PCI bridge to [bus 04-04] (subtractive decode)
[    0.202141] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.202144] pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.202149] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.202151] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.202153] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xfffffffff] (subtractive decode)
[    0.202168] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.202228] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.202279] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.202302] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.202323] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.202356]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.202360]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
[    0.202364] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.207855] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.207893] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.207927] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.207962] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 *14 15)
[    0.207996] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.208048] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.208082] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 *15)
[    0.208117] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.208199] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.208211] vgaarb: loaded
[    0.208212] vgaarb: bridge control possible 0000:00:02.0
[    0.208356] SCSI subsystem initialized
[    0.208403] libata version 3.00 loaded.
[    0.208436] usbcore: registered new interface driver usbfs
[    0.208445] usbcore: registered new interface driver hub
[    0.208467] usbcore: registered new device driver usb
[    0.208527] PCI: Using ACPI for IRQ routing
[    0.213484] PCI: pci_cache_line_size set to 64 bytes
[    0.213557] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    0.213559] reserve RAM buffer: 00000000cf780000 - 00000000cfffffff 
[    0.213644] NetLabel: Initializing
[    0.213649] NetLabel:  domain hash size = 128
[    0.213651] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.213660] NetLabel:  unlabeled traffic allowed by default
[    0.213693] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.213699] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.213704] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.220158] Switching to clocksource hpet
[    0.223667] Switched to NOHz mode on CPU #0
[    0.223735] Switched to NOHz mode on CPU #1
[    0.224812] AppArmor: AppArmor Filesystem Enabled
[    0.224840] pnp: PnP ACPI init
[    0.224856] ACPI: bus type pnp registered
[    0.224931] pnp 00:00: [bus 00-ff]
[    0.224933] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.224935] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.224936] pnp 00:00: [io  0x0d00-0xffff window]
[    0.224938] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.224940] pnp 00:00: [mem 0x000d0000-0x000dffff window]
[    0.224941] pnp 00:00: [mem 0xcf800000-0xffffffff window]
[    0.224991] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.224999] pnp 00:01: [mem 0xfed14000-0xfed19fff]
[    0.225038] system 00:01: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.225043] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.225067] pnp 00:02: [dma 4]
[    0.225068] pnp 00:02: [io  0x0000-0x000f]
[    0.225070] pnp 00:02: [io  0x0081-0x0083]
[    0.225071] pnp 00:02: [io  0x0087]
[    0.225072] pnp 00:02: [io  0x0089-0x008b]
[    0.225073] pnp 00:02: [io  0x008f]
[    0.225075] pnp 00:02: [io  0x00c0-0x00df]
[    0.225091] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.225098] pnp 00:03: [io  0x0070-0x0071]
[    0.225108] pnp 00:03: [irq 8]
[    0.225126] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.225134] pnp 00:04: [io  0x0061]
[    0.225151] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.225157] pnp 00:05: [io  0x00f0-0x00ff]
[    0.225161] pnp 00:05: [irq 13]
[    0.225179] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.225370] pnp 00:06: [irq 6]
[    0.225372] pnp 00:06: [dma 2]
[    0.225374] pnp 00:06: [io  0x03f0-0x03f5]
[    0.225375] pnp 00:06: [io  0x03f7]
[    0.225412] pnp 00:06: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.225434] pnp 00:07: [io  0x0000-0xffffffffffffffff disabled]
[    0.225436] pnp 00:07: [io  0x0000-0xffffffffffffffff disabled]
[    0.225437] pnp 00:07: [io  0x0290-0x0297]
[    0.225467] system 00:07: [io  0x0290-0x0297] has been reserved
[    0.225471] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.225538] pnp 00:08: [io  0x0010-0x001f]
[    0.225539] pnp 00:08: [io  0x0022-0x003f]
[    0.225541] pnp 00:08: [io  0x0044-0x004d]
[    0.225542] pnp 00:08: [io  0x0050-0x005f]
[    0.225543] pnp 00:08: [io  0x0062-0x0063]
[    0.225544] pnp 00:08: [io  0x0065-0x006f]
[    0.225546] pnp 00:08: [io  0x0072-0x007f]
[    0.225547] pnp 00:08: [io  0x0080]
[    0.225548] pnp 00:08: [io  0x0084-0x0086]
[    0.225549] pnp 00:08: [io  0x0088]
[    0.225551] pnp 00:08: [io  0x008c-0x008e]
[    0.225552] pnp 00:08: [io  0x0090-0x009f]
[    0.225553] pnp 00:08: [io  0x00a2-0x00bf]
[    0.225554] pnp 00:08: [io  0x00e0-0x00ef]
[    0.225556] pnp 00:08: [io  0x04d0-0x04d1]
[    0.225557] pnp 00:08: [io  0x0800-0x087f]
[    0.225558] pnp 00:08: [io  0x0400-0x03ff disabled]
[    0.225559] pnp 00:08: [io  0x0480-0x04bf]
[    0.225561] pnp 00:08: [mem 0xfed1c000-0xfed1ffff]
[    0.225562] pnp 00:08: [mem 0xfed20000-0xfed3ffff]
[    0.225564] pnp 00:08: [mem 0xfed50000-0xfed8ffff]
[    0.225565] pnp 00:08: [mem 0xffa00000-0xffafffff]
[    0.225566] pnp 00:08: [mem 0xffb00000-0xffbfffff]
[    0.225568] pnp 00:08: [mem 0xffe00000-0xffefffff]
[    0.225569] pnp 00:08: [mem 0xfff00000-0xfffffffe]
[    0.225620] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.225624] system 00:08: [io  0x0800-0x087f] has been reserved
[    0.225627] system 00:08: [io  0x0480-0x04bf] has been reserved
[    0.225630] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.225635] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.225639] system 00:08: [mem 0xfed50000-0xfed8ffff] has been reserved
[    0.225642] system 00:08: [mem 0xffa00000-0xffafffff] has been reserved
[    0.225645] system 00:08: [mem 0xffb00000-0xffbfffff] has been reserved
[    0.225649] system 00:08: [mem 0xffe00000-0xffefffff] has been reserved
[    0.225652] system 00:08: [mem 0xfff00000-0xfffffffe] has been reserved
[    0.225656] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.225700] pnp 00:09: [mem 0xfed00000-0xfed003ff]
[    0.225725] pnp 00:09: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.225886] pnp 00:0a: [irq 4]
[    0.225888] pnp 00:0a: [dma 0 disabled]
[    0.225890] pnp 00:0a: [io  0x03f8-0x03ff]
[    0.225935] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.225964] pnp 00:0b: [mem 0xfec00000-0xfec00fff]
[    0.225966] pnp 00:0b: [mem 0xfee00000-0xfee00fff]
[    0.225996] system 00:0b: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.226000] system 00:0b: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.226004] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.226024] pnp 00:0c: [io  0x0060]
[    0.226028] pnp 00:0c: [io  0x0064]
[    0.226032] pnp 00:0c: [irq 1]
[    0.226057] pnp 00:0c: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.226087] pnp 00:0d: [irq 12]
[    0.226109] pnp 00:0d: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.226131] pnp 00:0e: [mem 0xe0000000-0xefffffff]
[    0.226165] system 00:0e: [mem 0xe0000000-0xefffffff] has been reserved
[    0.226169] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.226491] pnp 00:0f: [mem 0x00000000-0x0009ffff]
[    0.226493] pnp 00:0f: [mem 0x000c0000-0x000cffff]
[    0.226494] pnp 00:0f: [mem 0x000e0000-0x000fffff]
[    0.226496] pnp 00:0f: [mem 0x00100000-0xcf7fffff]
[    0.226497] pnp 00:0f: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.226538] system 00:0f: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.226542] system 00:0f: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.226545] system 00:0f: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.226549] system 00:0f: [mem 0x00100000-0xcf7fffff] could not be reserved
[    0.226553] system 00:0f: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.226639] pnp: PnP ACPI: found 16 devices
[    0.226642] ACPI: ACPI bus type pnp unregistered
[    0.232170] PCI: max bus depth: 1 pci_try_num: 2
[    0.232203] pci 0000:00:1c.5: BAR 15: assigned [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.232210] pci 0000:00:1c.5: BAR 13: assigned [io  0x1000-0x1fff]
[    0.232214] pci 0000:00:1c.4: BAR 14: assigned [mem 0xf0200000-0xf03fffff]
[    0.232218] pci 0000:00:1c.4: BAR 15: assigned [mem 0xf0400000-0xf05fffff 64bit pref]
[    0.232223] pci 0000:00:1c.0: BAR 14: assigned [mem 0xf0600000-0xf09fffff]
[    0.232226] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.232229] pci 0000:00:1c.0: PCI bridge to [bus 03-03]
[    0.232233] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.232238] pci 0000:00:1c.0:   bridge window [mem 0xf0600000-0xf09fffff]
[    0.232242] pci 0000:00:1c.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
[    0.232249] pci 0000:00:1c.4: PCI bridge to [bus 02-02]
[    0.232252] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.232257] pci 0000:00:1c.4:   bridge window [mem 0xf0200000-0xf03fffff]
[    0.232261] pci 0000:00:1c.4:   bridge window [mem 0xf0400000-0xf05fffff 64bit pref]
[    0.232268] pci 0000:00:1c.5: PCI bridge to [bus 01-01]
[    0.232271] pci 0000:00:1c.5:   bridge window [io  0x1000-0x1fff]
[    0.232276] pci 0000:00:1c.5:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.232280] pci 0000:00:1c.5:   bridge window [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.232287] pci 0000:00:1e.0: PCI bridge to [bus 04-04]
[    0.232290] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.232295] pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.232300] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.232310] pci 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.232324] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.232329] pci 0000:00:1c.0: setting latency timer to 64
[    0.232333] pci 0000:00:1c.4: enabling device (0105 -> 0107)
[    0.232337] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.232342] pci 0000:00:1c.4: setting latency timer to 64
[    0.232346] pci 0000:00:1c.5: enabling device (0106 -> 0107)
[    0.232352] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.232356] pci 0000:00:1c.5: setting latency timer to 64
[    0.232361] pci 0000:00:1e.0: setting latency timer to 64
[    0.232364] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.232366] pci_bus 0000:00: resource 1 [mem 0x00000000-0xfffffffff]
[    0.232368] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.232369] pci_bus 0000:03: resource 1 [mem 0xf0600000-0xf09fffff]
[    0.232371] pci_bus 0000:03: resource 2 [mem 0xfdf00000-0xfdffffff 64bit pref]
[    0.232373] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.232374] pci_bus 0000:02: resource 1 [mem 0xf0200000-0xf03fffff]
[    0.232376] pci_bus 0000:02: resource 2 [mem 0xf0400000-0xf05fffff 64bit pref]
[    0.232378] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.232379] pci_bus 0000:01: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.232381] pci_bus 0000:01: resource 2 [mem 0xf0000000-0xf01fffff 64bit pref]
[    0.232383] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.232384] pci_bus 0000:04: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.232386] pci_bus 0000:04: resource 4 [io  0x0000-0xffff]
[    0.232388] pci_bus 0000:04: resource 5 [mem 0x00000000-0xfffffffff]
[    0.232420] NET: Registered protocol family 2
[    0.232607] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.234178] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.237281] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.237671] TCP: Hash tables configured (established 524288 bind 65536)
[    0.237674] TCP reno registered
[    0.237691] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.237757] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.237901] NET: Registered protocol family 1
[    0.237918] pci 0000:00:02.0: Boot video device
[    0.238056] PCI: CLS 32 bytes, default 64
[    0.238059] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.238062] Placing 64MB software IO TLB between ffff8800cb77a000 - ffff8800cf77a000
[    0.238066] software IO TLB at phys 0xcb77a000 - 0xcf77a000
[    0.238308] audit: initializing netlink socket (disabled)
[    0.238318] type=2000 audit(1322274696.232:1): initialized
[    0.271349] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.306375] VFS: Disk quotas dquot_6.5.2
[    0.306421] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.306847] fuse init (API version 7.16)
[    0.306907] msgmni has been set to 15950
[    0.307133] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.307153] io scheduler noop registered
[    0.307156] io scheduler deadline registered (default)
[    0.307186] io scheduler cfq registered
[    0.307269] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.307303] pcieport 0000:00:1c.0: irq 40 for MSI/MSI-X
[    0.307349] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.307378] pcieport 0000:00:1c.4: irq 41 for MSI/MSI-X
[    0.307419] pcieport 0000:00:1c.5: setting latency timer to 64
[    0.307447] pcieport 0000:00:1c.5: irq 42 for MSI/MSI-X
[    0.307503] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.307521] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.307554] intel_idle: MWAIT substates: 0x220
[    0.307556] intel_idle: does not run on family 6 model 15
[    0.307621] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    0.307628] ACPI: Power Button [PWRB]
[    0.307659] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.307665] ACPI: Power Button [PWRF]
[    0.307686] ACPI: acpi_idle registered with cpuidle
[    0.309102] ERST: Table is not found!
[    0.309154] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.329478] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.393281] Freeing initrd memory: 13948k freed
[    0.476439] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.476679] Linux agpgart interface v0.103
[    0.476734] agpgart-intel 0000:00:00.0: Intel G35 Chipset
[    0.476842] agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
[    0.477686] agpgart-intel 0000:00:00.0: detected 8192K stolen memory
[    0.477780] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    0.478506] brd: module loaded
[    0.478832] loop: module loaded
[    0.478962] ata_piix 0000:00:1f.2: version 2.13
[    0.478979] ata_piix 0000:00:1f.2: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    0.478984] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    0.479018] ata_piix 0000:00:1f.2: setting latency timer to 64
[    0.479214] scsi0 : ata_piix
[    0.479275] scsi1 : ata_piix
[    0.479819] ata1: SATA max UDMA/133 cmd 0xac00 ctl 0xa880 bmdma 0xa400 irq 22
[    0.479825] ata2: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa408 irq 22
[    0.479842] ata_piix 0000:00:1f.5: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    0.479847] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    0.479877] ata_piix 0000:00:1f.5: setting latency timer to 64
[    0.480017] scsi2 : ata_piix
[    0.480064] scsi3 : ata_piix
[    0.480568] ata3: SATA max UDMA/133 cmd 0xbc00 ctl 0xb880 bmdma 0xb400 irq 22
[    0.480573] ata4: SATA max UDMA/133 cmd 0xb800 ctl 0xb480 bmdma 0xb408 irq 22
[    0.480607] pata_acpi 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.480630] pata_acpi 0000:02:00.0: setting latency timer to 64
[    0.480641] pata_acpi 0000:02:00.0: PCI INT A disabled
[    0.480831] Fixed MDIO Bus: probed
[    0.480847] PPP generic driver version 2.4.2
[    0.480877] tun: Universal TUN/TAP device driver, 1.6
[    0.480879] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.480945] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.480962] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.480976] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.480979] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.481004] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.481027] ehci_hcd 0000:00:1a.7: debug port 1
[    0.484907] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.484917] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfe7fbc00
[    0.500032] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.500150] hub 1-0:1.0: USB hub found
[    0.500157] hub 1-0:1.0: 6 ports detected
[    0.500229] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.500247] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.500250] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.500279] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.500300] ehci_hcd 0000:00:1d.7: debug port 1
[    0.504193] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.504204] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfe7fb800
[    0.520021] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.520112] hub 2-0:1.0: USB hub found
[    0.520118] hub 2-0:1.0: 6 ports detected
[    0.520185] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.520201] uhci_hcd: USB Universal Host Controller Interface driver
[    0.520223] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.520236] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.520238] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.520264] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.520292] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000c480
[    0.520369] hub 3-0:1.0: USB hub found
[    0.520373] hub 3-0:1.0: 2 ports detected
[    0.520418] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    0.520424] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    0.520426] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.520450] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.520477] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000c800
[    0.520555] hub 4-0:1.0: USB hub found
[    0.520559] hub 4-0:1.0: 2 ports detected
[    0.520601] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.520607] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    0.520610] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.520636] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.520657] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000c880
[    0.520732] hub 5-0:1.0: USB hub found
[    0.520736] hub 5-0:1.0: 2 ports detected
[    0.520776] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.520782] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.520785] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.520808] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.520828] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000c000
[    0.520906] hub 6-0:1.0: USB hub found
[    0.520910] hub 6-0:1.0: 2 ports detected
[    0.520953] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.520959] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.520962] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.520987] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.521016] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000c080
[    0.521094] hub 7-0:1.0: USB hub found
[    0.521098] hub 7-0:1.0: 2 ports detected
[    0.521139] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.521145] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.521148] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.521169] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.521191] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000c400
[    0.521265] hub 8-0:1.0: USB hub found
[    0.521269] hub 8-0:1.0: 2 ports detected
[    0.521341] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    0.524097] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.524103] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.524146] mousedev: PS/2 mouse device common for all mice
[    0.524215] rtc_cmos 00:03: RTC can wake from S4
[    0.524285] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.524306] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.524374] device-mapper: uevent: version 1.0.3
[    0.524422] device-mapper: ioctl: 4.20.0-ioctl (2011-02-02) initialised: dm-devel@redhat.com
[    0.524430] cpuidle: using governor ladder
[    0.524433] cpuidle: using governor menu
[    0.524435] EFI Variables Facility v0.08 2004-May-17
[    0.524608] TCP cubic registered
[    0.524692] NET: Registered protocol family 10
[    0.525025] NET: Registered protocol family 17
[    0.525037] Registering the dns_resolver key type
[    0.525106] PM: Hibernation image not present or could not be loaded.
[    0.525115] registered taskstats version 1
[    0.545255]   Magic number: 3:671:511
[    0.545341] rtc_cmos 00:03: setting system clock to 2011-11-26 02:31:37 UTC (1322274697)
[    0.545654] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.545657] EDD information not available.
[    0.814542] ata4: SATA link down (SStatus 0 SControl 300)
[    0.825080] ata3: SATA link down (SStatus 0 SControl 300)
[    1.000020] usb 4-2: new low speed USB device number 2 using uhci_hcd
[    1.134585] ata1.00: SATA link down (SStatus 0 SControl 300)
[    1.134597] ata1.01: SATA link down (SStatus 0 SControl 300)
[    1.145192] ata2.00: SATA link down (SStatus 0 SControl 300)
[    1.145204] ata2.01: SATA link down (SStatus 0 SControl 300)
[    1.146408] Freeing unused kernel memory: 904k freed
[    1.146573] Write protecting the kernel read-only data: 12288k
[    1.151666] Freeing unused kernel memory: 1984k freed
[    1.155519] Freeing unused kernel memory: 1372k freed
[    1.167106] udevd[88]: starting version 173
[    1.179117] Btrfs loaded
[    1.218460] atl1 0000:01:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.218474] atl1 0000:01:00.0: setting latency timer to 64
[    1.218541] atl1 0000:01:00.0: version 2.1.3
[    1.220834] pata_jmicron 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.220869] pata_jmicron 0000:02:00.0: setting latency timer to 64
[    1.224167] scsi4 : pata_jmicron
[    1.224482] scsi5 : pata_jmicron
[    1.224697] ata5: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmdma 0xd400 irq 16
[    1.224702] ata6: PATA max UDMA/100 cmd 0xd800 ctl 0xd480 bmdma 0xd408 irq 16
[    1.241904] Floppy drive(s): fd0 is 1.44M
[    1.252033] Refined TSC clocksource calibration: 3005.554 MHz.
[    1.252041] Switching to clocksource tsc
[    1.259714] FDC 0 is a post-1991 82077
[    1.262495] usbcore: registered new interface driver usbhid
[    1.262500] usbhid: USB HID core driver
[    1.439095] ata5.00: ATA-7: ST3500830A, 3.AAC, max UDMA/100
[    1.439100] ata5.00: 976773168 sectors, multi 16: LBA48 
[    1.439108] ata5.01: ATAPI: HL-DT-STDVD-RAM GH22LP20, 1.00, max UDMA/66
[    1.505680] ata5.00: configured for UDMA/100
[    1.520549] ata5.01: configured for UDMA/66
[    1.521662] scsi 4:0:0:0: Direct-Access     ATA      ST3500830A       3.AA PQ: 0 ANSI: 5
[    1.521779] sd 4:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    1.521807] sd 4:0:0:0: Attached scsi generic sg0 type 0
[    1.521835] sd 4:0:0:0: [sda] Write Protect is off
[    1.521840] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.521864] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.523033] scsi 4:0:1:0: CD-ROM            HL-DT-ST DVD-RAM GH22LP20 1.00 PQ: 0 ANSI: 5
[    1.572000]  sda: sda1 sda2 sda3 sda4
[    1.573347] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.573354] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.573434] sr 4:0:1:0: Attached scsi CD-ROM sr0
[    1.573488] sr 4:0:1:0: Attached scsi generic sg1 type 5
[    1.574354] sd 4:0:0:0: [sda] Attached SCSI disk
[    1.729487] firewire_ohci 0000:04:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.744722] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/input/input2
[    1.744796] logitech 0003:046D:C517.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1a.1-2/input0
[    1.776511] logitech 0003:046D:C517.0002: fixing up Logitech keyboard report descriptor
[    1.776967] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.1/input/input3
[    1.777079] logitech 0003:046D:C517.0002: input,hiddev0,hidraw1: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1a.1-2/input1
[    1.792083] firewire_ohci: Added fw-ohci device 0000:04:03.0, OHCI v1.10, 4 IR + 8 IT contexts, quirks 0x11
[    2.292101] firewire_core: created device fw0: GUID 0011d8000193d069, S400
[    2.746990] device fsid cf737bad-a4d2-4fbb-9e70-252d4c2f3334 devid 1 transid 148962 /dev/sda3
[   15.348522] end_request: I/O error, dev fd0, sector 0
[   15.396979] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   20.158773] Adding 9381884k swap on /dev/sda4.  Priority:-1 extents:1 across:9381884k 
[   20.166302] udevd[355]: starting version 173
[   20.546965] Bridge firewalling registered
[   20.548856] device eth0 entered promiscuous mode
[   20.550459] atl1 0000:01:00.0: irq 43 for MSI/MSI-X
[   20.550555] atl1 0000:01:00.0: eth0 link is up 1000 Mbps full duplex
[   20.553601] br0: topology change detected, propagating
[   20.553604] br0: port 1(eth0) entering forwarding state
[   20.553607] br0: port 1(eth0) entering forwarding state
[   20.588317] type=1400 audit(1322274717.541:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=644 comm="apparmor_parser"
[   20.588352] type=1400 audit(1322274717.541:3): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=676 comm="apparmor_parser"
[   20.588507] type=1400 audit(1322274717.541:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=644 comm="apparmor_parser"
[   20.588563] type=1400 audit(1322274717.541:5): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=676 comm="apparmor_parser"
[   20.588627] type=1400 audit(1322274717.541:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=644 comm="apparmor_parser"
[   20.588686] type=1400 audit(1322274717.541:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=676 comm="apparmor_parser"
[   20.589535] type=1400 audit(1322274717.541:8): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=602 comm="apparmor_parser"
[   20.589744] type=1400 audit(1322274717.541:9): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=602 comm="apparmor_parser"
[   20.589879] type=1400 audit(1322274717.541:10): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=602 comm="apparmor_parser"
[   20.654910] lp: driver loaded but no devices found
[   20.740934] [drm] Initialized drm 1.1.0 20060810
[   20.837687] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   20.837691] i915 0000:00:02.0: setting latency timer to 64
[   20.898991] i915 0000:00:02.0: irq 44 for MSI/MSI-X
[   20.898996] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   20.898997] [drm] Driver supports precise vblank timestamp query.
[   20.899024] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   21.111320] [drm] initialized overlay support
[   21.454755] fbcon: inteldrmfb (fb0) is primary device
[   21.507504] Console: switching to colour frame buffer device 128x48
[   21.509135] fb0: inteldrmfb frame buffer device
[   21.509137] drm: registered panic notifier
[   21.509148] No ACPI video bus found
[   21.509213] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   21.509884] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   21.509936] HDA Intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[   21.509957] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   21.540726] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   21.653676] hda_codec: ALC883: BIOS auto-probing.
[   21.710696] HDMI status: Pin=3 Presence_Detect=0 ELD_Valid=0
[   21.710850] input: HDA Intel HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input4
[   21.711044] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   21.805559] device fsid cf737bad-a4d2-4fbb-9e70-252d4c2f3334 devid 1 transid 148962 /dev/sda3
[   23.189511] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   23.272173] type=1400 audit(1322274720.225:11): apparmor="STATUS" operation="profile_load" name="/usr/lib/libvirt/virt-aa-helper" pid=890 comm="apparmor_parser"
[   23.347761] init: failsafe main process (840) killed by TERM signal
[   23.348908] init: apport pre-start process (932) terminated with status 1
[   23.357785] init: apport post-stop process (970) terminated with status 1
[   23.522848] ip_tables: (C) 2000-2006 Netfilter Core Team
[   23.648582] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   23.766042] ADDRCONF(NETDEV_UP): virbr0: link is not ready
[   24.138100] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   30.960012] br0: no IPv6 routers present
[   51.572129] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
[   51.587234] ceph: loaded (mds proto 32)
[   51.598655] libceph: client7709 fsid c09c2197-3976-3779-d7b1-26700db70b68
[   51.598875] libceph: mon0 192.168.2.11:6789 session established
[  245.149999] libceph: client7710 fsid c09c2197-3976-3779-d7b1-26700db70b68
[  245.150219] libceph: mon0 192.168.2.11:6789 session established
[  534.421654] libceph: client7719 fsid c09c2197-3976-3779-d7b1-26700db70b68
[  534.421696] libceph: mon0 192.168.2.11:6789 session established
[  636.651226] init: tty4 main process ended, respawning
[  651.944918] init: tty3 main process ended, respawning
[  657.017011] init: tty2 main process ended, respawning
[  658.870689] init: tty2 main process ended, respawning
[  663.416957] init: tty1 main process ended, respawning
[  665.438708] init: tty1 main process ended, respawning
[ 2007.419280] show_signal_msg: 15 callbacks suppressed
[ 2007.419285] fsck.btrfs[3727]: segfault at c9 ip 0000000000412f2d sp 00007fffafb96738 error 4 in btrfsck[400000+1f000]
[ 2209.940609] end_request: I/O error, dev fd0, sector 0
[ 2250.326600] device fsid 209ccabc-11e0-495d-ae5a-216768304fda devid 1 transid 7 /dev/sda3
[ 5538.641217] fsck.btrfs[5345]: segfault at b4 ip 000000000040f486 sp 00007fffe8468890 error 4 in btrfsck[400000+1f000]
[ 5559.655594] fsck.btrfs[5351]: segfault at c4 ip 000000000040df31 sp 00007fffe8539790 error 4 in btrfsck[400000+1f000]
[43735.359711] libceph: client7822 fsid c09c2197-3976-3779-d7b1-26700db70b68
[43735.359930] libceph: mon0 192.168.2.11:6789 session established
[203473.279209] libceph: client7843 fsid c09c2197-3976-3779-d7b1-26700db70b68
[203473.279428] libceph: mon0 192.168.2.11:6789 session established


--------------040409000900070505000503--
