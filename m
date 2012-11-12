From: Sage Weil <sage@inktank.com>
Subject: Re: ceph cluster hangs when rebooting one node
Date: Mon, 12 Nov 2012 07:11:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211120710330.2293@cobra.newdream.net>
References: <50A1101A.4070401@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36892 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2KLPL2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 10:11:28 -0500
In-Reply-To: <50A1101A.4070401@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 12 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> i was checking what happens if i reboot a ceph node.
> 
> Sadly if i reboot one node, the whole ceph cluster hangs and no I/O is
> possible.

If you are using the current master, the new 'min_size' may be biting you; 
ceph osd dump | grep ^pool and see if you see min_size for your pools.  
You can change that back to the norma behavior with

 ceph osd pool set <poolname> min_size 1

sage


> 
> ceph -w:
> Looks like this:
> 2012-11-12 16:03:58.191106 mon.0 [INF] pgmap v19013: 7032 pgs: 7032
> active+clean; 91615 MB data, 174 GB used, 4294 GB / 4469 GB avail
> 2012-11-12 16:04:08.365557 mon.0 [INF] mon.a calling new monitor election
> 2012-11-12 16:04:13.422682 mon.0 [INF] mon.a@0 won leader election with quorum
> 0,2
> 2012-11-12 16:04:13.708045 mon.0 [INF] pgmap v19014: 7032 pgs: 7032
> active+clean; 91615 MB data, 174 GB used, 4294 GB / 4469 GB avail
> 2012-11-12 16:04:13.708059 mon.0 [INF] mdsmap e1: 0/0/1 up
> 2012-11-12 16:04:13.708070 mon.0 [INF] osdmap e4582: 20 osds: 20 up, 20 in
> 2012-11-12 16:04:08.242688 mon.2 [INF] mon.c calling new monitor election
> 2012-11-12 16:04:13.708089 mon.0 [INF] monmap e1: 3 mons at
> {a=10.255.0.100:6789/0,b=10.255.0.101:6789/0,c=10.255.0.102:6789/0}
> 2012-11-12 16:04:14.070593 mon.0 [INF] pgmap v19015: 7032 pgs: 7032
> active+clean; 91615 MB data, 174 GB used, 4294 GB / 4469 GB avail
> 2012-11-12 16:04:15.283954 mon.0 [INF] pgmap v19016: 7032 pgs: 7032
> active+clean; 91615 MB data, 174 GB used, 4294 GB / 4469 GB avail
> 2012-11-12 16:04:18.506812 mon.0 [INF] osd.21 10.255.0.101:6800/5049 failed (3
> reports from 3 peers after 20.339769 >= grace 20.000000)
> 2012-11-12 16:04:18.890003 mon.0 [INF] osdmap e4583: 20 osds: 19 up, 20 in
> 2012-11-12 16:04:19.137936 mon.0 [INF] pgmap v19017: 7032 pgs: 6720
> active+clean, 312 stale+active+clean; 91615 MB data, 174 GB used, 4294 GB /
> 4469 GB avail
> 2012-11-12 16:04:20.024595 mon.0 [INF] osdmap e4584: 20 osds: 19 up, 20 in
> 2012-11-12 16:04:20.330149 mon.0 [INF] pgmap v19018: 7032 pgs: 6720
> active+clean, 312 stale+active+clean; 91615 MB data, 174 GB used, 4294 GB /
> 4469 GB avail
> 2012-11-12 16:04:21.535471 mon.0 [INF] pgmap v19019: 7032 pgs: 6720
> active+clean, 312 stale+active+clean; 91615 MB data, 174 GB used, 4294 GB /
> 4469 GB avail
> 2012-11-12 16:04:24.181292 mon.0 [INF] osd.22 10.255.0.101:6803/5153 failed (3
> reports from 3 peers after 23.013550 >= grace 20.000000)
> 2012-11-12 16:04:24.182208 mon.0 [INF] osd.23 10.255.0.101:6806/5276 failed (3
> reports from 3 peers after 21.000834 >= grace 20.000000)
> 2012-11-12 16:04:24.671373 mon.0 [INF] pgmap v19020: 7032 pgs: 6637
> active+clean, 208 stale+active+clean, 187 incomplete; 91615 MB data, 174 GB
> used, 4295 GB / 4469 GB avail
> 2012-11-12 16:04:24.829022 mon.0 [INF] osdmap e4585: 20 osds: 17 up, 20 in
> 2012-11-12 16:04:24.870969 mon.0 [INF] osd.24 10.255.0.101:6809/5397 failed (3
> reports from 3 peers after 20.688672 >= grace 20.000000)
> 2012-11-12 16:04:25.522333 mon.0 [INF] pgmap v19021: 7032 pgs: 5912
> active+clean, 933 stale+active+clean, 187 incomplete; 91615 MB data, 174 GB
> used, 4295 GB / 4469 GB avail
> 2012-11-12 16:04:25.596927 mon.0 [INF] osd.24 10.255.0.101:6809/5397 failed (3
> reports from 3 peers after 21.708444 >= grace 20.000000)
> 2012-11-12 16:04:26.077545 mon.0 [INF] osdmap e4586: 20 osds: 16 up, 20 in
> 2012-11-12 16:04:26.606475 mon.0 [INF] pgmap v19022: 7032 pgs: 5394
> active+clean, 1094 stale+active+clean, 544 incomplete; 91615 MB data, 173 GB
> used, 4296 GB / 4469 GB avail
> 2012-11-12 16:04:27.162034 mon.0 [INF] osdmap e4587: 20 osds: 16 up, 20 in
> 2012-11-12 16:04:27.656974 mon.0 [INF] pgmap v19023: 7032 pgs: 5394
> active+clean, 1094 stale+active+clean, 544 incomplete; 91615 MB data, 173 GB
> used, 4296 GB / 4469 GB avail
> 2012-11-12 16:04:30.229958 mon.0 [INF] pgmap v19024: 7032 pgs: 5394
> active+clean, 1094 stale+active+clean, 544 incomplete; 91615 MB data, 172 GB
> used, 4296 GB / 4469 GB avail
> 2012-11-12 16:04:31.411989 mon.0 [INF] pgmap v19025: 7032 pgs: 5394
> active+clean, 1094 stale+active+clean, 544 incomplete; 91615 MB data, 172 GB
> used, 4296 GB / 4469 GB avail
> 2012-11-12 16:04:32.617576 mon.0 [INF] pgmap v19026: 7032 pgs: 4660
> active+clean, 2372 incomplete; 91615 MB data, 171 GB used, 4298 GB / 4469 GB
> avail
> 2012-11-12 16:04:35.172861 mon.0 [INF] pgmap v19027: 7032 pgs: 4660
> active+clean, 2372 incomplete; 91615 MB data, 171 GB used, 4298 GB / 4469 GB
> avail
> 2012-11-12 16:04:30.505872 osd.53 [WRN] 6 slow requests, 6 included below;
> oldest blocked for > 30.247691 secs
> 2012-11-12 16:04:30.505875 osd.53 [WRN] slow request 30.247691 seconds old,
> received at 2012-11-12 16:04:00.258118: osd_op(client.131626.0:771962
> rb.0.107a.734602d5.000000000bce [write 2478080~4096] 3.562a9efc) v4 currently
> reached pg
> 2012-11-12 16:04:30.505879 osd.53 [WRN] slow request 30.238016 seconds old,
> received at 2012-11-12 16:04:00.267793: osd_op(client.131626.0:772116
> rb.0.107a.734602d5.000000001608 [write 262144~4096] 3.a47890e) v4 currently
> reached pg
> 2012-11-12 16:04:30.505881 osd.53 [WRN] slow request 30.236572 seconds old,
> received at 2012-11-12 16:04:00.269237: osd_op(client.131626.0:772141
> rb.0.107a.734602d5.000000001777 [write 798720~4096] 3.547bc855) v4 currently
> reached pg
> 2012-11-12 16:04:30.505883 osd.53 [WRN] slow request 30.227850 seconds old,
> received at 2012-11-12 16:04:00.277959: osd_op(client.131626.0:772283
> rb.0.107a.734602d5.0000000000a6 [write 2379776~4096] 3.5d0f2510) v4 currently
> reached pg
> 2012-11-12 16:04:30.505884 osd.53 [WRN] slow request 30.227499 seconds old,
> received at 2012-11-12 16:04:00.278310: osd_op(client.131626.0:772289
> rb.0.107a.734602d5.0000000000d0 [write 3379200~4096] 3.b031884f) v4 currently
> reached pg
> 2012-11-12 16:04:30.819063 osd.52 [WRN] 6 slow requests, 6 included below;
> oldest blocked for > 30.578003 secs
> 2012-11-12 16:04:30.819069 osd.52 [WRN] slow request 30.578003 seconds old,
> received at 2012-11-12 16:04:00.240978: osd_op(client.131626.0:771697
> rb.0.107a.734602d5.000000001916 [write 3076096~4096] 3.627cbcb1) v4 currently
> reached pg
> 2012-11-12 16:04:30.819076 osd.52 [WRN] slow request 30.546967 seconds old,
> received at 2012-11-12 16:04:00.272014: osd_op(client.131626.0:772187
> rb.0.107a.734602d5.000000001974 [write 1675264~4096] 3.ba912483) v4 currently
> reached pg
> 2012-11-12 16:04:30.819078 osd.52 [WRN] slow request 30.544082 seconds old,
> received at 2012-11-12 16:04:00.274899: osd_op(client.131626.0:772235
> rb.0.107a.734602d5.000000001bfd [write 3686400~4096] 3.29b75f52) v4 currently
> reached pg
> 2012-11-12 16:04:30.819080 osd.52 [WRN] slow request 30.496902 seconds old,
> received at 2012-11-12 16:04:00.322079: osd_op(client.131626.0:772944
> rb.0.107a.734602d5.000000000bbb [write 266240~4096] 3.5db27880) v4 currently
> reached pg
> 2012-11-12 16:04:30.819081 osd.52 [WRN] slow request 30.470500 seconds old,
> received at 2012-11-12 16:04:00.348481: osd_op(client.131626.0:773397
> rb.0.107a.734602d5.000000000bbb [write 4145152~4096] 3.5db27880) v4 currently
> reached pg
> 2012-11-12 16:04:31.202553 osd.51 [WRN] 6 slow requests, 6 included below;
> oldest blocked for > 30.932114 secs
> 2012-11-12 16:04:31.203126 osd.51 [WRN] slow request 30.932114 seconds old,
> received at 2012-11-12 16:04:00.270383: osd_op(client.131626.0:772159
> rb.0.107a.734602d5.000000001826 [write 3842048~4096] 3.d489eb11) v4 currently
> reached pg
> 2012-11-12 16:04:31.203130 osd.51 [WRN] slow request 30.902220 seconds old,
> received at 2012-11-12 16:04:00.300277: osd_op(client.131626.0:772552
> rb.0.107a.734602d5.000000000fd9 [write 2990080~4096] 3.e64d168c) v4 currently
> reached pg
> 2012-11-12 16:04:31.203132 osd.51 [WRN] slow request 30.895459 seconds old,
> received at 2012-11-12 16:04:00.307038: osd_op(client.131626.0:772670
> rb.0.107a.734602d5.00000000177f [write 1028096~4096] 3.dad40d42) v4 currently
> reached pg
> 2012-11-12 16:04:31.203135 osd.51 [WRN] slow request 30.891418 seconds old,
> received at 2012-11-12 16:04:00.311079: osd_op(client.131626.0:772730
> rb.0.107a.734602d5.000000001ac6 [write 495616~4096] 3.27fd6b11) v4 currently
> reached pg
> 2012-11-12 16:04:31.203136 osd.51 [WRN] slow request 30.845134 seconds old,
> received at 2012-11-12 16:04:00.357363: osd_op(client.131626.0:773553
> rb.0.107a.734602d5.000000001688 [write 3125248~4096] 3.c83fad42) v4 currently
> reached pg
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
