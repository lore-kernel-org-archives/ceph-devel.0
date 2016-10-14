From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH] rbd: don't wait for the lock forever if blacklisted
Date: Thu, 13 Oct 2016 20:47:01 -0500
Message-ID: <58003915.5000205@redhat.com>
References: <1476281008-30556-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753434AbcJNBrD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Oct 2016 21:47:03 -0400
In-Reply-To: <1476281008-30556-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 10/12/2016 09:03 AM, Ilya Dryomov wrote:
> -EBLACKLISTED from __rbd_register_watch() means that our ceph_client
> got blacklisted - we won't be able to restore the watch and reacquire
> the lock.  Wake up and fail all outstanding requests waiting for the
> lock and arrange for all new requests that require the lock to fail
> immediately.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>

Thanks Ilya. I tested it and reviewed it. Note sure which signed off to use.

Tested-by: Mike Christie <mchristi@redhat.com>

