From: Paul Cuzner <pcuzner@redhat.com>
Subject: Interpreting ceph osd pool stats output
Date: Fri, 10 Mar 2017 15:37:48 +1300
Message-ID: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35169 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbdCJChv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Mar 2017 21:37:51 -0500
Received: by mail-wm0-f47.google.com with SMTP id v186so1075905wmd.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Mar 2017 18:37:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've been putting together a collectd plugin for ceph - since the old
one's I could find no longer work. I'm gathering data from the mon's
admin socket, merged with a couple of commands I issue through the
rados mon_command interface.

Nothing complicated, but the data has me a little confused

When I run "osd pool stats" I get *two* different sets of metrics that
describe client i/o and recovery i/o. Since the metrics are different
I can't merge them to get a consistent view of what the cluster is
doing as a whole at any given point in time. For example, client i/o
reports in bytes_sec, but the recovery dict is empty and the
recovery_rate is in objects_sec...

i.e.

}, {
"pool_name": "rados-bench-cbt",
"pool_id": 86,
"recovery": {},
"recovery_rate": {
"recovering_objects_per_sec": 3530,
"recovering_bytes_per_sec": 14462655,
"recovering_keys_per_sec": 0,
"num_objects_recovered": 7148,
"num_bytes_recovered": 29278208,
"num_keys_recovered": 0
},
"client_io_rate": {}

This is running Jewel - 10.2.5-37.el7cp

Is this a bug or a 'feature' :)

Cheers,

Paul C
