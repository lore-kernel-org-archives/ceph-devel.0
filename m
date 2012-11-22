From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Question about simulation with crushtool
Date: Thu, 22 Nov 2012 15:28:40 +0900
Message-ID: <CAHwdYF2=fPu6w2xkYUjfqq2MqSwtUstXazTFMXJ8A30htWtMkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.nap.gsic.titech.ac.jp ([131.112.222.52]:35690 "EHLO
	mail2.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755682Ab2KVSqm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Nov 2012 13:46:42 -0500
Received: from 209.85.220.174 (209.85.220.174 [209.85.220.174])
	by mail2.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF2=fPu6w2xkYUjfqq2MqSwtUstXazTFMXJ8A30htWtMkg@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 15:29:03 +0900
Received: by mail-vc0-f174.google.com with SMTP id m18so4370300vcm.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 22:29:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear all,

I am trying to do some small experiment with crushtool by simulating
different variants of CRUSHs.
However, I encounter some problem with crushtool due to its lack of
documentation.

I want to ask the command to simulate the placement in a 32-device
bucket system (only 1 bucket)? And how to show the placement of the
data through the simulation?
What I've figured out so far is:

> crushtool -t --min_x 3 --build --num_osds 32 root uniform 0

The output that I get is:
========================================================================
crushtool successfully built or modified map.  Use '-o <file>' to write it out.
rule 0 (data2012-11-23 00:13:21.676296 7fa31f813780  0 layer 1  root
bucket type uniform  0
), x = 0..1023, numrep = 2..2
2012-11-23 00:13:21.676313 7fa31f813780  0 lower_items
[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
2012-11-23 00:13:21.676320 7fa31f813780  0 lower_weights
[65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536,65536]
2012-11-23 00:13:21.676374 7fa31f813780  0   item 0 weight 65536
2012-11-23 00:13:21.676375 7fa31f813780  0   item 1 weight 65536
2012-11-23 00:13:21.676376 7fa31f813780  0   item 2 weight 65536
2012-11-23 00:13:21.676376 7fa31f813780  0   item 3 weight 65536
2012-11-23 00:13:21.676377 7fa31f813780  0   item 4 weight 65536
2012-11-23 00:13:21.676378 7fa31f813780  0   item 5 weight 65536
2012-11-23 00:13:21.676378 7fa31f813780  0   item 6 weight 65536
2012-11-23 00:13:21.676379 7fa31f813780  0   item 7 weight 65536
2012-11-23 00:13:21.676380 7fa31f813780  0   item 8 weight 65536
2012-11-23 00:13:21.676380 7fa31f813780  0   item 9 weight 65536
2012-11-23 00:13:21.676381 7fa31f813780  0   item 10 weight 65536
2012-11-23 00:13:21.676382 7fa31f813780  0   item 11 weight 65536
rule 0 (data) num_rep 2 result size == 02012-11-23 00:13:21.676382
7fa31f813780  0   item 12 weight 65536
:       2012-11-23 00:13:21.676404 7fa31f813780  0   item 13 weight 65536
1024/1024
2012-11-23 00:13:21.676407 7fa31f813780  0   item 14 weight 65536
2012-11-23 00:13:21.676407 7fa31f813780  0   item 15 weight 65536
2012-11-23 00:13:21.676408 7fa31f813780  0   item 16 weight 65536
2012-11-23 00:13:21.676409 7fa31f813780  0   item 17 weight 65536
2012-11-23 00:13:21.676412 7fa31f813780  0   item 18 weight 65536
2012-11-23 00:13:21.676413 7fa31f813780  0   item 19 weight 65536
2012-11-23 00:13:21.676414 7fa31f813780  0   item 20 weight 65536
2012-11-23 00:13:21.676414 7fa31f813780  0   item 21 weight 65536
2012-11-23 00:13:21.676415 7fa31f813780  0   item 22 weight 65536
2012-11-23 00:13:21.676416 7fa31f813780  0   item 23 weight 65536
2012-11-23 00:13:21.676417 7fa31f813780  0   item 24 weight 65536
2012-11-23 00:13:21.676417 7fa31f813780  0   item 25 weight 65536
2012-11-23 00:13:21.676671 7fa31f813780  0   item 26 weight 65536
2012-11-23 00:13:21.676673 7fa31f813780  0   item 27 weight 65536
2012-11-23 00:13:21.676674 7fa31f813780  0   item 28 weight 65536
2012-11-23 00:13:21.676675 7fa31f813780  0   item 29 weight 65536
2012-11-23 00:13:21.676676 7fa31f813780  0   item 30 weight 65536
2012-11-23 00:13:21.676678 7fa31f813780  0   item 31 weight 65536
2012-11-23 00:13:21.676731 7fa31f813780  0  in bucket -1 'root' size
32 weight 2097152
========================================================================

I can't seem to be able to add parameters like
"--show_utilization_all"; crushtool keeps complaining about
"layers must be specified with 3-tuples of (name, buckettype, size)".
I totally have no idea why.

When I modified the source code to force crushtool to printout the
placement of all the data items (for 32 devices it seems crushtool
allocates 32 items only), the list entries are just blank. Basically
it appears that CRUSH fails to find appropriate location for ALL the
data (the devices all have the same weight).

I hope someone here can tell me more about the usage of crushtool for
simulation like this. THank you

Best regards,
Nam Dang

Email: namd@de.cs.titech.ac.jp
HP: (+81) 080-4465-1587
Yokota Lab, Dept. of Computer Science
Tokyo Institute of Technology
Tokyo, Japan
