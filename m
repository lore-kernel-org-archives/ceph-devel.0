From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: sizeof (struct tYpO *) : it is just a typo or rather a bug ?
Date: Thu, 24 Jul 2014 20:37:52 +0200
Message-ID: <53D15280.5070407@gmx.de>
References: <53D14E60.1010105@gmx.de> <CALFYKtAyB6xGEgJ65Ti5vPx9xf4ipX9__FZBwosBYg1y9z7cKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:51011 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757603AbaGXSh4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Jul 2014 14:37:56 -0400
In-Reply-To: <CALFYKtAyB6xGEgJ65Ti5vPx9xf4ipX9__FZBwosBYg1y9z7cKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: linux-ia64@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 07/24/2014 08:33 PM, Ilya Dryomov wrote:
> On Thu, Jul 24, 2014 at 10:20 PM, Toralf F=C3=B6rster <toralf.foerste=
r@gmx.de> wrote:
>> Inspired by this "typo" fix
>> http://article.gmane.org/gmane.linux.kernel/1754640
>> I grep'ed the current git tree of linus for similar issues.
>>
>> For these 4 places I'm wondering where the appropriate struct defini=
tion is located :
>>
>> arch/ia64/sn/kernel/io_acpi_init.c:         sizeof(struct pci_devdev=
_info *)) {
>> tools/perf/builtin-sched.c:     sched->tasks =3D realloc(sched->task=
s, sched->nr_tasks * sizeof(struct task_task *));
>> fs/ceph/xattr.c:                xattrs =3D kcalloc(numattr, sizeof(s=
truct ceph_xattr *),
>> fs/ceph/xattr.c:                memset(xattrs, 0, numattr*sizeof(str=
uct ceph_xattr *));
>=20
> Heh, the ceph one is a five year old typo..  Looks like it should be
> struct ceph_inode_xattr, I'll fix it up.  I'm curious though, how did
> you grep for these?
>=20
> Thanks,
>=20
>                 Ilya
>=20

1:
	grep -Hr "sizeof[ *(]struct .* \*.)"  | cut -f2- -d':' | tee ~/tmp/out

2:
	cat ~/tmp/out | perl -wane 'chomp(); my ($left, $right) =3D split (/si=
zeof\(/); print $right, "\n";' | cut -f2 -d' ' | sort -u | cut -f1 -d')=
' | grep -v '^+' | while read i; do echo $i; git grep -q "struct $i {" =
|| echo error; echo; done

3:
	ignore false positives

--=20
Toralf

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
