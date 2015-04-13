From: Sage Weil <sage@newdream.net>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 09:49:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504130948570.4469@cobra.newdream.net>
References: <552BF349.50909@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36284 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbbDMQtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 12:49:53 -0400
In-Reply-To: <552BF349.50909@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 13 Apr 2015, Ken Dreyer wrote:
> A while ago this came up in #ceph-devel and I wanted to bring it to a
> wider audience.
> 
> Should we stop the convention of adding the "backport: " tags in Git?
> 
> Loic brought up the point that this data is essentially immutable after
> we merge it, and it's better to point at a Redmine tracker where we can
> alter the "backport" field.
> 
> This makes it easier to adjust the "backport" data after the code's been
> merged to master. It also makes it easier for whoever is corralling the
> backport efforts, because the person only have one place to look
> (Redmine) instead of two (Redmine + git commit logs).
> 
> For what it's worth I agree with Loic on this.

Yeah, this sounds better to me!

sage
