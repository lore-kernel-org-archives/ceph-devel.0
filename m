From: Sage Weil <sage@inktank.com>
Subject: Re: Recovery from loss of monitors
Date: Thu, 7 Jun 2012 20:38:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206072034030.10292@cobra.newdream.net>
References: <CA+jddaPdk3=Q1W4vftRB+H9fLzSZxJJPGJRtKTephtmSDdWV+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39047 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab2FHDi0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 23:38:26 -0400
In-Reply-To: <CA+jddaPdk3=Q1W4vftRB+H9fLzSZxJJPGJRtKTephtmSDdWV+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

Hi Mandell,

On Thu, 7 Jun 2012, Mandell Degerness wrote:
> I am thinking about data reliability issues and I'd like to know if we
> can recover a cluster if we have most of the OSD data intact (i.e.
> there are enough copies of all of the PGs), but we have lost all of
> the monitor data.

All of the monitor data can be found elsewhere:

 - cluster fsid
 - current mon map
 - past osd maps
 - the osd secret keys

The mon secret key is only needed by the monitors, so a new one will do.

So yes, in principle, a monitor can be rebuilt.  However, it can only be 
done manually (and tediously) at the moment... there is no tool or process 
to do it easily.  Making it easy wouldn't be too difficult, if there was 
a real need.

However, given that you need a majority of the monitors online for the 
cluster to function, I would expect people to notice things are going 
wrong well before the last remaining monitor has a media failure.  This is 
really just a protection against a catastrophic event that took out many 
nodes, and in that case I wouldn't expect all PGs to survive either.  If 
they did, they were well distributed physically (or something), and the 
monitors should have been too...

sage
