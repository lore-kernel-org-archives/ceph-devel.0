From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [PATCH 1/4] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:41:36 -0800 (PST)
Message-ID: <1428581154.47319.1320874896705.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAORUGqDjakCO6X-w-gofZWwiJZf65Lfk2VnV0OaDAZiSDATZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:36870 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab1KIVlh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:41:37 -0500
In-Reply-To: <CAORUGqDjakCO6X-w-gofZWwiJZf65Lfk2VnV0OaDAZiSDATZXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Noah Watkins <jayhawk@cs.ucsc.edu>

----- Original Message -----
> From: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
> To: "Noah Watkins" <jayhawk@cs.ucsc.edu>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, November 9, 2011 1:36:28 PM
> Subject: Re: [PATCH 1/4] client: return stripe address replicas
> On Tue, Nov 8, 2011 at 18:39, Noah Watkins <jayhawk@cs.ucsc.edu>
> wrote:
> > + /* naddr == 0: drop through and return actual size */
> > + if (naddr && (address.size() > (unsigned)naddr))
> 
> I have to say I'm not completely comfortable with the magicness of
> naddr==0, mostly because I haven't seen other APIs do it like that.

I'm with you, I haven't seen it -- atleast I couldn't find a good
example in libc. I guess it's technically a special case as 0 would
be too small and the user would expect ERANGE. I'm pretty neutral on
this as it's for pretty specialized users.
