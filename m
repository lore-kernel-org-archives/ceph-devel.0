From: Sage Weil <sweil@redhat.com>
Subject: Re: new OSD re-using old OSD id fails to boot
Date: Tue, 8 Dec 2015 18:50:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512081838240.25269@cobra.newdream.net>
References: <5663158D.1010302@dachary.org> <56678036.5050909@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbbLICuW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 21:50:22 -0500
In-Reply-To: <56678036.5050909@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 8 Dec 2015, David Zafman wrote:
> Remember I really think we want a disk replacement feature that would retain
> the OSD id so that it avoids unnecessary data movement.  See tracker
> http://tracker.ceph.com/issues/13732

Yeah, I totally agree.  We just need to form an opinion on how... probably 
starting with the user experience.  Ideally we'd go from up + in to down + 
in to down + out, then pull the drive and replace, and then initialize a 
new OSD with the same id... and journal partition.  Something like

  ceph-disk recreate id=N uuid=U <osd device path>

I.e., it could use the uuid (which the cluster has in the OSDMap) to find 
(and re-use) the journal device.

For a journal failure it'd probably be different.. but maybe not?

Any other ideas?

sage
