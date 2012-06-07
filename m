From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 7 Jun 2012 15:13:38 -0700
Message-ID: <CADvuQRGGqcx5niuJ9hgE9aAyVsi6jqtFnH+sHUy4x1VjDTdoyA@mail.gmail.com>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com> <1432839.r57HJoU1Hp@tolkien>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62606 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933206Ab2FGWN6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 18:13:58 -0400
Received: by pbbrp8 with SMTP id rp8so1666537pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 15:13:58 -0700 (PDT)
In-Reply-To: <1432839.r57HJoU1Hp@tolkien>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 7, 2012 at 2:36 PM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Again, I'll try that tomorrow. BTW, I could use some advice on how to go about
> that. Right I would stop one osd process (not the whole machine), reformat and
> remount its btrfs devices as XFS, delete the journal, restart the osd, wait
> until the cluster is healthy again, repeat for all the osds in the cluster. Is
> that sufficient?

Before restarting the osd, you need to do a ceph-osd --mkfs.
Otherwise, yeah that looks good.

> The rbd volume in question was created as a copy, using the rbd cp command,
> from a template volume. I cannot recall seeing any corruption while using the
> original volume (which was created using rbd import). Maybe the bug only bites
> volumes that have been created as copies of other volumes? I'll have to do
> more tests along those lines as well...

Hmm. There should be no difference between the end results of rbd cp
and rbd import.
