From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Documentation Error - Manual Deployment - Monitor Bootstrapping
Date: Thu, 17 Apr 2014 14:52:30 -0500
Message-ID: <2b647dfca2b13639319ace92a7a0b415@localhost>
Reply-To: YS3fpFE2ykfB@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:58080 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbaDQUBI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Apr 2014 16:01:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

After following the directions 
(http://ceph.com/docs/master/install/manual-deployment/#monitor-bootstrapping) 
to manually deploy and bootstrap the monitor, I find that the init 
scripts will not start the ceph-mon process.

I am running Ceph 0.78, Gentoo Ebuild.

After completing step # 13, my /etc/ceph/ceph.conf file reads like this:
-------------
[global]
fsid = 6dcb9db5-b974-4164-83a0-381ea740a351
mon initial members = cephmon
mon host = 10.208.39.100
-------------

When I try to start the monitor, nothing useful happens:
---------------
# sh -x /usr/lib/ceph/ceph_init.sh start
++ dirname /usr/lib/ceph/ceph_init.sh
+ '[' /usr/lib/ceph = . ']'
+ BINDIR=/usr/bin
+ SBINDIR=/usr/sbin
+ LIBDIR=/usr/lib/ceph
+ ETCDIR=/etc/ceph
+ test -f /usr/lib/ceph/ceph_common.sh
+ . /usr/lib/ceph/ceph_common.sh
++ CCONF=/usr/bin/ceph-conf
++ default_conf=/etc/ceph/ceph.conf
++ conf=/etc/ceph/ceph.conf
+++ hostname -s
++ hostname=cephmon
+ EXIT_STATUS=0
+ options=
+ version=0
+ dovalgrind=
+ docrun=
+ allhosts=0
+ debug=0
+ monaddr=
+ dofsmount=1
+ dofsumount=0
+ verbose=0
+ grep -q '^-'
+ echo start
+ verify_conf
+ '[' -x /etc/ceph/fetch_config ']'
+ '[' '!' -e /etc/ceph/ceph.conf ']'
+ command=start
+ '[' -n start ']'
+ shift
+ get_local_name_list
+ local=
+ get_local_daemon_list mon
+ type=mon
+ '[' -d /var/lib/ceph/mon ']'
++ find -L /var/lib/ceph/mon -mindepth 1 -maxdepth 1 -type d -printf 
'%f\n'
+ for i in '`find -L /var/lib/ceph/$type -mindepth 1 -maxdepth 1 -type d 
-printf '\''%f\n'\''`'
+ '[' -e /var/lib/ceph/mon/ceph-cephmon/sysvinit ']'
+ get_local_daemon_list osd
+ type=osd
+ '[' -d /var/lib/ceph/osd ']'
+ get_local_daemon_list mds
+ type=mds
+ '[' -d /var/lib/ceph/mds ']'
+ get_name_list
+ orig=
++ egrep -v '^mon$'
++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l mon
++ true
++ egrep -v '^mds$'
++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l mds
++ true
++ egrep -v '^osd$'
++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -l osd
++ true
+ allconf=' '
+ '[' -z '' ']'
+ what=' '
+ return
+ '[' start = stop ']'
+ '[' start = start -a /usr/bin '!=' . ']'
+ '[' '' = '' ']'
+ ceph-disk activate-all
+ exit 0
---------------


What am I missing here?



-- 
Thanks,
Dyweni
