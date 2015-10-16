From: "boukom.p.aa" <boukom.p.aa@m.titech.ac.jp>
Subject: Unable to mount CephFS
Date: Fri, 16 Oct 2015 10:29:03 +0900 (JST)
Message-ID: <1444958943.32103.boukom.p.aa@m.titech.ac.jp>
Reply-To: "boukom.p.aa" <boukom.p.aa@m.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail01.nap.gsic.titech.ac.jp ([131.112.13.20]:39891 "HELO
	mail01.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751222AbbJPB3H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Oct 2015 21:29:07 -0400
Received: from [131.112.13.22] (mail03.nap.gsic.titech.ac.jp)
	by drweb1.nap.gsic.titech.ac.jp (Dr.Web MailD 6.0.2.0)
	with SMTP id 072CBEB5 for ceph-devel@vger.kernel.org; Fri, 16 Oct 2015 10:29:05
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear peoples in mailing-list,

I've got a problem which is cannot mount CephFS.
This is my ceph status form 'ceph -s'

    cluster 7e549325-246f-4265-8715-11591a26df79
     health HEALTH_OK
     monmap e3: 3 mons at {rc010=192.168.0.10:6789/0,rc012=192.168.0.12:6789/0,rc013=192.168.0.13:6789/0}
            election epoch 16, quorum 0,1,2 rc010,rc012,rc013
     mdsmap e13: 1/1/1 up {0=rc010=up:active}, 2 up:standby
     osdmap e625: 8 osds: 8 up, 8 in
      pgmap v4153: 200 pgs, 2 pools, 1962 bytes data, 20 objects
            106 GB used, 292 GB / 399 GB avail
                 200 active+clean

Cluster seems to be ok, I guess.
I used the following command to mouth

~$ sudo mount -t ceph 192.168.0.10,192.168.12, 192.168.0.13:/ /mnt/mycephfs -o name=user,secretfile=/etc/ceph/key.secret

key.secret(s) are in /etc/ceph of mon node(s)
The result is "mount error 1 = Operation not permitted"

Any ideas for fixing this problem would be great.

Regards,
Piyawath
