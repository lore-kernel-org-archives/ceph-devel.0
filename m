From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] ceph-disk removal roadmap (was ceph-disk is now deprecated)
Date: Fri, 1 Dec 2017 07:45:47 -0500
Message-ID: <CAC-Np1zskEabUd4HKC-DmHXmLqU6mSBdtirEDgs6qdv9O0ayjQ@mail.gmail.com>
References: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
 <20171201081757.qwfo2lrhpmg77jgd@nora.maurer-it.com> <20171201082810.GH30636@shell.dmz.bit.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:39113 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdLAMpt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Dec 2017 07:45:49 -0500
Received: by mail-qt0-f180.google.com with SMTP id k19so12786113qtj.6
        for <ceph-devel@vger.kernel.org>; Fri, 01 Dec 2017 04:45:48 -0800 (PST)
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
> doing bluestore on top of LVM? Eager to use ceph-volume for that, and
> skip entirely over ceph-disk and our manual osd prepare process ...

Yes. I think that for 12.2.1 this was the case as well, in 12.2.2 is
the default.


>
> Gr. Stefan
>
> --
> | BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
> | GPG: 0xD14839C6                   +31 318 648 688 / info@bit.nl
