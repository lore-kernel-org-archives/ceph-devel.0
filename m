From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Read ahead affect Ceph read performance much
Date: Mon, 29 Jul 2013 09:48:47 -0500
Message-ID: <51F680CF.4050903@inktank.com>
References: <51F642E2.3090201@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:58073 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab3G2Osd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 10:48:33 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so2318367veb.23
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 07:48:33 -0700 (PDT)
In-Reply-To: <51F642E2.3090201@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 07/29/2013 05:24 AM, Li Wang wrote:
> We performed Iozone read test on a 32-node HPC server. Regarding the
> hardware of each node, the CPU is very powerful, so does the network,
> with a bandwidth > 1.5 GB/s. 64GB memory, the IO is relatively slow, =
the
> throughput measured by =91dd=92 locally is around 70MB/s. We configur=
ed a
> Ceph cluster with 24 OSDs on 24 nodes, one mds, one to four clients, =
one
> client per node. The performance is as follows,
>
>      Iozone sequential read throughput (MB/s)
> Number of clients     1          2         4
> Default resize    180.0954   324.4836   591.5851
> Resize: 256MB     645.3347   1022.998    1267.631
>
> The complete iozone parameter for one client is,
> iozone -t 1 -+m /tmp/iozone.nodelist.50305030 -s 64G -r 4M -i 0 -+n -=
w
> -c -e -b /tmp/iozone.nodelist.50305030.output, on each client node, o=
nly
> one thread is started.
>
> for two clients, it is,
> iozone -t 2 -+m /tmp/iozone.nodelist.50305030 -s 32G -r 4M -i 0 -+n -=
w
> -c -e -b /tmp/iozone.nodelist.50305030.output
>
> As the data shown, a larger read ahead window could result in >300%
> speedup!

Very interesting!  I've done some similar tests and saw somewhat=20
different results (I actually in some cases saw improvement with lower=20
readahead!).  I suspect that this may be very hardware dependent.  Were=
=20
you using RBD or CephFS?  In either case, was it the kernel client or=20
userland (IE QEMU/KVM or FUSE)?  Also, where did you adjust readahead?=20
Was this on the client volume or under the OSDs?

I've got to prepare for the talk later this week, but I will try to get=
=20
my readahead test results out soon as well.

>
> Besides, Since the backend of Ceph is not the traditional hard disk, =
it
> is beneficial to capture the stride read prefetching. To prove this, =
we
> tested the stride read with the following program, as we know, the
> generic read ahead algorithm of Linux kernel will not capture
> stride-read prefetch, so we use fadvise() to manually force pretching=
=2E
> the record size is 4MB. The result is even more surprising,
>
>              Stride read throughput (MB/s)
> Number of records prefetched  0      1      4      16      64      12=
8
> Throughput                  42.82  100.74 217.41  497.73  854.48  950=
=2E18
>
> As the data shown, with a read ahead size of 128*4MB, the speedup ove=
r
> without read ahead could be up to 950/42 > 2000%!
>
> The core logic of the test program is below,
>
> stride =3D 17
> recordsize =3D 4MB
> for (;;) {
>    for (i =3D 0; i < count; ++i) {
>      long long start =3D pos + (i + 1) * stride * recordsize;
>      printf("PRE READ %lld %lld\n", start, start + block);
>      posix_fadvise(fd, start, block, POSIX_FADV_WILLNEED);
>    }
>    len =3D read(fd, buf, block);
>    total +=3D len;
>    printf("READ %lld %lld\n", pos, (pos + len));
>    pos +=3D len;
>    lseek(fd, (stride - 1) * block, SEEK_CUR);
>    pos +=3D (stride - 1) * block;
> }
>
> Given the above results and some more, We plan to submit a blue print=
 to
> discuss the prefetching optimization of Ceph.

Cool!

>
> Cheers,
> Li Wang
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
