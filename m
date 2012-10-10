From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: [PATCH 0/4] rbd: finish up basic format 2 support
Date: Wed, 10 Oct 2012 16:55:10 +0100
Message-ID: <20121010165510.fc07422a.ctpm@ist.utl.pt>
References: <50748FA5.4030508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:41548 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab2JJQCf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Oct 2012 12:02:35 -0400
In-Reply-To: <50748FA5.4030508@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@inktank.com


On Tue, 09 Oct 2012 13:57:09 -0700 Alex Elder <elder@inktank.com> wrote=
:
> This series includes updates for two patches posted previously.
>=20
> 					-Alex

 Greetings,

 We're gearing up to test v0.52 (specifically the RBD stuff) on our
cluster. After reading this series of posts about rbd format 2 patches
I began wondering if we should start testing these patches as well or
not. To put it simply, what I'd like to know is:

 Is it enough to use the 3.6 vanilla kernel client to take full
advantage of the rbd changes in v0.52 (i.e. new RBD cloning features)?

 Do we have any benefits from applying any of these patches on top of
v3.6 and using "format 2", assuming that we stick to v0.52 on the
server, or is this strictly v0.53 and beyond stuff?


 I apologize if this is a dumb question, but by looking at the v0.52
changelog, at doc/rbd/* and the list, it doesn't seem clear how this
fits with v0.52.

 Thanks in advance

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
