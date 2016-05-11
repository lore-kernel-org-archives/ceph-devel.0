From: Gonzalo Aguilar Delgado <gaguilar.delgado@gmail.com>
Subject: OSD will never become up. HEALTH_ERR
Date: Wed, 11 May 2016 10:37:07 +0200
Message-ID: <1462955827.13078.22.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35617 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcEKIhL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 04:37:11 -0400
Received: by mail-wm0-f51.google.com with SMTP id e201so208637883wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 01:37:10 -0700 (PDT)
Received: from laptop.cloud.level2crm.com (46.red-212-170-57.staticip.rima-tde.net. [212.170.57.46])
        by smtp.gmail.com with ESMTPSA id gg7sm6820330wjd.10.2016.05.11.01.37.08
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2016 01:37:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,=C2=A0

I just upgraded my cluster to the version 10.1.2 and it worked well for
a while until I saw that systemctl ceph-disk@dev-sdc1.service was
failed and I reruned it.

=46rom there the OSD stopped working.=C2=A0

This is ubuntu 16.04.=C2=A0

I connected to the IRC looking for help where people pointed me to one
or another place but none of the investigations helped to resolve.

My configuration is rather simple:

oot@red-compute:~# ceph osd tree
ID WEIGHT=C2=A0 TYPE NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UP/DOWN REWEIGHT PRIMA=
RY-AFFINITY=C2=A0
-1 1.00000 root default=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
-4 1.00000=C2=A0=C2=A0=C2=A0=C2=A0 rack rack-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
-2 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host blue-co=
mpute=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A00 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 osd.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 down=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00000=C2=A0
=C2=A02 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 osd.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 down=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00000=C2=A0
-3 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host red-com=
pute=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
=C2=A01 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 osd.1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 down=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00000=C2=A0
=C2=A03 0.50000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 osd.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 up=C2=A0 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00000=C2=A0
=C2=A04 1.00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 osd.4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 down=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00000=C2=A0

It seems that all nodes are in preboot status. I was looking at the
latests commits and it seems that there's a patch
to make OSDs to wait for cluster to become healthy before rejoining.
Can this be the source of my problems?

root@red-compute:/var/lib/ceph/osd/ceph-1# ceph daemon osd.1 status
{
=C2=A0=C2=A0=C2=A0 "cluster_fsid": "9028f4da-0d77-462b-be9b-dbdf7fa5777=
1",
=C2=A0=C2=A0=C2=A0 "osd_fsid": "adf9890a-e680-48e4-82c6-e96f4ed56889",
=C2=A0=C2=A0=C2=A0 "whoami": 1,
=C2=A0=C2=A0=C2=A0 "state": "preboot",
=C2=A0=C2=A0=C2=A0 "oldest_map": 1764,
=C2=A0=C2=A0=C2=A0 "newest_map": 2504,
=C2=A0=C2=A0=C2=A0 "num_pgs": 323
}

root@red-compute:/var/lib/ceph/osd/ceph-1# ceph daemon osd.3 status
{
=C2=A0=C2=A0=C2=A0 "cluster_fsid": "9028f4da-0d77-462b-be9b-dbdf7fa5777=
1",
=C2=A0=C2=A0=C2=A0 "osd_fsid": "8dd085d4-0b50-4c80-a0ca-c5bc4ad972f7",
=C2=A0=C2=A0=C2=A0 "whoami": 3,
=C2=A0=C2=A0=C2=A0 "state": "preboot",
=C2=A0=C2=A0=C2=A0 "oldest_map": 1764,
=C2=A0=C2=A0=C2=A0 "newest_map": 2504,
=C2=A0=C2=A0=C2=A0 "num_pgs": 150
}

3 is up and in.=C2=A0


This is what I got sofar:

Once upgraded I discovered that daemon runs under ceph. I just ran
chown on ceph directories. and it worked.=C2=A0
=46irewall is fully disabled. Checked connectivity with nc and nmap.=C2=
=A0
Configuration seems to be right. I can post if you want.=C2=A0
Enabling logging on OSD shows that for example osd.1 is reconnecting
all the time.
2016-05-10 14:35:48.199573 7f53e8f1a700=C2=A0 1 --=C2=A00.0.0.0:6806/13=
962=C2=A0>> :/0
pipe(0x556f99413400 sd=3D84 :6806 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x556f993b3a80).accept sd=3D84=C2=A0172.16.0.119:35388/0
=C2=A02016-05-10 14:35:48.199966 7f53e8f1a700=C2=A0 2 --=C2=A00.0.0.0:6=
806/13962=C2=A0>>
:/0 pipe(0x556f99413400 sd=3D84 :6806 s=3D4 pgs=3D0 cs=3D0 l=3D0
c=3D0x556f993b3a80).fault (0) Success
=C2=A02016-05-10 14:35:48.200018 7f53fb941700=C2=A0 1 osd.1 2468 ms_han=
dle_reset
con 0x556f993b3a80 session 0
OSD.3 goes ok because never left out because ceph restriction.
I rebooted all services at once for it to have available all OSD at the
same time and don't mark it down. Don't work.=C2=A0
I forced up from commandline. ceph osd in 1-5. They appear as in for a
while then out.
We tried ceph-disk activate-all to boot everything. Don't work.

