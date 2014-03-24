From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: [librbd] Add interface of get the snapshot size?
Date: Mon, 24 Mar 2014 17:50:26 +0400
Message-ID: <53303822.20800@xdel.ru>
References: <CACJqLybccTqhcumeP33LTY8_s7zxjyuodU-bdKFL9a1cM28dVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59355 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaCXNuo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 09:50:44 -0400
Received: by mail-lb0-f175.google.com with SMTP id w7so3612334lbi.20
        for <ceph-devel@vger.kernel.org>; Mon, 24 Mar 2014 06:50:42 -0700 (PDT)
In-Reply-To: <CACJqLybccTqhcumeP33LTY8_s7zxjyuodU-bdKFL9a1cM28dVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/24/2014 05:30 PM, Haomai Wang wrote:
> Hi all,
> 
> As we know, snapshot is a lightweight resource in librbd and we
> doesn't have any statistic informations about it. But it causes some
> problems to the cloud management.
> 
> We can't measure the size of snapshot, different snapshot will occur
> different space. So we don't have way to estimate the resource usage
> of user.
> 
> Maybe we can have a counter to record space usage when volumn created.
> When creating snapshot, the counter is freeze and store as the size of
> snapshot. New counter will assign to zero for the volume.
> 
> Any feedback is appreciate!
> 

I believe that there is a rough estimation over 'rados df'. Per-image
statistics would be awesome, though precise stats will be neither rough
too(# of rbd object clones per volume) or introduce new counter
mechanism. Dealing with discard for the filestore, it looks even more
difficult to calculate right estimation, as with XFS preallocation feature.
