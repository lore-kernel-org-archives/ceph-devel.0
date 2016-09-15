From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Thu, 15 Sep 2016 18:16:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609151816540.19761@piezo.us.to>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com> <CAMMFjmFo=1B07c3czD41CkNUWR8htfSn9z5vwcpdJuVZjbtAyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbcIOSRE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Sep 2016 14:17:04 -0400
In-Reply-To: <CAMMFjmFo=1B07c3czD41CkNUWR8htfSn9z5vwcpdJuVZjbtAyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

On Tue, 13 Sep 2016, Yuri Weinstein wrote:
> Please see updates http://tracker.ceph.com/issues/16344#note-46 (after
> incorporating results from the latest runs on tip of jewel branch).
> 
> samba - passed
> 
> khfs - awaiting approval (Greg, John)
> 
> powercycle - awaiting approval (Sage, Loic)

Approved!

Thanks-
sage

> 
> Thx
> YuriW
> 
> On Tue, Sep 6, 2016 at 10:12 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> > Detailed summary of the QE Validation can be found here
> > http://tracker.ceph.com/issues/16344#note-46
> >
> > The following suites were in scope of this point release validation:
> >
> > rados (subset 35/50 297 jobs)
> > rbd
> > rgw
> > fs
> > krbd
> > kcephfs
> > knfs
> > rest
> > hadoop
> > samba
> > ceph-deploy
> > ceph-disk
> > upgrade/client-upgrade
> > upgrade/hammer-x (jewel)
> > upgrade/infernalis-x (jewel)
> > powercycle
> > (please let me know if any suites are missing from this ^ list)
> >
> > ==============================
> > Issues requiring approval/decision:
> >
> > rados:
> >    http://tracker.ceph.com/issues/16516 (approved by DavidZ)
> >
> > rbd:
> >    multiple issues (Jason pls rview/approve, see notes
> > http://tracker.ceph.com/issues/16344#note-46)
> >
> > krbd:
> >    http://tracker.ceph.com/issues/17223
> >    http://tracker.ceph.com/issues/17221
> >    http://tracker.ceph.com/issues/17222
> >    (Jason pls rview/approve)
> >
> > knfs
> >    http://tracker.ceph.com/issues/17192
> >    (Greg pls rview/approve, note: it's similar we saw in hammer point release)
> >
> > samba:
> >    http://tracker.ceph.com/issues/17184
> >    (Greg pls rview/approve)
> >
> > upgrade/client-upgrade:about:startpage
> >    http://tracker.ceph.com/issues/16506
> >    (Sage, Sam, Jason pls rview/approve)
> >
> > upgrade/infernalis-x (jewel):
> >    http://tracker.ceph.com/issues/17176
> >    (Sam, David  pls rview/approve)
> >
> > powercycle:
> >    http://tracker.ceph.com/issues/17177
> >    (Sage  pls rview/approve)
> >
> > Loic, given that we have high number of issues in this release, if you
> > and dev leads find that we need to add more backports we may consider
> > validating a new point RC (sha1).
> >
> > Thx
> > YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
