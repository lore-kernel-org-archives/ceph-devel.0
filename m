From: Sage Weil <sage@redhat.com>
Subject: mgr dashboard and rest api configs
Date: Thu, 1 Jun 2017 20:23:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56045 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFAUXl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 16:23:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: branto@redhat.com

Hi all,

So we now have 2 services in mgr that present http[s] endpoints: the 
dashboard and the new 'restful' API.  Once 
https://github.com/ceph/ceph/pull/15405 is merged these will be set up by 
vstart.sh for each testing:

 $ MGR=2 ../src/vstart.sh -n -l ...
 ...
 started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for debug 
 output.

 dashboard urls:  http://127.0.0.1:41542/ http://127.0.0.1:41544/
 restful urls:    https://127.0.0.1:41543 https://127.0.0.1:41545
    user/pass:    admin / secret
 ...

The services are configured via the config-key interface:

gnit:build (wip-rest-test) 04:06 PM $ bin/ceph config-key list
[
    "mgr/x/dashboard/server_addr",
    "mgr/x/dashboard/server_port",
    "mgr/x/restful/cert",
    "mgr/x/restful/keys",
    "mgr/x/restful/pkey_file",
    "mgr/x/restful/server_addr",
    "mgr/x/restful/server_port",
    "mgr/y/dashboard/server_addr",
    "mgr/y/dashboard/server_port",
    "mgr/y/restful/cert",
    "mgr/y/restful/keys",
    "mgr/y/restful/pkey_file",
    "mgr/y/restful/server_addr",
    "mgr/y/restful/server_port"
]

Several comments, questions, as I think there's lots of room for 
improvement here:

- The dashboard is always http; the restful endpoint always https.  Should 
we make either/both of them support either?

- The crt and key for restful can either come from the 'cert' or 
'pkey' option, a file named by 'cert_file' or 'pkey_file', or read out of 
/etc/ceph.  The ceph-mgr package currently generates an unsigned cert and 
puts it in /etc/ceph for that purpose.  Should we instead make the restful 
service generate its own key and store it on startup if it is not stored 
on disk?  I'm not a big fan of putting this in /etc/ceph.

- What if you want the crt/key to be shared across mgr daemons?  This 
would make sense if you have a load balancer (or some network indirection 
like that provided by kubernetes) in front of it.  In that case, should we 
allow these options to come from, say, either mgr/$id/$module/$option or 
mgr/*/$module/$option?  Or restructure the namespace so that it's either 
mgr/$module/$option or mgr.$id/$module/$option (more like the config 
sections work where they are [mgr] or [mgr.$id])?  [1]

- s/cert/crt/ and s/pkey/key/?

Comments welcome!
sage


[1] How should config options appear in config-key?  The current proposal 
at http://pad.ceph.com/p/ceph-conf-kv-store suggests config/$type/option 
or config/$type.$id/option.  Where do mgr modules fit into this namespace?

   config/mgr/$module/$option
   config/mgr.x/$module/$option

Or should they maybe not live under the config/ prefix that the "regular" 
ceph options will live under? ?

