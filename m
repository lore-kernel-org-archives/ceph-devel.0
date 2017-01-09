From: David Zafman <dzafman@redhat.com>
Subject: Failure to repair an omap digest
Date: Mon, 9 Jan 2017 13:05:45 -0800
Message-ID: <85235bfc-34da-4e31-1eb3-259477445967@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932505AbdAIVFr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 9 Jan 2017 16:05:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 819CE4C472
        for <ceph-devel@vger.kernel.org>; Mon,  9 Jan 2017 21:05:47 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

ceph version 11.1.0-6147-g12706d7 
(12706d76225fa1491d00362d3bc04e0541dead73)

A failure to repair occurred because without a digest in the object info 
the code doesn't attempt to decide which omap is wrong.   Here we only 
have an omap_digest_mismatch error.  Had the "selected_object_info" 
included "od" presuambly of 1fff04c0 then "omap_digest_mismatch_oi" 
would have been set on osd.47 and it would be repaired.

The way to fix this particular case is to stop osd.47, remove the object 
with ceph-objectstore-tool, then restart osd.47 and the repair should 
then re-create a correct object and omap there.  As you can see the 
object name is 100011cf577.00000000 in pool 1 (metadata).

$  sudo rados list-inconsistent-pg metadata
["1.25"]

$ sudo rados list-inconsistent-obj 1.25 --format=json-pretty
{
     "epoch": 767566,
     "inconsistents": [
         {
             "object": {
                 "name": "100011cf577.00000000",
                 "nspace": "",
                 "locator": "",
                 "snap": "head",
                 "version": 9023143
             },
             "errors": [
                 "omap_digest_mismatch"
             ],
             "union_shard_errors": [],
             "selected_object_info": 
"1:a7f0f16e:::100011cf577.00000000:head(768083'9023143 
mds.0.94887:9732381 dirty|omap|data_digest s 0 uv 9023143 dd ffffffff 
alloc_hint [0 0 0])",
             "shards": [
                 {
                     "osd": 7,
                     "errors": [],
                     "size": 0,
                     "omap_digest": "0x1fff04c0",
                     "data_digest": "0xffffffff"
                 },
                 {
                     "osd": 47,
                     "errors": [],
                     "size": 0,
                     "omap_digest": "0xc2c5ddcd",
                     "data_digest": "0xffffffff"
                 },
                 {
                     "osd": 60,
                     "errors": [],
                     "size": 0,
                     "omap_digest": "0x1fff04c0",
                     "data_digest": "0xffffffff"
                 },
                 {
                     "osd": 72,
                     "errors": [],
                     "size": 0,
                     "omap_digest": "0x1fff04c0",
                     "data_digest": "0xffffffff"
                 }
             ]
         }
     ]
}


David

