From: Sage Weil <sweil@redhat.com>
Subject: config on mons
Date: Fri, 10 Nov 2017 15:30:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750978AbdKJPan (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Nov 2017 10:30:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C00264E4CA
        for <ceph-devel@vger.kernel.org>; Fri, 10 Nov 2017 15:30:43 +0000 (UTC)
Received: from ovpn-112-2.rdu2.redhat.com (ovpn-112-2.rdu2.redhat.com [10.10.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 653CB619C6
        for <ceph-devel@vger.kernel.org>; Fri, 10 Nov 2017 15:30:43 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've started on this long-discussed feature!  I haven't gotten too far but 
you can see what's there so far at

	https://github.com/ceph/ceph/pull/18856

The first thing perhaps is to finalize what flexibility we want to 
support.  I've a quick summary at

	http://pad.ceph.com/p/config

Namely,

 config/option = value               # like [global]
 config/$type/option = value         # like [mon]
 config/$type.$id/option = value     # like [mon.a]

There are two new things:

 config/.../class:$classname/option = value

For OSDs, this matches the device_class.  So you can do something like

 config/osd/class:ssd/bluestore_cache_size = 10485760  # 10gb, woohoo!

You can also match the crush location:

 config/.../$crushtype:$crushvalue/option = value

e.g.,

 config/osd/rack:foo/debug_osd = 10    # hunting some issue

This obviously makes sense for OSDs.  We can also make it makes sense for 
non-OSDs since everybody (clients and daemons) has a concept of 
crush_location that is a set of key/value pairs like "host=foo rack=bar" 
which match the CRUSH hierarchy.  In this case, my plan is to make the 
initial mon authentication step include the hostname of the host you're 
connecting from and then extract the rest of the location by lookup 
up the host in the CRUSH map.

The precedence for these is described here:

	https://github.com/ceph/ceph/pull/18856/commits/5abbd0c9e279022f185787238d21eabbbe28e336#diff-344645b5339d494e1839ff1fcaa5cb7dR15


Lots of other thorny issues to consider.  For example:

- What about monitor configs?  If they store their config paxos, and you 
set an option that breaks paxos, how can you change/fix it?  For the 
moment I'm just ignoring the mons.

- What about ceph.conf?  My thought here is to mark which options are 
legal for bootstrap (i.e., used during the initial connection to mon to 
authenticate and fetch config), and warn on anything other than that in 
ceph.conf.  But what about after you connect?  Do these options get reset 
to default?

- Bootstrapping/upgrade: So far my best idea is to make the client share 
it's config with the mon on startup, and the first time a given daemon 
connects the mon will use that to populate it's config database.  
Thereafter it will be ignored.

- OSD startup: lots of stuff happens before we authenticate.  I think 
there will be a new initial step to fetch config, then do all that work, 
then start up for real.  And a new option to bypass mon configuration 
to avoid that (and for old school folks who don't want centralized 
configs... e.g. mon_config = false and everything works as before).

Feedback welcome!
sage
