From: "wido@42on.com" <wido@42on.com>
Subject: Re: mount.cephfs with domain name and multiple ip addresses
Date: Wed, 22 Jun 2016 08:16:09 +0200
Message-ID: <692318497.24133.1466576170232.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
References: <576A22BD.1000901@wyraz.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:41042 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751636AbcFVG0g convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jun 2016 02:26:36 -0400
In-Reply-To: <576A22BD.1000901@wyraz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Wyraz <michael@wyraz.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



> Op 22 jun. 2016 om 07:56 heeft Michael Wyraz <michael@wyraz.de> het volgende geschreven:
> 
> Hello,
> 
> I have multiple ceph monitor nodes and one domain name that has an a
> record for each node. I use this record in my fstab, e.g.:
> 
>    mon.mycephcluster.com:6789:/ /backups/ ceph _netdev
> 
> In /proc/mounts, I can see all IPs for mon.mycephcluster.com, e.g.:
> 
>    1.1.1.1:6789,2.2.2.2:6789,2.2.2.2:6789:/ /backups ceph
>    rw,relatime,acl 0 0
> 
> This works perfect and is a really good thing because it makes
> adding/removing nodes much more easy. What I'd like to know is if this
> is intended behaviour (in this case it should be documented in the
> manpage) or if this could have unexpected side effects.
> 

That is the intended behaviour and works as you describe. Nothing weird about this, actually a cool feature of Ceph.

Wido

> Kind regards,
> Michael.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
