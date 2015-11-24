From: "hzwulibin" <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: New added osd always down
Date: Tue, 24 Nov 2015 14:22:40 +0800
Message-ID: <5654022C.7080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi, cepher

My cluster has a big problem.
ceph version: 0.80.10
1. OSD are full, i can't delete volume, the io seems blocked. when i rm a image, here is the error message:
sudo rbd rm ff3a6870-24cb-427a-979b-6b9b257032c3 -p vol_ssd
2015-11-24 14:14:26.418016 7f9b900a5780 -1 librbd::ImageCtx: error finding header: (2) No such file or directory
2015-11-24 14:14:26.418237 7f9b900a5780  0 client.9237071.objecter  FULL, paused modify 0xcc5870 tid 3

follow is message from ceph -w:
 cluster 19eeb168-7dce-48ae-afb2-b6d1e1e29be4
     health HEALTH_ERR 1164 pgs backfill_toofull; 448 pgs degraded; 12 pgs incomplete; 12 pgs stuck inactive; 1224 pgs stuck unclean; recovery 1039912/5491280 objects degraded (18.938%); 35 full osd(s); 4 near full osd(s)
     monmap e2: 3 mons at {10-180-0-30=10.180.0.30:6789/0,10-180-0-31=10.180.0.31:6789/0,10-180-0-34=10.180.0.34:6789/0}, election epoch 114, quorum 0,1,2 10-180-0-30,10-180-0-31,10-180-0-34
     osdmap e12196: 44 osds: 39 up, 39 in
            flags full
      pgmap v461411: 4096 pgs, 3 pools, 6119 GB data, 1525 kobjects
            12314 GB used, 607 GB / 12921 GB avail
            1039912/5491280 objects degraded (18.938%)
                  38 active+degraded+remapped
                 754 active+remapped+backfill_toofull
                2872 active+clean
                  10 active+remapped
                 410 active+degraded+remapped+backfill_toofull
                  12 remapped+incomplete

2015-11-24 14:17:50.716166 osd.8 [WRN] OSD near full (95%)
2015-11-24 14:18:01.139994 osd.40 [WRN] OSD near full (95%)
2015-11-24 14:17:53.308538 osd.22 [WRN] OSD near full (95%)

2. I try to add some new osd, but it always be a down state.
ceph osd tree|grep down
# id	weight	type name	up/down	reweight
21	0.4			osd.21	down	0	
2	0.36			osd.2	down	0	
4	0.4			osd.4	down	0	

ceph osd dump:
osd.2 down out weight 0 up_from 8751 up_thru 8755 down_at 8766 last_clean_interval [8224,8746) 10.180.0.30:6821/40125 10.180.0.30:6827/40125 10.180.0.30:6828/40125 10.180.0.30:6829/40125 autoout,exists f1dc9181-ed70-48fb-95fa-cc568fee7b98

And here is the log of osd.2:
2015-11-24 14:21:38.547551 7ff48e8cb700 10 osd.2 0 do_waiters -- start 
2015-11-24 14:21:38.547554 7ff48e8cb700 10 osd.2 0 do_waiters -- finish
2015-11-24 14:21:39.386455 7ff47486f700 20 osd.2 0 update_osd_stat osd_stat(33360 kB used, 367 GB avail, 367 GB total, peers []/[] op hist [])
2015-11-24 14:21:39.386473 7ff47486f700  5 osd.2 0 heartbeat: osd_stat(33360 kB used, 367 GB avail, 367 GB total, peers []/[] op hist [])
2015-11-24 14:21:39.547615 7ff48e8cb700  5 osd.2 0 tick

What's wrong with my cluster?
			
--------------
hzwulibin
2015-11-24
