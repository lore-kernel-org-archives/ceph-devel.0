From: Loic Dachary <loic@dachary.org>
Subject: crush multiweight implementation details
Date: Mon, 10 Apr 2017 16:04:24 +0200
Message-ID: <6bcba5f9-7f68-bcf7-3f85-323b4fa6dd29@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44946 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdDJOE2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 10:04:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

We could have:

struct crush_choose_arg {
  __u32 bucket_id;
  __u32 num_items;
  __u32 *ids; // override the bucket items for placement
  __u32 num_positions;
  __u32 *weights; // size is num_positions*num_items
};
 
struct crush_choose_arg_map {
  struct crush_choose_arg *args;
  __u32 size;
};

and

void crush_init_workspace(const struct crush_map *m, struct crush_choose_arg_map *arg_map, void *v) {
...
if (m->buckets[b]->id == arg_map[b]->bucket_id)
   w->work[b]->arg = arg_map[b];
...
}

with

struct crush_work_bucket {
    __u32 perm_x; /* @x for which *perm is defined */
    __u32 perm_n; /* num elements of *perm that are permuted/defined */
    __u32 *perm;  /* Permutation of the bucket's items */
    struct crush_choose_arg *arg;
};

There would be no need to change the code path since crush_bucket_choose already is given the crush_work_bucket. And crush_init_workspace already has logic that is algorithm dependent. And all the sanity checks could be done in crush_init_workspace so that the choose function only does what's absolutely necessary.

What do you think ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre

