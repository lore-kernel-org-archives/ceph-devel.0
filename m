From: Walker H Haddock <whaddock@uab.edu>
Subject: RE: Ceph Manual Deployment for version 94.2
Date: Sun, 9 Aug 2015 19:40:34 +0000
Message-ID: <ED6C2349E87E9848AE0A2DAE891AD0A4222DEAE6@UABEXMB1.ad.uab.edu>
References: <ED6C2349E87E9848AE0A2DAE891AD0A4222DE6BE@UABEXMB1.ad.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from uabexch3.ad.uab.edu ([138.26.5.132]:49436 "EHLO
	uabexch3.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbHITkh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Aug 2015 15:40:37 -0400
In-Reply-To: <ED6C2349E87E9848AE0A2DAE891AD0A4222DE6BE@UABEXMB1.ad.uab.edu>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Correction. The version of Ceph is 94.1
ceph.x86_64 1:0.94.1-0.el7.centos

________________________________________
From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.org] on behalf of Walker H Haddock [whaddock@uab.edu]
Sent: Sunday, August 09, 2015 7:22 AM
To: ceph-devel@vger.kernel.org
Subject: Ceph Manual Deployment for version 94.2

In CentOS 7,
In Step 16, http://ceph.com/docs/master/install/manual-deployment/,

The /etc/init.d/ceph script fails with no error messages unless the file /var/lib/ceph/mon/{node name}sysvinit exists.

The procedure as documented worked on an Ubuntu distribution but would not start on the CentOS 7 distribution.
The documentation implies that this is only necessary to start the cluster on reboot of the node, but the service would not start using the init script without the file being created.

sudo sh -x /etc/init.d/ceph start mon.ceph07
...
+ cluster=ceph
+ '[' -e /var/lib/ceph/mon/ceph-ceph07/upstart ']'
+ '[' -e /var/lib/ceph/mon/ceph-ceph07/sysvinit ']'
+ '[' -z '' ']'
+ return 1
+ continue
+ '[' start = start -a /usr/bin '!=' . ']'
+ '[' mon.ceph07 = '' ']'
+ echo mon.ceph07
+ grep -q '^osd$'
+ exit 0

[ceph@ceph07 ~]$ sudo ls -l /var/lib/ceph/mon/ceph-ceph07
total 4
-rw-r--r--. 1 root root  0 Aug  8 16:47 done
-rw-r--r--. 1 root root 77 Aug  8 16:47 keyring
drwxr-xr-x. 2 root root 80 Aug  8 16:47 store.db
[ceph@ceph07 ~]$ sudo touch /var/lib/ceph/mon/ceph-ceph07/sysvinit
[ceph@ceph07 ~]$ sudo ls -l /var/lib/ceph/mon/ceph-ceph07
total 4
-rw-r--r--. 1 root root  0 Aug  8 16:47 done
-rw-r--r--. 1 root root 77 Aug  8 16:47 keyring
drwxr-xr-x. 2 root root 80 Aug  8 16:47 store.db
-rw-r--r--. 1 root root  0 Aug  9 07:06 sysvinit
[ceph@ceph07 ~]$ sudo sh -x /etc/init.d/ceph start mon.ceph07
...
+ '[' -e /var/lib/ceph/mon/ceph-ceph07/upstart ']'
+ '[' -e /var/lib/ceph/mon/ceph-ceph07/sysvinit ']'
+ host=ceph07
+ echo '=== mon.ceph07 === '
=== mon.ceph07 ===
+ return 0
...



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html