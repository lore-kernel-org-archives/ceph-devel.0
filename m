From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 1/3] java: add Java and C++ source files
Date: Mon, 5 Mar 2012 14:36:19 -0800
Message-ID: <CAORUGqBFO9hGFwL1ARRSRLjL0BcF6d5sEjrYQfN2fc9Yiy9GTw@mail.gmail.com>
References: <4F516A75.6020500@cs.ucsc.edu> <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
 <AEAC99B6-B38D-438B-BAA3-D06CD0716676@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57878 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab2CEWgj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 17:36:39 -0500
Received: by pbcun15 with SMTP id un15so3294591pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 14:36:39 -0800 (PST)
In-Reply-To: <AEAC99B6-B38D-438B-BAA3-D06CD0716676@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 5, 2012 at 12:49, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> So the JUnit tests require a functional ceph cluster to run. Can you
>> state that explicitly in the source/docs, please?
> Yes, I'll make this clear in the source and docs. Is there currently a mechanism available for testing libcephfs w/o a functional cluster? If so it would probably be feasible to adapt the same techniques to the Java library.

No, I don't think there is. Something in the spirit of to
src/vstart.sh might be the best way forward, or just a thing that
launches a vm and uses chef to install ceph using the cookbooks.
vstart itself has a lot of historical baggage.
