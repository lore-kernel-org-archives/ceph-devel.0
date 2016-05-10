From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: Implementing bitmap based space allocator for BlueStore
Date: Tue, 10 May 2016 10:20:21 +0000
Message-ID: <CY1PR0201MB1820941DBBE1FB7927F42D2185710@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <BLUPR0201MB1809B0B51FF640A10869E0A285790@BLUPR0201MB1809.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:13664
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751004AbcEJKU0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 06:20:26 -0400
In-Reply-To: <BLUPR0201MB1809B0B51FF640A10869E0A285790@BLUPR0201MB1809.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>

Hi Ceph Developers,

This is request to review PR:

https://github.com/ceph/ceph/pull/9031

is for below mentioned bitmap based allocator in BlueStore.

In short please review the code.


Details: (same mentioned in pull request)
------------------------------------------------
This is Bitmap based allocator for BlueStore.
Motivation:
1. Reduction of memory by using just one bit for single block (as compared to 8 + 8 byes in case of extent based allocator).
2. Concurrent allocations via multiple threads.

It exposes mainly these interfaces:
1. Allocate contiguous blocks.
2. Allocate non-contiguous blocks.
3. Free allocated blocks.
4. Get Statistics about allocator.

It works in two modes:

    Concurrent:
    Where multiple threads can be allocating at same time in different space zones. This is specially for faster media like SSDs.

    Serial:
    Only one thread can be active inside bitmap allocator at a time. This one is mainly to keep rotating media in mind since
    concurrent allocations can aggravate random writes.

Test Ran:
1. Make check.
2. Basic read write multi-threaded test cases with recovery.
3. Exhaustive unit test cases for corner cases

Next steps:
1. Complete set of multi-threaded test cases.
2. More test cases to protect from space leak and corruption in Blue Store.
4. Provide more intelligent configurable like Zone size.
5. If required make scanning faster my one more level in summary hierarchy.
6. If required more stricter reservations guarantee.

Over All Design Overview:

Full space is divided in to fixed size but configurable zones. It is the unit where at a time single thread can be actively allocating from.
A zone is then further divided in to BitMaps. Each bitmap is 64bits hence 64 blocks.

Allocation:

Start from a marker and scans for contiguous or dis-contiguous free blocks in zones one after another and in BitMaps one after another within a zone.
If while scan a zone is found locked by somebody, it simple tries in next zone.
If two scans does not find anything, then third scan is serial and it blocks on a zone if it is locked by another thread to avoid possibility missing only zones that have space.

In serial mode of allocation, it always take single lock on full allocator and scans for free space.

In contiguous allocation, the allocation is either fulfilled completely or nothing is allocated.
In case of dis-contiguous allocations, partial results can be returned.

Free:
Free does not take any lock on zone or area, it simply atomically tweaks the bits.

Limitations:

    Single allocation cannot extend beyond a zone in concurrent mode ( around 64M in current 64k config and default value).

-Regards,
Ramesh Chander
Sr. Stagg Software Engineer
Sandisk








-----Original Message-----
From: Ramesh Chander
Sent: Monday, May 02, 2016 11:38 AM
To: 'ceph-devel@vger.kernel.org'
Subject: Implementing bitmap based space allocator for BlueStore

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
