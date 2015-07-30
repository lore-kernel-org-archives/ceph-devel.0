From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Thu, 30 Jul 2015 00:34:25 -0700
Message-ID: <1438241665.14435.50.camel@haakon3.risingtidesystems.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
	 <20150729175515.GA16804@infradead.org> <55B95ACC.2030306@redhat.com>
	 <55B96451.30706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.linux-iscsi.org ([67.23.28.174]:37659 "EHLO
	linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbG3Hee (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 03:34:34 -0400
In-Reply-To: <55B96451.30706@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

Hey Mike & HCH,

On Wed, 2015-07-29 at 18:40 -0500, Mike Christie wrote:
> On 07/29/2015 05:59 PM, Mike Christie wrote:
> > On 07/29/2015 12:55 PM, Christoph Hellwig wrote:
> >> On Wed, Jul 29, 2015 at 04:23:38AM -0500, mchristi@redhat.com wrote:
> >>> From: Mike Christie <michaelc@cs.wisc.edu>
> >>>
> >>> LIO uses scatterlist for its page/data management. This patch
> >>> adds a scatterlist messenger data type, so LIO can pass its sg
> >>> down directly to rbd.
> >>
> >> Just as I mentioned for David's patches this is the wrong way to attack
> >> your problem.  The block layer already supports WRITE SAME, and COMPARE
> >> and WRITE nees to be supported at that level too insted of creating
> >> artifical bypasses.
> > 
> > Why do I have to use the block layer? I just want to map the se_cmd to a
> > ceph request and then put it back on the wire. I don't think I need any
> > of the block layer services. We will do things like io scheduling on the
> > OSD side. We just want to use LIO as more of a passthrough.
> 
> Maybe I misunderstood you.
> 
> I guess I was viewing this similar to cephfs where it does not use rbd
> and the block layer. It just makes ceph/rados calls directly using
> libceph. I am using rbd.c for its helper/wrapper functions around the
> libceph ones, but I could just make libceph calls directly too.
> 
> Were you saying because for lio support we need to do more block
> layer'ish operations like write same, compare and write, etc than
> cephfs, then I should not do the lio backend and we should always go
> through rbd for lio support?

If we're using common request_queue function pointers it would avoid the
need to maintain an extra backend drivers, and be a generic offload
interface for other make_request_fn() based block drivers using
target-core to utilize.

In the WRITE_SAME + COMPARE_AND_WRITE pass-through cases, IBLOCK se_cmd
pass-through should be invoking the driver provided VAAI callbacks
directly if they exist, and disabling local target-core CDB emulation.

For EXTENDED_COPY pass-through, target-core copy-manager still needs to
be responsible for config_group dependencies across multiple se_device
backends, with a IBLOCK pass-through providing both block_device *src_bd
+ *dst_bd pointers into a request_queue callback for different PUSH/PULL
offload models.

It should also be able to fall back to local copy if source +
destination devices do not both support the same type copy-offload
pass-through.

> 
> Is that for all operations? For distributed TMFs and PRs then are you
> thinking I should make those more block layer based (some sort of queue
> or block deivce callouts or REQ_ types), or should those still have some
> sort of lio callouts which could call different locking/cluster APIs
> like libceph?

The PR-OUT logic for REGISTER w/ remote I_PORT and remote PREEMPT-*
currently obtains the necessary config_group dependencies, and would
need to be considered for request_queue based PR pass-through too.

Exposing target TMFs pass-through into request_queue is a different
beast..

