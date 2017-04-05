From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Jewel 10.2.7 QE status
Date: Wed, 5 Apr 2017 14:55:55 -0700
Message-ID: <CAMMFjmG8jPmC1Ak4mDNN87ZK1qksvN9ms3Gaw8_Wa5v4aTShDw@mail.gmail.com>
References: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35097 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdDEVz5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Apr 2017 17:55:57 -0400
Received: by mail-wr0-f170.google.com with SMTP id o21so6755037wrb.2
        for <ceph-devel@vger.kernel.org>; Wed, 05 Apr 2017 14:55:56 -0700 (PDT)
In-Reply-To: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>

There had been lengthy discussion in #ceph-devel regarding failed
upgrade tests, https://github.com/ceph/teuthology/pull/1055,
http://tracker.ceph.com/issues/19429

We need to decide what to do about this in context of this release.

On Wed, Apr 5, 2017 at 1:16 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/19055#note-13
> The following suites were in scope of this point release validation:
>
> rados (subset 35/50 227 jobceph-ansibles)
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> rest
> hadoop - EXCLUDED
> samba - EXCLUDED
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/hammer-x (jewel)
> upgrade/jewel-x/point-to-point-x
> powercycle
> ceph-ansible
>
> (please let me know if any suites are missing from this ^ list)
>
> =====================
> Outstanding issues
>
> rados - two jobs failed, need Josh's approval
> krbd - seems similar to previous release, need Ilya's approval
>
> upgrade/client-upgrade
> and
> upgrade/hammer-x (jewel) - suspect
> http://tracker.ceph.com/issues/19429, need Sage/Josh approve
>
> Thx
> YuriW
