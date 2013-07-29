From: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Subject: mds.0 crashed with 0.61.7
Date: Mon, 29 Jul 2013 17:44:32 +0200
Message-ID: <20130729154432.GA24611@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:7018 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3G2Po6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 11:44:58 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

my Ceph test cluster runs fine with 0.61.4.

I have removed all data and have setup a new cluster with 0.61.7 using
the same configuration (see ceph.conf).

After
  mkcephfs -c /etc/ceph/ceph.conf -a
  /etc/init.d/ceph -a start
the mds.0 crashed:

    -1> 2013-07-29 17:02:57.626886 7fba2a8cd700  1 -- 10.0.0.231:6800/806 <== osd.121 10.0.0.231:6834/5350 1 ==== osd_op_reply(4 mds_snaptable [read 0~0] ack = -2 (No such file or directory)) v4 ==== 112+0+0 (2505332647 0 0) 0x13b7a30 con 0x7fba20010200
     0> 2013-07-29 17:02:57.627838 7fba2a8cd700 -1 mds/MDSTable.cc: In function 'void MDSTable::load_2(int, ceph::bufferlist&, Context*)' thread 7fba2a8cd700 time 2013-07-29 17:02:57.626907
mds/MDSTable.cc: 150: FAILED assert(0)

 ceph version 0.61.7 (8f010aff684e820ecc837c25ac77c7a05d7191ff)
 1: (MDSTable::load_2(int, ceph::buffer::list&, Context*)+0x4cf) [0x6e398f]
 2: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xe1e) [0x73c16e]
 3: (MDS::handle_core_message(Message*)+0x93f) [0x4db2ff]
 4: (MDS::_dispatch(Message*)+0x2f) [0x4db3df]
 5: (MDS::ms_dispatch(Message*)+0x1a3) [0x4dd163]
 6: (DispatchQueue::entry()+0x399) [0x7ddd69]
 7: (DispatchQueue::DispatchThread::entry()+0xd) [0x7d343d]
 8: (()+0x77b6) [0x7fba2f51e7b6]
 9: (clone()+0x6d) [0x7fba2e15dd6d]
 ...

At this point I have no rbd, no cephfs, no ceph-fuse configured.

  /etc/init.d/ceph -a stop
  /etc/init.d/ceph -a start

doesn't help.

Any help would be appreciated.

Andreas Friedrich
----------------------------------------------------------------------
FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1, 33106 Paderborn, Germany
Tel: +49 (5251) 525-1512
Fax: +49 (5251) 525-321512
Email: andreas.friedrich@ts.fujitsu.com
Web: ts.fujitsu.com
Company details: de.ts.fujitsu.com/imprint
----------------------------------------------------------------------

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ceph.conf"

[global]
        #debug ms = 20
        debug ITX = 0
	debug monc = 0
	debug rados = 0
	#
	# enable secure authentication
	# auth supported = cephx
        # keyring = /etc/ceph/keyring.client
	#
	# -- or -- disable secure authentication
	# auth supported = none

	# auth cluster required = cephx
	# auth service required = cephx
	# auth client required = cephx

	auth cluster required = none
	auth service required = none
	auth client required = none

        # allow ourselves to open a lot of files
        max open files = 131072

        # set log file
        # log file = /ceph-log/log/$name.log
        # log_to_syslog = true        # uncomment this line to log to syslog

        # set up pid files
        pid file = /var/run/ceph/$name.pid

        # If you want to run a IPv6 cluster, set this to true. Dual-stack isn't possible
        #ms bind ipv6 = true
	public network = 10.0.0.0/24
	cluster network = 10.0.0.0/24

	# environment for startup with rosckets
        # environment = LD_PRELOAD=/usr/lib64/libsdp.so.1
        # environment = LD_PRELOAD=/usr/local/lib/rsocket/librspreload.so.1.0.0 LD_LIBRARY_PATH=/usr/local/lib/rsocket:\\\$LD_LIBRARY_PATH

### [client.radosgw.ceph]
### 
###         host = ceph
###         # auto start = yes
###         log file = /var/log/ceph/$name.log
###         keyring = /etc/ceph/keyring.radosgw.ceph
###         rgw socket path = /var/run/radosgw.sock
###         # debug rgw = 20
###         # debug ms = 1

