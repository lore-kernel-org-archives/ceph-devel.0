From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Fri, 9 Sep 2016 11:19:36 -0700
Message-ID: <CAMMFjmFRHAu8cPpLatorQ_LZ_5fcAbA082ivT1N7bA9Qr_qgdg@mail.gmail.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36191 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbcIISTi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2016 14:19:38 -0400
Received: by mail-wm0-f46.google.com with SMTP id b187so45114728wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Sep 2016 11:19:37 -0700 (PDT)
In-Reply-To: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

Ticket http://tracker.ceph.com/issues/16344#note-46 updated with dev
leads approvals (pls review) as following (suites marked with * still
need decision/fix):

rados:
   http://tracker.ceph.com/issues/16516 (approved by DavidZ)

rbd:
   multiple issues (Approved by Jason)

krbd:
   http://tracker.ceph.com/issues/17223
   http://tracker.ceph.com/issues/17221
   http://tracker.ceph.com/issues/17222
   (Approved by Ilya)

* knfs
   http://tracker.ceph.com/issues/17192
   (Greg pls review/approve, note: it's similar we saw in hammer point release)

* samba:
   http://tracker.ceph.com/issues/17184
   (Greg pls review/approve)

upgrade/client-upgrade:about:startpage
   http://tracker.ceph.com/issues/16506
   (Approved by Loic)

upgrade/infernalis-x (jewel):
   http://tracker.ceph.com/issues/17176
   (Approved by Loic)

* powercycle:
   http://tracker.ceph.com/issues/17177
   (Sage  pls review/approve)

* ceph-disk
   http://tracker.ceph.com/issues/17114
   http://tracker.ceph.com/issues/17100
   (Loic  pls review/approve)

Thx
YuriW

On Tue, Sep 6, 2016 at 10:12 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/16344#note-46
>
> The following suites were in scope of this point release validation:
>
> rados (subset 35/50 297 jobs)
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> rest
> hadoop
> samba
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/hammer-x (jewel)
> upgrade/infernalis-x (jewel)
> powercycle
> (please let me know if any suites are missing from this ^ list)
>
> ==============================
> Issues requiring approval/decision:
>
> rados:
>    http://tracker.ceph.com/issues/16516 (approved by DavidZ)
>
> rbd:
>    multiple issues (Jason pls rview/approve, see notes
> http://tracker.ceph.com/issues/16344#note-46)
>
> krbd:
>    http://tracker.ceph.com/issues/17223
>    http://tracker.ceph.com/issues/17221
>    http://tracker.ceph.com/issues/17222
>    (Jason pls rview/approve)
>
> knfs
>    http://tracker.ceph.com/issues/17192
>    (Greg pls rview/approve, note: it's similar we saw in hammer point release)
>
> samba:
>    http://tracker.ceph.com/issues/17184
>    (Greg pls rview/approve)
>
> upgrade/client-upgrade:about:startpage
>    http://tracker.ceph.com/issues/16506
>    (Sage, Sam, Jason pls rview/approve)
>
> upgrade/infernalis-x (jewel):
>    http://tracker.ceph.com/issues/17176
>    (Sam, David  pls rview/approve)
>
> powercycle:
>    http://tracker.ceph.com/issues/17177
>    (Sage  pls rview/approve)
>
> Loic, given that we have high number of issues in this release, if you
> and dev leads find that we need to add more backports we may consider
> validating a new point RC (sha1).
>
> Thx
> YuriW
