From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: No space left while there are still available disk space
Date: Wed, 6 Oct 2010 12:59:27 +0800
Message-ID: <AANLkTikcFKstqiuX1nM9CR-RUsADnHdmdwCtbEEWKeVX@mail.gmail.com>
References: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
	<AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
	<AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33644 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255Ab0JFE73 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 00:59:29 -0400
Received: by wwj40 with SMTP id 40so6633068wwj.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Oct 2010 21:59:27 -0700 (PDT)
In-Reply-To: <AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

I found an interesting thing:

When I dumped the osdmap by "ceph osd dump -o -", it shows:

epoch 93
fsid d816eead-65ca-4332-d88c-049b93f21dc5
created 2010-09-28 10:29:57.497048
modifed 2010-10-06 04:04:37.826118
flags

pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
rjenkins pg_num 2944 pgp_num 2944 lpg_num 2 lpgp_num 2 last_change 12
owner 0)
pg_pool 1 'metadata' pg_pool(rep pg_size 3 crush_ruleset 1 object_hash
rjenkins pg_num 2944 pgp_num 2944 lpg_num 2 lpgp_num 2 last_change 6
owner 0)
pg_pool 2 'casdata' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash
rjenkins pg_num 2944 pgp_num 2944 lpg_num 2 lpgp_num 2 last_change 1
owner 0)
pg_pool 3 'rbd' pg_pool(rep pg_size 2 crush_ruleset 3 object_hash
rjenkins pg_num 2944 pgp_num 2944 lpg_num 2 lpgp_num 2 last_change 1
owner 0)

