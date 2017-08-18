From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: multi-line comments
Date: Fri, 18 Aug 2017 14:41:57 +0200
Message-ID: <ba5a6db9-029a-c303-18a1-648c597c7267@digiware.nl>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
 <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
 <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:51932 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdHRMmC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 18 Aug 2017 08:42:02 -0400
In-Reply-To: <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Amit Kumar <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 18-8-2017 13:35, John Spray wrote:

> Based on the discussion on https://github.com/ceph/ceph/pull/16705,
> there doesn't seem to be much support for removing contractions.
> 
> I sympathise with John W's original intent on that PR to make it
> easier to sync up upstream docs with commercial products that might
> have an IBM-ish style, but I don't think it makes sense to make the
> change without making it a rule, and I think it's not something that's
> desirable as a rule.

Being sort of cynical here, but:

The "fun" part of this is that the conversion is going to be automated.
So nothing stops the downstream commercial supplier to do that
replacement before he releases his own product.

--WjW
