From: John Spray <jspray@redhat.com>
Subject: Re: cephfs quota support for the kernel client
Date: Mon, 10 Jul 2017 17:57:23 +0100
Message-ID: <CALe9h7fDwLfBm9d=7yqbrn3mg=qvtFb7j=Mi8khdj8jyQ=Uyyg@mail.gmail.com>
References: <20170710150259.kbtbpjn762xu5web@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36004 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbdGJQ5q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jul 2017 12:57:46 -0400
Received: by mail-wr0-f174.google.com with SMTP id c11so146678622wrc.3
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jul 2017 09:57:45 -0700 (PDT)
In-Reply-To: <20170710150259.kbtbpjn762xu5web@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 10, 2017 at 4:02 PM, Jan Fajerski <jfajerski@suse.com> wrote:
> Hi list,
> are there any plans/intentions for or reservations against adding quota
> support the cephfs kernel client?
> From a superficial look into the quota implementation there doesn't seem to
> be technical reason for not adding this feature to the kernel.

The reason is that checking the quota for a given operation requires a
reverse-traverse of the hierarchy up to the ancestor with the quota on
it.  This is straightforward in the userspace client (because of
Client::client_lock), but *much* scarier to do in the kernel, which
does locking completely differently.

This was all kinda understood at the point that the quota stuff was
originally contributed, but there wasn't anyone with time/motivation
to do the kclient-compatible implementation, so we took on the quota
implementation as-is with the caveat that it was ceph-fuse only.

The way to fix that is to change how quotas work, so that the client
doesn't have to do a reverse-traversal any more.  That would work by
handling the lookup server side, and then giving the client a "quota
realm" or something similar, and then including a reference to that
with each inode that the client got.  Similar to how SnapRealms work.

If someone steps up and wants to do that work to rework quotas and
implement kclient support, that would be awesome.

The xattr aspect, I'm kind of unattached to.  We already have xattrs
for other things though, so it seems less like a quota issue and more
of a general thing.  Because we provide both fuse and kernel clients,
xattrs are much nicer than syscalls, as we can implement them the same
both places.

If we had to live without xattrs in the kernel client in the future, I
expect we would just use a libcephfs-based command line tool to do the
administrative tasks like setting quotas and layouts.  There is some
desire for a tool like that anyway -- it can be pretty annoying in
practice to have to actually mount a filesystem in order to do
something simple like changing the default file layout right after
creating the filesystem.

John

> From an engineering perspective there seem to be some objections against
> xattr based quota implementations in the wider kernel community.
> https://patchwork.kernel.org/patch/8449721/
> https://www.ietf.org/mail-archive/web/nfsv4/current/msg14063.html
> https://www.spinics.net/lists/linux-fsdevel/msg113357.html
>
> What does the Ceph community think?
>
> --
> Jan Fajerski
> Engineer Enterprise Storage
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
> HRB 21284 (AG Nürnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
