From: Sage Weil <sweil@redhat.com>
Subject: Re: 0.94.8 QE validation status
Date: Thu, 25 Aug 2016 20:17:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608252016240.25681@piezo.us.to>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com> <CAMMFjmG2OKJO_VnreX00QGophw3VfTtVEH=UMEZGqUX2X6rJJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757985AbcHYUR0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 16:17:26 -0400
In-Reply-To: <CAMMFjmG2OKJO_VnreX00QGophw3VfTtVEH=UMEZGqUX2X6rJJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, Nathan Cutler <ncutler@suse.cz>, "Deza, Alfredo" <adeza@redhat.com>

Great work, everyone!  All looks good to me.

On Thu, 25 Aug 2016, Yuri Weinstein wrote:
> We addressed all open issues and if there is no objections from Sage,
> it's ready for release!
> 
> Alfredo FYI
> 
> Thx
> YuriW
> 
> On Mon, Aug 22, 2016 at 2:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> > Detailed summary of the QE Validation can be found here
> > http://tracker.ceph.com/issues/15895#note-33
> >
> > The following suites were in scope of this point release testing:
> >
> > rados (subset 1/20)
> > rbd
> > rgw
> > fs
> > krbd
> > kcephfs
> > knfs
> > hadoop
> > samba
> > rest
> > ceph-deploy
> > upgrade/client-upgrade
> > upgrade/hammer-x (jewel)
> > upgrade/hammer
> > powercycle
> >
> > Deprecated suites (Sage pls reconfirm)
> >
> > upgrade/dumpling-firefly-x
> > upgrade/firefly-x (hammer)
> > upgrade/hammer-x (infernalis)
> > upgrade/firefly-hammer-x (infernalis)

Yep.

Thanks Yuri!
s

> >
> > Known issues (need approval):
> >
> > http://tracker.ceph.com/issues/17075 was caught be several runs, see
> > email from Nathan with details "What to do with python-ceph-compat?"
> >
> > krbd -  http://tracker.ceph.com/issues/17083 (Jason pls review/approve)
> > knsf - http://tracker.ceph.com/issues/17074 (Gregory, Sage pls review/approve)
> > upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17075 (Sage
> > pls review/approve)
> >
> > Thx
> > YuriW
> 
> 
