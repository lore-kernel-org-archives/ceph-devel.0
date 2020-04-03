From: kefu chai <tchaikov@gmail.com>
Subject: Re: [ceph-users] Re: v15.2.0 Octopus released
Date: Fri, 3 Apr 2020 13:25:12 +0800
Message-ID: <CAJE9aONskkr15LQyhchKP_y8vmsD5sgw6NvuhvCwhFS_v5r7SA@mail.gmail.com>
References: <878sjqc79i.fsf@suse.com> <alpine.DEB.2.21.2003271410190.4773@piezo.novalocal>
 <CAPPYiwpOOAnNwfPiFMx2zxj7Eh0DCUG+zfALp+8sJSLENDN-Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35666 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbgDCFZ0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Apr 2020 01:25:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id r17so1159911lff.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2020 22:25:24 -0700 (PDT)
In-Reply-To: <CAPPYiwpOOAnNwfPiFMx2zxj7Eh0DCUG+zfALp+8sJSLENDN-Og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mazzystr <mazzystr@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-announce@ceph.io, ceph-users@ceph.io, dev <dev@ceph.io>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.io, Ken Dreyer <kdreyer@redhat.com>

On Sat, Mar 28, 2020 at 1:29 AM Mazzystr <mazzystr@gmail.com> wrote:
>
> What about the missing dependencies for octopus on el8?  (looking at yoooou
> ceph-mgr!)

hi Mazzystr,

regarding to the dependencies of ceph-mgr, probably you could enable
the corp repo[0] for installing them, before they are included by
EPEL8.

---
[0] https://copr.fedorainfracloud.org/coprs/ktdreyer/ceph-el8/

>
> On Fri, Mar 27, 2020 at 7:15 AM Sage Weil <sage@newdream.net> wrote:
>
> > One word of caution: there is one known upgrade issue if you
> >
> >  - upgrade from luminous to nautilus, and then
> >  - run nautilus for a very short period of time (hours), and then
> >  - upgrade from nautilus to octopus
> >
> > that prevents OSDs from starting.  We have a fix that will be in 15.2.1,
> > but until that is out, I would recommend against the double-upgrade.  If
> > you have been running nautilus for a while (days) you should be fine.
> >
> > sage
> >
> >
> > https://tracker.ceph.com/issues/44770
> > _______________________________________________
> > ceph-users mailing list -- ceph-users@ceph.io
> > To unsubscribe send an email to ceph-users-leave@ceph.io
> >
> _______________________________________________
> ceph-users mailing list -- ceph-users@ceph.io
> To unsubscribe send an email to ceph-users-leave@ceph.io



-- 
Regards
Kefu Chai
