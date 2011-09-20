From: Sage Weil <sage@newdream.net>
Subject: Re: [libvirt] specifying rbd images in libvirt
Date: Mon, 19 Sep 2011 21:13:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109192049580.27606@cobra.newdream.net>
References: <Pine.LNX.4.64.1108271207100.14206@cobra.newdream.net>
 <20110901124635.GD14462@redhat.com> <Pine.LNX.4.64.1109011321420.1621@cobra.newdream.net>
 <Pine.LNX.4.64.1109071635040.13143@cobra.newdream.net> <20110916102856.GJ4190@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36831 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab1ITENF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 00:13:05 -0400
In-Reply-To: <20110916102856.GJ4190@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Veillard <veillard@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, 16 Sep 2011, Daniel Veillard wrote:
> > I don't think there's anything controversial here.  I suspect the main 
> > concern is that these fields are named in a sufficiently general fashion 
> > so that they can be used for other backend storage types.
> 
>   I guess the best is to start with the patches with the XML changes as
> an RFC and then add the code to wire the backend as a second step. Even
> if both are likely to be applied as a batch, the XML code review is
> likely to be the most controversial :-)

The first two patches of the series I posted last week add the 
authentication bits to src/conf/.  I just updated to include changes to 
the schema files (docs/schemas) and am reposting.

Thanks!
sage


