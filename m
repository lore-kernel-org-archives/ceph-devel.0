From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueStore IOContext Isolation
Date: Sun, 3 Apr 2016 15:41:06 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604031536390.19675@cpach.fuggernut.com>
References: <CACJqLyYoTxih4sBdDRO3SXdQHZZUzrC+opbw-5ii6DguVG1JdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbcDCTlN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 3 Apr 2016 15:41:13 -0400
In-Reply-To: <CACJqLyYoTxih4sBdDRO3SXdQHZZUzrC+opbw-5ii6DguVG1JdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 4 Apr 2016, Haomai Wang wrote:
> Hi sage,
> 
> I have a few questions regards to bluestore want to confirm from
> design view, I mean some cases is true for current kerneldevice impl,
> but it doesn't required by BlueStore(upper layer):
> 
> 1. Two IOContext need to share data for buffer ops? and what about
> read_buffered. like:
> 
> IOContext a, b;
> bdev->aio_write(a, 0, 100, true)
> bdev->read(b, 0, 100, true)
> bdev->read_buffered(0, 100)
> 
> b could read data from another "a" which haven't call bdev->flush().
> or this overlap case is guard by BlueStore already?

b can read a only if a's IO completed.  bdev->flush() is only needed for 
persistence/durability (it triggers any hardware-specific flush that is 
needed).

> 2. Is it possible exists single IOContext overlap ops? like:
> 
> IOContext a;
> bdev->aio_write(a, 0, 100, true)
> bdev->read(a, 0, 50, true)
> 
> OR
> IOContext a;
> bdev->aio_write(a, 0, 100, false)
> bdev->read(a, 0, 50, false)
> 
> read op need to aware of the inflight write ops from the same
> IOContext? or bluestore will prevent this?

The OSD prevents it (see ObcLockManager and 
ObjectContext::RWState::State).  BlueStore doesn't do anything.. if you 
submit racing reads and writes at the ObjectStore layer the result is 
undefined.

The main read/write issue BlueStore needs to worry about is 
Onode::flush(), which waits for any pending WAL work to complete.

sage
