From: Sage Weil <sweil@redhat.com>
Subject: Re: Erasure Code Plugins : PLUGINS_V3 feature
Date: Wed, 5 Aug 2015 11:44:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508051136360.22099@cobra.newdream.net>
References: <55B899FB.4080007@dachary.org> <55C1C789.3050401@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1799936537-1438800287=:22099"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51701 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbbHESos (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 Aug 2015 14:44:48 -0400
In-Reply-To: <55C1C789.3050401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Samuel Just <sjust@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1799936537-1438800287=:22099
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 5 Aug 2015, Loic Dachary wrote:
> Hi Sam,
> 
> How does this proposal sound ? It would be great if that was done before 
> the feature freeze.

I think it's a good time.

Takeshi, note that what this really means is that the on-disk encoding 
needs to remain fixed.  If we decide to change it down the line, we'll 
have to make a 'shec2' or similar so that the old format is still 
decodable (or ensure that existing data can still be read in some other 
way).

Sound good?

sage


> 
> Cheers
> 
> On 29/07/2015 11:16, Loic Dachary wrote:
> > Hi Sam,
> > 
> > The SHEC plugin[0] has been running in the rados runs[1] in the past few months. It also has a matching corpus verification which runs on every make check[2] as well as its optimized variants. I believe the flag "experimental" can now be removed. 
> > 
> > In order to do so, we need to use a PLUGINS_V3 feature, in the same way we did back in Giant when the ISA and LRC plugins were introduced[3]. This won't be necessary in the future, when there is a generic plugin mechanism, but right now that's what we need. It would be a commit very similar to the one implementing PLUGINS_V2[4].
> > 
> > Is this agreeable to you ? Or would you rather see another way to resolve this ?
> > 
> > Cheers
> > 
> > [0] https://github.com/ceph/ceph/tree/master/src/erasure-code/shec
> > [1] https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados/thrash-erasure-code-shec
> > [2] https://github.com/ceph/ceph-erasure-code-corpus/blob/master/v0.92-988/non-regression.sh#L52
> > [3] http://tracker.ceph.com/issues/9343
> > [4] https://github.com/ceph/ceph/commit/9687150ceac9cc7e506bc227f430d4207a6d7489
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--557981400-1799936537-1438800287=:22099--
