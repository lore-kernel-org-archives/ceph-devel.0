From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 0/6] libceph: CEPH_OSD_OP_SETALLOCHINT osd op
Date: Mon, 24 Feb 2014 08:58:54 -0600
Message-ID: <530B5E2E.3010905@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45433 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO6w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 09:58:52 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so3531832iec.35
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 06:58:52 -0800 (PST)
In-Reply-To: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
> Hello,
> 
> This series adds support for CEPH_OSD_OP_SETALLOCHINT osd op to libceph
> along with adjusting rbd to make use of it.  The rationale and the
> basic desing was outlined in the "rados io hints" thread on ceph-devel
> about a month ago.

It looks like some of this discussion is still active, so it
might be a little premature to implement this.  That being said,
I reviewed what you have.  Overall it looks good to me.  I have
some small suggestions for you to consider.  I also think that
in this case just extending the definition of a write request
is preferable to encoding this stuff in a distinct new op, but
I may be missing some information.

					-Alex

> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (6):
>   libceph: encode CEPH_OSD_OP_FLAG_* op flags
>   libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
>   libceph: bump CEPH_OSD_MAX_OP to 3
>   rbd: do not hard-code CEPH_OSD_MAX_OP in rbd_osd_req_callback()
>   rbd: num_ops parameter for rbd_osd_req_create()
>   rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT osd op
> 
>  drivers/block/rbd.c             |   90 ++++++++++++++++++++++++++++-----------
>  include/linux/ceph/osd_client.h |   12 +++++-
>  include/linux/ceph/rados.h      |   10 ++++-
>  net/ceph/osd_client.c           |   32 ++++++++++++++
>  4 files changed, 117 insertions(+), 27 deletions(-)
> 

