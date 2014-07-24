From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: sizeof (struct tYpO *) : it is just a typo or rather a bug ?
Date: Thu, 24 Jul 2014 22:33:23 +0400
Message-ID: <CALFYKtAyB6xGEgJ65Ti5vPx9xf4ipX9__FZBwosBYg1y9z7cKg@mail.gmail.com>
References: <53D14E60.1010105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:46611 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759062AbaGXSdY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 14:33:24 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so3777591qge.16
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 11:33:23 -0700 (PDT)
In-Reply-To: <53D14E60.1010105@gmx.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: linux-ia64@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Jul 24, 2014 at 10:20 PM, Toralf F=C3=B6rster <toralf.foerster@=
gmx.de> wrote:
> Inspired by this "typo" fix
> http://article.gmane.org/gmane.linux.kernel/1754640
> I grep'ed the current git tree of linus for similar issues.
>
> For these 4 places I'm wondering where the appropriate struct definit=
ion is located :
>
> arch/ia64/sn/kernel/io_acpi_init.c:         sizeof(struct pci_devdev_=
info *)) {
> tools/perf/builtin-sched.c:     sched->tasks =3D realloc(sched->tasks=
, sched->nr_tasks * sizeof(struct task_task *));
> fs/ceph/xattr.c:                xattrs =3D kcalloc(numattr, sizeof(st=
ruct ceph_xattr *),
> fs/ceph/xattr.c:                memset(xattrs, 0, numattr*sizeof(stru=
ct ceph_xattr *));

Heh, the ceph one is a five year old typo..  Looks like it should be
struct ceph_inode_xattr, I'll fix it up.  I'm curious though, how did
you grep for these?

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
