From: Vincent Godin <vince.mlist@gmail.com>
Subject: help needed after an outage - Is it possible to rebuild a bucket
 index ?
Date: Thu, 4 Jan 2018 19:37:47 +0100
Message-ID: <CAL2-6bK6nMAQQfUj7G1nAJe1FUxQTdtwqFmD0771MSBLU_7kXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:43547 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeADShs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 13:37:48 -0500
Received: by mail-qk0-f173.google.com with SMTP id j137so3062539qke.10
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 10:37:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Yesterday we had an outage on our ceph cluster. One OSD was looping on << [call
rgw.bucket_complete_op] snapc 0=[]
ack+ondisk+write+known_if_redirected e359833) currently waiting for
degraded object >> for hours blocking all the requests to this OSD and
then ...
We had to delete the degraded object for the cluster to retrieve a
normal behaviour. The object was a .dir object which is in fact a
marker for a bucket index. This object had a 0 size but all the files
related to this bucket were stored on the LevelDB of the OSD.
As this file has been deleted, is there a way to rebuild the index ? (
a simple rados comand ? a radosgw-admin command ? a more tricky
solution ?
Thanks for your help ...
