From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 14:24:28 -0700
Message-ID: <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:64315 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab3DRVYc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 17:24:32 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so1592576dan.19
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 14:24:31 -0700 (PDT)
In-Reply-To: <517060B2.80706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "Plaetinck, Dieter" <dieter@vimeo.com>, ceph-devel@vger.kernel.org, cdl@asgaard.org, danm@annaisystems.com


On Apr 18, 2013, at 2:08 PM, Josh Durgin <josh.durgin@inktank.com> wrote:

> I talked to some folks interested in doing a more limited form of this
> yesterday. They started a blueprint [1]. One of their ideas was to have
> erasure coding done by a separate process (or thread perhaps). It would
> use erasure coding on an object and then use librados to store the
> rasure-encoded pieces in a separate pool, and finally leave a marker in
> place of the original object in the first pool.

This sounds at a high-level similar to work out of Microsoft:

  https://www.usenix.org/system/files/conference/atc12/atc12-final181_0.pdf

The basic idea is to replicate first, then erasure code in the background.

- Noah
