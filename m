From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] daemons: write pid file even when told not to
 daemonize
Date: Tue, 9 Sep 2014 15:54:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409091553030.11887@cobra.newdream.net>
References: <or4mxyuvo4.fsf@free.home> <alpine.DEB.2.00.1409091520440.11887@cobra.newdream.net> <540F83C8.7080809@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36665 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbaIIWyM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 18:54:12 -0400
In-Reply-To: <540F83C8.7080809@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Alexandre Oliva <oliva@gnu.org>, ceph-devel@vger.kernel.org

On Wed, 10 Sep 2014, Loic Dachary wrote:
> The only reason I can think of is that it requires write permission to a 
> directory that was previously not used. I think it will break a few unit 
> tests but nothing we can't fix.

Let's go for it then and clean up whatever breaks.  We may want to change 
the default value for pid_file for some contexts, but I agree with 
Alexandre that that will be a better situation that the funny -f/-d 
side-effect we have now!

sage

> 
> On 10/09/2014 00:21, Sage Weil wrote:
> > I'm inlined to just apply this original patch.  Is there any reason *not* 
> > to create a pid file when -f is used?  It's a change from previous 
> > behavior, but is there any possible harm that can come of it?
> > 
> > sage
> > 
> > 
> > On Wed, 30 Jul 2014, Alexandre Oliva wrote:
> > 
> >> systemd wants to run daemons in foreground, but daemons wouldn't write
> >> out the pid file with -f.  Fixed.
> >>
> >> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> >> ---
> >>  src/ceph_mon.cc           |    3 +--
> >>  src/common/config.cc      |    2 --
> >>  src/global/global_init.cc |   10 +++++++++-
> >>  3 files changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
> >> index 4e84b4d..14dd6da 100644
> >> --- a/src/ceph_mon.cc
> >> +++ b/src/ceph_mon.cc
> >> @@ -406,8 +406,7 @@ int main(int argc, const char **argv)
> >>    // screwing us over
> >>    Preforker prefork;
> >>    if (!(flags & CINIT_FLAG_NO_DAEMON_ACTIONS)) {
> >> -    if (g_conf->daemonize) {
> >> -      global_init_prefork(g_ceph_context, 0);
> >> +    if (global_init_prefork(g_ceph_context, 0) >= 0) {
> >>        prefork.prefork();
> >>        if (prefork.is_parent()) {
> >>  	return prefork.parent_wait();
> >> diff --git a/src/common/config.cc b/src/common/config.cc
> >> index 0ee7f58..4e3b6fe 100644
> >> --- a/src/common/config.cc
> >> +++ b/src/common/config.cc
> >> @@ -389,12 +389,10 @@ int md_config_t::parse_argv(std::vector<const char*>& args)
> >>      }
> >>      else if (ceph_argparse_flag(args, i, "--foreground", "-f", (char*)NULL)) {
> >>        set_val_or_die("daemonize", "false");
> >> -      set_val_or_die("pid_file", "");
> >>      }
> >>      else if (ceph_argparse_flag(args, i, "-d", (char*)NULL)) {
> >>        set_val_or_die("daemonize", "false");
> >>        set_val_or_die("log_file", "");
> >> -      set_val_or_die("pid_file", "");
> >>        set_val_or_die("log_to_stderr", "true");
> >>        set_val_or_die("err_to_stderr", "true");
> >>        set_val_or_die("log_to_syslog", "false");
> >> diff --git a/src/global/global_init.cc b/src/global/global_init.cc
> >> index 7b20343..f03677c 100644
> >> --- a/src/global/global_init.cc
> >> +++ b/src/global/global_init.cc
> >> @@ -166,8 +166,16 @@ int global_init_prefork(CephContext *cct, int flags)
> >>    if (g_code_env != CODE_ENVIRONMENT_DAEMON)
> >>      return -1;
> >>    const md_config_t *conf = cct->_conf;
> >> -  if (!conf->daemonize)
> >> +  if (!conf->daemonize) {
> >> +    if (atexit(pidfile_remove_void)) {
> >> +      derr << "global_init_daemonize: failed to set pidfile_remove function "
> >> +	   << "to run at exit." << dendl;
> >> +    }
> >> +
> >> +    pidfile_write(g_conf);
> >> +
> >>      return -1;
> >> +  }
> >>  
> >>    // stop log thread
> >>    g_ceph_context->_log->flush();
> >>
> >> -- 
> >> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> >> You must be the change you wish to see in the world. -- Gandhi
> >> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> >> Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
