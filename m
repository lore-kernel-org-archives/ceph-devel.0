From: Sage Weil <sage@newdream.net>
Subject: dynamic types for ceph collectd plugin
Date: Thu, 10 Nov 2011 10:48:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111101042220.10729@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33539 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1KJSsk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2011 13:48:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: collectd@verplant.org
Cc: ceph-devel@vger.kernel.org

Hi,

We're working on a collectd plugin for Ceph (ceph.newdream.net) that 
sluprs up internal metrics and instrumentation values from running ceph 
daemons.  These are a range of random things like operation counts, types, 
latencies, and so on for various Ceph subsystems.  

We structured the plugin so that it queries the daemon for the types of 
the metrics it is gathering so that no modifications to types.db are 
necessary.  This is great because we are adding (and in some cases 
adjusting) the metrics we collect on an ongoing basis.  On the whole, it 
works great.

The problem is when we try to send the metrics to a server with the 
network plugin.  As far as I can tell the server needs to have all the 
types defined and isn't smart enough to take them from the client.  
That means that currently the metrics all get dropped on the floor.

Is it reasonable to just extend the network plugin protocol to also feed 
types to the server?  Is this something that is planned?  As things 
current stand, it seems like plugins that dynamically define their own 
types are basically useless in combination with the network plugin...

Or am I misunderstanding the situation?

Thanks!
sage

