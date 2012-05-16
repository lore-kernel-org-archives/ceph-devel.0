From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: issue with mounting ceph cluster over NFS
Date: Wed, 16 May 2012 00:34:37 -0700
Message-ID: <4FB3588D.60502@inktank.com>
References: <loom.20120515T173030-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62089 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759514Ab2EPHek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 03:34:40 -0400
Received: by pbbrp8 with SMTP id rp8so733841pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 00:34:40 -0700 (PDT)
In-Reply-To: <loom.20120515T173030-954@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/15/2012 08:31 AM, madhusudhana U wrote:
> Hi,
> I have a ceph cluster with 5 nodes, in which 2 are MDS, 3 are MON and all

Is only one MDS active?

> 5 acts as OSD. I have mounted the ceph cluster in one node in the cluster
> and exported the mounted dir via NFS. Below is my mount and exports file
> looks like
>
>
> ceph-fuse on /ceph_cluster type fuse.ceph-fuse
> (rw,nosuid,nodev,allow_other,default_permissions)
> [root@ceph-node-15 ~]# cat /etc/exports
> /ceph_cluster   *(rw,no_root_squash,fsid=10001)
>
> Below is automount entry
>
> madhusudhan_ceph -
> rw,intr,retrans=10,timeo=600,hard,rsize=32768,wsize=32768,tcp,noacl      ceph-
> node-15:/ceph_cluster/madhusudhana_ceph
>
> I am facing strange issue with one of my t_make build, where its failing
> for some unknown reason. But the same build works fine on local machine and
> build gets completed. There are no difference in the data as its been synced
> from perforce to both the directories.

Does the build work on ceph-fuse without nfs?

> Can someone put some lime light on the best way to mount the ceph cluster
> via NFS (using autofs to mount the dir) ? and is there anything that i need to
> make sure for mounting ceph cluster via NFS ? I heard that, t_make will fail
> if underlying file system can't handle 64b file handles [inode number/fileid]
> (faced the same issue with isilon storage). Can ceph handle above condition ?

Ceph inodes are always 64-bit. The only exception is ceph-fuse on a
32-bit machine, which won't work in general due to the restricted inode
size.
