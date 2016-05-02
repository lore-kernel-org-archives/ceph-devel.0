From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: Implementing bitmap based space allocator for BlueStore
Date: Mon, 2 May 2016 06:08:21 +0000
Message-ID: <BLUPR0201MB1809B0B51FF640A10869E0A285790@BLUPR0201MB1809.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0098.outbound.protection.outlook.com ([207.46.100.98]:32160
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750948AbcEBGIY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2016 02:08:24 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ceph Developers,

I hope you all are doing great.

This is just a note that I am working on implementing bitmap based allocator for BlueStore.

The first level of details are below.

Brief details of allocator:
-----------------------------

I am planning to write a bitmap scanner to find N contiguous or non-contiguous blocks from a bitmap of storage space range assigned to allocator.

It will be following interfaces of Allocator class in Allocator.h.

The main idea behind it is to reduce memory foot print of allocator when using small blocks like 4K. It will also allow multiple thread to allocate concurrently.

The logic divides the bitmap in to zones and multiple threads can be allocating from different zones at a time.
This can be helpful in case of storage is at saturation and lot of scanning needs to be done to find free blocks.

Scanning can/will be further made more intelligent keeping hierarchy of summary of space at different areas.

Please let me know your thoughts on this.

-Regards,
Ramesh Chander
Sr. Staff Engineer
Sandisk India
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
