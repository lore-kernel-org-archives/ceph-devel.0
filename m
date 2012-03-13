From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: ls -l not listing file attributes inside ceph directory
Date: Tue, 13 Mar 2012 09:13:53 +0000 (UTC)
Message-ID: <loom.20120313T100729-291@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57702 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758680Ab2CMJOL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Mar 2012 05:14:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S7Nnz-00024P-SO
	for ceph-devel@vger.kernel.org; Tue, 13 Mar 2012 10:14:07 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 10:14:07 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 10:14:07 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all
When I run ls -l command inside a folder coming from ceph cluster, 
sometime it will not list file properties. when I run again, it 
will list for some files and not for some. Any idea why this happens ?


[root@ceph-node-9 test35]# ll
total 0
?---------  ? ?      ?               ?            ? arrays
drwxrwxr-x  1 maddy maddy 21513958 Mar 13 12:29 bin
?---------  ? ?      ?               ?            ? BUILDNOTES
?---------  ? ?      ?               ?            ? cadRun
?---------  ? ?      ?               ?            ? chip_tools
?---------  ? ?      ?               ?            ? class
?---------  ? ?      ?               ?            ? clib
drwxrwxr-x  1 maddy maddy60406281 Mar 13 13:56 cmod
?---------  ? ?      ?               ?            ? Makefile
?---------  ? ?      ?               ?            ? Makeppfile
?---------  ? ?      ?               ?            ? NEWBUILD.README
?---------  ? ?      ?               ?            ? NEWPROJ.README
?---------  ? ?      ?               ?            ? TOTAL
[root@ceph-node-9 test35]# pwd
/mnt/maddy_ceph/test35_opensrc/test35
[root@ceph-node-9 test35]# ll
total 87
?---------  ? ?      ?               ?            ? arrays
drwxrwxr-x  1 maddy maddy 21513958 Mar 13 12:29 bin
-r--r--r--  1 maddy maddy    11651 Mar 13 11:52 BUILDNOTES
?---------  ? ?      ?               ?            ? cadRun
?---------  ? ?      ?               ?            ? chip_tools
?---------  ? ?      ?               ?            ? class
?---------  ? ?      ?               ?            ? clib
drwxrwxr-x  1 maddy maddy 64105611 Mar 13 14:39 cmod
-r--r--r--  1 maddy maddy    23337 Mar 13 11:52 Makefile
-r--r--r--  1 maddy maddy     6246 Mar 13 11:52 Makeppfile
-r--r--r--  1 maddy maddy      200 Mar 13 11:52 NEWBUILD.README
-r--r--r--  1 maddy maddy    36596 Mar 13 11:52 NEWPROJ.README
-r--r--r--  1 maddy maddy      300 Mar 13 11:52 TOTAL






