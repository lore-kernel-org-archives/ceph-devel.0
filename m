From: Christoph Hellwig <hch@infradead.org>
Subject: Re: kerberos / AD requirements, blueprint
Date: Thu, 23 Oct 2014 00:45:41 -0700
Message-ID: <20141023074541.GA30887@infradead.org>
References: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net>
 <20141017005239.GA31393@soma.private.linuxbox.com>
 <1413951689.9184.3.camel@catalyst.net.nz>
 <20141022224605.GA1152@soma.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:32871 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaJWHpv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 03:45:51 -0400
Content-Disposition: inline
In-Reply-To: <20141022224605.GA1152@soma.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mdw@linuxbox.com
Cc: Andrew Bartlett <abartlet@catalyst.net.nz>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, daniel.vanderster@cern.ch

On Wed, Oct 22, 2014 at 06:46:06PM -0400, mdw@linuxbox.com wrote:
> I think the overwhelming common implementation is AD - at all sizes
> of organizations from small to large.  But most of those will be
> microsoft-only environments, so aren't particularly relevant to ceph.
> I don't have good stats on the # of openldap/mit sites - but I imagine
> many of them either don't care about samba, or have already invested
> effort in a more or less parallel AD setup.  If you're running a lot
> of microsoft desktops already, you'd have to be pretty passionate
> to not just run AD and call it a day.  For ceph, though, you're
> talking about linux machines - and there, the attraction for AD
> is underwhelming.

I know enough large sites using AD for their Linux nodes as well. So
far I've not seen an overlap with Ceph deployments, though.

