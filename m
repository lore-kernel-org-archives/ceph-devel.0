From: Marcus Watts <mwatts@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 27 May 2016 04:28:33 -0400
Message-ID: <20160527082833.GB24096@degu.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
 <CACJqLyYbpFQynVcBFO4E254bvH5R05DvTAw+vfu68ptwa7oSZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932553AbcE0I2j (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2016 04:28:39 -0400
Content-Disposition: inline
In-Reply-To: <CACJqLyYbpFQynVcBFO4E254bvH5R05DvTAw+vfu68ptwa7oSZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Various wrote:...
On Fri, May 27, 2016 at 12:41:35PM +0800, Haomai Wang wrote:
> On Fri, May 27, 2016 at 2:17 AM, Sage Weil <sweil@redhat.com> wrote:
...
> S: TAG_AUTH_METHODS          # list methods
>     __le32 num_methods;
>     __le32 methods[num_methods];   // CEPH_AUTH_{NONE, CEPHX}
> 
> From my view, it looks we need to force a method instead of letting
> peer side select? What's use case that we allow client side to decide
> method?
...

Some cases to consider is: v2 server supports "v2.1" and "v2.2" (where .2 includes
some new method or other thing).  v2 client that only supports "v2.1" needs
to decide differently than another v2 client that also supports "v2.2".

Or, 2 clients, one sits on the "super fast secure" server room network,
another sits on the "slow insecure" link.  On the super fast connection
encryption overhead might result in unacceptable performance, yet on
the insecure link it might be absolutely essential.  The client is usually
in a much better position to know this than the server.

In the flow that you quoted, looks like when server advertises its methods
it doesn't yet know what the client supports, so it can't force any method.
The client is the one that knows what it supports, and learns what the server
supports, and therefore is the first one that can decide what it should do.

Of course you still need to somehow protect against a "downgrade" MITM attack.

					-Marcus Watts
