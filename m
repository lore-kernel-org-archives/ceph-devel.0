From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: Issue with replication level.
Date: Tue, 8 Mar 2011 10:09:08 -0800
Message-ID: <AANLkTim_wDvKGQjfQohoogWD1GTKd_HYM7mqQFxRXoh1@mail.gmail.com>
References: <AANLkTin_M1Bx878=Avkm5+p1mhvJoYg1R87xjZSc4e=b@mail.gmail.com>
	<29A2C5787D4B4B568C3DC53A800E687C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35265 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1CHSJJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2011 13:09:09 -0500
Received: by vws12 with SMTP id 12so4910623vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Mar 2011 10:09:08 -0800 (PST)
In-Reply-To: <29A2C5787D4B4B568C3DC53A800E687C@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Upendra Moturi <upendra.m@hexagrid.com>, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>, Saurav Lahiri <saurav.lahiri@hexagrid.com>

Just making sure I'm interpreting this right.
At steady state (data_size >> journal_size), total space usage for 2x
replication should be 2 * data_size + journal_size?
If you have (data_size < journal_size) and journal is on a file rather
than on a partition, then btrfs will report 4x data size.

On Tue, Mar 8, 2011 at 8:51 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Tuesday, March 8, 2011 at 12:52 AM, Upendra Moturi wrote:
> Hi
>>
>> I am having issue witrh replication levels.
>> Even though i have set data @2x and mds@1x replication,the data copi=
ed
>> is occupying 4x space
>
> How are you measuring the data use as being at 4x? Keep in mind that =
data will be journaled on the OSD and that the MDS will journal any met=
adata changes. Also, depending on configuration the "used" data might i=
nclude the host's used space -- this generally applies when the OSD's b=
acking store is a directory; I'm not sure what happens if it's using a =
journal file but a separate device for data. :)
>
> Also, you probably don't want to leave metadata at 1x -- if you do th=
en any one node failure can cause metadata loss and a bad filesystem!
> -Greg
>
>>
>>
>> I have used default crush map rules.
>>
>> 2) how to see how much space does a mon,mds,data,casdata and rbd
>> occupied individually.
>>
>> My ceph.conf
>>
>> =A0[global]
>> =A0pid file =3D /var/run/ceph/$name.pid
>> =A0debug ms =3D 1
>> [mon]
>> =A0mon data =3D /data/mon$id
>> [mon.0]
>> =A0host =3D ceph1
>> =A0mon addr =3D 192.168.155.5:6789
>> [mon.1]
>> =A0host =3D ceph2
>> =A0mon addr =3D 192.168.155.6:6789
>> [mon.2]
>> =A0host =3D ceph3
>> =A0mon addr =3D 192.168.155.7:6789
>> [mds]
>>
>> [mds0]
>> =A0host =3D ceph1
>> [mds1]
>> =A0host =3D ceph2
>>
>> [osd]
>> =A0sudo =3D true
>> =A0osd data =3D /data/osd$id
>> =A0osd journal =3D /data/osd$id/journal
>> =A0osd journal size =3D 512
>> =A0osd use stale snap =3D true
>> [osd0]
>> =A0host =3D ceph1
>> =A0btrfs devs =3D /dev/sdb
>> [osd1]
>> =A0host =3D ceph2
>> =A0btrfs devs =3D /dev/sdb
>> [osd2]
>> =A0host =3D ceph3
>> =A0btrfs devs =3D /dev/sdb
>>
>>
>>
>> My pg_data settings
>>
>> pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
>> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1
>> owner 0)
>> pg_pool 1 'metadata' pg_pool(rep pg_size 1 crush_ruleset 1 object_ha=
sh
>> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 10
>> owner 0)
>> pg_pool 2 'casdata' pg_pool(rep pg_size 1 crush_ruleset 2 object_has=
h
>> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 12
>> owner 0)
>> pg_pool 3 'rbd' pg_pool(rep pg_size 1 crush_ruleset 3 object_hash
>> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 15
>> owner 0)
>>
>>
>>
>>
>>
>> --
>> Thanks and Regards,
>> Upendra.M
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
