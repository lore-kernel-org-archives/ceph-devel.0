From: <Kelvin_Huang@wiwynn.com>
Subject: Ceph availability test & recovering question
Date: Sun, 17 Mar 2013 04:18:12 +0000
Message-ID: <86F425174C7E4F418CCF4E62056152E593906F@GDC-CLDMBX-P01.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw2.wistron.com ([220.128.89.22]:55287 "EHLO
	TWNHUMSW2.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3CQESQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Mar 2013 00:18:16 -0400
Received: from GDC-CLDCAS-P01.whq.wistron (unverified [10.37.38.62]) by TWNHUMSW2.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Taa84b435bdc0a816701054@TWNHUMSW2.wistron.com> for <ceph-devel@vger.kernel.org>;
 Sun, 17 Mar 2013 12:20:43 +0800
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Eric_YH_Chen@wiwynn.com

Hi, all

I have some problem after availability test

Setup:
Linux kernel: 3.2.0
OS: Ubuntu 12.04
Storage server : 11 HDD (each storage server has 11 osd, 7200 rpm, 1T) + 10GbE NIC 
RAID card: LSI MegaRAID SAS 9260-4i  For every HDD: RAID0, Write Policy: Write Back with BBU, Read Policy: ReadAhead, IO Policy: Direct 
Storage server number : 2

Ceph version : 0.48.2
Replicas : 2
Monitor number:3


We have two storage server as a cluter, then use ceph client create 1T RBD image for testing, the client also 
has 10GbE NIC , Linux kernel 3.2.0 , Ubuntu 12.04

We also use FIO to produce workload

fio command:
[Sequencial Read]
fio --iodepth = 32 --numjobs=1 --runtime=120  --bs = 65536 --rw = read --ioengine=libaio --group_reporting --direct=1 --eta=always  --ramp_time=10 --thinktime=10

[Sequencial Write]
fio --iodepth = 32 --numjobs=1 --runtime=120  --bs = 65536 --rw = write --ioengine=libaio --group_reporting --direct=1 --eta=always  --ramp_time=10 --thinktime=10


Now I want observe to ceph state when one storage server is crash, so I turn off one storage server networking.
We expect that data write and data read operation can be quickly resume or even not be suspended in ceph recovering time, but the experimental results show 
the data write and data read operation will pause for about 20~30 seconds in ceph recovering time.

My question is:
1.The state of I/O pause is normal when ceph recovering ?
2.The pause time of I/O that can not be avoided when ceph recovering ?
3.How to reduce the I/O pause time ?


Thanks!!
