From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH 6/6] ceph: perform asynchronous unlink if we have
 sufficient caps
Date: Thu, 9 Jan 2020 09:53:15 -0800
Message-ID: <CA+2bHPaML5kSYaZrNPsDHYTv-7_scEPWZ2xkD0fxp2Pg5G1cCA@mail.gmail.com>
References: <20200106153520.307523-1-jlayton@kernel.org> <20200106153520.307523-7-jlayton@kernel.org>
 <8f5e345a-2743-5868-3d89-017db6ae3d8c@redhat.com> <9cd39feb0b8d92f29af69a787355b89359c797a8.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728653AbgAIRxo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2020 12:53:44 -0500
Received: by mail-qk1-f200.google.com with SMTP id 194so4648639qkh.18
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jan 2020 09:53:42 -0800 (PST)
In-Reply-To: <9cd39feb0b8d92f29af69a787355b89359c797a8.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

On Thu, Jan 9, 2020 at 3:34 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2020-01-09 at 17:18 +0800, Yan, Zheng wrote:
> > > +bool enable_async_dirops;
> > > +module_param(enable_async_dirops, bool, 0644);
> > > +MODULE_PARM_DESC(enable_async_dirops, "Asynchronous directory operations enabled");
> > > +
> >
> > why not use mount option
> >
>
> I'm open to suggestions here.
>
> I mostly put this in originally to help facilitate performance testing.
> A module option makes it easy to change this at runtime (without having
> to remount or anything).
>
> That said, we probably _do_ want to have a way for users to enable or
> disable this feature. We'll probably want this disabled by default
> initially, but I can forsee that changing once get more confidence.
>
> Mount options are a bit of a pain to deal with over time. If the
> defaults change, we need to document that in the manpages and online
> documentation. If you put a mount option in the fstab, then you have to
> deal with breakage if you boot to an earlier kernel that doesn't support
> that option.
>
> My thinking is that we should just use a module option initially (for
> the really early adopters) and only convert that to a mount option as
> the need for it becomes clear.

Module option makes sense.

A mount option to disable async ops would also make sense. I do not
think the default behavior should be off-by-default.

(Someday perhaps the kernel will be smart enough to also digest the
ceph configs delivered through the monitors...)

-- 
Patrick Donnelly, Ph.D.
He / Him / His
Senior Software Engineer
Red Hat Sunnyvale, CA
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D
