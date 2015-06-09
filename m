From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k
Date: Tue, 9 Jun 2015 09:39:50 -0400 (EDT)
Message-ID: <1569135212.13362835.1433857190455.JavaMail.zimbra@redhat.com>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv> <CAMc8nAWo-jnAHS5cLw5gDt57T3vZpiN79vFXc=pz=+Cjm6Ra6A@mail.gmail.com> <959572886.1627596.1433834901443.JavaMail.zimbra@oxygem.tv> <1897614581.1694878.1433838989184.JavaMail.zimbra@oxygem.tv> <5576CFBF.1070405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:50234 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbFINj4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 09:39:56 -0400
In-Reply-To: <5576CFBF.1070405@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, pushpesh sharma <pushpesh.eck@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

> In the past we've hit some performance issues with RBD cache that we've
> fixed, but we've never really tried pushing a single VM beyond 40+K read
> IOPS in testing (or at least I never have).  I suspect there's a couple
> of possibilities as to why it might be slower, but perhaps joshd can
> chime in as he's more familiar with what that code looks like.
> 

At high queue-depths and high IOPS, I would suspect that the bottleneck is the single, coarse-grained mutex protecting the cache data structures.  It's been a back burner item to refactor the current cache mutex into finer-grained locks.

Jason
