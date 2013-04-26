From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: cluster and public network configuration.
Date: Fri, 26 Apr 2013 15:32:23 +0400
Message-ID: <517A65C7.9090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65154 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab3DZLc0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 07:32:26 -0400
Received: by mail-lb0-f172.google.com with SMTP id d10so813040lbj.3
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 04:32:24 -0700 (PDT)
Received: from [192.168.1.116] ([81.195.203.34])
        by mx.google.com with ESMTPSA id t6sm4534098lae.3.2013.04.26.04.32.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 04:32:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've configured my ceph cluster to use cluster and public networks, but 
looks like this configuration doesn't work correctly because when rados 
bench returns the following test's result:

  Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
  Object prefix: benchmark_data_srv64_4661
    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat avg lat
      0       0         0         0         0         0 -         0
      1      16        16         0         0         0 -         0
      2      16        17         1   1.99975         2   1.17015 1.17015
      3      16        17         1   1.33317         0         - 1.17015
      4      16        17         1  0.999894         0         - 1.17015
      5      16        17         1  0.799913         0         - 1.17015


------------------------------------------------------------------------------------
eth0 - public network
eth1 - cluster network

ceph.conf:

[global]

         public network = 10.8.0.0/24
         cluster network = 192.168.102.0/24

[osd.0]
        host = srv95
        cluster addr = 192.168.102.95
        public addr = 10.8.0.95
        devs = /dev/sdb

[osd.1]

        host = srv115
        cluster addr = 192.168.102.115
        public addr = 10.8.0.115
        devs = /dev/sda6

[osd.2]
         host = srv6
         cluster addr = 192.168.102.6
         public addr = 10.8.0.6
         devs = /dev/sda6

[osd.3]
         host = srv140
         cluster addr = 192.168.102.140
         public addr = 10.8.0.140
         devs = /dev/sda6

[osd.4]
         host = srv140
         cluster addr = 192.168.102.140
         public addr = 10.8.0.140
         devs = /dev/sdb6

[osd.5]
        host = srv6
        cluster addr = 192.168.102.6
        public addr = 10.8.0.6
        devs = /dev/sdb6

[osd.6]
        host = srv115
        cluster addr = 192.168.102.115
        public addr = 10.8.0.115
        devs = /dev/sdb6


# id    weight    type name    up/down    reweight
-1    7    root default
-3    7        rack unknownrack
-2    1            host srv95
0    1                osd.0    up    1
-4    2            host srv115
1    1                osd.1    up    1
6    1                osd.6    up    1
-5    2            host srv6
2    1                osd.2    up    1
5    1                osd.5    up    1
-6    2            host srv140
3    1                osd.3    up    1
4    1                osd.4    up    1
------------------------------------------------------------------------------------

My question is: How to set up cluster network correctly?

Thanks


-- 
Kind regards,

R. Alekseev

