From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Tue, 6 Sep 2016 10:27:47 -0700
Message-ID: <CAJ4mKGZtizmJ8m1rXLkgTrxboTHf7LYrJ8-HKwvC=kchncv4jA@mail.gmail.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35460 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964886AbcIFR1t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 13:27:49 -0400
Received: by mail-vk0-f47.google.com with SMTP id j189so97028102vkc.2
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2016 10:27:49 -0700 (PDT)
In-Reply-To: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

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
<snip>
> knfs
>    http://tracker.ceph.com/issues/17192
>    (Greg pls rview/approve, note: it's similar we saw in hammer point release)
>
> samba:
>    http://tracker.ceph.com/issues/17184
>    (Greg pls rview/approve)

John? :)
