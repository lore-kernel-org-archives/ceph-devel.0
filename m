From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 00/15] rbd: switch to blk-mq
Date: Fri, 31 Jan 2020 11:37:24 +0100
Message-ID: <20200131103739.136098-1-hare@suse.de>
Return-path: <linux-block-owner@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: ceph-devel.vger.kernel.org

Hi all,

this patchset implements multiqueue support for rbd, which gives
a nice performance benefit (I measured up to 25% on my grid).
To achieve this several steps are required:
1) drop the 'state_mutex' in rbd_img_advance.
   To do so the state machines had to be reordered so ensure
   no race windows are left when invoking asynchronous methods.
2) Embed image request into the block request to save a memory
   allocation in the hot path
3) Enable one queue per CPU to enhance parallelism.

I also took the opportunity to clean up the state machines, by
adding a 'done' step and ensuring that the step is always set
correctly upon exit. This allows for better debugging as now
the final states must always be set when destroying an object.

As usual, comments and reviews are welcome.

Hannes Reinecke (15):
  rbd: lock object request list
  rbd: use READ_ONCE() when checking the mapping size
  rbd: reorder rbd_img_advance()
  rbd: reorder switch statement in rbd_advance_read()
  rbd: reorder switch statement in rbd_advance_write()
  rbd: add 'done' state for rbd_obj_advance_copyup()
  rbd: use callback for image request completion
  rbd: add debugging statements for the state machine
  rbd: count pending object requests in-line
  rbd: kill 'work_result'
  rbd: drop state_mutex in __rbd_img_handle_request()
  rbd: kill img_request kref
  rbd: schedule image_request after preparation
  rbd: embed image request as blk_mq request payload
  rbd: switch to blk-mq

 drivers/block/rbd.c | 418 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 240 insertions(+), 178 deletions(-)

-- 
2.16.4
