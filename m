From: Igor Fedotov <ifedotov@mirantis.com>
Subject: data-at-rest compression
Date: Tue, 10 Nov 2015 18:46:38 +0300
Message-ID: <5642115E.407@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36566 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbbKJPqm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 10:46:42 -0500
Received: by lfs39 with SMTP id 39so302223lfs.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 07:46:41 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id j11sm621757lbz.21.2015.11.10.07.46.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2015 07:46:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

a while ago we had some conversations here about adding compression 
support for EC pools.
Here is corresponding pull request implementing this feature:

https://github.com/ceph/ceph/pull/6524/commits

Appropriate blueprint is at:
http://tracker.ceph.com/projects/ceph/wiki/Rados_-_at-rest_compression

All comments and reviews are highly appreciated.

Thanks,
Igor.