The strange thing is that culster started worked just right after
upgrade. But the systemctrl command broke both servers.=C2=A0
root@blue-compute:~# ceph -w
=C2=A0=C2=A0=C2=A0 cluster 9028f4da-0d77-462b-be9b-dbdf7fa57771
=C2=A0=C2=A0=C2=A0=C2=A0 health HEALTH_ERR
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 694 =
pgs are stuck inactive for more than 300 seconds
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 694 =
pgs stale
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 694 =
pgs stuck stale
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 too =
many PGs per OSD (1528 > max 300)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mds =
cluster is degraded
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crus=
h map has straw_calc_version=3D0
=C2=A0=C2=A0=C2=A0=C2=A0 monmap e10: 2 mons at {blue-compute=3D172.16.0=
=2E119:6789/0,red-
compute=3D172.16.0.100:6789/0}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elec=
tion epoch 3600, quorum 0,1 red-compute,blue-compute
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsmap e673: 1/1/1 up {0:0=3Dblue-compute=
=3Dup:replay}
=C2=A0=C2=A0=C2=A0=C2=A0 osdmap e2495: 5 osds: 1 up, 1 in; 5 remapped p=
gs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgmap v40765481: 764 pgs, 6 pools, 410 G=
B data, 103 kobjects
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8764=
1 MB used, 212 GB / 297 GB avail
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 694 stale+active+clean
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 70 active+clean

2016-05-10 17:03:55.822440 mon.0 [INF] HEALTH_ERR; 694 pgs are stuck
inactive for more than 300 seconds; 694 pgs stale; 694 pgs stuck stale;
too many PGs per OSD (1528 > max 300); mds cluster is degraded; crush
map has straw_calc_version=3D
cat /etc/ceph/ceph.conf=C2=A0
[global]

fsid =3D 9028f4da-0d77-462b-be9b-dbdf7fa57771
mon_initial_members =3D blue-compute, red-compute
mon_host =3D 172.16.0.119, 172.16.0.100
auth_cluster_required =3D cephx
auth_service_required =3D cephx
auth_client_required =3D cephx
filestore_xattr_use_omap =3D true
public_network =3D=C2=A0172.16.0.0/24
osd_pool_default_pg_num =3D 100
osd_pool_default_pgp_num =3D 100
osd_pool_default_size =3D 2=C2=A0 # Write an object 3 times.
osd_pool_default_min_size =3D 1 # Allow writing one copy in a degraded
state.

## Required upgrade
osd max object name len =3D 256
osd max object namespace len =3D 64

[mon.]

=C2=A0=C2=A0=C2=A0 debug mon =3D 9
=C2=A0=C2=A0=C2=A0 caps mon =3D "allow *"

Any help on this? Any clue of what's going wrong?


I also see this, I don't know if it's related or not

=3D> ceph-osd.admin.log <=3D=3D
2016-05-10 18:21:46.060278 7fa8f30cc8c0=C2=A0 0 ceph version 10.1.2
(4a2a6f72640d6b74a3bbd92798bb913ed380dcd4), process ceph-osd, pid 14135
2016-05-10 18:21:46.060460 7fa8f30cc8c0 -1 bluestore(/dev/sdc2)
_read_bdev_label unable to decode label at offset 66:
buffer::malformed_input: void
bluestore_bdev_label_t::decode(ceph::buffer::list::iterator&) decode
past end of struct encoding
2016-05-10 18:21:46.062949 7fa8f30cc8c0=C2=A0 1 journal _open /dev/sdc2=
 fd
4: 5367660544 bytes, block size 4096 bytes, directio =3D 0, aio =3D 0
2016-05-10 18:21:46.062991 7fa8f30cc8c0=C2=A0 1 journal close /dev/sdc2
2016-05-10 18:21:46.063026 7fa8f30cc8c0=C2=A0 0 probe_block_device_fsid
/dev/sdc2 is filestore, 119a9f4e-73d8-4a1f-877c-d60b01840c96
2016-05-10 18:21:47.072082 7eff735598c0=C2=A0 0 ceph version 10.1.2
(4a2a6f72640d6b74a3bbd92798bb913ed380dcd4), process ceph-osd, pid 14177
2016-05-10 18:21:47.072285 7eff735598c0 -1 bluestore(/dev/sdf2)
_read_bdev_label unable to decode label at offset 66:
buffer::malformed_input: void
bluestore_bdev_label_t::decode(ceph::buffer::list::iterator&) decode
past end of struct encoding
2016-05-10 18:21:47.074799 7eff735598c0=C2=A0 1 journal _open /dev/sdf2=
 fd
4: 5367660544 bytes, block size 4096 bytes, directio =3D 0, aio =3D 0
2016-05-10 18:21:47.074844 7eff735598c0=C2=A0 1 journal close /dev/sdf2
2016-05-10 18:21:47.074881 7eff735598c0=C2=A0 0 probe_block_device_fsid
/dev/sdf2 is filestore, fd069e6a-9a62-4286-99cb-d8a523bd946a


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
