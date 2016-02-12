From: Sage Weil <sage@newdream.net>
Subject: RE: cls_rbd ops on rbd_id.$name objects in EC pool
Date: Fri, 12 Feb 2016 08:14:42 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602120730010.4107@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com> <1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com> <CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com> <alpine.DEB.2.11.1602051340490.28396@cpach.fuggernut.com>
 <0bc701d1604f$8f21e0a0$ad65a1e0$@fisk.me.uk> <5848cd48.9Ro.9Gf.h0.1onaHAyHUe@mailjet.com> <549809462.21912115.1455221387486.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1602111557000.28396@cpach.fuggernut.com> <dbf6eb9a.9Ro.9Gf.cs.1lNjEIPmE9@mailjet.com>
 <alpine.DEB.2.11.1602112008490.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-394716180-1455282885=:4107"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33609 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbcBLNOZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Feb 2016 08:14:25 -0500
In-Reply-To: <alpine.DEB.2.11.1602112008490.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: 'Jason Dillaman' <dillaman@redhat.com>, 'Samuel Just' <sjust@redhat.com>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-394716180-1455282885=:4107
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Feb 2016, Sage Weil wrote:
> On Thu, 11 Feb 2016, Nick Fisk wrote:
> > That’s a relief, I was sensing a major case of face palm occuring when I 
> > read Jason's email!!!
> 
> https://github.com/ceph/ceph/pull/7617
> 
> The tangled logic in maybe_handle_cache wasn't respecting the force 
> promotion bool.

So, the cause on hammer was entirely different than on master.  There we 
broke things during a refactor, but on hammer we just hadn't backported 
a fix.  I've prepared a pull request for that:

	https://github.com/ceph/ceph/pull/7622

Nick, do you mind verifying that this fixes things for you?

sage

--8323329-394716180-1455282885=:4107--
