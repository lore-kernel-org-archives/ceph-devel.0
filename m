From: Igor Laskovy <igor.laskovy@gmail.com>
Subject: Re: Ceph as a NOVA-INST-DIR/instances/ storage backend
Date: Mon, 25 Jun 2012 22:50:45 +0300
Message-ID: <CAC+dAwFvgRbgBr6GSLDbJ+V-6V0UgvNFh-3Y6jDKVkphGgnPCg@mail.gmail.com>
References: <CAC+dAwHKuGY=iVC8O9oNStrPLuBDruriK1MQyhqCAGqo_ik+rg@mail.gmail.com>
	<CADvuQREy1iLz3HUECFh1Bud9uADTQRXFAh0HCWDmWQd0SmLGeA@mail.gmail.com>
	<CAC+dAwGFSBxfHh=tP6V7CqTqYxE6=0G+oT6AZxTmY31L1f1amg@mail.gmail.com>
	<CADvuQREu_9ZOEg7T80ph14HMuxd+f+G-wTa6d21N9PKvcOQ_Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42934 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab2FYTus (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 15:50:48 -0400
Received: by weyu7 with SMTP id u7so3060591wey.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 12:50:47 -0700 (PDT)
In-Reply-To: <CADvuQREu_9ZOEg7T80ph14HMuxd+f+G-wTa6d21N9PKvcOQ_Qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>, florian@hastexo.com
Cc: openstack-operators@lists.openstack.org, "&lt,openstack@lists.launchpad.net&gt," <openstack@lists.launchpad.net>, ceph-devel@vger.kernel.org

Thank you Florian and Tommi, I appreciated your help))

On Mon, Jun 25, 2012 at 8:18 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Jun 25, 2012 at 10:03 AM, Igor Laskovy <igor.laskovy@gmail.com> wrote:
>> but can I use RBD for booting instances? I would like store whole VM on the
>> Ceph, not only persistent volumes (actually for my project I not prefer use
>> persistent volumes at all).
>
> OpenStack Essex does not make it convenient, but it can boot off of RBD.
>
> We don't have really good documentation on that yet, but the relevant
> resources are:
>
> https://github.com/ceph/ceph-openstack-tools/blob/master/boot-from-volume
> https://github.com/ceph/ceph-openstack-tools/blob/master/start-on-rbd.sh
> http://docs.openstack.org/trunk/openstack-compute/admin/content/boot-from-volume.html



-- 
Igor Laskovy
facebook.com/igor.laskovy
Kiev, Ukraine
