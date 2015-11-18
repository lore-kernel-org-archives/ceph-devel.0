From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: RGW multi-tenancy APIs overview
Date: Tue, 17 Nov 2015 18:31:07 -0700
Message-ID: <20151117183107.5370500d@lembas.zaitcev.lan>
References: <20151109221015.2fa7745c@lembas.zaitcev.lan>
	<CADRKj5TmduPhctTc2LdbSXrMyycrR_9=+jkiXNOCpUy63ozuPg@mail.gmail.com>
	<20151117164723.0d89f579@lembas.zaitcev.lan>
	<CADRKj5RNmMnPmDhm63n=BiNpU+tPNJugOxj_2j3MjeBDY3MAwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41502 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbbKRBbI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Nov 2015 20:31:08 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 44CCAB7CE8
	for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 01:31:08 +0000 (UTC)
In-Reply-To: <CADRKj5RNmMnPmDhm63n=BiNpU+tPNJugOxj_2j3MjeBDY3MAwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 17 Nov 2015 16:00:12 -0800
Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:

> > <ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01">
> >  <Name>foobucket</Name>
> >  <Tenant>footenant</Tenant>  <=============== this one
> >  <IsTruncated>false</IsTruncated>
> >
> > There's a certain problem with this, in case the client is constructing
> > the URLs for further access. In case it's trying to access across tenants,
> > it has to fetch the tenant name from the attribute. I thought about returning
> > the bucket name as <Name>footenant:foobucket</Name> for all buckets that
> > belong to non-empty tenant, but that seems asking for compatibility issues
> > even for access within the tenant.
> 
> Ah, I understand this point now. Note that a user will only have
> buckets under its own tenant (not going to own buckets from another
> tenant), so I'm not sure we need to add this.

Good point. I think I'll drop that.

> >> Does that work the same for object copy, and acls?
> >
> > ACLs do not list buckets, only users, which may be qualified (tenant$user).
> 
> Not tenant:user?

I forgot what happened when we did tenant:user. There was some kind
of metadata syntax that used colon somewhere in one of APIs. I shall
re-examine that and add a code comment near to_str() with dollar.

-- Pete
