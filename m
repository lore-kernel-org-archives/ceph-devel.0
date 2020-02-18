From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: FYI nautilus branch is locked
Date: Tue, 18 Feb 2020 08:21:18 -0800
Message-ID: <CAMMFjmExNzhWDwRNfYkrmJf45p=z1fc+v00nfr=KVx6wmCDnSA@mail.gmail.com>
References: <CAMMFjmE4wyKcP0KkudhTu2zeZF+SswZ=kN_k-Xaq1aC6o4vWkQ@mail.gmail.com>
 <CAMMFjmGOqAoBYmmFOWFHTw9NrGQEwNLeUPmw2+5RE+LzVMsuYw@mail.gmail.com> <alpine.DEB.2.21.2002142006120.18815@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22984 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726411AbgBRQVe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2020 11:21:34 -0500
Received: by mail-qv1-f69.google.com with SMTP id cn2so12732674qvb.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Feb 2020 08:21:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.2002142006120.18815@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: dev@ceph.io, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Casey Bodley <cbodley@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Neha Ojha <nojha@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, David Zafman <dzafman@redhat.com>, Ramana Venkatesh Raja <rraja@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>, Matt Benjamin <mbenjamin@redhat.com>

Sage, I am resuming QE validation as
https://github.com/ceph/ceph/pull/33339 merged

On Fri, Feb 14, 2020 at 12:07 PM Sage Weil <sweil@redhat.com> wrote:
>
> Just a note, we need to sort out the mimic->nautilus upgrade failure
> before getting too far along here
>
>
>
>
> On Fri, 14 Feb 2020, Yuri Weinstein wrote:
>
> > Sorry correction again - 14.2.8
> >
> > On Fri, Feb 14, 2020 at 11:30 AM Yuri Weinstein <yweinste@redhat.com> wrote:
> > >
> > > We are getting ready to test 14.2.9 and nautilus branch is locked for
> > > merges until it's done.
> > >
> > > sah1 - 4d5b84085009968f557baaa4209183f1374773cd
> > >
> > > Nathan, Abhishek pls confirm.
> > >
> > > Thank you
> > > YuriW
> > _______________________________________________
> > Dev mailing list -- dev@ceph.io
> > To unsubscribe send an email to dev-leave@ceph.io
> >
> >
>
