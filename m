From: Sage Weil <sweil@redhat.com>
Subject: Re: can we stop packaging sysvinit scripts?
Date: Thu, 11 Jan 2018 23:34:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801112333170.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal> <b6b69060-2424-5404-cdf0-4ca019ec9ead@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753558AbeAKXee (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 Jan 2018 18:34:34 -0500
In-Reply-To: <b6b69060-2424-5404-cdf0-4ca019ec9ead@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Wed, 10 Jan 2018, Amon Ott wrote:
> Am 10.01.2018 um 15:44 schrieb Sage Weil:
> > We've had systemd unit files for several releases now and all major 
> > distros are using systemd by default.  Can we stop packaging the sysvinit 
> > scripts?
> > 
> > I realize that Debian allows you to switch init systems... do any users 
> > actually do this?  Is it required that debs include the sysvinit scripts 
> > or is there some glue that lets packages avoid maintaining sysvinit 
> > scripts?
> > 
> > I ask because the init scripts are one of the few remainining bits that 
> > use the ceph-conf utility, which I would like to deprecate (and eventually 
> > remove).  It parses local config files but we are migrating this to the 
> > mon.  We could make ceph-conf pull configs from the mon but I would 
> > like to simplify if possible!
> 
> We would really appreciate having the init scripts around for a long
> while, as we are not willing to use systemd on our servers for security
> reasons. Please do not drop them.

Okay, I think in the end ceph-conf behavior won't change (it will continue 
to only do config files, not mon config) so all of the current users (like 
sysvinit scripts) can continue to do their old legacy thing.  

So... nevermind, I guess!

sage
