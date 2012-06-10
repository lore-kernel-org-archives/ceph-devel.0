From: Sage Weil <sage@inktank.com>
Subject: please review wip-keyrings
Date: Sat, 9 Jun 2012 20:44:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206092039440.11295@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38263 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab2FJDoz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Jun 2012 23:44:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@inktank.com
Cc: ceph-devel@vger.kernel.org

Can you take a look at wip-keyrings?

 - generic config variable substitution, letting you put $any_config_var 
   in any other config var (as opposed to the handful of magic 
   metavariables supported now).  unit tests to go with it.
 - new 'mds data' and 'rgw data' config options, with defaults to 
   /var/lib/ceph/mds or radosgw/$cluster-$id 
 - default keyring locations for osd, mds, rgw are $whatever_data/keyring

Right now these daemons don't have much in the way of local files except 
their keyrings, but eventaully may have more.  Maybe rgw socket location 
could default to that directory.  Maybe the MDS could stick something else 
there.. who knows.

Anyway, this should get us closer to avoiding the need for any keyring 
definitions in the configs, without breaking existing config files that 
*do* specify those locations.

sage
