From: Mandell Degerness <mandell@pistoncloud.com>
Subject: possible bug in blacklist
Date: Tue, 24 Sep 2013 16:57:21 -0700
Message-ID: <CA+jddaN3M3xhu5ZVpJynivZ8EVMTwsVJcd4tixNae0+HMoBB+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36544 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab3IXX5W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 19:57:22 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so9456646ieb.26
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 16:57:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

See trace below.  We run this command on system restart in order to
clear any blacklist which was created while node was mis-behaving.
Now, rather than giving a reasonable error, it causes at Traceback:

[root@node-172-20-0-13 ~]# ceph osd blacklist rm 172.20.0.13
Traceback (most recent call last):
  File "/usr/bin/ceph", line 774, in <module>
    sys.exit(main())
  File "/usr/bin/ceph", line 717, in main
    sigdict, inbuf, verbose)
  File "/usr/bin/ceph", line 375, in new_style_command
    valid_dict = validate_command(sigdict, cmdargs, verbose)
  File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
890, in validate_command
  File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
715, in matchnum
  File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
690, in validate_one
  File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line 284, in valid
ValueError: need more than 1 value to unpack
[root@node-172-20-0-13 ~]# ceph --version
ceph version 0.67.3 (408cd61584c72c0d97b774b3d8f95c6b1b06341a)
[root@node-172-20-0-13 ~]#
