From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] rbd: rework rbd_request_fn()
Date: Tue, 5 Aug 2014 00:44:50 -0700
Message-ID: <20140805074450.GA10925@infradead.org>
References: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38788 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbaHEHov (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 03:44:51 -0400
Content-Disposition: inline
In-Reply-To: <1407224324-4811-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 05, 2014 at 11:38:44AM +0400, Ilya Dryomov wrote:
> While it was never a good idea to sleep in request_fn(), commit
> 34c6bc2c919a ("locking/mutexes: Add extra reschedule point") made it
> a *bad* idea.  mutex_lock() since 3.15 may reschedule *before* putting
> task on the mutex wait queue, which for tasks in !TASK_RUNNING state
> means block forever.  request_fn() may be called with !TASK_RUNNING on
> the way to schedule() in io_schedule().
> 
> Offload request handling to a workqueue, one per rbd device, to avoid
> calling blocking primitives from rbd_request_fn().

Btw, for the future you might want to consider converting rbd to use the
blk-mq infrastructure, which calls the I/O submission function from user
context and will allow you to sleep.

