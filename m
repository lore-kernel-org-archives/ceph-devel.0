From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RBD: periodic cephx issue ? "CephxAuthorizeHandler::verify_authorizer isvalid=0"
Date: Thu, 29 Nov 2012 12:00:43 +0100
Message-ID: <CAF6-1L7sBWbEUNma4QLm1DgSJbJLdpXOPzzuJzs_uhZP7ivJHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60312 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab2K2LAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 06:00:44 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so14334706oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 03:00:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm using RBD to store VM image and they're accessed through the
kernel client (xen vms).


In the client dmesg log, I see periodically :

Nov 29 10:46:48 b53-04 kernel: [160055.012206] libceph: osd8
10.208.2.213:6806 socket closed
Nov 29 10:46:48 b53-04 kernel: [160055.013635] libceph: osd8
10.208.2.213:6806 socket error on read


And in the matching osd log I find :

2012-11-29 10:46:48.130673 7f6018127700  0 -- 192.168.2.213:6806/944
>> 192.168.2.28:0/869804615 pipe(0xcf80600 sd=46 pgs=0 cs=0
l=0).accept peer addr is really 192.168.2.28:0/869804615 (socket is
192.168.2.28:40567/0)
2012-11-29 10:46:48.130902 7f6018127700  0 auth: could not find secret_id=0
2012-11-29 10:46:48.130912 7f6018127700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=0
2012-11-29 10:46:48.130915 7f6018127700  1
CephxAuthorizeHandler::verify_authorizer isvalid=0
2012-11-29 10:46:48.130917 7f6018127700  0 -- 192.168.2.213:6806/944
>> 192.168.2.28:0/869804615 pipe(0xcf80600 sd=46 pgs=0 cs=0
l=1).accept bad authorizer
2012-11-29 10:46:48.131132 7f6018127700  0 auth: could not find secret_id=0
2012-11-29 10:46:48.131146 7f6018127700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=0
2012-11-29 10:46:48.131151 7f6018127700  1
CephxAuthorizeHandler::verify_authorizer isvalid=0
2012-11-29 10:46:48.131154 7f6018127700  0 -- 192.168.2.213:6806/944
>> 192.168.2.28:0/869804615 pipe(0xcf80600 sd=46 pgs=0 cs=0
l=1).accept bad authorizer
2012-11-29 10:46:48.824180 7f6018127700  0 -- 192.168.2.213:6806/944
>> 192.168.2.28:0/869804615 pipe(0xaf5de00 sd=46 pgs=0 cs=0
l=0).accept peer addr is really 192.168.2.28:0/869804615 (socket is
192.168.2.28:40568/0)
2012-11-29 10:46:48.824585 7f6018127700  1
CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-11-29 10:46:48.825013 7f601f484700  0 osd.8 951 pg[3.514( v
950'1138 (223'137,950'1138] n=15 ec=10 les/c 941/948 916/916/916)
[8,7] r=0 lpr=916 mlcod 950'1137 active+clean] watch:
ctx->obc=0xb72e340 cookie=2 oi.version=1109 ctx->at_version=951'1139
2012-11-29 10:46:48.825024 7f601f484700  0 osd.8 951 pg[3.514( v
950'1138 (223'137,950'1138] n=15 ec=10 les/c 941/948 916/916/916)
[8,7] r=0 lpr=916 mlcod 950'1137 active+clean] watch:
oi.user_version=755


Note that this doesn't seem to pose any operational issue (i.e. it
works ... when it retries it eventually connects).

My configuration: The client currently runs on a debian wheezy and use
a custom built 3.6.8 kernel that contains all the latest ceph rbd
patch AFAIK but the problem was also showing up with earlier kernel
versions. The cluster is a 0.48.2 running on Ubuntu 12.04 LTS.

Cheers,

    Sylvain
