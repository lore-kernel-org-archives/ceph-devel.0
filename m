From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: ECONNREFUSED implies OSD definitely failed
Date: Fri, 29 Apr 2016 14:32:41 +0200
Message-ID: <20160429123241.GJ1541@suse.de>
References: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com>
 <20160428143251.GA1541@suse.de>
 <20160429074639.GG26146@predictor>
 <alpine.DEB.2.11.1604290828520.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54025 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcD2Mcp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Apr 2016 08:32:45 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 71604AC15
	for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2016 12:32:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604290828520.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2016-04-29T08:29:59, Sage Weil <sage@newdream.net> wrote:

> > I'm not convinced that we should care about this. I think that prob=
ability
> > of (re)connect event occurrence during firewall reconfiguration is =
quite
> > low.
> Yeah, I tend to agree.
>=20
> Let's just add a config option to control the new behavior so that if=
, for=20
> some reason, there is an environment where this does happen the fast-=
fail=20
> can be disabled.

Also agreed. Just wanted to add the cases where I've seen these happen
- and indeed, they are pretty obscure cases that shouldn't happen.


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
