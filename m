From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Tue, 23 Jun 2015 23:04:49 +0000
Message-ID: <robbat2-20150623T230410-006258787Z@orbis-terrarum.net>
References: <20150623093325.GH10754@orbis-terrarum.net>
 <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:50311 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932552AbbFWXEz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Jun 2015 19:04:55 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 475733409E2
	for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 23:04:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>


On Tue, Jun 23, 2015 at 04:30:19PM -0400, Yehuda Sadeh-Weinraub wrote:
> > Either I have to repeat a lot of code for it, which I'm not happy about,
> > or I have to refactor RGWGetObj* to more safely made the second GET
> > request for the error object (and make sure range headers etc are NOT
> > used for the get of the error object). I'm leaning to the latter.
> Is generating a new req_state a possibility? E.g., you catch the error
> at the top level, and restart most of the request processing with a
> newly created req_state?
That was the path I was trying, but not completely succeeding. 
I think need to step it back further and have a partially customized
copy of the RGWEnv from client_io->get_env(), so that I can build the
modified req_info for req_state.

It isn't a full new GET really, it's really just custom content for the
body as well as some headers (mostly Content-Length, Content-Type), but
ignore EPERM/EACCESS on trying to fetch that custom content, and if they
are detected, consider that a success but with different HTML content.

> Great! I'll wait for the cleaned up pull request.
Do you want pull requests per logical change of my proposed series
split, or rather just one pull request with the full series?

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
