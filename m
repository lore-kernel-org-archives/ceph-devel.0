From: ramu <ramu.freesystems@gmail.com>
Subject: Re: ceph was didn't stop.
Date: Thu, 28 Jun 2012 05:05:52 +0000 (UTC)
Message-ID: <loom.20120628T065725-838@post.gmane.org>
References: <loom.20120627T061404-977@post.gmane.org> <4FEBA33F.8020700@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59800 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab2F1FGK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jun 2012 01:06:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sk6vd-0007fV-Tp
	for ceph-devel@vger.kernel.org; Thu, 28 Jun 2012 07:06:06 +0200
Received: from segment-124-30.sify.net ([segment-124-30.sify.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 07:06:05 +0200
Received: from ramu.freesystems by segment-124-30.sify.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 07:06:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Josh Durgin <josh.durgin <at> inktank.com> writes:

Hi Josh,
  I tried to stop single osd with /etc/init.d/ceph -a stop osd.0.
But it was not stop.And I changed" #!/bin/sh" to "#!/bin/sh -x" also,
this is the one osd process in commandline.

=== osd.1 === 
+ return 0
+ get_conf pid_file /var/run/ceph/osd.1.pid pid file
+ var=pid_file
+ def=/var/run/ceph/osd.1.pid
+ key=pid file
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 pid file
+ eval echo -n /var/run/ceph/osd.1.pid
+ echo -n /var/run/ceph/osd.1.pid
+ eval pid_file="/var/run/ceph/osd.1.pid"
+ pid_file=/var/run/ceph/osd.1.pid
+ [ -n /var/run/ceph/osd.1.pid ]
+ dirname /var/run/ceph/osd.1.pid
+ do_cmd mkdir -p /var/run/ceph
+ [ -z ssh gamma ]
+ [ 0 -eq 1 ]
+ ssh gamma cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/run/ceph
+ get_conf log_dir  log dir
+ var=log_dir
+ def=
+ key=log dir
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 log dir
+ eval echo -n 
+ echo -n
+ eval log_dir=""
+ log_dir=
+ get_conf log_sym_dir  log sym dir
+ var=log_sym_dir
+ def=
+ key=log sym dir
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 log sym dir
+ eval echo -n 
+ echo -n
+ eval log_sym_dir=""
+ log_sym_dir=
+ [ -n  ]
+ [ -n  ]
+ [ stop = start ]
+ binary=/usr/local/bin/ceph-osd
+ [ stop = start ]
+ cmd=/usr/local/bin/ceph-osd -i 1
+ [ gamma = vu-AP480-S ]
+ + grepecho -v -q alpha  gamma  gamma alpha
 alpha
+ cur_conf=/tmp/ceph.conf.6982
+ cmd=/usr/local/bin/ceph-osd -i 1 -c /tmp/ceph.conf.6982
+ echo osd.1
+ grep -q ^osd
+ get_conf osd_data  osd data
+ var=osd_data
+ def=
+ key=osd data
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 osd data
+ eval osd_data="/data/osd.1"
+ osd_data=/data/osd.1
+ get_conf btrfs_path /data/osd.1 btrfs path
+ var=btrfs_path
+ def=/data/osd.1
+ key=btrfs path
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 btrfs path
+ eval echo -n /data/osd.1
+ echo -n /data/osd.1
+ eval btrfs_path="/data/osd.1"
+ btrfs_path=/data/osd.1
+ get_conf btrfs_devs  btrfs devs
+ var=btrfs_devs
+ def=
+ key=btrfs devs
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 btrfs devs
+ eval echo -n 
+ echo -n
+ eval btrfs_devs=""
+ btrfs_devs=
+ echo
+ cut -d  -f 1
+ first_dev=
+ get_conf lockfile /var/lock/subsys/ceph lock file
+ var=lockfile
+ def=/var/lock/subsys/ceph
+ key=lock file
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 lock file
+ eval echo -n /var/lock/subsys/ceph
+ echo -n /var/lock/subsys/ceph
+ eval lockfile="/var/lock/subsys/ceph"
+ lockfile=/var/lock/subsys/ceph
+ dirname /var/lock/subsys/ceph
+ lockdir=/var/lock/subsys
+ [ ! -d /var/lock/subsys ]
+ lockfile=
+ get_conf pre_stop  pre stop command
+ var=pre_stop
+ def=
+ key=pre stop command
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 pre stop command
+ eval echo -n 
+ echo -n
+ eval pre_stop=""
+ pre_stop=
+ get_conf post_stop  post stop command
+ var=post_stop
+ def=
+ key=post stop command
+ shift
+ shift
+ shift
+ [ -z  ]
+ [ 0 -eq 1 ]
+ /usr/local/bin/ceph-conf -c /etc/ceph/ceph.conf -n osd.1 post stop command
+ eval echo -n 
+ echo -n
+ eval post_stop=""
+ post_stop=
+ [ -n  ]
+ stop_daemon osd.1 ceph-osd /var/run/ceph/osd.1.pid
+ name=osd.1
+ daemon=ceph-osd
+ pidfile=/var/run/ceph/osd.1.pid
+ signal=
+ action=
+ [ -z  ]
+ action=Stopping
+ echo -n Stopping Ceph osd.1 on gamma...
Stopping Ceph osd.1 on gamma...+ do_cmd while [ 1 ]; do 
	[ -e /var/run/ceph/osd.1.pid ] || break
	pid=`cat /var/run/ceph/osd.1.pid`
	while [ -e /proc/$pid ] && grep -q ceph-osd /proc/$pid/cmdline ; do
	    cmd="kill  $pid"
	    echo -n $cmd...
	    $cmd
	    sleep 1
	    continue
	done
	break
    done
+ [ -z ssh gamma ]
+ [ 0 -eq 1 ]
+ ssh gamma cd /etc/ceph ; ulimit -c unlimited ; while [ 1 ]; do 
	[ -e /var/run/ceph/osd.1.pid ] || break
	pid=`cat /var/run/ceph/osd.1.pid`
	while [ -e /proc/$pid ] && grep -q ceph-osd /proc/$pid/cmdline ; do
	    cmd="kill  $pid"
	    echo -n $cmd...
	    $cmd
	    sleep 1
	    continue
	done
	break
    done
+ echo done
done
+ [ -n  ]
+ [ -n  ]
+ [ 0 -eq 1 ]
+ exit 0

  
Thanks,
Ramu.  


