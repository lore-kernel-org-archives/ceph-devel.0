From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph as a NOVA-INST-DIR/instances/ storage backend
Date: Mon, 25 Jun 2012 10:18:05 -0700
Message-ID: <CADvuQREu_9ZOEg7T80ph14HMuxd+f+G-wTa6d21N9PKvcOQ_Qw@mail.gmail.com>
References: <CAC+dAwHKuGY=iVC8O9oNStrPLuBDruriK1MQyhqCAGqo_ik+rg@mail.gmail.com>
 <CADvuQREy1iLz3HUECFh1Bud9uADTQRXFAh0HCWDmWQd0SmLGeA@mail.gmail.com> <CAC+dAwGFSBxfHh=tP6V7CqTqYxE6=0G+oT6AZxTmY31L1f1amg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56149 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380Ab2FYRS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 13:18:26 -0400
Received: by pbbrp8 with SMTP id rp8so6824825pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 10:18:25 -0700 (PDT)
In-Reply-To: <CAC+dAwGFSBxfHh=tP6V7CqTqYxE6=0G+oT6AZxTmY31L1f1amg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Laskovy <igor.laskovy@gmail.com>
Cc: openstack-operators@lists.openstack.org, "&lt,openstack@lists.launchpad.net&gt," <openstack@lists.launchpad.net>, ceph-devel@vger.kernel.org

On Mon, Jun 25, 2012 at 10:03 AM, Igor Laskovy <igor.laskovy@gmail.com> wrote:
> but can I use RBD for booting instances? I would like store whole VM on the
> Ceph, not only persistent volumes (actually for my project I not prefer use
> persistent volumes at all).

OpenStack Essex does not make it convenient, but it can boot off of RBD.

We don't have really good documentation on that yet, but the relevant
resources are:

https://github.com/ceph/ceph-openstack-tools/blob/master/boot-from-volume
https://github.com/ceph/ceph-openstack-tools/blob/master/start-on-rbd.sh
http://docs.openstack.org/trunk/openstack-compute/admin/content/boot-from-volume.html
