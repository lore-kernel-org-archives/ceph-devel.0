From: Li Wang <liwang@ubuntukylin.com>
Subject: Read ahead affect Ceph read performance much
Date: Mon, 29 Jul 2013 18:24:34 +0800
Message-ID: <51F642E2.3090201@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:50645 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3G2KYi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 06:24:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

We performed Iozone read test on a 32-node HPC server. Regarding the=20
hardware of each node, the CPU is very powerful, so does the network,=20
with a bandwidth > 1.5 GB/s. 64GB memory, the IO is relatively slow, th=
e=20
throughput measured by =91dd=92 locally is around 70MB/s. We configured=
 a=20
Ceph cluster with 24 OSDs on 24 nodes, one mds, one to four clients, on=
e=20
client per node. The performance is as follows,

     Iozone sequential read throughput (MB/s)
Number of clients     1          2         4
Default resize    180.0954   324.4836   591.5851
Resize: 256MB     645.3347   1022.998	1267.631

The complete iozone parameter for one client is,
iozone -t 1 -+m /tmp/iozone.nodelist.50305030 -s 64G -r 4M -i 0 -+n -w=20
-c -e -b /tmp/iozone.nodelist.50305030.output, on each client node, onl=
y=20
one thread is started.

for two clients, it is,
iozone -t 2 -+m /tmp/iozone.nodelist.50305030 -s 32G -r 4M -i 0 -+n -w=20
-c -e -b /tmp/iozone.nodelist.50305030.output

As the data shown, a larger read ahead window could result in >300% spe=
edup!

Besides, Since the backend of Ceph is not the traditional hard disk, it=
=20
is beneficial to capture the stride read prefetching. To prove this, we=
=20
tested the stride read with the following program, as we know, the=20
generic read ahead algorithm of Linux kernel will not capture=20
stride-read prefetch, so we use fadvise() to manually force pretching.
the record size is 4MB. The result is even more surprising,

             Stride read throughput (MB/s)
Number of records prefetched  0      1      4      16      64      128
Throughput                  42.82  100.74 217.41  497.73  854.48  950.1=
8

As the data shown, with a read ahead size of 128*4MB, the speedup over
without read ahead could be up to 950/42 > 2000%!

The core logic of the test program is below,

stride =3D 17
recordsize =3D 4MB
for (;;) {
   for (i =3D 0; i < count; ++i) {
     long long start =3D pos + (i + 1) * stride * recordsize;
     printf("PRE READ %lld %lld\n", start, start + block);
     posix_fadvise(fd, start, block, POSIX_FADV_WILLNEED);
   }
   len =3D read(fd, buf, block);
   total +=3D len;
   printf("READ %lld %lld\n", pos, (pos + len));
   pos +=3D len;
   lseek(fd, (stride - 1) * block, SEEK_CUR);
   pos +=3D (stride - 1) * block;
}

Given the above results and some more, We plan to submit a blue print t=
o=20
discuss the prefetching optimization of Ceph.

Cheers,
Li Wang




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
