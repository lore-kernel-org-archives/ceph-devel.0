From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RBD: periodic cephx issue ? "CephxAuthorizeHandler::verify_authorizer
 isvalid=0"
Date: Mon, 3 Dec 2012 17:23:44 +0100
Message-ID: <CAF6-1L4uLWLKiDFTuWvGxk5V0Rq6wsLULFC24EFwR8kUWEu=aw@mail.gmail.com>
References: <CAF6-1L7sBWbEUNma4QLm1DgSJbJLdpXOPzzuJzs_uhZP7ivJHw@mail.gmail.com>
	<alpine.DEB.2.00.1211290837140.30450@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58518 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab2LCQXp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 11:23:45 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2817780oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 08:23:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211290837140.30450@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> Can you attach/post the whole log somewhere?  I'm curious what is leading
> up to it not having secret_id=0.  Ideally with 'debug auth = 20' and
> 'debug osd = 20' and 'debug ms = 1'.


I repoduced the problem with debug auth = 10  and debug ms = 1  (no
debug osd ... that's just too verbose, the root fs fills before the
problem happens)
and there seem to be some relevant info so hopefully you'll understand
what's going on.


Here's the short version:


2012-12-03 16:00:26.644756 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.5 192.168.2.212:6814/5673 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xbb99380 con 0xa5b1a00
2012-12-03 16:00:26.644854 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.6 192.168.2.212:6817/5745 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xb9b5e00 con 0xa5b1c80
2012-12-03 16:00:26.645210 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.8 192.168.2.213:6808/17142 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xaf9ee00 con 0xa294140
2012-12-03 16:00:26.645228 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.9 192.168.2.213:6811/1014 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xb151700 con 0xa2d5140
2012-12-03 16:00:26.645238 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.11 192.168.2.213:6805/870 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xd150540 con 0xa294500
2012-12-03 16:00:26.645248 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.2 192.168.2.211:6802/933 1486 ==== osd_ping(ping_reply e1257 stamp
2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0) 0xd05c540
con 0xa2d58c0
2012-12-03 16:00:26.645258 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.0 192.168.2.210:6802/930 1486 ==== osd_ping(ping_reply e1257 stamp
2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0) 0xb9531c0
con 0xa278a00
2012-12-03 16:00:26.645268 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.3 192.168.2.211:6805/1004 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xbb2be00 con 0xa294c80
2012-12-03 16:00:26.645277 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.1 192.168.2.210:6805/1001 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0x9f00a80 con 0xa2948c0
2012-12-03 16:00:26.645287 7f8765469700  1 -- 192.168.2.212:0/8791 <==
osd.10 192.168.2.213:6802/18249 1486 ==== osd_ping(ping_reply e1257
stamp 2012-12-03 16:00:26.644309) v2 ==== 47+0+0 (1414161696 0 0)
0xb5e2700 con 0xa2d5500
2012-12-03 16:00:26.952048 7f8764c68700  1 -- 192.168.2.212:6804/8791
<== osd.0 192.168.2.210:0/930 1473 ==== osd_ping(ping e1257 stamp
2012-12-03 16:00:26.952769) v2 ==== 47+0+0 (1014752791 0 0) 0xb83ca80
con 0xae7c780
2012-12-03 16:00:26.952067 7f8764c68700  1 -- 192.168.2.212:6804/8791
--> 192.168.2.210:0/930 -- osd_ping(ping_reply e1257 stamp 2012-12-03
16:00:26.952769) v2 -- ?+0 0xb887700 con 0xae7c780
2012-12-03 16:00:27.036447 7f8764c68700  1 -- 192.168.2.212:6804/8791
<== osd.11 192.168.2.213:0/870 1462 ==== osd_ping(ping e1257 stamp
2012-12-03 16:00:27.038722) v2 ==== 47+0+0 (524832854 0 0) 0xc0b78c0
con 0xa409280
2012-12-03 16:00:27.036467 7f8764c68700  1 -- 192.168.2.212:6804/8791
--> 192.168.2.213:0/870 -- osd_ping(ping_reply e1257 stamp 2012-12-03
16:00:27.038722) v2 -- ?+0 0xb83ca80 con 0xa409280
2012-12-03 16:00:27.517729 7f8764c68700  1 -- 192.168.2.212:6804/8791
<== osd.9 192.168.2.213:0/1014 1508 ==== osd_ping(ping e1257 stamp
2012-12-03 16:00:27.520196) v2 ==== 47+0+0 (1539433990 0 0) 0xb544e00
con 0xa5b1000
2012-12-03 16:00:27.517742 7f8764c68700  1 -- 192.168.2.212:6804/8791
--> 192.168.2.213:0/1014 -- osd_ping(ping_reply e1257 stamp 2012-12-03
16:00:27.520196) v2 -- ?+0 0xc0b78c0 con 0xa5b1000
2012-12-03 16:00:28.032679 7f875e843700  0 bad crc in data 965917392
!= exp 3080890792
2012-12-03 16:00:28.036484 7f875c21d700  1 -- 192.168.2.212:6801/8791
>> :/0 pipe(0xa513600 sd=63 pgs=0 cs=0 l=0).accept sd=63
2012-12-03 16:00:28.036615 7f875c21d700  0 -- 192.168.2.212:6801/8791
>> 192.168.2.22:0/611252204 pipe(0xa513600 sd=63 pgs=0 cs=0
l=0).accept peer addr is really 192.168.2.22:0/611252204 (socket is
192.168.2.22:36660/0)
2012-12-03 16:00:28.036749 7f875c21d700 10 cephx: verify_authorizer
decrypted service osd secret_id=768
2012-12-03 16:00:28.036859 7f875c21d700  0 auth: could not find secret_id=768
2012-12-03 16:00:28.036964 7f875c21d700 10 auth: dump_rotating:
2012-12-03 16:00:28.037138 7f875c21d700 10 auth:  id 769
[somebase64string] expires 2012-12-03 15:54:00.859830
2012-12-03 16:00:28.037885 7f875c21d700 10 auth:  id 770
[somebase64string] expires 2012-12-03 16:54:00.859830
2012-12-03 16:00:28.038003 7f875c21d700 10 auth:  id 771
[somebase64string] expires 2012-12-03 17:54:03.244356
2012-12-03 16:00:28.038119 7f875c21d700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=768
2012-12-03 16:00:28.038225 7f875c21d700  1
CephxAuthorizeHandler::verify_authorizer isvalid=0
2012-12-03 16:00:28.038352 7f875c21d700  0 -- 192.168.2.212:6801/8791
>> 192.168.2.22:0/611252204 pipe(0xa513600 sd=63 pgs=0 cs=0
l=1).accept bad authorizer
2012-12-03 16:00:28.038764 7f875c21d700 10 cephx: verify_authorizer
decrypted service osd secret_id=769
2012-12-03 16:00:28.038857 7f875c21d700 10 cephx: verify_authorizer
global_id=6985
2012-12-03 16:00:28.038928 7f875c21d700 10 cephx: verify_authorizer ok
nonce 5d15bffa061f81a7 reply_bl.length()=36
2012-12-03 16:00:28.038967 7f875c21d700  1
CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-12-03 16:00:28.039723 7f876646b700  1 -- 192.168.2.212:6801/8791
<== client.6985 192.168.2.22:0/611252204 1 ====
osd_op(client.6985.1:30491173 rb.0.1aaf.3667f50e.00000000007e [write
16384~16384] 3.3080bee3 RETRY) ==== 139+0+16384 (3181155605 0
4283479039) 0xb229000 con 0xbb6bb40
2012-12-03 16:00:28.040039 7f8763465700  1 -- 192.168.2.212:6803/8791
--> osd.2 192.168.2.211:6801/933 -- osd_sub_op(client.6985.1:30491173
3.2e3 3080bee3/rb.0.1aaf.3667f50e.00000000007e/head//3 [] v
1257'131293 snapset=0=[]:[] snapc=0=[]) v7 -- ?+16994 0xb939a00
2012-12-03 16:00:28.041643 7f8765c6a700  1 -- 192.168.2.212:6803/8791
<== osd.2 192.168.2.211:6801/933 11022 ====
osd_sub_op_reply(client.6985.1:30491173 3.2e3
3080bee3/rb.0.1aaf.3667f50e.00000000007e/head//3 [] ondisk, result =
0) v1 ==== 157+0+0 (1720684508 0 0) 0xa516500 con 0xa274a00


The full version is there http://ge.tt/6SXhIpS/v/0

Cheers,

    Sylvain
