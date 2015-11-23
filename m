From: "Yan, Zheng" <zyan@redhat.com>
Subject: =?utf-8?Q?Re=3A_Ceph-fuse_single_read_limitation=3F=E2=80=8F?=
Date: Mon, 23 Nov 2015 10:22:23 +0800
Message-ID: <99D7EA2A-9588-4B80-B172-1F92F2A2142E@redhat.com>
References: <SNT146-W62CB5B81C00E768E7348638C190@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbbKWCW3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Nov 2015 21:22:29 -0500
In-Reply-To: <SNT146-W62CB5B81C00E768E7348638C190@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Zhang <zhangz.david@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Nov 21, 2015, at 10:12, Z Zhang <zhangz.david@outlook.com> wrote:
> 
> Hi Guys,
> 
> Now we have a very small cluster with 3 OSDs but using 40Gb NIC. We use ceph-fuse as cephfs client and enable readahead, but testing single reading a large file from cephfs via fio, dd or cp can only achieve ~70+MB/s, even if fio or dd's block size is set to 1MB or 4MB.
> 
> From the ceph client log, we found each read request's size (ll_read) is limited to 128KB, which should be the limitation of kernel fuse's FUSE_MAX_PAGES_PER_REQ = 32. We may try to increase this value to see the performance difference, but are there other options we can try to increase single read performance?
> 

try setting client_readahead_max_bytes to 4M

Yan, Zheng 		 	   		  

