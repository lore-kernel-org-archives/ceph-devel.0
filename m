From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/3] rbd: drop parent_ref in rbd_dev_unprobe() unconditionally
Date: Tue, 20 Jan 2015 17:24:29 -0800
Message-ID: <54BEFFCD.70707@inktank.com>
References: <1421757669-38796-1-git-send-email-idryomov@redhat.com> <1421757669-38796-3-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57420 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbAUBay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 20:30:54 -0500
In-Reply-To: <1421757669-38796-3-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@redhat.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 01/20/2015 04:41 AM, Ilya Dryomov wrote:
> This effectively reverts the last hunk of 392a9dad7e77 ("rbd: detect
> when clone image is flattened").
>
> The problem with parent_overlap != 0 condition is that it's possible
> and completely valid to have an image with parent_overlap == 0 whose
> parent state needs to be cleaned up on unmap.  The next commit, which
> drops the "clone image now standalone" logic, opens up another window
> of opportunity to hit this, but even without it
>
>      # cat parent-ref.sh
>      #!/bin/bash
>      rbd create --image-format 2 --size 1 foo
>      rbd snap create foo@snap
>      rbd snap protect foo@snap
>      rbd clone foo@snap bar
>      rbd resize --allow-shrink --size 0 bar
>      rbd resize --size 1 bar
>      DEV=$(rbd map bar)
>      rbd unmap $DEV
>
> leaves rbd_device/rbd_spec/etc and rbd_client along with ceph_client
> hanging around.
>
> My thinking behind calling rbd_dev_parent_put() unconditionally is that
> there shouldn't be any requests in flight at that point in time as we
> are deep into unmap sequence.  Hence, even if rbd_dev_unparent() caused
> by flatten is delayed by in-flight requests, it will have finished by
> the time we reach rbd_dev_unprobe() caused by unmap, thus turning
> unconditional rbd_dev_parent_put() into a no-op.
>
> Fixes: http://tracker.ceph.com/issues/10352
>
> Cc: stable@vger.kernel.org # 3.11+
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

