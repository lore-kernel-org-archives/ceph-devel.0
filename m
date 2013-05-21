From: "ymorita000@gmail.com" <ymorita000@gmail.com>
Subject: found some issues on ceph v0.61.2
Date: Mon, 20 May 2013 17:00:32 -0700
Message-ID: <CAA4Vorp+ZVDjwxaYV4em12QPvW-RAOuwJyc4y9FcmGd1rWyMig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53]:64831 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3EUAAd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 May 2013 20:00:33 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so9972vbh.26
        for <ceph-devel@vger.kernel.org>; Mon, 20 May 2013 17:00:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have found some issues on ceph v0.61.2 on Ubuntu 12.10.

(1) "ceph-deploy osd create" command fails when using --cluster <name> option.

[root@host3 yuji_ceph]# ceph-deploy --cluster yuji osd create host1:sdb
Traceback (most recent call last):
  File "/usr/sbin/ceph-deploy", line 8, in <module>
    load_entry_point('ceph-deploy==0.1', 'console_scripts', 'ceph-deploy')()
  File "/root/ceph-deploy/ceph_deploy/cli.py", line 112, in main
    return args.func(args)
  File "/root/ceph-deploy/ceph_deploy/osd.py", line 428, in osd
    prepare(args, cfg, activate_prepared_disk=True)
  File "/root/ceph-deploy/ceph_deploy/osd.py", line 273, in prepare
    s = '{} returned {}\n{}\n{}'.format(cmd, ret, out, err)
ValueError: zero length field name in format


(2) "service ceph -a start/stop" command is accepted, but nothing happens.

root@host1:~# ceph osd tree

# id    weight  type name       up/down reweight
-1      0.16    root default
-2      0.16            host host1
0       0.03                    osd.0   up      1
1       0.03                    osd.1   up      1
2       0.03                    osd.2   up      1
3       0.06999                 osd.3   up      1

root@host1:~# /etc/init.d/ceph -a stop
root@host1:~# ceph osd tree

# id    weight  type name       up/down reweight
-1      0.16    root default
-2      0.16            host host1
0       0.03                    osd.0   up      1
1       0.03                    osd.1   up      1
2       0.03                    osd.2   up      1
3       0.06999                 osd.3   up      1



By the way, I could not find [osd], [host] and [mon] entry in the
/etc/ceph/ceph.conf anymore when I create ceph cluster using
"ceph-deploy". Is this information still stored somewhere?

Thank you.
Yuji
