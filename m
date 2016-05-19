From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: Min alloc size according to media type
Date: Thu, 19 May 2016 18:14:52 +0000
Message-ID: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0088.outbound.protection.outlook.com ([65.55.169.88]:24016
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932706AbcESSO4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 14:14:56 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

I am doing changes in Bluestore related to minimum allocation size according to ssd and hdd.
This change involves:

1. There are three min alloc sizes now:
                a. min_alloc_size: old one, default changed to 0
                b. min_alloc_size_hdd: for rotational media, default 64k
                c. min_alloc_size_ssd: for ssd, default 4k.

2. Making changes in BlockDevice to maintain its own min_alloc_size. It allows to maintain different min_alloc_size for different devices.

3. Making changes in allocator(stupid, bitmap) interfaces to take min_alloc_size from the corresponding devices.


I have following questions regarding this parameter and use of it in bluestore:

1. I assume this parameter is transient and does not have effect on different values (say changed from 4k to 64k or vice versa) across reboots or different ceph versions?
                Is it ondisk anywhere in metadata or in freelist manager in direct or indirect manner? Because having on disk presence could cause confusions by
                having new options when existing users move to build with this change.

2. While figuring out the min_alloc_size for devices, I give preferences to old config parameter so that existing configs
                are not changed by this code change. Is this right or this is not required?


-Regards,
Ramesh Chander


PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
