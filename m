From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Thu, 04 Jul 2013 00:52:31 +0100
Message-ID: <27575.1372895551@warthog.procyon.org.uk>
References: <CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com> <20130629035155.GA7975@gmail.com> <CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com> <CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com> <11954.1372792498@warthog.procyon.org.uk> <CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com> <12577.1372793962@warthog.procyon.org.uk> <CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com> <1074.1372798161@warthog.procyon.org.uk> <CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com> <3869.1372808417@warthog.procyon.org.uk>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123Ab3GCXwj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Jul 2013 19:52:39 -0400
In-Reply-To: <CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

Milosz Tanski <milosz@adfin.com> wrote:

> > Looking at your index structure, ceph has per-fsid indices under the top
> > "ceph" index and then per-inode indices under those?  Are fsids universally
> > unique - or just for a given server/cell/whatever?
> 
> It's my understanding that's a guuid assigned to the cluster.

What's the likelyhood of two clusters throwing up the same guuid?

David
