From: mdw@linuxbox.com
Subject: Re: kerberos / AD requirements, blueprint
Date: Wed, 22 Oct 2014 18:46:06 -0400
Message-ID: <20141022224605.GA1152@soma.private.linuxbox.com>
References: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net>
 <20141017005239.GA31393@soma.private.linuxbox.com>
 <1413951689.9184.3.camel@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3417 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933001AbaJVWqo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Oct 2014 18:46:44 -0400
Content-Disposition: inline
In-Reply-To: <1413951689.9184.3.camel@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Bartlett <abartlet@catalyst.net.nz>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, daniel.vanderster@cern.ch

On Wed, Oct 22, 2014 at 05:21:29PM +1300, Andrew Bartlett wrote:
...
> > At a large site, I think you can confidently expect:
> > 	or or more large scale deployments of AD,MIT,openldap,etc.
> > 	homebrew management system to provision and manage accounts
> > 	the filesystem group(s) and the identity management group are separate
> 
> Do you see a lot of this beyond major universities and similar sites?  I
> ask because at least from my Samba background, I feel like we lost out
> in the 2000's against AD, with a good number of very passionate users
> waiting patiently for Samba4, but so, so many just running AD from
> Microsoft.  The number with OpenLDAP and Kerberos that come past the
> Samba lists seemed vanishingly small. 
> 
> (I've very glad for our passionate OpenLDAP and Kerberos users, I just
> don't see so many of them these days).

I think the overwhelming common implementation is AD - at all sizes
of organizations from small to large.  But most of those will be
microsoft-only environments, so aren't particularly relevant to ceph.
I don't have good stats on the # of openldap/mit sites - but I imagine
many of them either don't care about samba, or have already invested
effort in a more or less parallel AD setup.  If you're running a lot
of microsoft desktops already, you'd have to be pretty passionate
to not just run AD and call it a day.  For ceph, though, you're
talking about linux machines - and there, the attraction for AD
is underwhelming.

					-Marcus Watts
