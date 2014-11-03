From: Christoph Hellwig <hch@lst.de>
Subject: blk-mq: allow to defer ->queue_rq invocations to workqueue
Date: Mon,  3 Nov 2014 09:23:26 +0100
Message-ID: <1415003008-16683-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: Richard Weinberger <richard@nod.at>, Ming Lei <tom.leiming@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Drivers that need to do synchronous, blocking operations to do I/O gene=
rally
want to defer all I/O to a dr=D1=96ver-private workqueue.  Examples for=
 that are
the loop driver, rbd, or ubi block driver, and probably lots more that =
haven't
been evaluated yet.
