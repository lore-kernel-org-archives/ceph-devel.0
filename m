From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: apache/fcgi deprecation?
Date: Tue, 9 Feb 2016 13:40:53 +1100
Message-ID: <CA+z5DswP2bywCYM7H_WjNuD4+8qP0=NDz7iSa7GovE-jyoqZhg@mail.gmail.com>
References: <56B42126.7090106@suse.cz> <CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com>
 <56B91FA8.8080709@suse.cz> <alpine.DEB.2.11.1602081929450.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34759 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcBIClN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 21:41:13 -0500
Received: by mail-oi0-f53.google.com with SMTP id j125so7842172oih.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 18:41:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602081929450.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 9 February 2016 at 11:30, Sage Weil <sweil@redhat.com> wrote:
> What do you think?  There are some valid use-cases for wanting apache (or
> whatever) in front as it gives you access to a bunch of modules.  On the
> other hand, you can do the same with a proxy.

I don't think it's valid to point people at the civetweb docs without
some clear info about how it is embedded in radosgw and how (if it's
even possible?) to change the embedded civetweb's config.

At Monash we recently implemented radosgw under Red Hat Ceph (i.e.,
Hammer .3-ish). We were quite surprised (and to be honest, a bit
disappointed) that there was apparently no documentation about
architecture or configuration for standing up a production grade
radosgw service with the current tech (civetweb) - understandable to
see upstream/community docs lacking, but had hoped the Red Hat
subscription might unlock some useful internal docs/configs to this
effect.

After some effort we now have a horizontally scalable radosgw behind
haproxy (SSL termination there) + keepalived with basic DNS
round-robin providing the initial request fan-out, and would be
willing to contribute some rudimentary info to the docs around this.
We're now trying to figure out how we can implement some basic
security controls with this setup (e.g., block brute-force
attempts)...

-- 
Cheers,
~Blairo
