From: Florian Haas <florian@hastexo.com>
Subject: Re: Ceph as a NOVA-INST-DIR/instances/ storage backend
Date: Mon, 25 Jun 2012 19:07:54 +0200
Message-ID: <CAPUexz8F76PfHsPJdpr=BJfbM6W1LtjzpfRfLNAX5zjdvYn3Aw@mail.gmail.com>
References: <CAC+dAwHKuGY=iVC8O9oNStrPLuBDruriK1MQyhqCAGqo_ik+rg@mail.gmail.com>
	<CADvuQREy1iLz3HUECFh1Bud9uADTQRXFAh0HCWDmWQd0SmLGeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:60217 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757477Ab2FYROe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 13:14:34 -0400
Received: by qabj40 with SMTP id j40so1530618qab.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 10:14:33 -0700 (PDT)
In-Reply-To: <CADvuQREy1iLz3HUECFh1Bud9uADTQRXFAh0HCWDmWQd0SmLGeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Igor Laskovy <igor.laskovy@gmail.com>, openstack-operators@lists.openstack.org, "<openstack@lists.launchpad.net>" <openstack@lists.launchpad.net>, ceph-devel@vger.kernel.org

On Mon, Jun 25, 2012 at 6:03 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Sat, Jun 23, 2012 at 11:42 AM, Igor Laskovy <igor.laskovy@gmail.com> wrote:
>> Hi all from hot Kiev))
>>
>> Does anybody use Ceph as a backend storage for NOVA-INST-DIR/instances/ ?

Yes. http://www.sebastien-han.fr/blog/2012/06/10/introducing-ceph-to-openstack/
Look at the "Live Migration with CephFS" part.

>> Is it in production use?

"Production use" would require CephFS to be production ready, which at
this point it isn't.

> Live migration is still possible?

Yes.

>> I kindly ask any advice of best practices point of view.
>
> That's the shared NFS mount style for storing images, right? While you
> could use the Ceph Distributed File System for that, there's a better
> answer (for both Nova and Glance): RBD.

... which sort of goes hand-in-hand with boot from volume, which was
just recently documented in the Nova admin guide, so you may want to
take a look: http://docs.openstack.org/trunk/openstack-compute/admin/content/boot-from-volume.html

That being said, volume attachment persistence across live migrations
hasn't always been stellar in Nova, and I'm not 100% sure how well
trunk currently deals with that.

Cheers,
Florian