max_osd 46
osd0 in weight 1 up   (up_from 24 up_thru 88 down_at 23 last_clean
3-22) 192.168.1.39:6800/29826 192.168.1.39:6801/29826
osd1 in weight 1 up   (up_from 17 up_thru 52 down_at 16 last_clean
5-15) 192.168.1.32:6800/29592 192.168.1.32:6801/29592
osd2 in weight 1 up   (up_from 23 up_thru 88 down_at 22 last_clean
3-21) 192.168.1.8:6800/29918 192.168.1.8:6801/29918
osd3 in weight 1 up   (up_from 24 up_thru 86 down_at 23 last_clean
5-22) 192.168.1.12:6800/29988 192.168.1.12:6801/29988
osd4 in weight 1 up   (up_from 23 up_thru 87 down_at 22 last_clean
3-21) 192.168.1.28:6800/29316 192.168.1.28:6801/29316
osd5 in weight 1 up   (up_from 23 up_thru 86 down_at 22 last_clean
3-21) 192.168.1.19:6800/28770 192.168.1.19:6801/28770
osd6 in weight 1 up   (up_from 22 up_thru 86 down_at 21 last_clean
3-20) 192.168.1.7:6800/29777 192.168.1.7:6801/29777
osd7 in weight 1 up   (up_from 23 up_thru 88 down_at 22 last_clean
3-21) 192.168.1.35:6800/29820 192.168.1.35:6801/29820
osd8 in weight 1 up   (up_from 22 up_thru 88 down_at 21 last_clean
3-20) 192.168.1.5:6800/29424 192.168.1.5:6801/29424
osd9 in weight 1 up   (up_from 22 up_thru 87 down_at 21 last_clean
3-20) 192.168.1.43:6800/29160 192.168.1.43:6801/29160
osd10 in weight 1 up   (up_from 18 up_thru 88 down_at 17 last_clean
3-16) 192.168.1.21:6800/29242 192.168.1.21:6801/29242
osd11 in weight 1 up   (up_from 18 up_thru 87 down_at 17 last_clean
3-16) 192.168.1.41:6800/28935 192.168.1.41:6801/28935
osd12 in weight 1 up   (up_from 19 up_thru 88 down_at 18 last_clean
4-17) 192.168.1.11:6800/29683 192.168.1.11:6801/29683
osd13 in weight 1 up   (up_from 19 up_thru 87 down_at 18 last_clean
3-17) 192.168.1.26:6800/29197 192.168.1.26:6801/29197
osd14 in weight 1 up   (up_from 17 up_thru 87 down_at 16 last_clean
3-15) 192.168.1.36:6800/29550 192.168.1.36:6801/29550
osd15 in weight 1 up   (up_from 18 up_thru 87 down_at 17 last_clean
2-16) 192.168.1.10:6800/29632 192.168.1.10:6801/29632
osd16 in weight 1 up   (up_from 18 up_thru 87 down_at 17 last_clean
3-16) 192.168.1.3:6800/29275 192.168.1.3:6801/29275
osd17 in weight 1 up   (up_from 18 up_thru 88 down_at 17 last_clean
3-16) 192.168.1.20:6800/29213 192.168.1.20:6801/29213
osd18 in weight 1 up   (up_from 19 up_thru 88 down_at 18 last_clean
3-17) 192.168.1.13:6800/29712 192.168.1.13:6801/29712
osd19 in weight 1 up   (up_from 19 up_thru 85 down_at 18 last_clean
5-17) 192.168.1.33:6800/29688 192.168.1.33:6801/29688
osd20 in weight 1 up   (up_from 16 up_thru 87 down_at 15 last_clean
3-14) 192.168.1.23:6800/29133 192.168.1.23:6801/29133
osd21 in weight 1 up   (up_from 16 up_thru 88 down_at 15 last_clean
5-14) 192.168.1.22:6800/29183 192.168.1.22:6801/29183
osd22 in weight 1 up   (up_from 17 up_thru 88 down_at 16 last_clean
3-15) 192.168.1.31:6800/29519 192.168.1.31:6801/29519
osd23 in weight 1 up   (up_from 16 up_thru 85 down_at 15 last_clean
3-14) 192.168.1.37:6800/28998 192.168.1.37:6801/28998
osd24 in weight 1 up   (up_from 15 up_thru 88 down_at 14 last_clean
5-13) 192.168.1.25:6800/29084 192.168.1.25:6801/29084
osd25 in weight 1 up   (up_from 15 up_thru 87 down_at 14 last_clean
3-13) 192.168.1.14:6800/29552 192.168.1.14:6801/29552
osd26 in weight 1 up   (up_from 20 up_thru 85 down_at 19 last_clean
3-18) 192.168.1.45:6800/29735 192.168.1.45:6801/29735
osd27 in weight 1 up   (up_from 15 up_thru 85 down_at 14 last_clean
5-13) 192.168.1.2:6800/29237 192.168.1.2:6801/29237
osd28 in weight 1 up   (up_from 15 up_thru 88 down_at 14 last_clean
3-13) 192.168.1.46:6800/29583 192.168.1.46:6801/29583
osd29 in weight 1 up   (up_from 15 up_thru 87 down_at 14 last_clean
3-13) 192.168.1.42:6800/29351 192.168.1.42:6801/29351
osd30 out down (up_from 69 up_thru 75 down_at 77 last_clean 46-68)
osd31 in weight 1 up   (up_from 22 up_thru 88 down_at 21 last_clean
3-20) 192.168.1.15:6800/29749 192.168.1.15:6801/29749
osd32 in weight 1 up   (up_from 21 up_thru 86 down_at 20 last_clean
3-19) 192.168.1.30:6800/29719 192.168.1.30:6801/29719
osd33 in weight 1 up   (up_from 21 up_thru 87 down_at 20 last_clean
3-19) 192.168.1.38:6800/29690 192.168.1.38:6801/29690
osd34 in weight 1 up   (up_from 20 up_thru 88 down_at 19 last_clean
3-18) 192.168.1.40:6800/29614 192.168.1.40:6801/29614
osd35 in weight 1 up   (up_from 21 up_thru 88 down_at 20 last_clean
5-19) 192.168.1.1:6800/29618 192.168.1.1:6801/29618
osd36 in weight 1 up   (up_from 20 up_thru 87 down_at 19 last_clean
3-18) 192.168.1.44:6800/29049 192.168.1.44:6801/29049
osd37 in weight 1 up   (up_from 20 up_thru 87 down_at 19 last_clean
5-18) 192.168.1.47:6800/29594 192.168.1.47:6801/29594
osd38 in weight 1 up   (up_from 20 up_thru 87 down_at 19 last_clean
5-18) 192.168.1.4:6800/29380 192.168.1.4:6801/29380
osd39 in weight 1 up   (up_from 20 up_thru 87 down_at 19 last_clean
4-18) 192.168.1.17:6800/29231 192.168.1.17:6801/29231
osd40 in weight 1 up   (up_from 25 up_thru 86 down_at 24 last_clean
3-23) 192.168.1.34:6800/29844 192.168.1.34:6801/29844
osd41 in weight 1 up   (up_from 25 up_thru 87 down_at 24 last_clean
5-23) 192.168.1.24:6800/29515 192.168.1.24:6801/29515
osd42 in weight 1 up   (up_from 25 up_thru 85 down_at 24 last_clean
5-23) 192.168.1.6:6800/29662 192.168.1.6:6801/29662
osd43 in weight 1 up   (up_from 25 up_thru 88 down_at 24 last_clean
5-23) 192.168.1.18:6800/29484 192.168.1.18:6801/29484
osd44 in weight 1 up   (up_from 25 up_thru 87 down_at 24 last_clean
6-23) 192.168.1.29:6800/29899 192.168.1.29:6801/29899
osd45 in weight 1 up   (up_from 24 up_thru 84 down_at 23 last_clean
6-22) 192.168.1.27:6800/29790 192.168.1.27:6801/29790

But, when I mounted debugfs on client side and checked the osdmap, it
stays in epoch 90:

