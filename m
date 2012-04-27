From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: global_init fails when only specifying monitor address
Date: Fri, 27 Apr 2012 15:53:07 -0700
Message-ID: <C6BC88030EB84991B22AB940ABFE912E@dreamhost.com>
References: <4F994883.3060805@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42895 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab2D0WxK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Apr 2012 18:53:10 -0400
Received: by obbta14 with SMTP id ta14so1653357obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 Apr 2012 15:53:10 -0700 (PDT)
In-Reply-To: <4F994883.3060805@widodh.nl>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, April 26, 2012 at 6:07 AM, Wido den Hollander wrote:
> Hi,
> =20
> I tried to connect to a small Ceph setup on my desktop without cephx =
and =20
> that failed:
> =20
> root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 (http://wido-desk=
top.widodh.nl:6789) -s
> global_init: unable to open config file.
> root@stack01:~#
> =20
> I however worked with:
> =20
> root@stack01:~# ceph -m wido-desktop.widodh.nl:6789 (http://wido-desk=
top.widodh.nl:6789) -c /dev/null -s
> 2012-04-26 14:55:33.828524 pg v148: 594 pgs: 594 active+clean; 0 =20
> bytes data, 7740 KB used, 70571 MB / 76800 MB avail
> 2012-04-26 14:55:33.829622 mds e1: 0/0/1 up
> 2012-04-26 14:55:33.836144 osd e14: 3 osds: 3 up, 3 in
> 2012-04-26 14:55:33.886429 log 2012-04-26 14:52:50.674430 osd.1 =20
> [2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6807/28366 12 : [INF] 1.2b scru=
b ok
> 2012-04-26 14:55:33.892423 mon e1: 1 mons at =20
> {desktop=3D[2a00:f10:11c:ab:52e5:49ff:fec2:c976]:6789/0}
> root@stack01:~#
> =20
> I quick look at global_init.cc (http://global_init.cc) showed me why =
this happened, it simply =20
> looks for a configuration file to open and when it can't it fails.
> =20
> But if a monitor address is set, a config file shouldn't be mandatory=
=2E
> =20
> It could be accomplished rather simple by setting the flag =20
> CINIT_FLAG_NO_DEFAULT_CONFIG_FILE if a mon_host has been set, but to =
do =20
> that conf->parse_argv(args); should move a few lines up.
> =20
> Comments? Thoughts?
If this is a big annoyance for you, you can cherry-pick the head of wip=
-2352-hack to build a ceph tool that doesn't require a config file if y=
ou specify -m in a similar fashion to what you suggest. Unfortunately a=
ctually doing what you suggest would break everything (you need to pars=
e the config file before parsing command-line options so that the comma=
nd-line ones win=E2=80=A6although it's possible parsing them twice woul=
d work, actually=E2=80=A6) and this hack isn't appropriate to put upstr=
eam so I need to spend some time working out a more general fix (hopefu=
lly, one that lets executables specify the arguments they need and then=
 requiring the config file iff those aren't all set on the command-line=
). =20
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
