From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Luminous 12.1.1 upgrade mgr woes
Date: Tue, 18 Jul 2017 21:03:34 +1200
Message-ID: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------11F3567233DDCEB9EAF4ED9F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:57970
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751349AbdGRJDi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Jul 2017 05:03:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTP id 357B080510
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 21:03:36 +1200 (NZST)
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([127.0.0.1])
        by localhost (cat-porwal-prod-mail1.servers.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c4EwM-Fyo4f3 for <ceph-devel@vger.kernel.org>;
        Tue, 18 Jul 2017 21:03:34 +1200 (NZST)
Received: from [IPv6:2406:e001:e5d:1:511b:9c7f:8a75:3670] (unknown [IPv6:2406:e001:e5d:1:511b:9c7f:8a75:3670])
        (Authenticated sender: mark.kirkwood@catalyst.net.nz)
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id 6BF0E804E7
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 21:03:34 +1200 (NZST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------11F3567233DDCEB9EAF4ED9F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Just had a go at this - 12.1.1 from a freshly deployed Jewel (10.2.9) on 
Ubuntu 16.04, following 
http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken. 


So it all worked ok *except* for the the mgr deploy, this hang at the 
key/caps modification stage (see attached). Now I managed to work around it:

- switch cephx to none in ceph.conf

- restart mon

- redeploy mgr

- edit client.admin and add missing: caps mgr = "allow *"

- switch to cephx again, restart mon, mgr

- ...and continue, but it makes things a whole lot more messy than 
needed, would be good for this not to trip up upgraders on important 
systems (I'm just on a play setup, so no stress here)!

regards

Mark



--------------11F3567233DDCEB9EAF4ED9F
Content-Type: text/x-log;
 name="mgr.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mgr.log"

[2017-07-18 20:43:09,773][ceph_deploy.conf][DEBUG ] found configuration file at: /home/markir/.cephdeploy.conf
[2017-07-18 20:43:09,773][ceph_deploy.cli][INFO  ] Invoked (1.5.38): /usr/local/bin/ceph-deploy mgr create ceph1
[2017-07-18 20:43:09,773][ceph_deploy.cli][INFO  ] ceph-deploy options:
[2017-07-18 20:43:09,773][ceph_deploy.cli][INFO  ]  username                      : None
[2017-07-18 20:43:09,773][ceph_deploy.cli][INFO  ]  verbose                       : False
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  mgr                           : [('ceph1', 'ceph1')]
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  subcommand                    : create
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  quiet                         : False
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  cd_conf                       : <ceph_deploy.conf.cephdeploy.Conf instance at 0x7fd9ea1fbab8>
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  cluster                       : ceph
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  func                          : <function mgr at 0x7fd9ea6cb0c8>
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[2017-07-18 20:43:09,774][ceph_deploy.cli][INFO  ]  default_release               : False
[2017-07-18 20:43:09,774][ceph_deploy.mgr][DEBUG ] Deploying mgr, cluster ceph hosts ceph1:ceph1
[2017-07-18 20:43:10,230][ceph1][DEBUG ] connection detected need for sudo
[2017-07-18 20:43:10,681][ceph1][DEBUG ] connected to host: ceph1 
[2017-07-18 20:43:10,681][ceph1][DEBUG ] detect platform information from remote host
[2017-07-18 20:43:10,693][ceph1][DEBUG ] detect machine type
[2017-07-18 20:43:10,696][ceph_deploy.mgr][INFO  ] Distro info: Ubuntu 16.04 xenial
[2017-07-18 20:43:10,696][ceph_deploy.mgr][DEBUG ] remote host will use systemd
[2017-07-18 20:43:10,696][ceph_deploy.mgr][DEBUG ] deploying mgr bootstrap to ceph1
[2017-07-18 20:43:10,697][ceph1][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[2017-07-18 20:43:10,699][ceph1][DEBUG ] create path if it doesn't exist
[2017-07-18 20:43:10,700][ceph1][INFO  ] Running command: sudo ceph --cluster ceph --name client.bootstrap-mgr --keyring /var/lib/ceph/bootstrap-mgr/ceph.keyring auth get-or-create mgr.ceph1 mon allow profile mgr osd allow * mds allow * -o /var/lib/ceph/mgr/ceph-ceph1/keyring
[2017-07-18 20:43:10,967][ceph1][INFO  ] Running command: sudo systemctl enable ceph-mgr@ceph1
[2017-07-18 20:43:11,033][ceph1][INFO  ] Running command: sudo systemctl start ceph-mgr@ceph1
[2017-07-18 20:43:11,068][ceph1][INFO  ] Running command: sudo systemctl enable ceph.target

--------------11F3567233DDCEB9EAF4ED9F--
