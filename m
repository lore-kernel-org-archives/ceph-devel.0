From: Sage Weil <sage@newdream.net>
Subject: Re: msgr2 protocol
Date: Fri, 27 May 2016 13:33:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605271330580.4873@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CACJqLyYbpFQynVcBFO4E254bvH5R05DvTAw+vfu68ptwa7oSZA@mail.gmail.com> <20160527082833.GB24096@degu.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40594 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488AbcE0Rcw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2016 13:32:52 -0400
In-Reply-To: <20160527082833.GB24096@degu.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 27 May 2016, Marcus Watts wrote:
> Of course you still need to somehow protect against a "downgrade" MITM 
> attack.

How is this generally done?  I'm thinking about, for example, a MITM who 
silently drops the TAG_ENCRYPT message in the protocol I described.  It 
seems like we need a secure TAG_AUTH_something that makes a statement 
about what has been negotiated before we start the message exchange or 
else some part of the initial exchange could have been dropped.

?

sage
