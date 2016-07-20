From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: CephFS Samba VFS RHEL packages
Date: Wed, 20 Jul 2016 09:32:11 -0600
Message-ID: <CALqRxCwg3jFN2OTC2ut=otHukOGHw9p9r7+RbByvQdTMBifM8A@mail.gmail.com>
References: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33405 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbcGTPcM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 11:32:12 -0400
Received: by mail-vk0-f45.google.com with SMTP id x130so74240286vkc.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 08:32:12 -0700 (PDT)
In-Reply-To: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

The Samba packages in Fedora 22+ do enable the Samba VFS:
https://bugzilla.redhat.com/1174412

From what Ira said downthread, this is pretty experimental, so you
could run your tests on a Fedora system and see how it goes :)

- Ken

On Tue, Jul 19, 2016 at 11:45 PM, Blair Bethwaite
<blair.bethwaite@gmail.com> wrote:
> Hi all,
>
> We've started a CephFS Samba PoC on RHEL but just noticed the Samba
> Ceph VFS doesn't seem to be included with Samba on RHEL, or we're not
> looking in the right place. Trying to avoid needing to build Samba
> from source if possible. Any pointers appreciated.
>
> --
> Cheers,
> ~Blairo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