[mon]
        #mon data = /var/lib/ceph/mon/$cluster-$id
        mon data = /data/mon$id
        # debug ms = 0     ; see message traffic
        # debug mon = 5   ; monitor 
        # debug paxos = 5 ; monitor replication
        # debug auth = 5  ; authentication code
        # keyring = /etc/ceph/keyring.$name
	debug optracker = 0
        mon debug dump transactions = false

[mon.0]
        host = cibst1
        mon addr = 10.0.0.231:6789

[mon.1]
        host = cibst2
        mon addr = 10.0.0.232:6789

[mon.3]
        host = cibst3
        mon addr = 10.0.0.233:6789

[mds]
        # debug mds = 1
        # keyring = /etc/ceph/keyring.$name
	debug optracker = 0

[mds.0]
        host = cibst1

[mds.1]
        host = cibst2

[osd]

        # journal dio = false
        # journal aio = true
        #osd data = /var/lib/ceph/osd/$cluster-$id
        osd data = /data/$name
        # osd journal = /journals/$name/journal
        # osd journal = ""
        osd journal size = 5120
        #osd journal size = 1024

	filestore max sync interval = 30
	filestore min sync interval = 29
	filestore flusher = false
	filestore queue max ops = 10000

	debug optracker = 0

        # keyring = /etc/ceph/keyring.$name
        # debug osd = 20
        # debug osd = 0         ; waiters
        # debug ms = 10         ; message traffic
        # debug filestore = 20 ; local object storage
        debug journal = 0   ; local journaling
        # debug monc = 5      ; monitor interaction, startup

	# osd op threads = 24
	# osd disk threads = 24
	# filestore op threads = 6
	# filestore queue max ops = 24
	### fstype = xfs
	osd mkfs type = xfs


[osd.110]
        host = cibst1
        devs = /dev/fioa6
        osd journal = /dev/fiob1
[osd.111]
        host = cibst1
        devs = /dev/fioa7
        osd journal = /dev/fiob2
[osd.112]
        host = cibst1
        devs = /dev/fioa8
        osd journal = /dev/fiob3
[osd.113]
        host = cibst1
        devs = /dev/fioa9
        osd journal = /dev/fiob5
[osd.114]
        host = cibst1
        devs = /dev/fiob6
        osd journal = /dev/fioa1
[osd.115]
        host = cibst1
        devs = /dev/fiob7
        osd journal = /dev/fioa2
[osd.116]
        host = cibst1
        devs = /dev/fiob8
        osd journal = /dev/fioa3
[osd.117]
        host = cibst1
        devs = /dev/fiob9
        osd journal = /dev/fioa5
[osd.118]
        host = cibst1
        devs = /dev/fioc6
        osd journal = /dev/fiod1
[osd.119]
        host = cibst1
        devs = /dev/fioc7
        osd journal = /dev/fiod2
[osd.120]
        host = cibst1
        devs = /dev/fioc8
        osd journal = /dev/fiod3
[osd.121]
        host = cibst1
        devs = /dev/fioc9
        osd journal = /dev/fiod5
[osd.122]
        host = cibst1
        devs = /dev/fiod6
        osd journal = /dev/fioc1
[osd.123]
        host = cibst1
        devs = /dev/fiod7
        osd journal = /dev/fioc2
[osd.124]
        host = cibst1
        devs = /dev/fiod8
        osd journal = /dev/fioc3
[osd.125]
        host = cibst1
        devs = /dev/fiod9
        osd journal = /dev/fioc5

[osd.210]
        host = cibst2
        devs = /dev/fioa6
        osd journal = /dev/fiob1
[osd.211]
        host = cibst2
        devs = /dev/fioa7
        osd journal = /dev/fiob2
[osd.212]
        host = cibst2
        devs = /dev/fioa8
        osd journal = /dev/fiob3
[osd.213]
        host = cibst2
        devs = /dev/fioa9
        osd journal = /dev/fiob5
