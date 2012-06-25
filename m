From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph as a NOVA-INST-DIR/instances/ storage backend
Date: Mon, 25 Jun 2012 09:03:20 -0700
Message-ID: <CADvuQREy1iLz3HUECFh1Bud9uADTQRXFAh0HCWDmWQd0SmLGeA@mail.gmail.com>
References: <CAC+dAwHKuGY=iVC8O9oNStrPLuBDruriK1MQyhqCAGqo_ik+rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42637 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab2FYQDl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 12:03:41 -0400
Received: by dady13 with SMTP id y13so5511321dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 09:03:40 -0700 (PDT)
In-Reply-To: <CAC+dAwHKuGY=iVC8O9oNStrPLuBDruriK1MQyhqCAGqo_ik+rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Laskovy <igor.laskovy@gmail.com>
Cc: openstack-operators@lists.openstack.org, "<openstack@lists.launchpad.net>" <openstack@lists.launchpad.net>, ceph-devel@vger.kernel.org

On Sat, Jun 23, 2012 at 11:42 AM, Igor Laskovy <igor.laskovy@gmail.com> wrote:
> Hi all from hot Kiev))
>
> Does anybody use Ceph as a backend storage for NOVA-INST-DIR/instances/ ?
> Is it in production use? Live migration is still possible?
> I kindly ask any advice of best practices point of view.

That's the shared NFS mount style for storing images, right? While you
could use the Ceph Distributed File System for that, there's a better
answer (for both Nova and Glance): RBD.

Our docs are still being worked on, but you can see the current state
at http://ceph.com/docs/master/rbd/rbd-openstack/
