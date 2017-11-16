From: Venky Shankar <vshankar@redhat.com>
Subject: Re: Unittest_rbd_miiror: Build failed in Jenkins: ceph-master #1448
Date: Thu, 16 Nov 2017 08:02:48 -0500
Message-ID: <20171116130248.7dom32jkpqugyt7s@fedora-vs>
References: <1672609555.4.1510819269612.JavaMail.jenkins@cephdev.digiware.nl>
 <3eda6263-6c8a-0292-9aaa-863f6075cb77@digiware.nl>
 <20171116093341.o7msuimn4vo3cfhd@fedora-vs>
 <8e509950-886d-6b6d-e9dc-eff6380ad9b3@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:47224 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934843AbdKPNCz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Nov 2017 08:02:55 -0500
Received: by mail-pf0-f175.google.com with SMTP id t69so10592585pfg.4
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 05:02:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8e509950-886d-6b6d-e9dc-eff6380ad9b3@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 17-11-16 10:46:02, Willem Jan Withagen wrote:
> On 16/11/2017 10:33, Venky Shankar wrote:
> > On 17-11-16 09:56:36, Willem Jan Withagen wrote:
> > > Hi
> > > 
> > > Unittest_rbd_mirror consistently (twice already) fails in the same test and
> > > the same traceback.
> > > 
> > > Any suggestions as to where to start looking?
> > 
> > Kefu has a PR for this: https://github.com/ceph/ceph/pull/18964
> > 
> Ah, thnax.
> I'll run the patch and report with the PR.

This should fix it: https://github.com/ceph/ceph/pull/18969

> 
> --WjW
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
