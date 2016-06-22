From: Sage Weil <sage@newdream.net>
Subject: Re: mount.cephfs with domain name and multiple ip addresses
Date: Wed, 22 Jun 2016 12:29:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606221228450.21827@piezo.us.to>
References: <576A22BD.1000901@wyraz.de> <692318497.24133.1466576170232.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:52318 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751925AbcFVM3x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jun 2016 08:29:53 -0400
In-Reply-To: <692318497.24133.1466576170232.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>
Cc: Michael Wyraz <michael@wyraz.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 22 Jun 2016, wido@42on.com wrote:
> > Op 22 jun. 2016 om 07:56 heeft Michael Wyraz <michael@wyraz.de> het volgende geschreven:
> > 
> > Hello,
> > 
> > I have multiple ceph monitor nodes and one domain name that has an a
> > record for each node. I use this record in my fstab, e.g.:
> > 
> >    mon.mycephcluster.com:6789:/ /backups/ ceph _netdev
> > 
> > In /proc/mounts, I can see all IPs for mon.mycephcluster.com, e.g.:
> > 
> >    1.1.1.1:6789,2.2.2.2:6789,2.2.2.2:6789:/ /backups ceph
> >    rw,relatime,acl 0 0
> > 
> > This works perfect and is a really good thing because it makes
> > adding/removing nodes much more easy. What I'd like to know is if this
> > is intended behaviour (in this case it should be documented in the
> > manpage) or if this could have unexpected side effects.
> > 
> 
> That is the intended behaviour and works as you describe. Nothing weird 
> about this, actually a cool feature of Ceph.

Yes.  You can also add multiple A (or AAAA) records to DNS so that your 
fstab line is simple (e.g., mycluster-mons.foo.com) and can be easily 
updated (via DNS) when your mons change.  Same goes for the mon host = ... 
line in ceph.conf.

sage
