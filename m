From: Sage Weil <sage@newdream.net>
Subject: ceph-mgr setup magic
Date: Wed, 28 Jun 2017 19:04:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706281857110.8533@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59134 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdF1TEs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 15:04:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: tserong@suse.com, jspray@redhat.com

There is some goofy behavior with the systemd unit files that tries to 
make a new ceph-mgr daemon automagically appear next to the mons during a 
cluster upgrade:

- The ceph-mon@.service triggers ceph-mgr@ to start
- The ceph-mgr@.service tries to create a ceph-mgr key using whatever 
mon key it can find

This was intended to ease the upgrade path by auto-creating ceph-mgr 
daemons along the way.

Do we really want this?  I was reminded this behavior is here because of 
#19994, which points out that this isn't implemented for upstart (still 
used by trusty 14.04).

The jewel -> luminous upgrade process is currently documented here

	http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken

and basically has a step that says 'verify mgr daemons are running and, if 
not, create some'.  Is that sufficient?

sage
