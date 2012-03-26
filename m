From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: problems when hadoop runs upon ceph
Date: Mon, 26 Mar 2012 09:38:37 -0700
Message-ID: <F9608BCF7A3D469288597C784FDA4AC7@dreamhost.com>
References: <1765b87.66.136439257f9.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64377 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738Ab2CZQiq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 12:38:46 -0400
Received: by yhmm54 with SMTP id m54so3950554yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 09:38:45 -0700 (PDT)
In-Reply-To: <1765b87.66.136439257f9.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lixiaobing10@otcaix.iscas.ac.cn
Cc: ceph-devel@vger.kernel.org

Is this the same cluster you were unable to get the MDS out of "creating" on? Hadoop won't work without an active MDS since it can't mount the filesystem. :) 

The reason your MDS isn't starting up is complicated; look for an email on that shortly...
-Greg


On Saturday, March 24, 2012 at 12:18 AM, lixiaobing10@otcaix.iscas.ac.cn wrote:

> Hi ceph-devel,
> 
> I installed ceph-0.44, which can be mounted by ceph-fuse correctly. Besides, hadoop-0.20.205.0 patched with hadoop-0.20.205.0-cephfs1.patch can run correctly too, but with hdfs as the underlying fs. (refered to http://ceph.newdream.net/wiki/Hadoop_FileSystem)
> 
> However, when I let hadoop use ceph as the fs, I encountered this problem: 
> 
> 12/03/24 14:45:47 INFO ceph.CephFileSystem: initialize:Ceph initialization arguments: CephFSInterface -k /data/keyring.mds.0 -n client.admin --auth-supported=cephx -m 192.168.122.201:6789 --client-readahead-max-periods=1
> 12/03/24 14:45:47 FATAL ceph.CephFileSystem: initialize:Ceph initialization failed!
> Bad connection to FS. command aborted. exception: Ceph initialization failed!
> 
> I have traced the source code from java-side to ceph-side, and found the connection between them failed to establish. But I have no idea about the real cause. Could someone give me any suggestion on this problem?
> 
> Additionally, hadoop-0.20.205.0 patched with hadoop-0.20.205.0-cephfs1.patch can work with ceph-0.20.1, although it would crashed during reduce task phase, and that is why I turned to the latest ceph version.
> 
> Thanks for your attention!
> 
> Best,
> Xiaobing
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



