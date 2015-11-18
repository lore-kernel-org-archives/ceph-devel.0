From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: RGW multi-tenancy APIs overview
Date: Wed, 18 Nov 2015 15:55:35 -0700
Message-ID: <20151118155535.68c6131f@lembas.zaitcev.lan>
References: <20151109221015.2fa7745c@lembas.zaitcev.lan>
	<CADRKj5TmduPhctTc2LdbSXrMyycrR_9=+jkiXNOCpUy63ozuPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbbKRWzg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Nov 2015 17:55:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 0F703C0BB2BD
	for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 22:55:36 +0000 (UTC)
In-Reply-To: <CADRKj5TmduPhctTc2LdbSXrMyycrR_9=+jkiXNOCpUy63ozuPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 9 Nov 2015 21:36:47 -0800
Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:

> In the supported domains configuration, we can specify for each domain
> whether a subdomain for it would be a bucket (as it is now), or
> whether it would be a tenant (which implies the possibility of
> bucket.tenant). This only affects the global (a.k.a the "empty")
> tenant.
> 
> E.g., we can have two domains:
> 
> legacy-foo.com
> new-foo.com
> 
> We'd specify that legacy-foo.com is a global tenant endpoint. In which
> case, when accessing buck.legacy-foo.com, it will access the global
> tenant, and bucket=buck.
> Whereas, new-foo.com isn't a global tenant endpoint, in which case, if
> we'd access buck.new-foo.com, it will mean that we accessed the 'buck'
> tenant.

I think I found another issue with this. Suppose we want a client authenticated
under an explicit tenant accessing a legacy bucket. The only way for it to
work is for it to use a different endpoint (in your example above it's
legacy-foo.com). The client cannot use buck.new-foo.com syntax, as mentioned.
So, there's a certain asymmetry built into the system.

Oddly enough, the X-amz-copy-source: syntax always includes bucket, and
tenant:bucket syntax is recognized there, so miraclously we're good there.

-- Pete

