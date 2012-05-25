From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Error 5 when trying to mount Ceph 0.47.1
Date: Fri, 25 May 2012 14:58:45 +0900
Message-ID: <CAHwdYF3oCSODVEjOogdX3agVFYxmsQ8N_-vshSPCNkNo4+zEkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.nap.gsic.titech.ac.jp ([131.112.222.51]:65367 "EHLO
	mail1.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753834Ab2EYGHm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 May 2012 02:07:42 -0400
Received: from 209.85.217.174 (209.85.217.174 [209.85.217.174])
	by mail1.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF3oCSODVEjOogdX3agVFYxmsQ8N_-vshSPCNkNo4+zEkw@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 14:59:09 +0900
Received: by lbbgm6 with SMTP id gm6so399109lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 22:59:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I've just started working with Ceph for a couple of weeks. At the
moment, I'm trying to setup a small cluster with 1 monitor, 1 MDS and
6 OSDs. However, I cannot mount ceph to the system no matter which
node I'm executing the mounting command on.

My nodes run Ubuntu 11.10 with kernal 3.0.0-12
Seeing some other people also faced similar problems, I attached the
result of running ceph -s as followed:

2012-05-25 23:52:17.802590    pg v434: 1152 pgs: 189 active+clean, 963
stale+active+clean; 8730 bytes data, 3667 MB used, 844 GB / 893 GB
avail
2012-05-25 23:52:17.806759   mds e12: 1/1/1 up {0=1=up:replay}
2012-05-25 23:52:17.806827   osd e30: 6 osds: 1 up, 1 in
2012-05-25 23:52:17.806966   log 2012-05-25 23:44:14.584879 mon.0
192.168.172.178:6789/0 2 : [INF] mds.? 192.168.172.179:6800/6515
up:boot
2012-05-25 23:52:17.807086   mon e1: 1 mons at {0=192.168.172.178:6789/0}

I tried to use the mount -t ceph node:port:/ [destination] but I keep
getting "mount error 5 = Input/output error"

I also check if the firewall is blocking anything with nmap -sT -p
6789 [monNode]

My ceph version is 0.47.1, installed with sudo apt-get on the system.
I've spent a couple of days googling with no avails, and the
documentation does not address this issue at all.

Thank you very much for your help,

Best regards,
Nam Dang
Tokyo Institute of Technology
Tokyo, Japan
