From: Sage Weil <sage@newdream.net>
Subject: Re: mount error mds not active
Date: Wed, 18 May 2011 14:10:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105181408030.1988@cobra.newdream.net>
References: <D9942BA805B91F419A05B04E4B620578019C48@EXMB10.srn.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60029 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab1ERVIy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 17:08:54 -0400
In-Reply-To: <D9942BA805B91F419A05B04E4B620578019C48@EXMB10.srn.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Mukherjee, Shyamali" <smukher@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Wed, 18 May 2011, Mukherjee, Shyamali wrote:
> Hi Sage,
> 
>     I have  made changed to mkcephfs script and able to start  OSDs, cmon, cmds etc.
> But mount was failing since last evening. So I added debug version and did some
> kprint ( actually existing pr_info )..
> 
> I see that I have one MDS running but  during ceph_real_mount() --> open_root_dentry()
> fails. Off couse without MDS and mount point attachment we can not go any further.
> 
> 
> ceph -w shows nothing much:
> 
> [root@bz1 ceph]# ceph -c /etc/ceph.conf -w
> 2011-05-18 12:21:37.055290    pg v2263: 15840 pgs: 9632 active+clean, 6208 active+clean+degraded; 17 KB data, 22349 MB used, 16563 GB / 16585 GB avail
> 2011-05-18 12:21:37.089256   mds e3: 1/1/1 up {0=up:creating}

This is the problem (up:creating).  The mds needs to reach up:acting 
before you'll be able to mount.

Usually this happens because the OSDs are completing writes (all the 
create stage does is create some initial objects).  Do you have any 
problems doing, say,

 rados -p rbd bench 30 write

(which should write a bunch of objects for about 30 seconds)?

sage


> 2011-05-18 12:21:37.089288   osd e84: 60 osds: 59 up, 59 in
> 2011-05-18 12:21:37.089400   log 2011-05-18 10:50:00.757878 osd55 192.168.2.101:6804/4254 215 : [INF] 3.0p55 scrub ok
> 2011-05-18 12:21:37.089475   mon e1: 1 mons at {0=192.168.2.101:6789/0}
> 
> 
> I see that ceph_mdsc_do_request()  returned failure EIO.
> 
> 
> 
> 
> 
> 
> [root@bz1 ceph-client-standalone]# dmesg
> libceph: client4200 fsid 0ef741ca-47a1-a20e-964a-04f8710bfbfa
> ceph: handle_map epoch 3 len 499
> ceph: check_new_map new 3 old 0
> ceph: do_request on ffff88005f2b3000
> ceph: __register_request ffff88005f2b3000 tid 1
> ceph: __choose_mds (null) is_hash=0 (0) mode 0
> ceph: choose_mds chose random mds-1
> ceph: do_request no mds or not active, waiting for map
> ceph: do_request waiting
> libceph: mon0 192.168.2.101:6789 session established
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: do_request waited, got -5
> ceph: aborted request 1 with -5
> ceph: do_request ffff88005f2b3000 done, result -5
> ceph: open_root_dentry after ceph_mdsc_do_request
> ceph: open_root_dentry after ceph_mdsc_put_request
> ceph: mount error opening root -5
> ceph: close_sessions
> ceph: waiting for sessions to close
> ceph: stopped
> ceph: pre_umount
> ceph: drop_leases
> ceph: wait_requests waiting for requests
> ceph: wait_requests timed out on tid 1
> ceph: __unregister_request ffff88005f2b3000 tid 1
> ceph: wait_requests done
> ceph: stop
> libceph: client4205 fsid 0ef741ca-47a1-a20e-964a-04f8710bfbfa
> ceph: handle_map epoch 3 len 499
> ceph: check_new_map new 3 old 0
> ceph: do_request on ffff8800b2ad1800
> ceph: __register_request ffff8800b2ad1800 tid 1
> ceph: __choose_mds (null) is_hash=0 (0) mode 0
> ceph: choose_mds chose random mds-1
> ceph: do_request no mds or not active, waiting for map
> libceph: mon0 192.168.2.101:6789 session established
> ceph: do_request waiting
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> ceph: mdsc delayed_work
> 
> 
> I have restarted MDS couple of time and I see it is running.. but  not able to mount. Any suggestion.
> 
> Current  ceph.conf  log file   seems to get huge due to constant ping from all OSDs.
> 
> 
> 
