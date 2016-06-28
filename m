From: Lars Marowsky-Bree <lmb@suse.com>
Subject: "Tags" for Ceph pools?
Date: Tue, 28 Jun 2016 21:54:27 +0200
Message-ID: <20160628195427.bu2idrr25apcundv@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43464 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbcF1Tyx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 15:54:53 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id BEFB2AC80
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 19:54:27 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

silly question time. From a UX perspective, we sometimes need to know
what a specific pool does. We can't always figure it out directly by
looking at the pool - is this used for RBDs? A MDS metadata pool? RGW
buckets?

Right now, that is all bundled into the naming scheme. Is that the way
to proceed? Is there a recommended/standard naming scheme that tools
could attach to, then?

We though of storing it in an object in the pool, but, uh, that
obviously doesn't work so well for cache-tiered pools ;-)

Or should we have metadata about our Ceph entities maintained outside
Ceph, in a separate tooling database?

Or would there be the chance to somehow store some description
somewhere, like a few k/v, free-form? x-... parameters maybe?

(Tool suppliers could then agree on common tags, hopefully.)



Regards
    Lars

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
