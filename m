From: Sage Weil <sweil@redhat.com>
Subject: Re: Ceph OSD getting their config from kv store (ETCD or ceph-mon)
Date: Tue, 3 May 2016 08:45:21 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605030834130.26967@cpach.fuggernut.com>
References: <CA+HUO7JP4vYJtDtE=qBVCkBwFXJEwdTM1Y-GJhuqbwWeo9HVAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932687AbcECMpN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 08:45:13 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E4CA15555
	for <ceph-devel@vger.kernel.org>; Tue,  3 May 2016 12:45:13 +0000 (UTC)
In-Reply-To: <CA+HUO7JP4vYJtDtE=qBVCkBwFXJEwdTM1Y-GJhuqbwWeo9HVAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <shan@redhat.com>
Cc: Kyle Bader <kbader@redhat.com>, ceph-devel@vger.kernel.org

[Adding ceph-devel]

On Tue, 3 May 2016, Sebastien Han wrote:
> Hi Sage,
> 
> While discussing with Kyle last week, we re-iterated the idea of
> having OSDs getting their configuration from a KV store like ETCD or
> ceph-mons.
> This is exactly what we discussed a couple fo weeks ago :).
> This is in the context of running OSD on Atomic sitting on an Ethernet
> drive. Since those drives don't have much ressources, it'll be nice to
> use Atomic as the OS since it is really lightweight.
> 
> The general idea would be to deploy those containers on Atomic by
> passing the URL of the kv store and then running OSD like this:
> 
> exec /usr/bin/ceph-osd --cluster ceph --kv-store <address>:<port> -f
> -d -i <id> --setuser ceph --setgroup disk
> 
> In order to contact the mon we have several options:
> 
> 1. create a minimal ceph.conf with the mons address (not ideal)
> 2. use "-m <mon-ip>:<port>" to run the OSD
> 3. simply search for "mon_initial_members" in the kv, then connect to the mon
> 
> I just wanted to know if you had any prototype for this one.
> It is not a urgent task but I wanted to know how far we are from this
> and how difficult will it be.

We talked about this a bit in Raleigh and the thinking was that we weren't 
convinced it made sense to add another external dependency that was also a 
distributed reliable cluster service.  Using etcd would be convenient if 
you already had it deployed for some other reason, but we wouldn't want to 
deploy it just for ceph.

The alternative proposal was to use the existing mon config-key service, 
or something based on it.  e.g.,

# config/ for global stuff
  config/global/foo = bar
# config/osd/ for osd stuff
  config/osd/debug_osd = 20
  config/osd/debug_ms = 1
  config/osd.123/debug_filestore = 20

or whatever.  That way you could do something like

 ceph config-key set config/osd.44/debug_foo 20

to set an option, and 

 ceph config-key list config/

to get a dump of all keys with a config/ prefix and see the whole cluster 
config in one go.

What this *doesn't* give you is the ability to put comments in there 
explaining why settings are set the way they are.  I'm not sure if that 
matters or not.

An alternative would be to dump entire configs in the value.  That lets 
you put comments (or whatever), but loses the uniform structure.

In any case, practically speaking, to get the mon approach to work we need 
to give the daemon enough to do the initial mon connection (mon host and 
an auth key) so that it can fetch its config.

We'd probably also want daemons to subscribe to config changes so they get 
them immediately.  Or come up with some other strategy for how options we 
set on the mon propagate to daemons.  (There are several different options 
that might make sense.  For example, you might want to set refresh options 
on a subset of the cluster (e.g., by host or rack) without having to 
identify osds individually.  That could be done by telling daemons to 
refresh manually, or by allowing the config-key values to apply to 
different slices of the cluster.)

After that, we'd also need to make sure we have config observers for 
everything so that the options can be set post-startup.  This would 
actually be a huge project.  It might instead make sense to do an initial 
MonClient session to bootstrap that fetchs config values, sets them, and 
then restarts fresh with those config options in place.

sage
