From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Thu, 3 Dec 2015 21:47:49 +0000
Message-ID: <robbat2-20151203T214017-551971919Z@orbis-terrarum.net>
References: <20150623093325.GH10754@orbis-terrarum.net>
 <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com>
 <robbat2-20150623T230410-006258787Z@orbis-terrarum.net>
 <854662566.18884035.1435100864177.JavaMail.zimbra@redhat.com>
 <1563403567.1093721.1438280774967.JavaMail.zimbra@redhat.com>
 <robbat2-20150731T080643-628065411Z@orbis-terrarum.net>
 <565EF9E4.2020501@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:60889 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbbLCVru (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 16:47:50 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id EBE1A340A85
	for <ceph-devel@vger.kernel.org>; Thu,  3 Dec 2015 21:47:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <565EF9E4.2020501@igalia.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Javier =?iso-8859-1?Q?Mu=F1oz?= <jmunhoz@igalia.com>
Cc: "	Robin H. Johnson" <robbat2@gentoo.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>

On Wed, Dec 02, 2015 at 03:02:12PM +0100, Javier Mu=F1oz wrote:
> I would appreciate to know the current status of the implementation i=
f
> possible. Any progress? Any 'deadline' to go upstream? :)

When:
As soon as it works 100% and passes my testsuite, which I hope is very
soon. I would very much like to have this in Jewel.

My work was being done in this branch
https://github.com/dreamhost/ceph/tree/wip-static-website-robbat2-maste=
r
However, due to master moving forward, I can't use the latest parts of
the gitbuilder and automatic testing successfully (they've moved on,
while this has stayed behind).

Yehuda wanted me to try and NOT rebase it, for ease of his review, but
that was no longer possible :-(.
(tagged as wip-static-website-robbat2-master_yehuda-review-20151012 in
the dreamhost fork).

The above, but squashed and updated to master as of 2015/12/02
https://github.com/dreamhost/ceph/tree/wip-static-website-robbat2-maste=
r-20151202
It's presently running against my testsuite, and if it passes the piece=
s
that I know it should [1], I'll be splitting it up to submit.

[1] I'm seeing some failures of places where I didn't touch the code, s=
o
having to separate those out.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
