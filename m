From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Problems when benchmarking Ceph
Date: Wed, 30 May 2012 19:28:35 +0900
Message-ID: <CAHwdYF3iJ8AT_NVAsyJuoo8Lu6+H1Oj9x+fO2ZGhdnqOUKm2CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.nap.gsic.titech.ac.jp ([131.112.222.51]:58693 "EHLO
	mail1.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752098Ab2E3K3J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 May 2012 06:29:09 -0400
Received: from 209.85.215.46 (209.85.215.46 [209.85.215.46])
	by mail1.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF3iJ8AT_NVAsyJuoo8Lu6+H1Oj9x+fO2ZGhdnqOUKm2CQ@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 19:28:59 +0900
Received: by lahd3 with SMTP id d3so3175048lah.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 03:28:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear all,

I am using Ceph as a baseline for Hadoop. In Hadoop there is a
NNThroughputBenchmark, which tries to test the upper limit of the
namenode (a.k.a MDS in Ceph).
This NNThroughputBenchmark basically creates a master node, and
creates many threads that sends requests to the master node as
possible. This approach minimizes communication overhead when
employing actual clients. The code can be found here:
https://svn.apache.org/repos/asf/hadoop/common/branches/branch-0.19/src/test/org/apache/hadoop/hdfs/NNThroughputBenchmark.java

So I'm testing Ceph in similar manner:
- Mount Ceph to a folder
- Create many threads and send requests to the MDS on the MDS (so no
network communication)
- I do not write any data to the files: just mere file creation.

However, I notice very poor performance on Ceph (only about 485
ops/sec, as oppose to 8000ops/sec in Hadoop, and I'm not sure why. I
also notice that when I tried to remove the folder created by the
interrupted test of the benchmark mentioned above, I took too long I
had to Ctrl+Break out of the rm program. I'm thinking that the reason
could be that I'm using Java IO instead of Ceph direct data
manipulation code. Also, I didn't write any data so there shouldn't be
any overhead of communicating with the OSDs (or is my assumption
wrong?)

So do you have any idea on this?

My configuration at the moment:
- Ceph 0.47.1
- Intel Xeon 5 2.4Ghz, 4x2 cores
- 24GB of RAM
- One node for Monitor, One for MDS, 5 for OSD (of the same configuration)
- I mount Ceph to a folder on the MDS and run the simulation on that
folder (creating, opening, deleting files) - Right now I'm just
working on creating files so I haven't tested with others.

And I'm wondering if there is anyway I can use the API to manipulate
the file system directly instead of mounting through the OS and use
the OS's basic file manipulation layer.
I checked the API doc at http://ceph.com/docs/master/api/librados/ and
it appears that there is no clear way of accessing the Ceph's file
system directly, only object-based storage system.

Thank you very much for your help!

Below is the configuration of my Ceph installation:

; disable authentication
[mon]
	mon data = /home/namd/ceph/mon

[osd]
	osd data = /home/namd/ceph/osd
	osd journal = /home/namd/ceph/osd.journal
	osd journal size = 1000
	osd min rep = 3
	osd max rep = 3
	; the following line is for ext4 partition
	filestore xattr use omap = true

[mds.1]
	host=sakura09

[mds.2]
	host=sakura10

[mds.3]
	host=sakura11

[mds.4]
	host=sakura12

[mon.0]
	host=sakura08
	mon addr=192.168.172.178:6789

[osd.0]
	host=sakura13

[osd.1]
	host=sakura14

[osd.2]
	host=sakura15

[osd.3]
	host=sakura16

[osd.4]
	host=sakura17

[osd.5]
	host=sakura18



Best regards,

Nam Dang
Email: namd@de.cs.titech.ac.jp
Tokyo Institute of Technology
Tokyo, Japan
