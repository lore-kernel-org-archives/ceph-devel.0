From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: new statx() like interface for libcephfs
Date: Tue, 28 Jun 2016 14:53:38 -0400
Message-ID: <CAL-2WbF5HAoAvbje8xr91OP5Cd1ye7UF7W+PA01m-V1+O==DjA@mail.gmail.com>
References: <1467137825.32374.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38687 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbcF1SyA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 14:54:00 -0400
Received: by mail-wm0-f51.google.com with SMTP id r201so40946249wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 11:53:59 -0700 (PDT)
In-Reply-To: <1467137825.32374.29.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, Ganesha NFS List <nfs-ganesha-devel@lists.sourceforge.net>, David Howells <dhowells@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Is stx_version a generation ID for the inode that can be used for the
NFSv4 Change ID?  If so, that would be quite useful to us.  Otherwise,
I'm not sure there's that much in there that's useful beyond what stat
already provides, unless I'm missing something.

On Tue, Jun 28, 2016 at 2:17 PM, Jeff Layton <jlayton@redhat.com> wrote:
> I have a patchset queued up for ceph that adds btime (birthtime)
> support to it. What was lacking though was a mechanism to get the btime
> out of the inode.
>
> Rather than cook up a brand new interface just for the btime, I decided
> to "borrow" the work that David Howells did with the new proposed
> statx() interface. The pull request to add this to ceph is up here:
>
>      https://github.com/ceph/ceph/pull/9965
>
> Sage has already closed it out which I take to mean that he has pulled
> the patches into a staging branch for eventual merge.
>
> It occurs to me though that I didn't ask anyone who is working on the
> samba vfs or ganesha fsal code whether they think this interface is
> acceptable.
>
> Since Samba and Ganesha are the targeted users of this interface, it'd
> be good to have developers from both communities take a look and see if
> there are any problems here.
>
> Does anyone see any issues with the above pull request?
> --
> Jeff Layton <jlayton@redhat.com>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
