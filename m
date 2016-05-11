From: Sage Weil <sage@newdream.net>
Subject: Re: OSD will never become up. HEALTH_ERR
Date: Wed, 11 May 2016 08:55:47 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605110855100.15518@cpach.fuggernut.com>
References: <1462955827.13078.22.camel@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-974118800-1462971350=:15518"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54377 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbcEKMzk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 08:55:40 -0400
In-Reply-To: <1462955827.13078.22.camel@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gonzalo Aguilar Delgado <gaguilar.delgado@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-974118800-1462971350=:15518
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 May 2016, Gonzalo Aguilar Delgado wrote:
> Hello, 
> 
> I just upgraded my cluster to the version 10.1.2 and it worked well for
> a while until I saw that systemctl ceph-disk@dev-sdc1.service was
> failed and I reruned it.

What version did you upgrade *from*?  If it was older than 0.94.4 then 
that is the problem.  Check for messages in /var/log/ceph/ceph.log.

Also, you probably want to use 10.2.0, not 10.1.2 (which was a release 
candidate).

sage


> From there the OSD stopped working. 
> 
> This is ubuntu 16.04. 
> 
> I connected to the IRC looking for help where people pointed me to one
> or another place but none of the investigations helped to resolve.
> 
> My configuration is rather simple:
> 
> oot@red-compute:~# ceph osd tree
> ID WEIGHT  TYPE NAME                 UP/DOWN REWEIGHT PRIMARY-AFFINITY 
> -1 1.00000 root default                                                
> -4 1.00000     rack rack-1                                             
> -2 1.00000         host blue-compute                                   
>  0 1.00000             osd.0            down        0          1.00000 
>  2 1.00000             osd.2            down        0          1.00000 
> -3 1.00000         host red-compute                                    
>  1 1.00000             osd.1            down        0          1.00000 
>  3 0.50000             osd.3              up  1.00000          1.00000 
>  4 1.00000             osd.4            down        0          1.00000 
> 
> It seems that all nodes are in preboot status. I was looking at the
> latests commits and it seems that there's a patch
> to make OSDs to wait for cluster to become healthy before rejoining.
> Can this be the source of my problems?
> 
> root@red-compute:/var/lib/ceph/osd/ceph-1# ceph daemon osd.1 status
> {
>     "cluster_fsid": "9028f4da-0d77-462b-be9b-dbdf7fa57771",
>     "osd_fsid": "adf9890a-e680-48e4-82c6-e96f4ed56889",
>     "whoami": 1,
>     "state": "preboot",
>     "oldest_map": 1764,
>     "newest_map": 2504,
>     "num_pgs": 323
> }
> 
> root@red-compute:/var/lib/ceph/osd/ceph-1# ceph daemon osd.3 status
> {
>     "cluster_fsid": "9028f4da-0d77-462b-be9b-dbdf7fa57771",
>     "osd_fsid": "8dd085d4-0b50-4c80-a0ca-c5bc4ad972f7",
>     "whoami": 3,
>     "state": "preboot",
>     "oldest_map": 1764,
>     "newest_map": 2504,
>     "num_pgs": 150
> }
> 
> 3 is up and in. 
> 
> 
> This is what I got sofar:
> 
> Once upgraded I discovered that daemon runs under ceph. I just ran
> chown on ceph directories. and it worked. 
> Firewall is fully disabled. Checked connectivity with nc and nmap. 
> Configuration seems to be right. I can post if you want. 
> Enabling logging on OSD shows that for example osd.1 is reconnecting
> all the time.
> 2016-05-10 14:35:48.199573 7f53e8f1a700  1 -- 0.0.0.0:6806/13962 >> :/0
> pipe(0x556f99413400 sd=84 :6806 s=0 pgs=0 cs=0 l=0
> c=0x556f993b3a80).accept sd=84 172.16.0.119:35388/0
>  2016-05-10 14:35:48.199966 7f53e8f1a700  2 -- 0.0.0.0:6806/13962 >>
> :/0 pipe(0x556f99413400 sd=84 :6806 s=4 pgs=0 cs=0 l=0
> c=0x556f993b3a80).fault (0) Success
>  2016-05-10 14:35:48.200018 7f53fb941700  1 osd.1 2468 ms_handle_reset
> con 0x556f993b3a80 session 0
> OSD.3 goes ok because never left out because ceph restriction.
> I rebooted all services at once for it to have available all OSD at the
> same time and don't mark it down. Don't work. 
> I forced up from commandline. ceph osd in 1-5. They appear as in for a
> while then out.
> We tried ceph-disk activate-all to boot everything. Don't work.
> 
> The strange thing is that culster started worked just right after
> upgrade. But the systemctrl command broke both servers. 
> root@blue-compute:~# ceph -w
>     cluster 9028f4da-0d77-462b-be9b-dbdf7fa57771
>      health HEALTH_ERR
>             694 pgs are stuck inactive for more than 300 seconds
>             694 pgs stale
>             694 pgs stuck stale
>             too many PGs per OSD (1528 > max 300)
>             mds cluster is degraded
>             crush map has straw_calc_version=0
>      monmap e10: 2 mons at {blue-compute=172.16.0.119:6789/0,red-
> compute=172.16.0.100:6789/0}
>             election epoch 3600, quorum 0,1 red-compute,blue-compute
>       fsmap e673: 1/1/1 up {0:0=blue-compute=up:replay}
>      osdmap e2495: 5 osds: 1 up, 1 in; 5 remapped pgs
>       pgmap v40765481: 764 pgs, 6 pools, 410 GB data, 103 kobjects
>             87641 MB used, 212 GB / 297 GB avail
>                  694 stale+active+clean
>                   70 active+clean
> 
> 2016-05-10 17:03:55.822440 mon.0 [INF] HEALTH_ERR; 694 pgs are stuck
> inactive for more than 300 seconds; 694 pgs stale; 694 pgs stuck stale;
> too many PGs per OSD (1528 > max 300); mds cluster is degraded; crush
> map has straw_calc_version=
> cat /etc/ceph/ceph.conf 
> [global]
> 
> fsid = 9028f4da-0d77-462b-be9b-dbdf7fa57771
> mon_initial_members = blue-compute, red-compute
> mon_host = 172.16.0.119, 172.16.0.100
> auth_cluster_required = cephx
> auth_service_required = cephx
> auth_client_required = cephx
> filestore_xattr_use_omap = true
> public_network = 172.16.0.0/24
> osd_pool_default_pg_num = 100
> osd_pool_default_pgp_num = 100
> osd_pool_default_size = 2  # Write an object 3 times.
> osd_pool_default_min_size = 1 # Allow writing one copy in a degraded
> state.
> 
> ## Required upgrade
> osd max object name len = 256
> osd max object namespace len = 64
> 
> [mon.]
> 
>     debug mon = 9
>     caps mon = "allow *"
> 
> Any help on this? Any clue of what's going wrong?
> 
> 
> I also see this, I don't know if it's related or not
> 
> => ceph-osd.admin.log <==
> 2016-05-10 18:21:46.060278 7fa8f30cc8c0  0 ceph version 10.1.2
> (4a2a6f72640d6b74a3bbd92798bb913ed380dcd4), process ceph-osd, pid 14135
> 2016-05-10 18:21:46.060460 7fa8f30cc8c0 -1 bluestore(/dev/sdc2)
> _read_bdev_label unable to decode label at offset 66:
> buffer::malformed_input: void
> bluestore_bdev_label_t::decode(ceph::buffer::list::iterator&) decode
> past end of struct encoding
> 2016-05-10 18:21:46.062949 7fa8f30cc8c0  1 journal _open /dev/sdc2 fd
> 4: 5367660544 bytes, block size 4096 bytes, directio = 0, aio = 0
> 2016-05-10 18:21:46.062991 7fa8f30cc8c0  1 journal close /dev/sdc2
> 2016-05-10 18:21:46.063026 7fa8f30cc8c0  0 probe_block_device_fsid
> /dev/sdc2 is filestore, 119a9f4e-73d8-4a1f-877c-d60b01840c96
> 2016-05-10 18:21:47.072082 7eff735598c0  0 ceph version 10.1.2
> (4a2a6f72640d6b74a3bbd92798bb913ed380dcd4), process ceph-osd, pid 14177
> 2016-05-10 18:21:47.072285 7eff735598c0 -1 bluestore(/dev/sdf2)
> _read_bdev_label unable to decode label at offset 66:
> buffer::malformed_input: void
> bluestore_bdev_label_t::decode(ceph::buffer::list::iterator&) decode
> past end of struct encoding
> 2016-05-10 18:21:47.074799 7eff735598c0  1 journal _open /dev/sdf2 fd
> 4: 5367660544 bytes, block size 4096 bytes, directio = 0, aio = 0
> 2016-05-10 18:21:47.074844 7eff735598c0  1 journal close /dev/sdf2
> 2016-05-10 18:21:47.074881 7eff735598c0  0 probe_block_device_fsid
> /dev/sdf2 is filestore, fd069e6a-9a62-4286-99cb-d8a523bd946a
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-974118800-1462971350=:15518--
