From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Ceph Performance puzzle.
Date: Thu, 7 May 2015 11:38:15 -0700
Message-ID: <CAKKTCLV2deJU-s=GubM9xcNNd8bfLZ0OE1xEZD5s4E0dyci4Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36776 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEGSig (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 14:38:36 -0400
Received: by obbkp3 with SMTP id kp3so38338936obb.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2015 11:38:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>, zhiqiang.wang@intel.com

Hope someone sheds light. Not able to reason out what I am seeing.
OSD bench shows that bandwidth is increasing with BlockSize.
While librados bench shows bandwidth is falling after 16k.
I have 3 SSD  OSDs in SSD pool.

vjujjuri@wsl6:~$ iperf -csl2 -P 16
 [SUM]  0.0-10.1 sec  1.11 GBytes   945 Mbits/sec

vjujjuri@wsl13:/media/data$ ceph --version
ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)


vjujjuri@wsl13:/media/data$ ceph tell osd.0 bench 10485760 8192
{
    "bytes_written": 10485760,
    "blocksize": 8192,
    "bytes_per_sec": 47176008.000000
}

vjujjuri@wsl13:/media/data$ ceph tell osd.0 bench 10485760 16384
{
    "bytes_written": 10485760,
    "blocksize": 16384,
    "bytes_per_sec": 109491958.000000
}

vjujjuri@wsl13:/media/data$ ceph tell osd.0 bench 10485760 32768
{
    "bytes_written": 10485760,
    "blocksize": 32768,
    "bytes_per_sec": 242963276.000000
}

Where as the bench:
vjujjuri@wsl13:/media/data$ rados bench -p sfdc_ssd -b 8192 10 write
--no-cleanup
Bandwidth (MB/sec):     25.878

vjujjuri@wsl13:/media/data$ rados bench -p sfdc_ssd -b 16384 10 write
--no-cleanup
Bandwidth (MB/sec):     48.425

vjujjuri@wsl13:/media/data$ rados bench -p sfdc_ssd -b 32768 10 write
--no-cleanup
Bandwidth (MB/sec):     35.750

Thanks in advance


--
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
