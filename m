From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Accidental image deletion
Date: Wed, 10 Apr 2013 17:43:06 -0700
Message-ID: <5166071A.7040409@inktank.com>
References: <CABYiri8Y4yK+H_fb9Pm_GNrfCJbzEeFyhT8WEwawc0MBMUBB2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63107 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934600Ab3DKAnf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Apr 2013 20:43:35 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro12so547948pbb.18
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 17:43:35 -0700 (PDT)
In-Reply-To: <CABYiri8Y4yK+H_fb9Pm_GNrfCJbzEeFyhT8WEwawc0MBMUBB2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/07/2013 01:31 PM, Andrey Korolyov wrote:
> Hello,
>
> Is there an existing or planned way to save an image from such thing,
> except protected snapshot? Since ``rbd snap protect'' is good enough
> for a small or inactive images, large ones may add significant overhead
> by space or by I/O when 'locking' snapshot is present, so it would be nice
> to see same functionality by the flag of ``rbd lock'' command.

When we added locking originally, we thought about adding a general
--lock flag for rbd commands on a particular image that would acquire
an exclusive lock on the image before doing anything.

Then you could do 'rbd rm --lock', and it would fail if you'd left the
imaged locked. This is easy to implement, but we haven't gotten around
to it. It's in the tracker though: http://tracker.ceph.com/issues/2586

On a related note, Wido is adding an option to prevent accidental data
loss via resize: https://github.com/ceph/ceph/pull/209

Josh
