From: Sergey Nazarov <natarajaya@gmail.com>
Subject: Extremely slow small files rewrite performance
Date: Tue, 21 Oct 2014 11:52:45 -0400
Message-ID: <CAAprOjbE_-HNtHgKqPHygewS2YOwEnrmUmFesF-Uf_bHiqxn2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64378 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbaJUPwq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 11:52:46 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so1450863iec.25
        for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 08:52:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

I just built a new cluster using this quickstart instructions:
http://ceph.com/docs/master/start/

And here is what I am seeing:

# time for i in {1..10}; do echo $i > $i.txt ; done
real 0m0.081s
user 0m0.000s
sys 0m0.004s

And if I try to repeat the same command (when files already created):

# time for i in {1..10}; do echo $i > $i.txt ; done
real 0m48.894s
user 0m0.000s
sys 0m0.004s

I was very surprised and then just tried to rewrite a single file:

# time echo 1 > 1.txt
real 0m3.133s
user 0m0.000s
sys 0m0.000s

BTW, I dont think it is the problem with OSD speed or network:

# time sysbench --num-threads=1 --test=fileio --file-total-size=1G
--file-test-mode=rndrw prepare
1073741824 bytes written in 23.52 seconds (43.54 MB/sec).

Here is my ceph cluster status and verion:

# ceph -w
    cluster d3dcacc3-89fb-4db0-9fa9-f1f6217280cb
     health HEALTH_OK
     monmap e4: 4 mons at
{atl-fs10=10.44.101.70:6789/0,atl-fs11=10.44.101.91:6789/0,atl-fs12=10.44.101.92:6789/0,atl-fs9=10.44.101.69:6789/0},
election epoch 40, quorum 0,1,2,3 atl-fs9,atl-fs10,atl-fs11,atl-fs12
     mdsmap e33: 1/1/1 up {0=atl-fs12=up:active}, 3 up:standby
     osdmap e92: 4 osds: 4 up, 4 in
      pgmap v8091: 192 pgs, 3 pools, 123 MB data, 1658 objects
            881 GB used, 1683 GB / 2564 GB avail
                 192 active+clean
  client io 1820 B/s wr, 1 op/s

# ceph -v
ceph version 0.80.7 (6c0127fcb58008793d3c8b62d925bc91963672a3)

All nodes connected with gigabit network.
