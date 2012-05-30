From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Re: Problems when benchmarking Ceph
Date: Wed, 30 May 2012 20:15:24 +0900
Message-ID: <CAHwdYF2TwGG9Js+sia2CV3iwvDAMjuWPqMBg-aHnwaMnxb3sJA@mail.gmail.com>
References: <CAHwdYF3iJ8AT_NVAsyJuoo8Lu6+H1Oj9x+fO2ZGhdnqOUKm2CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail3.nap.gsic.titech.ac.jp ([131.112.222.61]:49176 "EHLO
	mail3.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752573Ab2E3LPv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 May 2012 07:15:51 -0400
Received: from 209.85.217.174 (209.85.217.174 [209.85.217.174])
	by mail3.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF2TwGG9Js+sia2CV3iwvDAMjuWPqMBg-aHnwaMnxb3sJA@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 20:15:49 +0900
Received: by lbbgm6 with SMTP id gm6so2876797lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 04:15:45 -0700 (PDT)
In-Reply-To: <CAHwdYF3iJ8AT_NVAsyJuoo8Lu6+H1Oj9x+fO2ZGhdnqOUKm2CQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i just figured out one problem in my benchmark: all the concurrent
threads use the same file layer provided by the OS - so probably this
can be a bottleneck when the number of threads increases.
I wonder if I can connect directly to the MDS and access the the
underlying file system through some library? Sorry for my inexperience
but I haven't found any mentioning of IO operations for files in the
API. Did I miss something?

Best regards,

Nam Dang
Email: namd@de.cs.titech.ac.jp
Tokyo Institute of Technology
Tokyo, Japan


On Wed, May 30, 2012 at 7:28 PM, Nam Dang <namd@de.cs.titech.ac.jp> wro=
te:
> Dear all,
>
> I am using Ceph as a baseline for Hadoop. In Hadoop there is a
> NNThroughputBenchmark, which tries to test the upper limit of the
> namenode (a.k.a MDS in Ceph).
> This NNThroughputBenchmark basically creates a master node, and
> creates many threads that sends requests to the master node as
> possible. This approach minimizes communication overhead when
> employing actual clients. The code can be found here:
> https://svn.apache.org/repos/asf/hadoop/common/branches/branch-0.19/s=
rc/test/org/apache/hadoop/hdfs/NNThroughputBenchmark.java
>
> So I'm testing Ceph in similar manner:
> - Mount Ceph to a folder
> - Create many threads and send requests to the MDS on the MDS (so no
> network communication)
> - I do not write any data to the files: just mere file creation.
>
> However, I notice very poor performance on Ceph (only about 485
> ops/sec, as oppose to 8000ops/sec in Hadoop, and I'm not sure why. I
> also notice that when I tried to remove the folder created by the
> interrupted test of the benchmark mentioned above, I took too long I
> had to Ctrl+Break out of the rm program. I'm thinking that the reason
> could be that I'm using Java IO instead of Ceph direct data
> manipulation code. Also, I didn't write any data so there shouldn't b=
e
> any overhead of communicating with the OSDs (or is my assumption
> wrong?)
>
> So do you have any idea on this?
>
> My configuration at the moment:
> - Ceph 0.47.1
> - Intel Xeon 5 2.4Ghz, 4x2 cores
> - 24GB of RAM
> - One node for Monitor, One for MDS, 5 for OSD (of the same configura=
tion)
> - I mount Ceph to a folder on the MDS and run the simulation on that
> folder (creating, opening, deleting files) - Right now I'm just
> working on creating files so I haven't tested with others.
>
> And I'm wondering if there is anyway I can use the API to manipulate
> the file system directly instead of mounting through the OS and use
> the OS's basic file manipulation layer.
> I checked the API doc at http://ceph.com/docs/master/api/librados/ an=
d
> it appears that there is no clear way of accessing the Ceph's file
> system directly, only object-based storage system.
>
> Thank you very much for your help!
>
> Below is the configuration of my Ceph installation:
>
> ; disable authentication
> [mon]
> =A0 =A0 =A0 =A0mon data =3D /home/namd/ceph/mon
>
> [osd]
> =A0 =A0 =A0 =A0osd data =3D /home/namd/ceph/osd
> =A0 =A0 =A0 =A0osd journal =3D /home/namd/ceph/osd.journal
> =A0 =A0 =A0 =A0osd journal size =3D 1000
> =A0 =A0 =A0 =A0osd min rep =3D 3
> =A0 =A0 =A0 =A0osd max rep =3D 3
> =A0 =A0 =A0 =A0; the following line is for ext4 partition
> =A0 =A0 =A0 =A0filestore xattr use omap =3D true
>
> [mds.1]
> =A0 =A0 =A0 =A0host=3Dsakura09
>
> [mds.2]
> =A0 =A0 =A0 =A0host=3Dsakura10
>
> [mds.3]
> =A0 =A0 =A0 =A0host=3Dsakura11
>
> [mds.4]
> =A0 =A0 =A0 =A0host=3Dsakura12
>
> [mon.0]
> =A0 =A0 =A0 =A0host=3Dsakura08
> =A0 =A0 =A0 =A0mon addr=3D192.168.172.178:6789
>
> [osd.0]
> =A0 =A0 =A0 =A0host=3Dsakura13
>
> [osd.1]
> =A0 =A0 =A0 =A0host=3Dsakura14
>
> [osd.2]
> =A0 =A0 =A0 =A0host=3Dsakura15
>
> [osd.3]
> =A0 =A0 =A0 =A0host=3Dsakura16
>
> [osd.4]
> =A0 =A0 =A0 =A0host=3Dsakura17
>
> [osd.5]
> =A0 =A0 =A0 =A0host=3Dsakura18
>
>
>
> Best regards,
>
> Nam Dang
> Email: namd@de.cs.titech.ac.jp
> Tokyo Institute of Technology
> Tokyo, Japan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
