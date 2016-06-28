From: Sage Weil <sage@newdream.net>
Subject: Re: prefered behavior for injecting untracked args
Date: Tue, 28 Jun 2016 15:38:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606281533160.8816@piezo.us.to>
References: <CAEYCsVJz9b8fDdEz8V7iraoq6t6wtY8ddt4XqBnxEVmvAcLnfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33416 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcF1Pim (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 11:38:42 -0400
In-Reply-To: <CAEYCsVJz9b8fDdEz8V7iraoq6t6wtY8ddt4XqBnxEVmvAcLnfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 28 Jun 2016, Xiaoxi Chen wrote:
> Hi,
> 
>    In jewel , when handling "inject-args" command, monitor will report
> "unchangeable" for those non-tracking args, nevertheless, the config
> is still updated. as "ceph daemon config show " will give out the new
> value.
> 
>      It looks to me like if the configuration is not dynamically
> changeable, we may better NOT to update the config? as the config set
> by injectargs is not persist to disk , so before reboot the daemon,
> config will not take effect, after reboot the daemon, config will
> lost...it doesnt work(i.e make the config change) anyway.
> 
>     We notice this because we had an accident on our network switch so
> lots of the OSD down and out, and we would intent to speed up the
> recovery, then we inject "osd_recovery_max_active= 10" and got
> "unchangeable", but in admin socket we can see this configuration so
> we assume it is working but actually not. My point is the non-tracking
> args showing in admin socket config dump is really misleading, other
> guys will never know whether the args in config dump is make effect if
> they don't know how this is set, via admin socket or via configuration
> files.
> 
>     Kefu and I had some discussion on the original PR and would like to 
> here more opinions, See pr for more background: 
> https://github.com/ceph/ceph/pull/7085.

We desperately need to overhaul the way that config options are described 
and updated.  Right now we are cheating by letting any integer option be 
changed, regardless of whether an observer is defined, and no string 
options to be changed without an observer.  (This is the minimum necessary 
to make config updates thread safe.)

I think we need to extend the config_opts.h definitions of config options 
to include things like accepted values (for enums), and annotations 
indicating whether online updates are possible.  This *could* be implied 
by the presence of observers, but in practice most of the options are used 
directly out of g_conf and don't have observers defined...that would be 
a bigger changes. Just setting a flag in the config options would be a 
start.

We've discussed this a few times in the past and there is probably an 
etherpad sitting around somewhere from an old CDS...

As to your specific question(s),

1- injectargs is never going to persis anything.  but we're looking at the 
ability to define config options for the cluster via the mon, that that 
would be persisted.

2- making message you see accurate would be good.

3- we may want to revise the observer framework a bit so that a set option 
can be rejected.  Right now the internal interface doesn't allow this.

sage
