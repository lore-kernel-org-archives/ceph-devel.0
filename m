From: Varada Kari <varada.kari@gmail.com>
Subject: Object data loss in RGW when multipart upload completion times out
 and retried
Date: Mon, 31 Jul 2017 19:56:11 +0530
Message-ID: <CABbLZY0Zn0hH5r6VPaZ52ZEJS4xy99cuF_ZmZkfH5DT2Fs1DbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37372 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbdGaO0N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 10:26:13 -0400
Received: by mail-wm0-f44.google.com with SMTP id t201so51025622wmt.0
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jul 2017 07:26:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: "Saood Khan (Engineering Manager)" <saood.khan@flipkart.com>, rolland.s@flipkart.com, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi,

Recently in one of the clusters, lost some of objects if a multipart
complete upload times out and been retried before the first request
can be finished.  Please refer to the following events happened on the
cluster to result in a object loss.

2017-07-25 02:01:54.817492 7f4d67e86700  1 civetweb: 0x3bb3b90:
X.X.X.X - - [25/Jul/2017:02:01:51 +0530] "POST TESTBUCKET/file1.txt
HTTP/1.1" -1 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64

2017-07-25 02:02:06.554676 7fdef1469700  1 civetweb: 0x45a1050:
X.X.X.X - - [25/Jul/2017:02:01:54 +0530] "PUT TESTBUCKET/file1.txt
HTTP/1.1" -1 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64

2017-07-25 02:02:06.569207 7fb7eaf15700  1 civetweb: 0x3c66bd0:
X.X.X.X - - [25/Jul/2017:02:02:06 +0530] "GET TESTBUCKET/file1.txt
HTTP/1.1" 200 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64

2017-07-25 02:03:29.650093 7f5f52f1d700  1 civetweb: 0x7f5fc40:
X.X.X.X - - [25/Jul/2017:02:02:06 +0530] "POST TESTBUCKET/file1.txt
HTTP/1.1" -1 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64 <<==
first post request to complete the upload

2017-07-25 02:03:42.069385 7fe522ef5700  1 civetweb: 0x445aa10:
X.X.X.X - - [25/Jul/2017:02:03:16 +0530] "POST TESTBUCKET/file1.txt
HTTP/1.1" -1 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64 <<==
same request been retried again. Both requests succeeded

2017-07-25 04:17:53.543050 7fb19ce31700  1 civetweb: 0x4021c10:
X.X.X.X - - [25/Jul/2017:04:17:53 +0530] "GET TESTBUCKET/file1.txt
HTTP/1.1" -1 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64  << This
GET resulted in a 404

2017-07-25 04:17:53.548596 7f9062ffd700  1 civetweb: 0x44e0ee0:
X.X.X.X - - [25/Jul/2017:04:17:53 +0530] "HEAD TESTBUCKET/file1.txt
HTTP/1.1" -1 0 - Boto/2.40.0 Python/2.7.3 Linux/3.2.0-4-amd64 <<==
This is sucessful call and we can do a s3 ls to get the size(fetching
from omap) etc... but the object read fails.

Timeout happened when the cluster is in rebalance due to osd failure.
I can reproduce the same issue with help of delay in the following
code. And the multipart objects are marked for delete by gc when the
first  request succeds after second request finishes.

==========================
diff --git a/src/rgw/rgw_op.cc b/src/rgw/rgw_op.cc
index aae6372..0ecf842 100644
--- a/src/rgw/rgw_op.cc
+++ b/src/rgw/rgw_op.cc
@@ -5403,6 +5403,12 @@ void RGWCompleteMultipart::execute()
  if (op_ret < 0)
    return;

+  if (g_conf->rgw_introduce_latency) {
+    dout(0) << __func__ << "sleeping for 5 secs" << dendl;
+    sleep(5);
+  }
+
+
  // remove the upload obj
  int r = store->delete_obj(*static_cast<RGWObjectCtx *>(s->obj_ctx),
                           s->bucket_info, meta_obj, 0);

==========================

So far i am not able to come up with a fix where we can store the
state of the multipart complete upload progress and deleting the
meta_obj. This problem exists in all the releases and results in a
data loss. Following is the snippet from master branch.

Please find the logs and the required information below.

# bin/ceph --admin-daemon /tmp/ceph-asok.kXejsq/client.rgw.22202.asok
config get rgw_introduce_latency
*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
{
   "rgw_introduce_latency": "true"
}

# bin/radosgw-admin gc list --include-all
[
   {
       "tag": "69510504-522a-4f6c-a169-62cb6c7eac51.4106.11\u0000",
       "time": "2017-07-31 14:07:02.0.532372s",
       "objs": [
           {
               "pool": "default.rgw.buckets.data",
               "oid":
"69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.1",
               "key": "",
               "instance": ""
           },
           {
               "pool": "default.rgw.buckets.data",
               "oid":
"69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.2",
               "key": "",
               "instance": ""
           },
           {
               "pool": "default.rgw.buckets.data",
               "oid":
"69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.3",
               "key": "",
               "instance": ""
           },
           {
               "pool": "default.rgw.buckets.data",
               "oid":
"69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.4",
               "key": "",
               "instance": ""
           },
           {
               "pool": "default.rgw.buckets.data",
               "oid":
"69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.5",
               "key": "",
               "instance": ""
           }
       ]
   }
]

# bin/rados ls -p default.rgw.buckets.data
69510504-522a-4f6c-a169-62cb6c7eac51.4106.1_junkfile
69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.2
69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.3
69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.4
69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.5
69510504-522a-4f6c-a169-62cb6c7eac51.4106.1__multipart_junkfile.2~4Br_wpZyqMbSpNniRBOxQbNij0efqrq.1

Once the gc process the requests, except the head object rest of the
multiparts are deleted leading to the whole object loss. Omap contains
the meta information about the object but fails to read the object and
results in a 404.

Have filed a ticket with details at http://tracker.ceph.com/issues/20861.

Any help on fixing the issue is appreciated.

Varada
