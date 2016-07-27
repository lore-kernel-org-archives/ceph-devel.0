From: Samuel Just <sjust@redhat.com>
Subject: Re: [ceph-users] Listing objects in a specified placement group / OSD
Date: Wed, 27 Jul 2016 09:44:50 -0700
Message-ID: <CAN=+7FU2BWDdJd+fRaBEcxOeacK6MqPk+NEpRMmJYqrhm4ckJA@mail.gmail.com>
References: <VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0@VI1PR0701MB2542.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35068 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcG0Qow convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2016 12:44:52 -0400
Received: by mail-qt0-f181.google.com with SMTP id x25so33138394qtx.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2016 09:44:51 -0700 (PDT)
In-Reply-To: <VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0@VI1PR0701MB2542.eurprd07.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Blundell <David.Blundell@100percentit.com>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, it's kind of deliberately obfuscated because PGs aren't a
librados-level abstraction.  Why do you want to list the objects in a
PG?
-Sam

On Wed, Jul 27, 2016 at 8:10 AM, David Blundell
<David.Blundell@100percentit.com> wrote:
> Hi,
>
>
>
> I wasn=E2=80=99t sure if this is a ceph-users or ceph-devel question =
as it=E2=80=99s about
> the API (users) but the answer may involve me writing a RADOS method
> (devel).
>
>
>
> At the moment in Ceph Jewel I can find which objects are held in an O=
SD or
> placement group by looking on the filesystem under
> /var/lib/ceph/osd/ceph-*/current
>
>
>
> This requires access to the OSD host and may well break when using Bl=
uestore
> if there is no filesystem to look through.  I would like to be able t=
o list
> objects in a specified PG/OSD from outside of the OSD host using Ceph
> commands.
>
>
>
> I can list all PGs hosted on OSD 1 using =E2=80=9Cceph pg ls-by-osd o=
sd.1=E2=80=9D and could
> loop through this output if there was a way to list the objects in a =
PG.
>
>
>
> I have checked the API and librados docs (I would be happy to hack so=
mething
> together using librados) and can=E2=80=99t see any obvious way to lis=
t the objects
> in a PG.
>
>
>
> I have seen a post on this mailing list from Ilya last September sayi=
ng:
>
> =E2=80=9CInternally there is a way to list objects within a specific =
PG (actually
> more than one way IIRC), but I don't think anything like that is expo=
sed in
> a CLI (it might be exposed in librados though).=E2=80=9D
>
>
>
> but could not find any follow up posts with details.
>
>
>
> Does anyone have any more details on these internal methods and how t=
o call
> them?
>
>
>
> Cheers,
>
>
>
> David
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
