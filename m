From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/3] rbd: do not treat standalone as flatten
Date: Tue, 20 Jan 2015 17:25:56 -0800
Message-ID: <54BF0024.2040006@inktank.com>
References: <1421757669-38796-1-git-send-email-idryomov@redhat.com> <1421757669-38796-4-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57419 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbbAUBay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 20:30:54 -0500
In-Reply-To: <1421757669-38796-4-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@redhat.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 01/20/2015 04:41 AM, Ilya Dryomov wrote:
> If the clone is resized down to 0, it becomes standalone.  If such
> resize is carried over while an image is mapped we would detect this
> and call rbd_dev_parent_put() which means "let go of all parent state,
> including the spec(s) of parent images(s)".  This leads to a mismatch
> between "rbd info" and sysfs parent fields, so a fix is in order.
>
>      # rbd create --image-format 2 --size 1 foo
>      # rbd snap create foo@snap
>      # rbd snap protect foo@snap
>      # rbd clone foo@snap bar
>      # DEV=$(rbd map bar)
>      # rbd resize --allow-shrink --size 0 bar
>      # rbd resize --size 1 bar
>      # rbd info bar | grep parent
>              parent: rbd/foo@snap
>
> Before:
>
>      # cat /sys/bus/rbd/devices/0/parent
>      (no parent image)
>
> After:
>
>      # cat /sys/bus/rbd/devices/0/parent
>      pool_id 0
>      pool_name rbd
>      image_id 10056b8b4567
>      image_name foo
>      snap_id 2
>      snap_name snap
>      overlap 0
>
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

