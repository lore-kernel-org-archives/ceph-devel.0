From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Tue, 6 Sep 2016 13:26:27 -0700
Message-ID: <CAMMFjmFBW+Zdnx8Ux9mtKvh3W187oHL3UDqNpKtkHZ15Q=porg@mail.gmail.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36216 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbcIFU0a (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 16:26:30 -0400
Received: by mail-wm0-f43.google.com with SMTP id b187so83440143wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 13:26:29 -0700 (PDT)
In-Reply-To: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

Missed a line with ceph-disk issue -

ceph-disk:
   http://tracker.ceph.com/issues/15350
   (Loic, Sam pls review/approve)

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
