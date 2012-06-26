From: Nick Bartos <nick@pistoncloud.com>
Subject: Remove unrelated log output from command line utils?
Date: Tue, 26 Jun 2012 11:53:00 -0700
Message-ID: <CAPud5_5iOr9sCXYQU9Nr5f-+NDBy-sPkGuc5x-wTETyP_MDtfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40456 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693Ab2FZSxA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 14:53:00 -0400
Received: by dady13 with SMTP id y13so278958dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 11:53:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sometimes, I get (what seems like) unrelated log output when running a
command.  For example:

Command ran: rbd -m 172.18.0.13:6789,172.18.0.15:6789,172.18.0.14:6789 list

Return code is 0, as expected.

Stdout is this as expected:
libvirt_172.18.0.13
libvirt_172.18.0.14
libvirt_172.18.0.15
libvirt_save_node-172-18-0-14
mysql
node-172-18-0-13novadisk0
node-172-18-0-14novadisk0
node-172-18-0-15novadisk0
swift_node-172-18-0-13
swift_node-172-18-0-14
swift_node-172-18-0-15

However, this is on stderr, which is not expected:
2012-06-26 18:39:42.283752 7f141e43f700  0 -- 172.18.0.14:0/1002349 >>
172.18.0.14:6806/11061 pipe(0x7f141eaa59a0 sd=3 pgs=0 cs=0
l=0).connect claims to be 172.18.0.14:6806/2331 not
172.18.0.14:6806/11061 - wrong node!
2012-06-26 18:39:42.284243 7f141e43f700  0 -- 172.18.0.14:0/1002349 >>
172.18.0.14:6806/11061 pipe(0x7f141eaa59a0 sd=3 pgs=0 cs=0
l=0).connect claims to be 172.18.0.14:6806/2331 not
172.18.0.14:6806/11061 - wrong node!
2012-06-26 18:39:42.484832 7f141e43f700  0 -- 172.18.0.14:0/1002349 >>
172.18.0.14:6806/11061 pipe(0x7f141eaa59a0 sd=3 pgs=0 cs=0
l=0).connect claims to be 172.18.0.14:6806/2331 not
172.18.0.14:6806/11061 - wrong node!
2012-06-26 18:39:42.885548 7f141e43f700  0 -- 172.18.0.14:0/1002349 >>
172.18.0.14:6806/11061 pipe(0x7f141eaa59a0 sd=3 pgs=0 cs=0
l=0).connect claims to be 172.18.0.14:6806/2331 not
172.18.0.14:6806/11061 - wrong node!

I think the stderr output should only be going to the logs, not to an
arbitrary command line utility.

Is there any way to change this behaviour?  The ceph version is
0.47.2, and here is the ceph.conf:


# cat /etc/ceph/ceph.conf
[global]
;   auth supported = cephx

    log file = ""
    log to syslog = true
    clog to monitors = false
    clog to syslog = true

    # Tone down insane number of osd::tracker messages
    debug optracker = 1


[mon]
    mon data = /mnt/local/mon$id

[mon.0]
    host = 172.18.0.13
    mon addr = 172.18.0.13:6789

[mon.1]
    host = 172.18.0.15
    mon addr = 172.18.0.15:6789

[mon.2]
    host = 172.18.0.14
    mon addr = 172.18.0.14:6789


[osd]
    osd data = /mnt/osd$id
    osd journal = /mnt/osd$id/journal
    osd class dir = /usr/lib/rados-classes
    filestore fiemap = false

;name: node-172-18-0-13
;ip: 172.18.0.13
;tup: (u'fdadf12b-1a88-4046-b123-20d055eb0464', 0, True)
[osd.0]
    host = 172.18.0.13
    cluster addr = 172.18.0.13
    public addr = 172.18.0.13
    osd journal size = 8192
;name: node-172-18-0-13
;ip: 172.18.0.13
;tup: (u'405fcd80-f96b-427c-9d86-242016e83b7b', 1, True)
[osd.1]
    host = 172.18.0.13
    cluster addr = 172.18.0.13
    public addr = 172.18.0.13
    osd journal size = 8192
;name: node-172-18-0-13
;ip: 172.18.0.13
;tup: (u'a8d4fd6a-42a2-4bb5-9e37-637f1e2f32cb', 2, True)
[osd.2]
    host = 172.18.0.13
    cluster addr = 172.18.0.13
    public addr = 172.18.0.13
    osd journal size = 8192
;name: node-172-18-0-13
;ip: 172.18.0.13
;tup: (u'50d8b146-5a52-4812-9f13-caa1f7b90df2', 3, True)
[osd.3]
    host = 172.18.0.13
    cluster addr = 172.18.0.13
    public addr = 172.18.0.13
    osd journal size = 8192
;name: node-172-18-0-15
;ip: 172.18.0.15
;tup: (u'f18c1c80-b072-425e-bcee-e84f7c9e0805', 24, False)
[osd.24]
    host = 172.18.0.15
    cluster addr = 172.18.0.15
    public addr = 172.18.0.15
    osd journal size = 1536
;name: node-172-18-0-15
;ip: 172.18.0.15
;tup: (u'b4173d75-cdd7-475e-91a8-c95a2acbb263', 25, False)
[osd.25]
    host = 172.18.0.15
    cluster addr = 172.18.0.15
    public addr = 172.18.0.15
    osd journal size = 1536
;name: node-172-18-0-15
;ip: 172.18.0.15
;tup: (u'6420f4f3-c08b-4ee6-bce1-3305820cc75a', 26, False)
[osd.26]
    host = 172.18.0.15
    cluster addr = 172.18.0.15
    public addr = 172.18.0.15
    osd journal size = 1536
;name: node-172-18-0-15
;ip: 172.18.0.15
;tup: (u'fe03984e-9178-40dd-a453-99b9e48dabf8', 27, False)
[osd.27]
    host = 172.18.0.15
    cluster addr = 172.18.0.15
    public addr = 172.18.0.15
    osd journal size = 1536
;name: node-172-18-0-14
;ip: 172.18.0.14
;tup: (u'48b84d00-bd0b-47ec-81eb-6616a47e3427', 48, False)
[osd.48]
    host = 172.18.0.14
    cluster addr = 172.18.0.14
    public addr = 172.18.0.14
    osd journal size = 1536
;name: node-172-18-0-14
;ip: 172.18.0.14
;tup: (u'50069ff7-44d0-4df8-bb5d-388725273bc0', 49, False)
[osd.49]
    host = 172.18.0.14
    cluster addr = 172.18.0.14
    public addr = 172.18.0.14
    osd journal size = 1536
;name: node-172-18-0-14
;ip: 172.18.0.14
;tup: (u'a8fc35d6-add5-4946-ba9b-6b6c42611b96', 50, False)
[osd.50]
    host = 172.18.0.14
    cluster addr = 172.18.0.14
    public addr = 172.18.0.14
    osd journal size = 1536
;name: node-172-18-0-14
;ip: 172.18.0.14
;tup: (u'35ae9a9f-52a3-46a5-81ce-12df1d491644', 51, False)
[osd.51]
    host = 172.18.0.14
    cluster addr = 172.18.0.14
    public addr = 172.18.0.14
    osd journal size = 1536
