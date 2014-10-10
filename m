From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 14:48:33 -0700
Message-ID: <CA+Hcz58UV8-eEbbV8uJrg5xaS+DCdueZAmRDwdtuVQTzfSPgSw@mail.gmail.com>
References: <5437A6C0.3000005@dachary.org>
	<alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>
	<5438134E.7050009@dachary.org>
	<alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net>
	<CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>
	<5438307C.4060701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49349 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbaJJVse (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 17:48:34 -0400
Received: by mail-qa0-f53.google.com with SMTP id v10so2222617qac.40
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 14:48:34 -0700 (PDT)
In-Reply-To: <5438307C.4060701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 10, 2014 at 12:16 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Noah,
>
> My focus is to create centos7 and ubuntu-14.04 packages at this point.

I think a newish Ubuntu should work just fine for us. Are the builds
using a cross compile? If so it'd be great if there was one build for
ARMv8.