epoch 90
flags FULL
pg_pool 0 pg_num 2944 / 4095, lpg_num 2 / 1
pg_pool 1 pg_num 2944 / 4095, lpg_num 2 / 1
pg_pool 2 pg_num 2944 / 4095, lpg_num 2 / 1
pg_pool 3 pg_num 2944 / 4095, lpg_num 2 / 1
        osd0    192.168.1.39:6800       100%    (exists, up)
        osd1    192.168.1.32:6800       100%    (exists, up)
        osd2    192.168.1.8:6800        100%    (exists, up)
        osd3    192.168.1.12:6800       100%    (exists, up)
        osd4    192.168.1.28:6800       100%    (exists, up)
        osd5    192.168.1.19:6800       100%    (exists, up)
        osd6    192.168.1.7:6800        100%    (exists, up)
        osd7    192.168.1.35:6800       100%    (exists, up)
        osd8    192.168.1.5:6800        100%    (exists, up)
        osd9    192.168.1.43:6800       100%    (exists, up)
        osd10   192.168.1.21:6800       100%    (exists, up)
        osd11   192.168.1.41:6800       100%    (exists, up)
        osd12   192.168.1.11:6800       100%    (exists, up)
        osd13   192.168.1.26:6800       100%    (exists, up)
        osd14   192.168.1.36:6800       100%    (exists, up)
        osd15   192.168.1.10:6800       100%    (exists, up)
        osd16   192.168.1.3:6800        100%    (exists, up)
        osd17   192.168.1.20:6800       100%    (exists, up)
        osd18   192.168.1.13:6800       100%    (exists, up)
        osd19   192.168.1.33:6800       100%    (exists, up)
        osd20   192.168.1.23:6800       100%    (exists, up)
        osd21   192.168.1.22:6800       100%    (exists, up)
        osd22   192.168.1.31:6800       100%    (exists, up)
        osd23   192.168.1.37:6800       100%    (exists, up)
        osd24   192.168.1.25:6800       100%    (exists, up)
        osd25   192.168.1.14:6800       100%    (exists, up)
        osd26   192.168.1.45:6800       100%    (exists, up)
        osd27   192.168.1.2:6800        100%    (exists, up)
        osd28   192.168.1.46:6800       100%    (exists, up)
        osd29   192.168.1.42:6800       100%    (exists, up)
        osd30   192.168.1.9:6800          0%    (exists)
        osd31   192.168.1.15:6800       100%    (exists, up)
        osd32   192.168.1.30:6800       100%    (exists, up)
        osd33   192.168.1.38:6800       100%    (exists, up)
        osd34   192.168.1.40:6800       100%    (exists, up)
        osd35   192.168.1.1:6800        100%    (exists, up)
        osd36   192.168.1.44:6800       100%    (exists, up)
        osd37   192.168.1.47:6800       100%    (exists, up)
        osd38   192.168.1.4:6800        100%    (exists, up)
        osd39   192.168.1.17:6800       100%    (exists, up)
        osd40   192.168.1.34:6800       100%    (exists, up)
        osd41   192.168.1.24:6800       100%    (exists, up)
        osd42   192.168.1.6:6800        100%    (exists, up)
        osd43   192.168.1.18:6800       100%    (exists, up)
        osd44   192.168.1.29:6800       100%    (exists, up)
        osd45   192.168.1.27:6800       100%    (exists, up)

On Wed, Oct 6, 2010 at 12:57 PM, Leander Yu <leander.yu@gmail.com> wrot=
e:
> Thanks, we found that even after I clean some disk space and make sur=
e
> all the osd disk usage is less than 90%, I still can not write any
> data to the filesystem(not a single byte).
> Henry have check the kernel client debug info and found the osdmap is
> out of date and the flag is keep at full.
> He will post more detail information later.
> I guess there are some error handling problem there so that the clien=
t
> didn't keep updating the osdmap when disk is fulled.
>
> Any suggestion for further trouble shooting ?
>
> Regards,
> Leander Yu.
>
> On Wed, Oct 6, 2010 at 12:48 PM, Gregory Farnum <gregf@hq.newdream.ne=
t> wrote:
>> On Tue, Oct 5, 2010 at 9:40 PM, Leander Yu <leander.yu@gmail.com> wr=
ote:
>>> Hi,
>>> I just found my ceph cluster report no space left error. I check th=
e
>>> df and every osd disk. it still has space available and after delet=
e
>>> some file, I still can't write any data to the file system.
>>> Any suggestion for trouble shooting this case?
>> As with all distributed filesystems, Ceph still doesn't handle thing=
s
>> very well when even one disk runs out of space. Some sort of solutio=
n
>> will appear, but isn't on the roadmap yet. The most likely cause is
>> that you have disks of different sizes and haven't balanced their
>> input (via the CRUSH map) to match. Unfortunately, the best fix is
>> either to keep deleting data or to put a larger disk in whichever OS=
D
>> is full. The logs should tell you which one reported full.
>>
>> Keep in mind that to prevent more nasty badness from the local
>> filesystem, Ceph reports a disk "full" at some percentage below full
>> (I think it's 95%, but it may actually be less).
>> -Greg
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
