From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Rbd map failure in 3.16.0-55
Date: Sat, 12 Dec 2015 06:56:57 +0000
Message-ID: <BLUPR0201MB1908E516F6CE6529654476ECE2EB0@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0073.outbound.protection.outlook.com ([157.56.111.73]:42752
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751497AbbLLIbL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Dec 2015 03:31:11 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

We are working on jewel branch on a test cluster to validate some of the fixes. But landed up in the following error when mapping an image using  krbd on Ubuntu 14.04.2 with 3.16.0-55 kernel version.

$ sudo rbd map -p pool1 rbd1
rbd: sysfs write failed
rbd: map failed: (5) Input/output error


$ uname -a
Linux 3.16.0-55-generic #74~14.04.1-Ubuntu SMP Tue Nov 17 10:15:59 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

$dmesg
....
[11082.199006] libceph: read_partial_message bad hdr  crc 2112154322 != expected 0
[11082.209414] libceph: mon0 x.x.x.x:6789 socket error on read
[11092.238317] libceph: read_partial_message bad hdr  crc 2112154322 != expected 0
[11092.248982] libceph: mon0 x.x.x.x:6789 socket error on read
.....

When I looked at the ceph_msg_header on 3.16 kernel (http://lxr.free-electrons.com/source/include/linux/ceph/msgr.h?v=3.16)

There is one field change from jewel branch 

145 struct ceph_msg_header {
.......
159
160         /* oldest code we think can decode this.  unknown if zero. */
161         __le16 compat_version; <<< New one, which is present from 3.19 onwards
162         __le16 reserved;
163         __le32 crc;       /* header crc32c */
164 } __attribute__ ((packed));

How can map the image in 3.16 kernel apart from upgrading the kernel? Do we have any branch where I can build the modules with latest changes? 

Regards,
Varada

