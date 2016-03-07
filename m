From: Sage Weil <sage@newdream.net>
Subject: Re: systemd and ceph.conf and environment variables. (particularly
 mds and rgw)
Date: Mon, 7 Mar 2016 06:47:31 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603070641150.25897@cpach.fuggernut.com>
References: <56DD5B26.30902@suse.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1906707565-1457351254=:25897"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43799 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcCGLry (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 06:47:54 -0500
In-Reply-To: <56DD5B26.30902@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1906707565-1457351254=:25897
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Mar 2016, Owen Synge wrote:
> Dear all,
> 
> I have a simple idea that I think would be beneficial for ceph's
> services. I would be curious to hear others opinions.
> 
> At the moment the only way (I know) to configure specific entities in
> ceph such as a specific port for a mds or rgw is via ${CLUSTERNAME}.conf
> which is usually set to ceph.conf. For brevity I will call this file
> ceph.conf.

In jewel there is a new path added to the config search path: 
/var/lib/ceph/$type/$cluster-$id/config.  This is checked before 
/etc/ceph/$cluster.conf, which means that you have to put *all* config 
values in the new location if you use it, but it might capture your 
use-case?

If you need both config paths to work, one idea is to add 'include <path>' 
support to the conf parser... hoping to avoid making things more 
complicated if we don't have a strong reason for it, though!

> The current setup leads to complexities as ideally I want all ceph.conf
> files to be identical across a cluster, and at the same time, I want to
> add services such as rgw or mds without changing ceph.conf. I also want
> to template a ceph.conf cluster.
> 
> If we could always get these settings via environment variables, it
> would make setting up ceph with tools such as cluster/config management
> tools such as puppet, chef, and salt easier.
> 
> So here is the diff of the systemd service files I am thinking of:
> 
> # diff -u  ceph-mds@.service /tmp/ceph-mds@.service
> --- ceph-mds@.service   2016-03-01 20:48:05.000000000 -0500
> +++ /tmp/ceph-mds@.service      2016-03-07 05:14:43.392000000 -0500
> @@ -8,8 +8,8 @@
>  LimitNOFILE=1048576
>  LimitNPROC=1048576
>  EnvironmentFile=-/etc/sysconfig/ceph
> -Environment=CLUSTER=ceph
> -ExecStart=/usr/bin/ceph-mds -f --cluster ${CLUSTER} --id %i --setuser
> ceph --setgroup ceph
> +EnvironmentFile=-/var/lib/ceph/env/mds/%i
> +ExecStart=/usr/bin/ceph-mds -f --cluster ${CLUSTER} --id %i --setuser
> ceph --setgroup ceph -m ${BIND_IPV4}:${BIND_PORT}
>  ExecReload=/bin/kill -HUP $MAINPID
>  PrivateDevices=yes
>  ProtectHome=true
> 
> First you should note the extra EnvironmentFile line:
> 
> EnvironmentFile=-/var/lib/ceph/mds/systemd/%i
> 
> This means that if the mds service is started with parameter "param_one"
> then the environment will be set with the content of
> 
>     /var/lib/ceph/env/mds/param_one
> 
> The "-" means don’t error if the above file does not exist.
> 
> Hence we could add service instance variables such as ${BIND_IPV4} and
> ${BIND_PORT} as well as important values like ${CLUSTER} to values like
> ceph.
> 
> Having played with systemd, it seems that environment variables are
> updated by the last assignment in systemd just like shell.
> 
> I have *not* found a good way to put in conditionals in such systemd
> "EnvironmentFile" content. Hence it would be impossible to nicely
> default command line parameters without using dirty tricks. Specifically
> what we cant do in the systemd "EnvironmentFile" context:
> 
> 	if [ X"${BIND_IPV4}${BIND_PORT}" != X ] ; then
> 	EXTRA_ARGS="-m ${BIND_IPV4}:${BIND_PORT}"
> 	fi
> 
> Hence I think we have to accept to integrate with systemd nicely we
> should allow setting to be read from environment rather than only from
> the command line.
> 
> What do people think?

I would probably make it '/var/lib/ceph/$type/$cluster-$id/env'.

You're sure systemd lets you specify multiple environment files?  We 
can't/shouldn't stop looking at the standard location...

sage
--8323329-1906707565-1457351254=:25897--
