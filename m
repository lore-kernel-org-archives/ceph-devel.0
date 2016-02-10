From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: hammer v0.94.6 QE Validation status
Date: Wed, 10 Feb 2016 11:24:43 -0800
Message-ID: <CAJ4mKGZi_pMc4eXq91FPync-gz_7_5NmDCb3QGz5n=zB+5GTTQ@mail.gmail.com>
References: <CAMMFjmHcBKZubn7e_ebmNMcE-7MbzPYXD0fAPFzA_ME2oEBkPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35852 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbcBJTYo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 14:24:44 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so43734181wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 11:24:44 -0800 (PST)
In-Reply-To: <CAMMFjmHcBKZubn7e_ebmNMcE-7MbzPYXD0fAPFzA_ME2oEBkPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, "Weil, Sage" <sage@redhat.com>, Nathan Cutler <ncutler@suse.cz>

On Wed, Feb 10, 2016 at 10:56 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Hello
>
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/13356#note-61
>
> The following suites were in scope of this point release testing:
>
> rados (subset 1/7)
> rbd
> rgw
> fs
> krbd
> kcephfs
> hadoop
> samba
> rest
> ceph-deploy
> upgrade/client-upgrade
> upgrade/dumpling-firefly-x (hammer)
> upgrade/firefly-x (hammer)
> upgrade/hammer
> upgrade/hammer-x (infernalis)
> powercycle
>
> Outstanding issues (approval requested):
>
> fs:
> http://tracker.ceph.com/issues/14716 - Greg, do you want those to be
> fixed for this release or approve release as is with a known issue?
>
> samba:
> http://tracker.ceph.com/issues/14714 - Greg, do you want those to be
> fixed for this release or approve release as is with a known issue?

I'll be evaluating both of these bugs today and will let you know.
-Greg
