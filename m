From: Sage Weil <sage@newdream.net>
Subject: Re: logfile created with root:root ownership when "log_file" config
 option specified
Date: Fri, 5 Feb 2016 21:02:58 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602052051140.28396@cpach.fuggernut.com>
References: <20160203231727.GA18601@oak.lan> <20160206004652.GA29769@oak.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56850 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbcBFCCm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 21:02:42 -0500
In-Reply-To: <20160206004652.GA29769@oak.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Mroz <kmroz@suse.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Feb 2016, Karol Mroz wrote:
> On Wed, Feb 03, 2016 at 03:17:27PM -0800, Karol Mroz wrote:
> [...]
> > From a quick glance, removing changed.count("log_file"...) from
> > LogObs::handle_conf_changes() would skip over the early logfile creation in this observer.
> > A more invasive option would be to remove conf->apply_changes() from global_pre_init(),
> > thus delaying running the observers for the first time until after the permissions drop.
> > However, I suspect there may be valid reason why conf->apply_changes() is needed in
> > global_pre_init()? As I'm not familiar with the nuances here, a comment from someone more
> > familiar with this would be appreciated.
> 
> Removing the changed.count("log_file") section in LogObs::handle_conf_changes() I think would kill
> the possibility of changing the logfile via injectargs. I'd say that's a no-go.
> 
> The more I look at it, the more I think running conf->handle_changes(NULL) from global_pre_init()
> is not needed. Upon returning to global_init(), we invoke g_conf->call_all_observers() which does
> meta variable expansion and runs _all_ observers. This should be enough... or am I oversimplifying
> things? :D

That sounds like the right thing to me.  These are dark and crufty parts 
of the code, though, so we'll have to make the change and see what 
breaks..

There are only 2 global_pre_init callers: global_init (the next method 
down), and ceph-conf.  Presumably this was split to make ceph-conf happy.  
So this is primarily a matter of looking through global_init to make sure 
nothing depends on metavariable expansion.  The only thing htat catches my 
eye is g_conf->run_dir.  We can probably move that below 
call_all_observers?  Or, put the apply_changes just after we drop 
privileges.

Take a look at

	https://github.com/ceph/ceph/pull/7545

I think this does the trick, and passes my quick smoke test...

sage
