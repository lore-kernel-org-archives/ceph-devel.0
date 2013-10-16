From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Ceph puppet module
Date: Wed, 16 Oct 2013 11:36:46 +0200
Message-ID: <CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
References: <525E47AA.8060006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:62048 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760112Ab3JPJha convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 05:37:30 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so166999bkb.34
        for <ceph-devel@vger.kernel.org>; Wed, 16 Oct 2013 02:37:27 -0700 (PDT)
Received: by mail-lb0-f182.google.com with SMTP id p9so478896lbv.27
        for <ceph-devel@vger.kernel.org>; Wed, 16 Oct 2013 02:37:26 -0700 (PDT)
In-Reply-To: <525E47AA.8060006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dan Bode <bodepd@gmail.com>

Hi,
We would support this. The enovance module is a good starting point if
you will accept something that doesn't yet use all the udev magic.
Cheers, Dan
CERN IT

On Wed, Oct 16, 2013 at 10:00 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi Ceph,
>
> How about creating
>
> https://github.com/ceph/puppet-ceph
>
> to federate the development efforts for a puppet module exclusively f=
ocused on deploying / maintaining a Ceph cluster ? It looks like we are=
 at a point in time where the fragmentation of the work created a desir=
e for a central place. And the https://github.com/ceph/ seems agreeable=
 to everyone involved.
>
> The discussion initialy started on Ceph + OpenStack + puppet but it s=
eems sensible to separate the OpenStack specific part and host it on ht=
tps://github.com/stackforge/
>
> The full thread that leads to this proposal is at:
>
> https://groups.google.com/a/puppetlabs.com/d/msg/puppet-openstack/ibn=
rmXBAxVg/Y3Z3e6sZoa4J
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
