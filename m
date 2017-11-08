From: "Marc Roos" <M.Roos@f1-outsourcing.eu>
Subject: RE: [ceph-users] who is using nfs-ganesha and cephfs?
Date: Wed, 8 Nov 2017 22:53:37 +0100
Message-ID: <15555.9471030303$1510179826@news.gmane.org>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail03.roosit.eu ([212.19.193.213]:55098 "EHLO mail03.roosit.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdKHWXp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Nov 2017 17:23:45 -0500
In-Reply-To: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, sweil <sweil@redhat.com>

 

I, in test environment, centos7, on a luminous osd node, with binaries 
from 
download.ceph.com::ceph/nfs-ganesha/rpm-V2.5-stable/luminous/x86_64/

Having these:
Nov  6 17:41:34 c01 kernel: ganesha.nfsd[31113]: segfault at 0 ip 
00007fa80a151a43 sp 00007fa755ffa2f0 error 4 in 
libdbus-1.so.3.7.4[7fa80a12b000+46000]
Nov  6 17:41:34 c01 kernel: ganesha.nfsd[31113]: segfault at 0 ip 
00007fa80a151a43 sp 00007fa755ffa2f0 error 4 in 
libdbus-1.so.3.7.4[7fa80a12b000+46000]
Nov  6 17:42:16 c01 kernel: ganesha.nfsd[6839]: segfault at 8 ip 
00007fc97a5d3f98 sp 00007fc8c6ffc2f8 error 6 in 
libdbus-1.so.3.7.4[7fc97a5ac000+46000]
Nov  6 17:42:16 c01 kernel: ganesha.nfsd[6839]: segfault at 8 ip 
00007fc97a5d3f98 sp 00007fc8c6ffc2f8 error 6 in 
libdbus-1.so.3.7.4[7fc97a5ac000+46000]
Nov  6 17:47:47 c01 kernel: ganesha.nfsd[7662]: segfault at 4 ip 
00007f15e2afc060 sp 00007f152effc388 error 6 in 
libdbus-1.so.3.7.4[7f15e2ad6000+46000]
Nov  6 17:47:47 c01 kernel: ganesha.nfsd[7662]: segfault at 4 ip 
00007f15e2afc060 sp 00007f152effc388 error 6 in 
libdbus-1.so.3.7.4[7f15e2ad6000+46000]
Nov  6 17:52:25 c01 kernel: ganesha.nfsd[14415]: segfault at 88 ip 
00007f9258eed453 sp 00007f91a9ff2348 error 4 in 
libdbus-1.so.3.7.4[7f9258eda000+46000]
Nov  6 17:52:25 c01 kernel: ganesha.nfsd[14415]: segfault at 88 ip 
00007f9258eed453 sp 00007f91a9ff2348 error 4 in 
libdbus-1.so.3.7.4[7f9258eda000+46000]


And reported this
https://github.com/nfs-ganesha/nfs-ganesha/issues/215



-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: woensdag 8 november 2017 22:42
To: ceph-users@ceph.com; ceph-devel@vger.kernel.org
Subject: [ceph-users] who is using nfs-ganesha and cephfs?

Who is running nfs-ganesha's FSAL to export CephFS?  What has your 
experience been?

(We are working on building proper testing and support for this into 
Mimic, but the ganesha FSAL has been around for years.)

Thanks!
sage

_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


