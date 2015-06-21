From: David Disseldorp <ddiss@suse.de>
Subject: Re: ceph-deploy: install bundled SES / openSUSE distribution
 packages
Date: Sun, 21 Jun 2015 14:36:45 +0200
Message-ID: <20150621143645.353f114f@plati.site>
References: <20150611193747.2cc6cfaa@plati.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43878 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbbFUMgs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 21 Jun 2015 08:36:48 -0400
In-Reply-To: <20150611193747.2cc6cfaa@plati.site>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Travis Rhoden <trhoden@gmail.com>, Owen Synge <osynge@suse.com>

On Thu, 11 Jun 2015 19:37:47 +0200, David Disseldorp wrote:

> I'd like to proceed with one of the
> following options:
> 1) Rename @use_rhceph to @use_bundled_ceph, and add new sles/opensuse
>    back-ends.
> 2) Change the suse back-end install() function to always use
>    distribution packages. The mirror_install(repo) logic triggered by
>    --repo-url can continue to be used for installations from other (e.g.
>    ceph.com) sources.
> 3) Pass a @bundled argument to the distro back-end install() function,
>    and implement the conditional logic there.
> 
> Any thoughts / preferences? I'm leaning towards (2), given that
> http://ceph.com/rpm-$release doesn't carry openSUSE or SLES packages for
> recent releases.

I submitted (2) via: https://github.com/ceph/ceph-deploy/pull/308
Feedback or merge appreciated. Thanks to Owen for the initial review.

Cheers, David
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
