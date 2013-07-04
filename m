From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Wed, 3 Jul 2013 17:03:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307031702530.3375@cobra.newdream.net>
References: <CANP1eJFQgoLBjZ7-vCTzRb62H2P6hX5ZD8u2XyMQAjwZtFJDJQ@mail.gmail.com> <20130629035155.GA7975@gmail.com> <CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com> <CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com>
 <11954.1372792498@warthog.procyon.org.uk> <CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com> <12577.1372793962@warthog.procyon.org.uk> <CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com> <1074.1372798161@warthog.procyon.org.uk>
 <CANP1eJH9PU3wX8m9auNjHrRt=rQWKCMmnFjfQ+V4tSG7mBBoEg@mail.gmail.com> <3869.1372808417@warthog.procyon.org.uk> <27575.1372895551@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39658 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab3GDADh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 20:03:37 -0400
In-Reply-To: <27575.1372895551@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, ceph-devel@vger.kernel.org, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

On Thu, 4 Jul 2013, David Howells wrote:
> Milosz Tanski <milosz@adfin.com> wrote:
> 
> > > Looking at your index structure, ceph has per-fsid indices under the top
> > > "ceph" index and then per-inode indices under those?  Are fsids universally
> > > unique - or just for a given server/cell/whatever?
> > 
> > It's my understanding that's a guuid assigned to the cluster.
> 
> What's the likelyhood of two clusters throwing up the same guuid?

1 in 2^128.  The uuid comes from /dev/random, courtesy of uuidgen.

sage
