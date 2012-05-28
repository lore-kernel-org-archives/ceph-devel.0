From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: OSD per disk.
Date: Mon, 28 May 2012 14:56:54 +0100
Message-ID: <1338213414.9733.1.camel@squire.doc.ic.ac.uk>
References: <loom.20120528T080903-621@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.cc.ic.ac.uk ([155.198.5.155]:59742 "EHLO
	smtp1.cc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2E1O31 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 May 2012 10:29:27 -0400
In-Reply-To: <loom.20120528T080903-621@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chandrashekhar <chandubigc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 2012-05-28 at 06:19 +0000, chandrashekhar wrote:

>       I want to setup a ceph cluster with 4 osds ( one OSD per disk), 2 mons, 1
> mds. Please help me to configure this.

You almost certainly do not want to have 2 MON nodes in your cluster; an
odd number of nodes is strongly recommended.

(Reason: a strict majority of MON odes must be up and functional to
maintain quorum; increasing the number of MONs from 1 to 2 makes
failures more likely but does not increase resiliency.)

Cheers,
David
-- 
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

