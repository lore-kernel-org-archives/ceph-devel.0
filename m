From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Tue, 6 Sep 2016 19:47:57 +0200
Message-ID: <CAOi1vP8V9OgR-U5=QC6qwVt-uRSB8Kb3qCAQ+ZmsV2PfZtiMLg@mail.gmail.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34103 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936212AbcIFRr6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 13:47:58 -0400
Received: by mail-vk0-f45.google.com with SMTP id v189so106887070vkv.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 10:47:58 -0700 (PDT)
In-Reply-To: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

On Tue, Sep 6, 2016 at 7:12 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
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

I've assigned these tickets to myself.  Neither is a blocker, approved.

Thanks,

                Ilya
