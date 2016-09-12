From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/47] RADOS Block Device: Fine-tuning for several function
 implementations
Date: Mon, 12 Sep 2016 20:40:19 +0200
Message-ID: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 20:35:20 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (47):
  Use kmalloc_array() in rbd_header_from_disk()
  Less function calls in rbd_header_from_disk() after error detection
  Adjust the position of a jump label in rbd_header_from_disk()
  Refactor two calls for memory allocations in rbd_dev_image_id()
  One function call less in rbd_dev_image_id() after error detection
  Rename jump labels in rbd_add_parse_args()
  Rename a jump label in rbd_dev_v2_snap_name()
  Rename jump labels in rbd_dev_v2_snap_context()
  Rename a jump label in rbd_spec_fill_names()
  One function call less in rbd_dev_image_name() after error detection
  Delete three unnecessary initialisations in rbd_dev_image_name()
  One function call less in rbd_dev_v2_parent_info() after error detection
  Delete an unnecessary initialisation in rbd_dev_v2_parent_info()
  Rename a jump label in rbd_dev_v2_object_prefix()
  Rename jump labels in rbd_dev_create()
  Rename jump labels in rbd_dev_v1_header_info()
  Rename jump labels in rbd_init_disk()
  Fix jump targets in rbd_queue_workfn()
  Rename a jump label in rbd_reregister_watch()
  Rename a jump label in rbd_register_watch()
  Rename jump labels in rbd_try_lock()
  Rename a jump label in find_watcher()
  Rename jump labels in get_lock_owner_info()
  Rename jump labels in rbd_request_lock()
  Fix jump targets in rbd_img_parent_read()
  Rename a jump label in rbd_img_parent_read_callback()
  Rename a jump label in rbd_img_request_submit()
  Refactor a jump target in rbd_img_obj_exists_submit()
  Delete an unnecessary initialisation in rbd_img_obj_exists_submit()
  Refactor a jump target in rbd_img_obj_exists_callback()
  Fix three jump targets in rbd_img_obj_parent_read_full()
  Rename a jump label in rbd_img_obj_parent_read_full_callback()
  Adjust the position of a jump label in rbd_img_request_fill()
  Rename a jump label in rbd_img_obj_callback()
  Rename jump labels in rbd_osd_req_create_copyup()
  Rename jump labels in rbd_osd_req_create()
  Rename a jump label in bio_chain_clone_range()
  Rename jump labels in rbd_client_create()
  Rename a jump label in rbd_ioctl_set_ro()
  One function call less in rbd_dev_probe_parent() after error detection
  Rename jump labels in rbd_dev_device_setup()
  Rename jump labels in rbd_dev_image_probe()
  Rename jump labels in do_rbd_add()
  Delete an unnecessary initialisation in do_rbd_add()
  Rename a jump label in rbd_slab_init()
  Rename jump labels in rbd_init()
  Delete unwanted spaces behind usages of the sizeof operator

 drivers/block/rbd.c | 544 ++++++++++++++++++++++++++--------------------------
 1 file changed, 272 insertions(+), 272 deletions(-)

-- 
2.10.0

