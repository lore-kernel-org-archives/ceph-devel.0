From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 08:03:15 -0400
Message-ID: <20100525120315.GA6773@infradead.org>
References: <20100519192222.GD61706@ncolin.muc.de> <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com> <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com> <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:35544 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab0EYMDS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 08:03:18 -0400
Content-Disposition: inline
In-Reply-To: <4BFBB3C1.9020905@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Tue, May 25, 2010 at 02:25:53PM +0300, Avi Kivity wrote:
> Currently if someone wants to add a new block format, they have to  
> upstream it and wait for a new qemu to be released.  With a plugin API,  
> they can add a new block format to an existing, supported qemu.

So?  Unless we want a stable driver ABI which I fundamentally oppose as
it would make block driver development hell they'd have to wait for
a new release of the block layer.  It's really just going to be a lot
of pain for no major gain.  qemu releases are frequent enough, and if
users care enough they can also easily patch qemu.

