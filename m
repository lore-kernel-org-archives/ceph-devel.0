From: Sage Weil <sage@inktank.com>
Subject: Re: Add Metavariable $imagename
Date: Wed, 4 Sep 2013 09:22:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309040919200.1073@cobra.newdream.net>
References: <522747D0.6050906@cloudapt.com> <52274CA1.2040801@inktank.com> <522755F1.2000406@cloudapt.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46394 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab3IDQW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Sep 2013 12:22:59 -0400
In-Reply-To: <522755F1.2000406@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, josh.durgin@inktank.com

Hi Mike,

On Wed, 4 Sep 2013, Mike Dawson wrote:
> Thanks for the feature request Mark!
> 
> To illustrate where my understanding ends, here is a patch to stub in this
> functionality:
> 
> From 137ebc2d5326ca710a5e99e2899fd851b02c10f7 Mon Sep 17 00:00:00 2001
> From: Mike Dawson <mdawson@gammacode.com>
> Date: Wed, 4 Sep 2013 11:39:05 -0400
> Subject: [PATCH] Update config.cc
> 
> ---
>  src/common/config.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/common/config.cc b/src/common/config.cc
> index 5c64f4e..89ac0ee 100644
> --- a/src/common/config.cc
> +++ b/src/common/config.cc
> @@ -929,7 +929,7 @@ int md_config_t::set_val_raw(const char *val, const
> config_option *opt)
>  }
> 
>  static const char *CONF_METAVARIABLES[] =
> -  { "cluster", "type", "name", "host", "num", "id", "pid" };
> +  { "cluster", "type", "name", "host", "num", "id", "pid", "image-name" };
>  static const int NUM_CONF_METAVARIABLES =
>        (sizeof(CONF_METAVARIABLES) / sizeof(CONF_METAVARIABLES[0]));
> 
> @@ -1007,6 +1007,8 @@ bool md_config_t::expand_meta(std::string &origval)
> const
>  	  out += name.get_id().c_str();
>  	else if (var == "pid")
>  	  out += stringify(getpid());
> +	else if (var == "image-name")
> +	  out += "TBD"
>  	else
>  	  assert(0); // unreachable
>  	found_meta = true;
> -- 
> 1.8.4
> 
> 
> Obviously, the I'm stuck at "TBD". I'll finish it if someone could point me in
> the right direction.

The challenge here is that the image name is currently parsed by things 
like rbd.cc or not at all.  And more significantly, a single librbd 
instance can map any number of images, but the config context has only one 
'image-name' slot and log.

An alternative approach would be to stick some other unique identification 
of the librbd 'instance'.  It would be gibberish but would give you 
different instances of the asok file (and/or logs).

Or, since qemu is the one creating one librbd instance per mapped image, 
it could explicitly set the log file and admin socket to something 
appropriate.  I think that in general having these enabled by default is a 
good thing (especially the admin socket).

Josh, what do you think?

sage

> 
> Thanks,
> 
> Mike Dawson
> Co-Founder & Director of Cloud Architecture
> Cloudapt LLC
> 6330 East 75th Street, Suite 170
> Indianapolis, IN 46250
> 
> On 9/4/2013 11:07 AM, Mark Nelson wrote:
> > On 09/04/2013 09:46 AM, Mike Dawson wrote:
> > > There are currently a few metavariables available for use in ceph.conf:
> > > http://ceph.com/docs/master/rados/configuration/ceph-conf/#metavariables
> > > 
> > > In addition to those listed in that document, $pid was added in Bobtail.
> > > That allows me to get RBD admin sockets for libvirt/qemu guests by
> > > specifying
> > > 
> > > [client]
> > >      admin socket = /var/run/ceph/rbd-$pid.asok
> > > 
> > > in /etc/ceph/ceph.conf. That works well for VMs with a single volume,
> > > but it does not work for VMs with multiple volumes. With multiple
> > > volumes, the admin only lists data on the last volume specified, leaving
> > > me unable to monitor stats on any volumes other than the last.
> > > 
> > > I imagine you could specify a unique admin socket for each volume on the
> > > command-line that libvirt uses to spawn qemu, but that seems like a pain.
> > > 
> > > Is it possible instead to add a metavariable that would expand to the
> > > image name? This way, my ceph.conf would look like
> > > 
> > > 
> > > [client]
> > >      admin socket = /var/run/ceph/$imagename.asok
> > > 
> > > and I would end up with admin sockets like:
> > > 
> > > /var/run/ceph/rbd-volume-0025b693-6230-443e-ad6a-3aa43efdd648.asok
> > > /var/run/ceph/rbd-volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6.asok
> > > 
> > > # rbd -p volumes ls
> > > volume-0025b693-6230-443e-ad6a-3aa43efdd648
> > > volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6
> > > 
> > > I'd be happy to provide a patch if someone could give me sufficient
> > > guidance on how/where to add this functionality.
> > > 
> > 
> > Created a feature request in the tracker for this:
> > 
> > http://tracker.ceph.com/issues/6228
> > 
> > Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
