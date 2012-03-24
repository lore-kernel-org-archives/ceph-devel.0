From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: problems when hadoop runs upon ceph
Date: Sat, 24 Mar 2012 08:52:10 -0700
Message-ID: <9CB99878-A764-4A57-91C9-797FBD6D0402@cs.ucsc.edu>
References: <1765b87.66.136439257f9.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:39313 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab2CXPwL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Mar 2012 11:52:11 -0400
In-Reply-To: <1765b87.66.136439257f9.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lixiaobing10@otcaix.iscas.ac.cn
Cc: ceph-devel@vger.kernel.org


On Mar 24, 2012, at 12:18 AM, lixiaobing10@otcaix.iscas.ac.cn wrote:

> 12/03/24 14:45:47 INFO ceph.CephFileSystem: initialize:Ceph initialization arguments: CephFSInterface -k /data/keyring.mds.0 -n client.admin --auth-supported=cephx  -m 192.168.122.201:6789 --client-readahead-max-periods=1
> 12/03/24 14:45:47 FATAL ceph.CephFileSystem: initialize:Ceph initialization failed!
> Bad connection to FS. command aborted. exception: Ceph initialization failed!

Can you try turning on client debugging? In your Hadoop configuration file core-site.xml:

<property>
    <name>fs.ceph.commandLine</name>
    <value> --debug_client 20 --debug_ms 20</value>
</property>

> 
> I have traced the source code from java-side to ceph-side, and found the connection between them failed to establish.

Where was the failure exactly? I suspect that the failure is occurring when ceph_mount(..) is being called.

- Noah