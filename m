From: Luis Periquito <periquito@gmail.com>
Subject: Fwd: monitor crashing
Date: Tue, 13 Oct 2015 12:45:24 +0100
Message-ID: <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com>
References: <CACx0BdM2qsO0n492Y7R=+FBfJzJT+4HxbBYaU1rkG0mZV=caJw@mail.gmail.com>
	<CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35293 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbJMLpZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 07:45:25 -0400
Received: by obbzf10 with SMTP id zf10so11120047obb.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 04:45:25 -0700 (PDT)
In-Reply-To: <CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Any ideas? I'm growing desperate :(

I've tried compiling from source, and including
https://github.com/ceph/ceph/pull/5276, but it still crashes on boot
of the ceph-mon

---------- Forwarded message ----------
From: Luis Periquito <periquito@gmail.com>
Date: Tue, Oct 13, 2015 at 12:26 PM
Subject: Re: monitor crashing
To: Ceph Users <ceph-users@lists.ceph.com>


I'm currently running Hammer (0.94.3), created an invalid LRC profile
(typo in the l=, should have been l=4 but was l=3, and now I don't
have enough different ruleset-locality) and created a pool. Is there
any way to delete this pool? remember I can't start the ceph-mon...

On Tue, Oct 13, 2015 at 11:56 AM, Luis Periquito <periquito@gmail.com> wrote:
> It seems I've hit this bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=1231630
>
> is there any way I can recover this cluster? It worked in our test
> cluster, but crashed the production one...
