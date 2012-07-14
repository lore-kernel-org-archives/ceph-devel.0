From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] vstart: use absolute path for keyring
Date: Fri, 13 Jul 2012 17:12:17 -0700
Message-ID: <CADvuQRFptoXhEUCkwP6Uobwu7YXy5dv0nFDCWVvtO4iJ=M+0pA@mail.gmail.com>
References: <EAE9FF3D-13E6-46CB-8D2F-31AE0C1D583A@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40989 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab2GNAMj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 20:12:39 -0400
Received: by lbbgm6 with SMTP id gm6so6554794lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 17:12:38 -0700 (PDT)
In-Reply-To: <EAE9FF3D-13E6-46CB-8D2F-31AE0C1D583A@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 13, 2012 at 5:01 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Stores absolute path to the generated keyring so that tests running in
> other directories (e.g. src/java/test) can simply reference the
> generated ceph.conf.

Perhaps relative paths in ceph.conf should be interpreted as relative
to the config file? That's a fairly standard convention in other
software..
