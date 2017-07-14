From: Mike Lowe <j.michael.lowe@gmail.com>
Subject: Re: upgrade procedure to Luminous
Date: Fri, 14 Jul 2017 10:34:35 -0400
Message-ID: <C7751C1D-7C11-4706-B167-D4745D058F0B@gmail.com>
References: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de>
 <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
 <20170714142734.5aqzae7x7fmsqmmz@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34055 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbdGNOem (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 10:34:42 -0400
Received: by mail-io0-f195.google.com with SMTP id f66so2401482iof.1
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jul 2017 07:34:42 -0700 (PDT)
In-Reply-To: <20170714142734.5aqzae7x7fmsqmmz@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Sage Weil <sage@newdream.net>, Joao Eduardo Luis <joao@suse.de>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

Having run ceph clusters in production for the past six years and =
upgrading from every stable release starting with argonaut to the next, =
I can honestly say being careful about order of operations has not been =
a problem.

> On Jul 14, 2017, at 10:27 AM, Lars Marowsky-Bree <lmb@suse.com> wrote:
>=20
> On 2017-07-14T14:12:08, Sage Weil <sage@newdream.net> wrote:
>=20
>>> Any thoughts on how to mitigate this, or on whether I got this all =
wrong and
>>> am missing a crucial detail that blows this wall of text away, =
please let me
>>> know.
>> I don't know; the requirement that mons be upgraded before OSDs =
doesn't=20
>> seem that unreasonable to me.  That might be slightly more painful in =
a=20
>> hyperconverged scenario (osds and mons on the same host), but it =
should=20
>> just require some admin TLC (restart mon daemons instead of=20
>> rebooting).
>=20
> I think it's quite unreasonable, to be quite honest. Collocated MONs
> with OSDs is very typical for smaller cluster environments.
>=20
>> Is there something in some distros that *requires* a reboot in order =
to=20
>> upgrade packages?
>=20
> Not necessarily.
>=20
> *But* once we've upgraded the packages, a failure or reboot might
> trigger this.
>=20
> And customers don't always upgrade all nodes at once in a short period
> (the benefit of a supposed rolling upgrade cycle), increasing the =
risk.
>=20
> I wish we'd already be fully containerized so indeed the MONs were =
truly
> independent of everything else going on on the cluster, but ...
>=20
>> Also, this only seems like it will affect users that are getting =
their=20
>> ceph packages from the distro itself and not from a ceph.com channel =
or a=20
>> special subscription/product channel (this is how the RHEL stuff =
works, I=20
>> think).
>=20
> Even there, upgrading only the MON daemons and not the OSDs is tricky?
>=20
>=20
>=20
>=20
> --=20
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham =
Norton, HRB 21284 (AG N=C3=BCrnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar =
Wilde
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

