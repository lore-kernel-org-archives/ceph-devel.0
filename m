From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: fix posix acl couldn't be settable
Date: Mon, 10 Feb 2020 20:45:36 +0100
Message-ID: <CAOi1vP9Pw+=JGJsBLphO44j9RYu=O11VsgJs3fJGG1=gT=Q0UA@mail.gmail.com>
References: <20200210135841.21177-1-xiubli@redhat.com> <e2614ef4-7dc1-d9ac-752a-d48b806dd561@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-il1-f194.google.com ([209.85.166.194]:37685 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgBJTpT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Feb 2020 14:45:19 -0500
Received: by mail-il1-f194.google.com with SMTP id v13so1313909iln.4
        for <ceph-devel@vger.kernel.org>; Mon, 10 Feb 2020 11:45:18 -0800 (PST)
In-Reply-To: <e2614ef4-7dc1-d9ac-752a-d48b806dd561@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, David Howells <dhowells@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 10, 2020 at 3:52 PM Xiubo Li <xiubli@redhat.com> wrote:
>
> On 2020/2/10 21:58, xiubli@redhat.com wrote:
> > From: Xiubo Li <xiubli@redhat.com>
> >
> > For the old mount API, the module parameters parseing function will
> > be called in ceph_mount() and also just after the default posix acl
> > flag set, so we can control to enable/disable it via the mount option.
> >
> > But for the new mount API, it will call the module parameters
> > parseing function before ceph_get_tree(), so the posix acl will always
> > be enabled.
> >
> > Fixes: 82995cc6c5ae ("libceph, rbd, ceph: convert to use the new mount API")
> > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > ---
> >   fs/ceph/super.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 5fef4f59e13e..69fa498391dc 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -341,6 +341,10 @@ static int ceph_parse_mount_param(struct fs_context *fc,
> >       unsigned int mode;
> >       int token, ret;
> >
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +     fc->sb_flags |= SB_POSIXACL;
> > +#endif
> > +
>
> Maybe we should move this to ceph_init_fs_context().

Hi Xiubo,

Yes -- so it is together with fsopt defaults.

Thanks,

                Ilya
