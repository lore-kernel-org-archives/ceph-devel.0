From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RBD Async request: When / How are the call back called ?
Date: Thu, 30 Aug 2012 14:16:36 +0200
Message-ID: <CAF6-1L7GstF3ooOV7hOfCKXvFPP51Ce-mFovpt5oRm-_T=sffg@mail.gmail.com>
References: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com>
	<503E47C6.2040200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43595 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab2H3MQh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 08:16:37 -0400
Received: by vcbfk26 with SMTP id fk26so1780973vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 05:16:36 -0700 (PDT)
In-Reply-To: <503E47C6.2040200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, Mike Ryan <mike.ryan@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Thanks Mike and Josh for the answer, I see how it works now.

Using a pipe seems like a good fit for me.

One more question: When I have async read pending, I would have
expected rbd_flush and/or rbd_close to wait for them to finish but
they dont. Is there a way to wait for all operation to be complete ?
Because if I shutdown everything before they are, the application
hangs ...

Cheers,

    Sylvain
