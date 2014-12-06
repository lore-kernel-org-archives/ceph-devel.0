From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: [ceph-users] normalizing radosgw
Date: Sat, 6 Dec 2014 15:47:24 -0800
Message-ID: <CABBk=J8ZQNmQ52ah6t6+xbD=9LxGGtqtqi+yQq1F5GoP0WADqA@mail.gmail.com>
References: <alpine.DEB.2.00.1412061025330.18213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53188 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbaLFXrZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Dec 2014 18:47:25 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so2763956ieb.35
        for <ceph-devel@vger.kernel.org>; Sat, 06 Dec 2014 15:47:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412061025330.18213@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Sat, Dec 6, 2014 at 10:39 AM, Sage Weil <sweil@redhat.com> wrote:
> Several things are different/annoying with radosgw than with other Ceph
> daemons:
>
> - binary/package are named 'radosgw' instead of 'ceph-rgw'.
>
> This is cosmetic, but it also makes it fit less well into the
> new /var/lib/ceph/* view of things.
>
> - default log location is /var/log/radosgw/$cluster-$name.log instead of
> /var/lib/ceph/$cluster-$rgw.$name.log (or similar).
>
> - rgw_data default is /var/lib/ceph/radosgw instead of /var/lib/ceph/rgw
>
> (not sure if 3 letters for consistency is better?)
>
> - rgw usually authenticates as a client.something user, which means if you
> do use more standard rgw log names, then you get
> /var/log/ceph/client.something.$pid.$uniqueid.log.  There is a loose
> convention that 'something' is 'rgw.hostname' (i.e., client.rgw.hostname).

Maybe we can make it so that unless user name starts with mon, osd, or
mds, it's going to be treated as 'client'? Or something along these
lines.

>
> - radosgw has it's own separate sysvinit script that enumerates daemons
> from /etc/ceph/ceph.conf sections that start with client.radosgw.*
>
> - radosgw upstart script is called radosgw (not ceph-rgw) and enumerates
> daemons from /var/lib/ceph/radosgw/*
>
> (totally different than sysvinit!)
>
> - radosgw instances usually need some stuff in ceph.conf to make them
> behave properly, which means they need a section in the shared
> /etc/ceph/ceph.conf.  more work for admins or config management systems.
>
> - on rpm-based systems we have a separate sysvinit script that is
> slightly different (mostly because the username is different, apache
> instead of www-data).
>
> ---
>
> There is enough wrong here and little enough convention that my
> proposal is to essentially start fresh:
>
> - rename package ceph-rgw.  obsoletes/replaces radosgw.
>
> - merge rgw start/stop into standard sysvinit script (just another
> daemon type?).
>
> - normalize upstart start/stop (just rename radosgw-* to ceph-rgw-*,
> basically).
>
> - make upstart use /var/lib/ceph/rgw instead of /var/lib/ceph/radosgw (do
> this automagically on upgrade?  that will at least avoid the upgrade pain
> for ubuntu users)
>
> - create new systemd start/stop that are correct the first time
> around.
>
> - move log file to /var/log/ceph
>
>
> The part I'm not sure about is how to handle config.  I would really like
> the ability to put per-daemon config stuff in /var/lib/ceph/rgw/foo/conf
> or config, but there is no 'include file' function in our ini-file parser
> (or in other typical ini-file implementations that i can find) and I don't

The samba configuration files, which our ceph conf was heavily
influenced by does have that capability. We also used to be able to
do:

   include = <other include file>

but sadly that was taken out during some cleanup years ago. I don't
think it's going to be too complicated to revive this functionality.

> like the idea the per-daemon config would completely supplant the
> /etc/ceph/ one.
>
> Basically, I'd like to get to a point where we can programatically deploy
> an rgw without any wonky code that edits the ceph.conf.  Perhaps the way
> to accomplish this is to have the admin create a generic client.rgw user
> and generic [client.rgw] section in the global ceph.conf?
>
> If there were an include file function, we could make the per-daemon
> config file something like
>
>  include /etc/ceph/$cluster.conf
>  [client.rgw.hostname]
>  rgw foo = bar
>  rgw baz = blip
>
> or whatever.
>
> Thoughts?  Suggestions?
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
