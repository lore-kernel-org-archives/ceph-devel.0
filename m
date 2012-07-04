From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] librados: Bump the version to 0.48
Date: Wed, 4 Jul 2012 09:33:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207040932090.6931@cobra.newdream.net>
References: <1341409564-26660-1-git-send-email-wido@widodh.nl>
 <6ED535BAF3394911BDF4F16441761D6A@inktank.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1429156764-1341419598=:6931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43913 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2GDQdU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:33:20 -0400
In-Reply-To: <6ED535BAF3394911BDF4F16441761D6A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1429156764-1341419598=:6931
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Jul 2012, Gregory Farnum wrote:
> Hmmm =FF=FF we generally try to modify these versions when the API change=
s,=20
> not on every sprint. It looks to me like Sage added one function in 0.45=
=20
> where we maybe should have bumped it, but that was a long time ago and=20
> at this point we should maybe just eat it?

Yeah, I went ahead and applied this to stable (argonaut) since it's as=20
good a reference point as any.  Moving forward, we should try to sync=20
this up with API changes as they happen.  Hmm, like that assert=20
ObjectOperation that just went into master...=20

sage
--557981400-1429156764-1341419598=:6931--
