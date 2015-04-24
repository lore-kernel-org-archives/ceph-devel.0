From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 15:05:37 -0600
Message-ID: <CAANLjFq4tuw8PNjSJTS-6kmitdTUeodkBn-=A9VJvh6z=Dwtfw@mail.gmail.com>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net>
	<553AA491.6040409@bisect.de>
	<alpine.DEB.2.00.1504241349570.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36217 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965484AbbDXVFi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 17:05:38 -0400
Received: by wgen6 with SMTP id n6so62624116wge.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2015 14:05:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1504241349570.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com

On Fri, Apr 24, 2015 at 2:52 PM, Sage Weil <sweil@redhat.com> wrote:
>
> We could, but I wonder if not touching upstart or sysvinit will be an
> easy way to handle migration/compat issues.
>
> One other thing Greg brought up today was that we should allow an admin to
> configure daemons to run as root if they want.  They can do that by
> editing the unit files; I'm not sure if we want to do something more
> friendly than that?  (FWIW I think this is basically what Leannart
> suggests.)

How about putting a user option in /etc/default/ceph or ceph.conf?
