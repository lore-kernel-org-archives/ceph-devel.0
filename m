From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Issue with replication level.
Date: Tue, 8 Mar 2011 08:51:40 -0800
Message-ID: <29A2C5787D4B4B568C3DC53A800E687C@gmail.com>
References: <AANLkTin_M1Bx878=Avkm5+p1mhvJoYg1R87xjZSc4e=b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42639 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab1CHQvp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2011 11:51:45 -0500
Received: by ywj3 with SMTP id 3so2051150ywj.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Mar 2011 08:51:45 -0800 (PST)
In-Reply-To: <AANLkTin_M1Bx878=Avkm5+p1mhvJoYg1R87xjZSc4e=b@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>, Saurav Lahiri <saurav.lahiri@hexagrid.com>

On Tuesday, March 8, 2011 at 12:52 AM, Upendra Moturi wrote:
Hi
> 
> I am having issue witrh replication levels.
> Even though i have set data @2x and mds@1x replication,the data copied
> is occupying 4x space

How are you measuring the data use as being at 4x? Keep in mind that data will be journaled on the OSD and that the MDS will journal any metadata changes. Also, depending on configuration the "used" data might include the host's used space -- this generally applies when the OSD's backing store is a directory; I'm not sure what happens if it's using a journal file but a separate device for data. :)

Also, you probably don't want to leave metadata at 1x -- if you do then any one node failure can cause metadata loss and a bad filesystem!
-Greg

> 
> 
> I have used default crush map rules.
> 
> 2) how to see how much space does a mon,mds,data,casdata and rbd
> occupied individually.
> 
> My ceph.conf
> 
>  [global]
>  pid file = /var/run/ceph/$name.pid
>  debug ms = 1
> [mon]
>  mon data = /data/mon$id
> [mon.0]
>  host = ceph1
>  mon addr = 192.168.155.5:6789
> [mon.1]
>  host = ceph2
>  mon addr = 192.168.155.6:6789
> [mon.2]
>  host = ceph3
>  mon addr = 192.168.155.7:6789
> [mds]
> 
> [mds0]
>  host = ceph1
> [mds1]
>  host = ceph2
> 
> [osd]
>  sudo = true
>  osd data = /data/osd$id
>  osd journal = /data/osd$id/journal
>  osd journal size = 512
>  osd use stale snap = true
> [osd0]
>  host = ceph1
>  btrfs devs = /dev/sdb
> [osd1]
>  host = ceph2
>  btrfs devs = /dev/sdb
> [osd2]
>  host = ceph3
>  btrfs devs = /dev/sdb
> 
> 
> 
> My pg_data settings
> 
> pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash
> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1
> owner 0)
> pg_pool 1 'metadata' pg_pool(rep pg_size 1 crush_ruleset 1 object_hash
> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 10
> owner 0)
> pg_pool 2 'casdata' pg_pool(rep pg_size 1 crush_ruleset 2 object_hash
> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 12
> owner 0)
> pg_pool 3 'rbd' pg_pool(rep pg_size 1 crush_ruleset 3 object_hash
> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 15
> owner 0)
> 
> 
> 
> 
> 
> --
> Thanks and Regards,
> Upendra.M
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

