From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: global_init fails when only specifying monitor address
Date: Tue, 1 May 2012 09:36:40 -0700
Message-ID: <AB9F708F613F43F1BF61BAA850F61A06@dreamhost.com>
References: <4F994883.3060805@widodh.nl>
 <Pine.LNX.4.64.1204260932260.6109@cobra.newdream.net>
 <CA+qbEUMucp8tpF_ofTrinvE1e7Krue1gT164H04UQOkDueYuqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39100 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2EAQgo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 May 2012 12:36:44 -0400
Received: by obbtb18 with SMTP id tb18so1017478obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 May 2012 09:36:44 -0700 (PDT)
In-Reply-To: <CA+qbEUMucp8tpF_ofTrinvE1e7Krue1gT164H04UQOkDueYuqQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

What we ended up merging into master is a change so that if you don't specify a configuration file, you'll get a small warning printed out but the program will continue executing. We may remove the warning in future, but right now we thought it was important to leave in since using the default parameters can result in some truly bizarre error messages if they don't match what the rest of the system is using. 
-Greg


On Saturday, April 28, 2012 at 6:10 PM, Colin McCabe wrote:

> There's no technical reason why you can't simply remove these lines:
> 
> > if (ret == -EDOM) {
> > dout_emergency("global_init: error parsing config file.\n");
> > _exit(1);
> > }
> 
> 
> 
> Without a configuration file, you'll just get the defaults for
> everything. Wido, it sounds like that is what you're already doing by
> passing in "-c /dev/null"
> 
> So why didn't we do that in the first place? It was basically a
> philosophical reason. We have a section in the configuration file for
> clients. If clients don't use that section, then it would seem kind
> of pointless to have it. If I were a system administrator, I might be
> annoyed by accidentally failing to set CEPH_CONF in my .bashrc, and
> getting a bunch of defaults flooding in when I ran /usr/bin/ceph (or
> some other tool).
> 
> With that being said, there is a case to be made that we should let
> people run without a configuration file if they so desire. Most UNIX
> utilities will run with out without a configuration file, so maybe
> that's what cephtool and similar utilities should do. Your call.
> 
> 
> Unrelated:
> It might be a good time to get rid of that chunk of code in
> md_config_t::parse_config_files_impl that does "Warn about section
> names that look like old-style section names." It's been a while
> since that actually mattered, I believe.
> 
> Colin
> 
> 
> On Thu, Apr 26, 2012 at 9:33 AM, Sage Weil <sage@newdream.net (mailto:sage@newdream.net)> wrote:
> > On Thu, 26 Apr 2012, Wido den Hollander wrote:
> > > Hi,
> > > 
> > > I tried to connect to a small Ceph setup on my desktop without cephx and that
> > > failed:
> > > 
> > > root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 (http://wido-desktop.widodh.nl:6789) -s
> > > global_init: unable to open config file.
> > > root@stack01:~#
> > > 
> > > I however worked with:
> > > 
> > > root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 (http://wido-desktop.widodh.nl:6789) -c /dev/null -s
> > > 2012-04-26 14:55:33.828524 pg v148: 594 pgs: 594 active+clean; 0 bytes
> > > data, 7740 KB used, 70571 MB / 76800 MB avail
> > > 2012-04-26 14:55:33.829622 mds e1: 0/0/1 up
> > > 2012-04-26 14:55:33.836144 osd e14: 3 osds: 3 up, 3 in
> > > 2012-04-26 14:55:33.886429 log 2012-04-26 14:52:50.674430 osd.1
> > > [2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6807/28366 12 : [INF] 1.2b scrub ok
> > > 2012-04-26 14:55:33.892423 mon e1: 1 mons at
> > > {desktop=[2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6789/0}
> > > root@stack01:~#
> > > 
> > > I quick look at global_init.cc (http://global_init.cc) showed me why this happened, it simply looks
> > > for a configuration file to open and when it can't it fails.
> > > 
> > > But if a monitor address is set, a config file shouldn't be mandatory.
> > > 
> > > It could be accomplished rather simple by setting the flag
> > > CINIT_FLAG_NO_DEFAULT_CONFIG_FILE if a mon_host has been set, but to do that
> > > conf->parse_argv(args); should move a few lines up.
> > > 
> > > Comments? Thoughts?
> > 
> > I wonder if the simplest thing to do is:
> > 
> > - never error out on missing config in the default search path
> > - always error out on missing config if it was explicitly specified via
> > -c foo or CEPH_CONF in environment.
> > 
> > ?
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