[osd.214]
        host = cibst2
        devs = /dev/fiob6
        osd journal = /dev/fioa1
[osd.215]
        host = cibst2
        devs = /dev/fiob7
        osd journal = /dev/fioa2
[osd.216]
        host = cibst2
        devs = /dev/fiob8
        osd journal = /dev/fioa3
[osd.217]
        host = cibst2
        devs = /dev/fiob9
        osd journal = /dev/fioa5
[osd.218]
        host = cibst2
        devs = /dev/fioc6
        osd journal = /dev/fiod1
[osd.219]
        host = cibst2
        devs = /dev/fioc7
        osd journal = /dev/fiod2
[osd.220]
        host = cibst2
        devs = /dev/fioc8
        osd journal = /dev/fiod3
[osd.221]
        host = cibst2
        devs = /dev/fioc9
        osd journal = /dev/fiod5
[osd.222]
        host = cibst2
        devs = /dev/fiod6
        osd journal = /dev/fioc1
[osd.223]
        host = cibst2
        devs = /dev/fiod7
        osd journal = /dev/fioc2
[osd.224]
        host = cibst2
        devs = /dev/fiod8
        osd journal = /dev/fioc3
[osd.225]
        host = cibst2
        devs = /dev/fiod9
        osd journal = /dev/fioc5

[osd.310]
        host = cibst3
        devs = /dev/fioa6
        osd journal = /dev/fiob1
[osd.311]
        host = cibst3
        devs = /dev/fioa7
        osd journal = /dev/fiob2
[osd.312]
        host = cibst3
        devs = /dev/fioa8
        osd journal = /dev/fiob3
[osd.313]
        host = cibst3
        devs = /dev/fioa9
        osd journal = /dev/fiob5
[osd.314]
        host = cibst3
        devs = /dev/fiob6
        osd journal = /dev/fioa1
[osd.315]
        host = cibst3
        devs = /dev/fiob7
        osd journal = /dev/fioa2
[osd.316]
        host = cibst3
        devs = /dev/fiob8
        osd journal = /dev/fioa3
[osd.317]
        host = cibst3
        devs = /dev/fiob9
        osd journal = /dev/fioa5
[osd.318]
        host = cibst3
        devs = /dev/fioc6
        osd journal = /dev/fiod1
[osd.319]
        host = cibst3
        devs = /dev/fioc7
        osd journal = /dev/fiod2
[osd.320]
        host = cibst3
        devs = /dev/fioc8
        osd journal = /dev/fiod3
[osd.321]
        host = cibst3
        devs = /dev/fioc9
        osd journal = /dev/fiod5
[osd.322]
        host = cibst3
        devs = /dev/fiod6
        osd journal = /dev/fioc1
[osd.323]
        host = cibst3
        devs = /dev/fiod7
        osd journal = /dev/fioc2
[osd.324]
        host = cibst3
        devs = /dev/fiod8
        osd journal = /dev/fioc3
[osd.325]
        host = cibst3
        devs = /dev/fiod9
        osd journal = /dev/fioc5

[osd.410]
        host = cibst4
        devs = /dev/fioa6
        osd journal = /dev/fiob1
[osd.411]
        host = cibst4
        devs = /dev/fioa7
        osd journal = /dev/fiob2
[osd.412]
        host = cibst4
        devs = /dev/fioa8
        osd journal = /dev/fiob3
[osd.413]
        host = cibst4
        devs = /dev/fioa9
        osd journal = /dev/fiob5
[osd.414]
        host = cibst4
        devs = /dev/fiob6
        osd journal = /dev/fioa1
[osd.415]
        host = cibst4
        devs = /dev/fiob7
        osd journal = /dev/fioa2
[osd.416]
        host = cibst4
        devs = /dev/fiob8
        osd journal = /dev/fioa3
[osd.417]
        host = cibst4
        devs = /dev/fiob9
        osd journal = /dev/fioa5
[osd.418]
        host = cibst4
        devs = /dev/fioc6
        osd journal = /dev/fiod1
[osd.419]
        host = cibst4
        devs = /dev/fioc7
        osd journal = /dev/fiod2
