From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 00/16] rbd: support for exclusive-lock + mpath remap bits
Date: Wed, 24 Aug 2016 13:34:23 -0500
Message-ID: <216a8726-a6fa-2cd5-66fc-f21bb74d7005@redhat.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752805AbcHXSfk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 14:35:40 -0400
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
> Hello,
> 
> This series already has a general thumbs up from Mike and an ack on
> sysfs interface additions from Sage, but, as wip-exclusive-lock branch
> has been through quite a few rebases recently, I wanted to send what
> hopefully is the final version for a wider review.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Douglas Fuller (5):
>   libceph: support for CEPH_OSD_OP_LIST_WATCHERS
>   libceph: add ceph_osdc_call() single-page helper
>   libceph: support for advisory locking on RADOS objects
>   libceph: support for lock.lock_info
>   libceph: support for blacklisting clients
> 
> Ilya Dryomov (7):
>   libceph: rename ceph_entity_name_encode() ->
>     ceph_auth_entity_name_encode()
>   libceph: rename ceph_client_id() -> ceph_client_gid()
>   rbd: introduce a per-device ordered workqueue
>   rbd: retry watch re-registration periodically
>   rbd: support for exclusive-lock feature
>   rbd: print capacity in decimal and features in hex
>   rbd: add 'client_addr' sysfs rbd device attribute
> 
> Mike Christie (4):
>   rbd: add 'cluster_fsid' sysfs rbd device attribute
>   rbd: add 'snap_id' sysfs rbd device attribute
>   rbd: add 'config_info' sysfs rbd device attribute
>   rbd: add force close option
> 

Reviewed-by and Tested-by: Mike Christie <mchristi@redhat.com>


