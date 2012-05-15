From: madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: issue with mounting ceph cluster over NFS
Date: Tue, 15 May 2012 15:31:11 +0000 (UTC)
Message-ID: <loom.20120515T173030-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44351 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758305Ab2EOPbW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 May 2012 11:31:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SUJia-0000Nz-RO
	for ceph-devel@vger.kernel.org; Tue, 15 May 2012 17:31:21 +0200
Received: from Static-115.229.96.14.tataidc.co.in ([Static-115.229.96.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 15 May 2012 17:31:20 +0200
Received: from madhusudhana.u.acharya by Static-115.229.96.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 15 May 2012 17:31:20 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I have a ceph cluster with 5 nodes, in which 2 are MDS, 3 are MON and all 
5 acts as OSD. I have mounted the ceph cluster in one node in the cluster
and exported the mounted dir via NFS. Below is my mount and exports file 
looks like


ceph-fuse on /ceph_cluster type fuse.ceph-fuse 
(rw,nosuid,nodev,allow_other,default_permissions)
[root@ceph-node-15 ~]# cat /etc/exports
/ceph_cluster   *(rw,no_root_squash,fsid=10001)

Below is automount entry

madhusudhan_ceph -
rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp,noacl      ceph-
node-15:/ceph_cluster/madhusudhana_ceph

I am facing strange issue with one of my t_make build, where its failing
for some unknown reason. But the same build works fine on local machine and
build gets completed. There are no difference in the data as its been synced 
from perforce to both the directories.

Can someone put some lime light on the best way to mount the ceph cluster 
via NFS (using autofs to mount the dir) ? and is there anything that i need to 
make sure for mounting ceph cluster via NFS ? I heard that, t_make will fail
if underlying file system can't handle 64b file handles [inode number/fileid] 
(faced the same issue with isilon storage). Can ceph handle above condition ?

Any help/input greatly appreciated.

Thanks


