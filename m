From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph and Software Defined Storage (SDS)
Date: Sat, 15 Dec 2012 06:53:10 -0800
Message-ID: <39E93E2B1ED3453E92D932C772C1940A@inktank.com>
References: <CAMcTwKoQFJQgYrgDoUhg4jrQ=vsYcpArmJc-dUmp0oBs2=HS9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:39115 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2LOOxO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 09:53:14 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2019595dak.19
        for <ceph-devel@vger.kernel.org>; Sat, 15 Dec 2012 06:53:14 -0800 (PST)
In-Reply-To: <CAMcTwKoQFJQgYrgDoUhg4jrQ=vsYcpArmJc-dUmp0oBs2=HS9g@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Itamar Landsman <itamar@itamar.org>
Cc: ceph-devel@vger.kernel.org

http://en.wikipedia.org/wiki/Software_defined_storage

Basically, with Ceph you've got a bunch of storage boxes providing raw =
disk. They're aggregated together via the software daemons they run rat=
her than by a RAID controller or some hardware box that re-exports them=
, and the administrator can change the "shape" of that storage via simp=
le commands =E2=80=94 adding new boxes, removing old ones, or setting i=
t up so that type foo data lives in those 20 machines and type bar live=
s in these other 10 machines even though it all used to live on all 30 =
machines is done via just a couple of commands.
It's storage, defined by software. ;)
-Greg


On Saturday, December 15, 2012 at 5:36 AM, Itamar Landsman wrote:

> Hi,
> =20
> There is some talk going around about software defined storage.
> Nevertheless I could not find a concrete definition for it.
> =20
> Can someone comment about where a definition can be found and how can
> ceph be a part of it?
> =20
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