[osd.420]
        host = cibst4
        devs = /dev/fioc8
        osd journal = /dev/fiod3
[osd.421]
        host = cibst4
        devs = /dev/fioc9
        osd journal = /dev/fiod5
[osd.422]
        host = cibst4
        devs = /dev/fiod6
        osd journal = /dev/fioc1
[osd.423]
        host = cibst4
        devs = /dev/fiod7
        osd journal = /dev/fioc2
[osd.424]
        host = cibst4
        devs = /dev/fiod8
        osd journal = /dev/fioc3
[osd.425]
        host = cibst4
        devs = /dev/fiod9
        osd journal = /dev/fioc5

[osd.510]
        host = cibst5
        devs = /dev/fioa6
        osd journal = /dev/fiob1
[osd.511]
        host = cibst5
        devs = /dev/fioa7
        osd journal = /dev/fiob2
[osd.512]
        host = cibst5
        devs = /dev/fioa8
        osd journal = /dev/fiob3
[osd.513]
        host = cibst5
        devs = /dev/fioa9
        osd journal = /dev/fiob5
[osd.514]
        host = cibst5
        devs = /dev/fiob6
        osd journal = /dev/fioa1
[osd.515]
        host = cibst5
        devs = /dev/fiob7
        osd journal = /dev/fioa2
[osd.516]
        host = cibst5
        devs = /dev/fiob8
        osd journal = /dev/fioa3
[osd.517]
        host = cibst5
        devs = /dev/fiob9
        osd journal = /dev/fioa5
[osd.518]
        host = cibst5
        devs = /dev/fioc6
        osd journal = /dev/fiod1
[osd.519]
        host = cibst5
        devs = /dev/fioc7
        osd journal = /dev/fiod2
[osd.520]
        host = cibst5
        devs = /dev/fioc8
        osd journal = /dev/fiod3
[osd.521]
        host = cibst5
        devs = /dev/fioc9
        osd journal = /dev/fiod5
[osd.522]
        host = cibst5
        devs = /dev/fiod6
        osd journal = /dev/fioc1
[osd.523]
        host = cibst5
        devs = /dev/fiod7
        osd journal = /dev/fioc2
[osd.524]
        host = cibst5
        devs = /dev/fiod8
        osd journal = /dev/fioc3
[osd.525]
        host = cibst5
        devs = /dev/fiod9
        osd journal = /dev/fioc5

[osd.610]
        host = cibst6
        devs = /dev/fioa6
        osd journal = /dev/fiob1
[osd.611]
        host = cibst6
        devs = /dev/fioa7
        osd journal = /dev/fiob2
[osd.612]
        host = cibst6
        devs = /dev/fioa8
        osd journal = /dev/fiob3
[osd.613]
        host = cibst6
        devs = /dev/fioa9
        osd journal = /dev/fiob5
[osd.614]
        host = cibst6
        devs = /dev/fiob6
        osd journal = /dev/fioa1
[osd.615]
        host = cibst6
        devs = /dev/fiob7
        osd journal = /dev/fioa2
[osd.616]
        host = cibst6
        devs = /dev/fiob8
        osd journal = /dev/fioa3
[osd.617]
        host = cibst6
        devs = /dev/fiob9
        osd journal = /dev/fioa5
[osd.618]
        host = cibst6
        devs = /dev/fioc6
        osd journal = /dev/fiod1
[osd.619]
        host = cibst6
        devs = /dev/fioc7
        osd journal = /dev/fiod2
[osd.620]
        host = cibst6
        devs = /dev/fioc8
        osd journal = /dev/fiod3
[osd.621]
        host = cibst6
        devs = /dev/fioc9
        osd journal = /dev/fiod5
[osd.622]
        host = cibst6
        devs = /dev/fiod6
        osd journal = /dev/fioc1
[osd.623]
        host = cibst6
        devs = /dev/fiod7
        osd journal = /dev/fioc2
[osd.624]
        host = cibst6
        devs = /dev/fiod8
        osd journal = /dev/fioc3
[osd.625]
        host = cibst6
        devs = /dev/fiod9
        osd journal = /dev/fioc5

--LZvS9be/3tNcYl/X--
