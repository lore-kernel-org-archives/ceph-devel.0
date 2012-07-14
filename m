From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] vstart: use absolute path for keyring
Date: Fri, 13 Jul 2012 17:15:19 -0700
Message-ID: <CAPrxi5_W6K1OfEKwxXdEFOU6k9RjZQJUeHh8aTaAmC8jWd8v3A@mail.gmail.com>
References: <EAE9FF3D-13E6-46CB-8D2F-31AE0C1D583A@cs.ucsc.edu>
	<CADvuQRFptoXhEUCkwP6Uobwu7YXy5dv0nFDCWVvtO4iJ=M+0pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61441 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2GNAPU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 20:15:20 -0400
Received: by yenl2 with SMTP id l2so4130582yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 17:15:19 -0700 (PDT)
In-Reply-To: <CADvuQRFptoXhEUCkwP6Uobwu7YXy5dv0nFDCWVvtO4iJ=M+0pA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Ok good point. I know where the config is cause I ran ./vstart :)

On Fri, Jul 13, 2012 at 5:12 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Fri, Jul 13, 2012 at 5:01 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> Stores absolute path to the generated keyring so that tests running in
>> other directories (e.g. src/java/test) can simply reference the
>> generated ceph.conf.
>
> Perhaps relative paths in ceph.conf should be interpreted as relative
> to the config file? That's a fairly standard convention in other
> software..
