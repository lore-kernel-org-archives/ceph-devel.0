From: Bastian Rosner <bastian.rosner@profitbricks.com>
Subject: Users not listable using RadosGW-admin REST-API
Date: Mon, 30 Jan 2017 17:44:22 +0100
Message-ID: <696034a5-aca7-fecf-e61a-6552daba3d52@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37974 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdA3QoZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2017 11:44:25 -0500
Received: by mail-wm0-f50.google.com with SMTP id r141so40616570wmg.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2017 08:44:24 -0800 (PST)
Received: from [192.168.79.91] ([62.217.45.26])
        by smtp.googlemail.com with ESMTPSA id e14sm19557776wmd.14.2017.01.30.08.44.22
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2017 08:44:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we noticed difference in behavior between "radosgw-admin user list" and 
GET /admin/user.

According to the docs[1], if we don't specify a UID we should get a list 
of all users along with suspension information. Instead the response 
looks like this:

{
   "Code": "InvalidArgument",
   "RequestId": "tx0000000000000000000b6-00588f637f-28195-default",
   "HostId": "28195-default-default"
}

It seems that specifying a uid is mandatory with REST? At least the CLI 
will list all users when no user is specified.

Digging through the code[2], we found a commit[3] that fixes issue 15455 
which seems to be related. OTOH, we are able to get a listing of all 
users "usage stats" via REST.

Is it just an error in the documentation?


[1]: http://docs.ceph.com/docs/kraken/radosgw/adminops/#get-user-info
[2]: https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rest_user.cc#L38
[3]: 
https://github.com/ceph/ceph/commit/6fbd00a778ee2ecc9ae639d67bef953d107069a2
[4]: http://tracker.ceph.com/issues/15455

Best, Bastian
