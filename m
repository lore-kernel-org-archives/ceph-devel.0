From: John Spray <jspray@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 01:48:05 +0100
Message-ID: <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34252 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbbJTAsZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 20:48:25 -0400
Received: by obbda8 with SMTP id da8so1727504obb.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 17:48:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 19, 2015 at 8:49 PM, Sage Weil <sweil@redhat.com> wrote:
>  - We have to size the kv backend storage (probably still an XFS
> partition) vs the block storage.  Maybe we do this anyway (put metadata on
> SSD!) so it won't matter.  But what happens when we are storing gobs of
> rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
> a different pool and those aren't currently fungible.

This is the concerning bit for me -- the other parts one "just" has to
get the code right, but this problem could linger and be something we
have to keep explaining to users indefinitely.  It reminds me of cases
in other systems where users had to make an educated guess about inode
size up front, depending on whether you're expecting to efficiently
store a lot of xattrs.

In practice it's rare for users to make these kinds of decisions well
up-front: it really needs to be adjustable later, ideally
automatically.  That could be pretty straightforward if the KV part
was stored directly on block storage, instead of having XFS in the
mix.  I'm not quite up with the state of the art in this area: are
there any reasonable alternatives for the KV part that would consume
some defined range of a block device from userspace, instead of
sitting on top of a filesystem?

John
