From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Object Write Latency
Date: Tue, 24 Sep 2013 12:04:42 +0200
Message-ID: <CABZ+qqmzumXyncc3R6gOA4dzutto99eCUPOd7EG3TgNG9-=SyA@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
 <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
 <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net> <CABZ+qq=Pj0oQ3nUUh3T_mTnpXSUd93uLzX955bHx6MY+fek9YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:41010 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab3IXKFY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 06:05:24 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so1678883bkb.29
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 03:05:23 -0700 (PDT)
Received: by mail-lb0-f176.google.com with SMTP id y6so3602014lbh.35
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 03:05:22 -0700 (PDT)
In-Reply-To: <CABZ+qq=Pj0oQ3nUUh3T_mTnpXSUd93uLzX955bHx6MY+fek9YQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Some more tests...

~journal in XFS:
[root@p05151113777233 fio]# time dd if=/dev/zero
of=/var/lib/ceph/osd/osd.1045/testtest bs=512 count=1 conv=fsync
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.0423365 s, 12.1 kB/s

real 0m0.044s
user 0m0.000s
sys 0m0.001s


~directio via the FS
[root@p05151113777233 fio]# time dd if=/dev/zero
of=/var/lib/ceph/osd/osd.1045/testtest bs=512 count=1
oflag=direct,dsync
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.0426422 s, 12.0 kB/s

real 0m0.044s
user 0m0.000s
sys 0m0.001s


~directio to the bdev seems to be faster (a few attempts below):

[root@p05151113760120 ~]# time dd if=/dev/zero of=/dev/sdo1 bs=512
count=1 seek=$(($RANDOM*1000)) oflag=direct,dsync
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.0113362 s, 45.2 kB/s

real 0m0.013s
user 0m0.001s
sys 0m0.001s
[root@p05151113760120 ~]# time dd if=/dev/zero of=/dev/sdo1 bs=512
count=1 seek=$(($RANDOM*1000)) oflag=direct,dsync
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.0129222 s, 39.6 kB/s

real 0m0.014s
user 0m0.001s
sys 0m0.000s
[root@p05151113760120 ~]# time dd if=/dev/zero of=/dev/sdo1 bs=512
count=1 seek=$(($RANDOM*1000)) oflag=direct,dsync
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.00484823 s, 106 kB/s

real 0m0.006s
user 0m0.001s
sys 0m0.001s
[root@p05151113760120 ~]#
[root@p05151113760120 ~]# time dd if=/dev/zero of=/dev/sdo1 bs=512
count=1 seek=$(($RANDOM*1000)) oflag=direct,dsync
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.00441663 s, 116 kB/s

real 0m0.006s
user 0m0.001s
sys 0m0.001s


So it looks like I really should try those O_DIRECT journals on a
separate partition.

Cheers, Dan

On Tue, Sep 24, 2013 at 11:13 AM, Dan van der Ster <dan@vanderster.com> wrote:
> On Mon, Sep 23, 2013 at 8:18 PM, Sage Weil <sage@inktank.com> wrote:
>> You
>> might try measuring that directly and comparing it to the 33ms
>> append+fsync that you previously saw.
>
> dd with fsync is quite slow...
>
> [root@p05151113777233 fio]# time dd if=/dev/zero
> of=/var/lib/ceph/osd/osd.1045/testtest bs=5 count=1
> 1+0 records in
> 1+0 records out
> 5 bytes (5 B) copied, 8.884e-05 s, 56.3 kB/s
>
> real 0m0.001s
> user 0m0.000s
> sys 0m0.001s
>
>
> [root@p05151113777233 fio]# time dd if=/dev/zero
> of=/var/lib/ceph/osd/osd.1045/testtest bs=5 count=1 conv=fsync
> 1+0 records in
> 1+0 records out
> 5 bytes (5 B) copied, 0.0435103 s, 0.1 kB/s
>
> real 0m0.045s
> user 0m0.001s
> sys 0m0.001s
