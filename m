From: Sage Weil <sage@newdream.net>
Subject: Re: libgtkmm Dependency
Date: Mon, 13 Jun 2011 09:25:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106130924210.27640@cobra.newdream.net>
References: <151A9CB0-0426-4C8E-A55E-B122B5ECF9C2@Vanderbilt.Edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51620 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1FMQWy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 12:22:54 -0400
In-Reply-To: <151A9CB0-0426-4C8E-A55E-B122B5ECF9C2@Vanderbilt.Edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Hemingway, Graham Stuart" <graham.hemingway@Vanderbilt.Edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 13 Jun 2011, Hemingway, Graham Stuart wrote:
> Hello,
> 
> I am trying to install Ceph onto a cluster of Ubuntu 10.04 servers, but 
> apt-get is showing a requirement to install libgtkmm (plus its numerous 
> dependencies).  Are the server-side components of Ceph really dependent 
> on gtk?  Is there any way to get Ceph without having to install gtk and 
> its dependencies?

This was just fixed in the master branch (gceph, a simple gui tool, is 
separated into a different package).  It'll be in v0.30.

sage
