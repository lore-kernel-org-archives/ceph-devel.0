From: Constantinos Venetsanopoulos <cven@grnet.gr>
Subject: Re: Using Ceph and CloudStack? Let us know!
Date: Sat, 18 May 2013 17:27:58 +0300
Message-ID: <51978FEE.6040709@grnet.gr>
References: <CAP8Oy=K3qa7dcVxAab9m=whUD+JoUsLxy5ZoX5DPM09x4_aPaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:22067 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682Ab3ERO2A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 18 May 2013 10:28:00 -0400
In-Reply-To: <CAP8Oy=K3qa7dcVxAab9m=whUD+JoUsLxy5ZoX5DPM09x4_aPaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <patrick@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

Hello Patrick and Ceph users,

On 5/16/13 17:02 PM, Patrick McGarry wrote:
> Of course,
> we'd love to hear about anything you're working on.  So, if you have
> notes to share about Ceph with other cloud flavors, massive storage
> clusters, or custom work, we'd treasure them appropriately.

as you already know from an older post on the Ceph blog [1] we have been
evaluating RADOS for use in our public cloud service [2], powered by the
open source cloud software Synnefo [3]. When writing the post, we had
already fully integrated RADOS in Synnefo (VM disks, Images, Files) and
we were in the process of moving everything into production.

Indeed, we are now happy to inform you that the deployment of RADOS
into our production environment has been completed successfully and
since last month [4] our users are storing their files and images on
RADOS and also have the choice of spawning VMs with their disks on
RADOS too; in seconds with thin cloning.

We are currently experimenting with thin disk snapshotting and hope to
have the functionality integrated in one of the next Synnefo versions.
In the same time, we are expanding our production RADOS cluster as
demand rises with a plan to hit 1PB or raw storage.

Keep the good work,
Kind Regards,
Constantinos


[1] http://ceph.com/community/ceph-comes-to-synnefo-and-ganeti/
[2] http://okeanos.grnet.gr
[3] http://synnefo.org
[4] https://okeanos.grnet.gr/blog/2013/04/04/introducing-archipelago/

> Feel free to just reply to this email, send a message to
> community@inktank.com, message 'scuttlemonkey' on irc.oftc.net, or tie
> a note to our ip-over-carrier-pigeon network.  Thanks, and happy
> Ceph-ing.
>
>
> Best Regards,
>
> Patrick McGarry
> Director, Community || Inktank
>
> http://ceph.com  ||  http://inktank.com
> @scuttlemonkey || @ceph || @inktank
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

