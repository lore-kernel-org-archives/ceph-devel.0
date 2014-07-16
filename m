From: Amit Tiwary <tiwaryamt@gmail.com>
Subject: extremely-high-unreasonable number of threads and memory usage on the client side using librados C++ api
Date: Wed, 16 Jul 2014 10:24:10 +0000 (UTC)
Message-ID: <loom.20140716T121228-862@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59157 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932680AbaGPKY0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jul 2014 06:24:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1X7MNs-0002k8-FA
	for ceph-devel@vger.kernel.org; Wed, 16 Jul 2014 12:24:24 +0200
Received: from NSG-Static-099.53.71.182.airtel.in ([NSG-Static-099.53.71.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 12:24:24 +0200
Received: from tiwaryamt by NSG-Static-099.53.71.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 12:24:24 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph Developers, we are using C++ librados (ceph 0.67.9) to interact with 
two ceph clusters. cluster1(test) has 30 osds whereas cluster2(production) 
has 936 osds. We are hitting extremely-high-unreasonable number of threads 
and memory usage on the client side while interacting with cluster2 for 
performing even basic operations like stat() and read().

Scenario: consider a C++ app that performs simple-operations using librados:
1. cluster.init( ceph_client_id );
2. cluster.conf_read_file( ceph_conf_path );
3. cluster.connect();
4. cluster.ioctx_create( pool_name, ioctx);
5. while( in_file >> object_id )
     ioctx.stat( object_id, &size, &mtime);
6. ioctx.close();
7. cluster.shutdown();

When stat-ing or reading 710 objects on cluster 2, ps -o thcnt,size,rss,vsz 
pid_c++_app gives:
THCNT  SIZE    RSS    VSZ
    1 14656   8564   73148 (start of program)
   11 149032  11844  214844 (after step 1,2,3,4)
  867 1029668 15536 1095480 (during step 5)
  867 1029668 15536 1095480 (after ioctx.close)
    1 187592  13844 253404 (after cluster.shutdown)

Similarly, when stat-ing 2000 non-existent objects on cluster 2, the 
measures are given below:
THCNT  SIZE(KB)  RSS(KB)  VSZ(KB)
    1  14656     8564  73152
   11  149024   11924 214840
 1199  1371908 16672 1437724
 1199  1371908 16672 1437724
    1  188536    14212 254352 

On cluster1, the thread-count for same operations never goes above 25. Is is 
related to number of osds (are threads being created per osd and cleaned up 
only during shutdown?)

Is there any workaround that could be of any help? Any configurable 
parameter that disallows librados to cache/persist threads and release only 
at shutdown?

Note: We were hit with assertion and pthread_create failures few months ago 
and had to increase the ulimit on number of open files (ulimit -n)  
http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/19225

Regards,
Amit Tiwary

