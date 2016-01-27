From: Wido den Hollander <wido@42on.com>
Subject: Re: /var/lib/ceph/*/*/config
Date: Wed, 27 Jan 2016 16:24:50 +0100
Message-ID: <56A8E142.4040401@42on.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
 <CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com>
 <alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
 <alpine.DEB.2.11.1601270956260.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:47801 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740AbcA0PYv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 10:24:51 -0500
In-Reply-To: <alpine.DEB.2.11.1601270956260.6524@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 27-01-16 15:59, Sage Weil wrote:
> Loic pointed out that adding a new config file that is overrides/combines 
> with the global config makes our already-complicated config infrastructure 
> even more so.  And it turned out to be more complicated to implement than 
> I'd hoped.  On the other hand, I think there are valid use-cases for a 
> global config, e.g.:
> 
>  - most config on the osd disk itself
>  - /etc/ceph/ceph.conf containing crush_location and mon_host
> 
> ...and with a single config I'm not sure how we'd get the datacenter 
> location set properly.
> 

Yes, you probably want the mon_host variable in a global config. We
might and I say *might* want to look at a DNS lookup at some time?

A lookup for 'ceph-monitor' in the current DNS search domain. But that
might be offtopic here.

> Anyway, I have two versions implemented.  The first just adds 
> $data_dir/config to the search pathh:
> 
> 	https://github.com/ceph/ceph/pull/7377
> 

I like the first patch, but it doesn't seem to merge the config files,
right?

If a global /etc/ceph/ceph.conf is found it doesn't search any further.

> The second adds the extra_config infrastructure.  It's just the last patch 
> that is different:
> 
> 	https://github.com/ceph/ceph/pull/7378
> 

The --extra-config seems weird to me. Isn't there a way where you supply
--config multiple times with multiple files?

Wido

> Comments?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
