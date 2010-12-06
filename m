From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Fail to compile ceph-client-standalone: master-backport
Date: Mon, 6 Dec 2010 13:53:43 +0800
Message-ID: <1291614823.3788.4.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:46193 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836Ab0LFFwV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 00:52:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: mllv <mllv@tnsoft.com.cn>


Hi ,

 I git ceph-client-standalone : master-backport 
from git://ceph.newdream.net/git/ceph-client-standalone.git

but fail to compile it ,what is it wrong ?  the detail steps and logs
attached below.

 Thanks.

Jeff


===============================================================================

jeff@cephhost:~/work/ceph$ git clone
git://ceph.newdream.net/git/ceph-client-standalone.git
Initialized empty Git repository
in /home/jeff/work/ceph/ceph-client-standalone/.git/
remote: Counting objects: 2435, done.
remote: Compressing objects: 100% (1391/1391), done.
remote: Total 2435 (delta 1724), reused 1593 (delta 1033)
Receiving objects: 100% (2435/2435), 760.24 KiB | 191 KiB/s, done.
Resolving deltas: 100% (1724/1724), done.

jeff@cephhost:~/work/ceph$ cd ceph-client-standalone/
jeff@cephhost:~/work/ceph/ceph-client-standalone$ git branch
master-backport origin/master-backport
Branch master-backport set up to track remote branch master-backport
from origin.

jeff@cephhost:~/work/ceph/ceph-client-standalone$ git checkout
master-backport
Switched to branch 'master-backport'
jeff@cephhost:~/work/ceph/ceph-client-standalone$ ls
ceph  debian  dkms  dkms.conf  include-ceph  include-crush
last_upstream_commit  libceph  rbd  start  upstream_version.h
jeff@cephhost:~/work/ceph/ceph-client-standalone$ cd libceph/
jeff@cephhost:~/work/ceph/ceph-client-standalone/libceph$ make
make -C /lib/modules/2.6.35-22-generic/build
M=/home/jeff/work/ceph/ceph-client-standalone/libceph CONFIG_CEPH_LIB=m
modules

....................................................................................................

  LD [M]  /home/jeff/work/ceph/ceph-client-standalone/libceph/libceph.o
  Building modules, stage 2.
  MODPOST 1 modules

CC      /home/jeff/work/ceph/ceph-client-standalone/libceph/libceph.mod.o
  LD [M]  /home/jeff/work/ceph/ceph-client-standalone/libceph/libceph.ko
make[1]:Leaving `/usr/src/linux-headers-2.6.35-22-generic'

jeff@cephhost:~/work/ceph/ceph-client-standalone/libceph$ cd ..
jeff@cephhost:~/work/ceph/ceph-client-standalone$ cd ceph/
jeff@cephhost:~/work/ceph/ceph-client-standalone/ceph$ make 
make -C /lib/modules/2.6.35-22-generic/build
M=/home/jeff/work/ceph/ceph-client-standalone/ceph CONFIG_CEPH_FS=m
modules

...................................................................................

  CC [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/strings.o
  CC [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph_frag.o
  CC [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/debugfs.o
  LD [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING:
"ceph_msgr_flush" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_con_close" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_con_init" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_buffer_release" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_pr_addr" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_parse_options" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_writepages" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_monc_validate_auth" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_monc_do_statfs" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_alloc_page_vector" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"__ceph_open_session" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_copy_user_to_page_vector" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_destroy_client" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_sync" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_pagelist_release" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_put_page_vector" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_buffer_new" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_msg_dump" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_compare_options" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_start_request" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_zero_page_vector_range" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_con_send" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_readpages" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_monc_got_mdsmap" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_calc_file_object_mapping" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_pagelist_set_cursor" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_new_request" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_wait_request" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_get_direct_page_vector" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_calc_object_layout" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_pagelist_append" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_pagelist_reserve" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_check_fsid" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_release_page_vector" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_pagelist_truncate" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_msg_type_name" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_msg_new" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_copy_page_vector_to_user" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_caps_for_mode" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_msg_last_put" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_flags_to_mode" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_con_open" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_osdc_release_request" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_calc_pg_primary" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_create_client" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
WARNING:
"ceph_con_keepalive" [/home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko] undefined!
  CC      /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.mod.o
  LD [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.ko
make[1]:leaving `/usr/src/linux-headers-2.6.35-22-generic'
jeff@cephhost:~/work/ceph/ceph-client-standalone/ceph$ 




