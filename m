From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] debian: create standalone client-tools package for
 mount.ceph
Date: Fri, 30 Jul 2010 09:25:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007300923440.28085@cobra.newdream.net>
References: <1280476219-16538-1-git-send-email-thomas@chaschperli.ch>
 <i2u1jf$hnt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49412 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab0G3QWp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 12:22:45 -0400
In-Reply-To: <i2u1jf$hnt$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Fri, 30 Jul 2010, Thomas Mueller wrote:
> Am Fri, 30 Jul 2010 09:50:19 +0200 schrieb Thomas Mueller:
> 
> > on a client the server-side is IMHO not needed. Move the mount util to a
> > dedicated package.
> 
> ... and maybe move the rbd util also to client-tools?

The 'rados' and 'csyn' tools also fall into the user-level client 
category.  Maybe if ceph recommends ceph-client-tools?

sage
