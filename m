From: yue longguang <yuelongguang@gmail.com>
Subject: all my osds are down, but ceph -s tells they are up and in.
Date: Tue, 9 Sep 2014 10:04:05 +0800
Message-ID: <CAPaK2r93h-cXpHsn1aSRC2VHuwQATuWQqkrY=+DF8FfyDBZ5GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54903 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbaIICEG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Sep 2014 22:04:06 -0400
Received: by mail-ie0-f175.google.com with SMTP id y20so19163040ier.20
        for <ceph-devel@vger.kernel.org>; Mon, 08 Sep 2014 19:04:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,all

that is crazy.
1.
all my osds are down, but ceph -s tells they are up and in. why?
2.
now all osds are down, a vm is using rbd as its disk, and inside vm
fio is r/wing the disk , but it hang ,can not be killed. why ?

thanks

[root@cephosd2-monb ~]# ceph -v
ceph version 0.81 (8de9501df275a5fe29f2c64cb44f195130e4a8fc)

 [root@cephosd2-monb ~]# ceph -s
    cluster 508634f6-20c9-43bb-bc6f-b777f4bb1651
     health HEALTH_WARN mds 0 is laggy
     monmap e13: 3 mons at
{cephosd1-mona=10.154.249.3:6789/0,cephosd2-monb=10.154.249.4:6789/0,cephosd3-monc=10.154.249.5:6789/0},
election epoch 154, quorum 0,1,2
cephosd1-mona,cephosd2-monb,cephosd3-monc
     mdsmap e21: 1/1/1 up {0=0=up:active(laggy or crashed)}
     osdmap e196: 5 osds: 5 up, 5 in
      pgmap v21836: 512 pgs, 5 pools, 3115 MB data, 805 objects
            9623 MB used, 92721 MB / 102344 MB avail
                 512 active+clean
