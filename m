From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] ceph-disk removal roadmap (was ceph-disk is now deprecated)
Date: Fri, 1 Dec 2017 12:28:06 -0500
Message-ID: <CAC-Np1yUZn8yE9==fidSwFp73JpwHyUR0isdbD5TFjz506n-ZQ@mail.gmail.com>
References: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
 <20171201081757.qwfo2lrhpmg77jgd@nora.maurer-it.com> <20171201082810.GH30636@shell.dmz.bit.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:41345 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdLAR2H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Dec 2017 12:28:07 -0500
Received: by mail-qt0-f182.google.com with SMTP id i40so13952269qti.8
        for <ceph-devel@vger.kernel.org>; Fri, 01 Dec 2017 09:28:07 -0800 (PST)
In-Reply-To: <20171201082810.GH30636@shell.dmz.bit.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kooman <stefan@bit.nl>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Dec 1, 2017 at 3:28 AM, Stefan Kooman <stefan@bit.nl> wrote:
> Quoting Fabian Grünbichler (f.gruenbichler@proxmox.com):
>> I think the above roadmap is a good compromise for all involved parties,
>> and I hope we can use the remainder of Luminous to prepare for a
>> seam- and painless transition to ceph-volume in time for the Mimic
>> release, and then finally retire ceph-disk for good!
>
> Will the upcoming 12.2.2 release ship with a ceph-volume capable of
> doing bluestore on top of LVM?

Yes, see the open pr for it (https://github.com/ceph/ceph-deploy/pull/455)

> Eager to use ceph-volume for that, and
> skip entirely over ceph-disk and our manual osd prepare process ...

Now please note that the API will change in a non backwards compatible
way, so a major release of ceph-deploy will
be done after that is merged.

>
> Gr. Stefan
>
> --
> | BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
> | GPG: 0xD14839C6                   +31 318 648 688 / info@bit.nl
