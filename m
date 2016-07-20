From: John Spray <jspray@redhat.com>
Subject: Re: CephFS Samba VFS RHEL packages
Date: Wed, 20 Jul 2016 10:59:36 +0100
Message-ID: <CALe9h7c=zegmKFYkz7-oKSG9uQ0-TUE+DkXSCNdkwJgvpqsRXA@mail.gmail.com>
References: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33090 "EHLO
	mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbcGTJ75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 05:59:57 -0400
Received: by mail-qt0-f177.google.com with SMTP id w38so23503342qtb.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 02:59:57 -0700 (PDT)
In-Reply-To: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Ira Cooper <icooper@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 20, 2016 at 6:45 AM, Blair Bethwaite
<blair.bethwaite@gmail.com> wrote:
> Hi all,
>
> We've started a CephFS Samba PoC on RHEL but just noticed the Samba
> Ceph VFS doesn't seem to be included with Samba on RHEL, or we're not
> looking in the right place. Trying to avoid needing to build Samba
> from source if possible. Any pointers appreciated.

RHEL packagers tend to be conservative about building in feature flags
that aren't official parts of their product.

Unfortunately we do our upstream Samba testing on Ubuntu, so don't
have any RPMs from the gitbuilders either; you're probably going to
have to build your own.

CCing Ira who was recently evaluating the state of Samba+CephFS and
might have some tips on setting this up on RHEL.

Cheers,
John

> --
> Cheers,
> ~Blairo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
