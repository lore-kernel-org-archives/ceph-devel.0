From: Theofilos Mouratidis <mtheofilos@gmail.com>
Subject: Re: [ceph-users] Re: v15.2.0 Octopus released
Date: Wed, 1 Apr 2020 14:20:36 +0200
Message-ID: <CA+9pRwSBV_1Mn7q0YHB0Qn_8A3bX7TqHfLYmJUypwoduq+3tcQ@mail.gmail.com>
References: <878sjqc79i.fsf@suse.com> <alpine.DEB.2.21.2003271410190.4773@piezo.novalocal>
 <CAPPYiwpOOAnNwfPiFMx2zxj7Eh0DCUG+zfALp+8sJSLENDN-Og@mail.gmail.com> <CAJE9aOMsBp3xq2Ed1UYyBH0On2uOy1_ED_o4_niKE-Mmb8BcHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb1-f174.google.com ([209.85.219.174]:44105 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbgDAMUs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2020 08:20:48 -0400
Received: by mail-yb1-f174.google.com with SMTP id 11so13074100ybj.11
        for <ceph-devel@vger.kernel.org>; Wed, 01 Apr 2020 05:20:48 -0700 (PDT)
In-Reply-To: <CAJE9aOMsBp3xq2Ed1UYyBH0On2uOy1_ED_o4_niKE-Mmb8BcHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Mazzystr <mazzystr@gmail.com>, ceph-announce@ceph.io, ceph-users@ceph.io, dev <dev@ceph.io>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.io

I've been trying to use drivegroups on 15.2.0 to setup osds, but with
no luck, is this implemented?

On Sun, 29 Mar 2020 at 16:01, kefu chai <tchaikov@gmail.com> wrote:
>
> On Sat, Mar 28, 2020 at 1:29 AM Mazzystr <mazzystr@gmail.com> wrote:
> >
> > What about the missing dependencies for octopus on el8?  (looking at yoooou
> > ceph-mgr!)
>
> FWIW, leveldb for el8 is pending on review at
> https://bodhi.fedoraproject.org/updates/FEDORA-EPEL-2020-3171aba6be,
> if you could help test it. that'd be great!
>
> >
> > On Fri, Mar 27, 2020 at 7:15 AM Sage Weil <sage@newdream.net> wrote:
> >
> > > One word of caution: there is one known upgrade issue if you
> > >
> > >  - upgrade from luminous to nautilus, and then
> > >  - run nautilus for a very short period of time (hours), and then
> > >  - upgrade from nautilus to octopus
> > >
> > > that prevents OSDs from starting.  We have a fix that will be in 15.2.1,
> > > but until that is out, I would recommend against the double-upgrade.  If
> > > you have been running nautilus for a while (days) you should be fine.
> > >
> > > sage
> > >
> > >
> > > https://tracker.ceph.com/issues/44770
> > > _______________________________________________
> > > ceph-users mailing list -- ceph-users@ceph.io
> > > To unsubscribe send an email to ceph-users-leave@ceph.io
> > >
> > _______________________________________________
> > ceph-users mailing list -- ceph-users@ceph.io
> > To unsubscribe send an email to ceph-users-leave@ceph.io
>
>
>
> --
> Regards
> Kefu Chai
> _______________________________________________
> ceph-users mailing list -- ceph-users@ceph.io
> To unsubscribe send an email to ceph-users-leave@ceph.io
