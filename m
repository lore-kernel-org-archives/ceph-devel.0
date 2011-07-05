From: Sage Weil <sage@newdream.net>
Subject: Re: ceph lock
Date: Tue, 5 Jul 2011 12:54:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107051254290.5150@cobra.newdream.net>
References: <CACR322iwXcEs6JwQtYaLb0KS7d-bY=kZo6eLvnToV0RaL4QGHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34478 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab1GETvx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 15:51:53 -0400
In-Reply-To: <CACR322iwXcEs6JwQtYaLb0KS7d-bY=kZo6eLvnToV0RaL4QGHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 6 Jul 2011, biyan chen wrote:
> HI everyone, I want to consult everybody ceph file system, whether to
> support the PHP flock ()?
> 
> If that is not like NFS flock () support?

flock() and fcntl() locks are support with the kernel client, but not yet 
with the fuse-based client.

sage
