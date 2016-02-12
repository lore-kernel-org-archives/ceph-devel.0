From: Sage Weil <sweil@redhat.com>
Subject: RE: cls_rbd ops on rbd_id.$name objects in EC pool
Date: Thu, 11 Feb 2016 20:09:31 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602112008490.28396@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com> <1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com> <CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com> <alpine.DEB.2.11.1602051340490.28396@cpach.fuggernut.com>
 <0bc701d1604f$8f21e0a0$ad65a1e0$@fisk.me.uk> <5848cd48.9Ro.9Gf.h0.1onaHAyHUe@mailjet.com> <549809462.21912115.1455221387486.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1602111557000.28396@cpach.fuggernut.com> <dbf6eb9a.9Ro.9Gf.cs.1lNjEIPmE9@mailjet.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1515539657-1455239374=:28396"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48951 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbcBLBJM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Feb 2016 20:09:12 -0500
In-Reply-To: <dbf6eb9a.9Ro.9Gf.cs.1lNjEIPmE9@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: 'Jason Dillaman' <dillaman@redhat.com>, 'Samuel Just' <sjust@redhat.com>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1515539657-1455239374=:28396
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Feb 2016, Nick Fisk wrote:
> That’s a relief, I was sensing a major case of face palm occuring when I 
> read Jason's email!!!

https://github.com/ceph/ceph/pull/7617

The tangled logic in maybe_handle_cache wasn't respecting the force 
promotion bool.

sage
--8323329-1515539657-1455239374=:28396--
