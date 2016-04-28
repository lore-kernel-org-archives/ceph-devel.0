From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: ECONNREFUSED implies OSD definitely failed
Date: Thu, 28 Apr 2016 16:32:51 +0200
Message-ID: <20160428143251.GA1541@suse.de>
References: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44334 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbcD1Ocz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2016 10:32:55 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 07B14ABDD
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 14:32:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2016-04-22T12:24:52, Sage Weil <sweil@redhat.com> wrote:

> Piotr has a PR at
>=20
> 	https://github.com/ceph/ceph/pull/8558
>=20
> that changes the messenger and OSD logic so that if we get an ECONNRE=
=46USED=20
> trying to talk to another OSD we can definitively conclude that the O=
SD is=20
> down/failed, without waiting for the normal heartbeat timeout.
>=20
> I think this is true in normal networking environments.  My only conc=
ern=20
> is that there might be cases where the OSD isn't actually down and so=
me=20
> transient network issue could cause ECONNREFUSED.  Like... some=20
> firewally magic networky thing.  If a transient ECONNREFUSED was poss=
ible,=20
> it could cause some ugly flapping.
>=20
> Can anyone think of something that might cause this?  Even if it is=20
> something obscure, it means we should have a config option to disable=
 this=20
> new behavior (we probably should anyway).

Exactly this - the system reconfiguring it's network interfaces and
firewall rules (in a suboptimal fashion; it should drop, not reject, bu=
t
=2E..).

Or a duplicate IP address (with a node that isn't running ceph-osd).
Again, not supposed to happen.



--=20
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton,=
 HRB 21284 (AG N=FCrnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wil=
de

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
