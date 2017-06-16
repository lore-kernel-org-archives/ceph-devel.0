From: Sage Weil <sage@newdream.net>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM
 volumes
Date: Fri, 16 Jun 2017 18:42:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706161842140.32269@piezo.novalocal>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com> <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-811301427-1497638562=:32269"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58313 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdFPSmn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jun 2017 14:42:43 -0400
In-Reply-To: <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Warren Wang - ISD <Warren.Wang@walmart.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-811301427-1497638562=:32269
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 16 Jun 2017, Alfredo Deza wrote:
> On Fri, Jun 16, 2017 at 2:11 PM, Warren Wang - ISD
> <Warren.Wang@walmart.com> wrote:
> > I would prefer that this is something more generic, to possibly support other backends one day, like ceph-volume. Creating one tool per backend seems silly.
> >
> > Also, ceph-lvm seems to imply that ceph itself has something to do with lvm, which it really doesn’t. This is simply to deal with the underlying disk. If there’s resistance to something more generic like ceph-volume, then it should at least be called something like ceph-disk-lvm.
> 
> Sage, you had mentioned the need for "composable" tools for this, and
> I think that if we go with `ceph-volume` we could allow plugins for
> each strategy. We are starting with `lvm` support so that would look
> like: `ceph-volume lvm`
> 
> The `lvm` functionality could be implemented as a plugin itself, and
> when we start working with supporting regular disks, then `ceph-volume
> disk` can come along, etc...
> 
> It would also open the door for anyone to be able to write a plugin to
> `ceph-volume` to implement their own logic, while at the same time
> re-using most of what we are implementing today: logging, reporting,
> systemd support, OSD metadata, etc...
> 
> If we were to separate these into single-purpose tools, all those
> would need to be re-done.

Yeah, this sounds great to me!

sage


> 
> 
> >
> > 2 cents from one of the LVM for Ceph users,
> > Warren Wang
> > Walmart ✻
> >
> > On 6/16/17, 10:25 AM, "ceph-users on behalf of Alfredo Deza" <ceph-users-bounces@lists.ceph.com on behalf of adeza@redhat.com> wrote:
> >
> >     Hello,
> >
> >     At the last CDM [0] we talked about `ceph-lvm` and the ability to
> >     deploy OSDs from logical volumes. We have now an initial draft for the
> >     documentation [1] and would like some feedback.
> >
> >     The important features for this new tool are:
> >
> >     * parting ways with udev (new approach will rely on LVM functionality
> >     for discovery)
> >     * compatibility/migration for existing LVM volumes deployed as directories
> >     * dmcache support
> >
> >     By documenting the API and workflows first we are making sure that
> >     those look fine before starting on actual development.
> >
> >     It would be great to get some feedback, specially if you are currently
> >     using LVM with ceph (or planning to!).
> >
> >     Please note that the documentation is not complete and is missing
> >     content on some parts.
> >
> >     [0] http://tracker.ceph.com/projects/ceph/wiki/CDM_06-JUN-2017
> >     [1] http://docs.ceph.com/ceph-lvm/
> >     _______________________________________________
> >     ceph-users mailing list
> >     ceph-users@lists.ceph.com
> >     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-811301427-1497638562=:32269--
