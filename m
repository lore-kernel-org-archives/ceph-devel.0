From: Andrew Woodward <xarses@gmail.com>
Subject: Re: Ceph puppet module
Date: Thu, 17 Oct 2013 13:29:28 -0700
Message-ID: <CACEfbZghTwxVAhVv4=gUbPffj3CyrNh5rXjZVPHsKMJuLUoH=A@mail.gmail.com>
References: <525E47AA.8060006@dachary.org>
	<CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:65340 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762348Ab3JQU3a convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Oct 2013 16:29:30 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so2334696lbh.6
        for <ceph-devel@vger.kernel.org>; Thu, 17 Oct 2013 13:29:28 -0700 (PDT)
In-Reply-To: <CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

We need to have a reasonable license on this preferably Apache 2.0.
the enovance module is AGPL which can't come in contact with nearly
anything with out causing massive license issues. Starting with any of
the enovance code is a Non-starter as it will require the AGPL
License.

On Wed, Oct 16, 2013 at 2:36 AM, Dan van der Ster <dan@vanderster.com> =
wrote:
> Hi,
> We would support this. The enovance module is a good starting point i=
f
> you will accept something that doesn't yet use all the udev magic.
> Cheers, Dan
> CERN IT
>
> On Wed, Oct 16, 2013 at 10:00 AM, Loic Dachary <loic@dachary.org> wro=
te:
>> Hi Ceph,
>>
>> How about creating
>>
>> https://github.com/ceph/puppet-ceph
>>
>> to federate the development efforts for a puppet module exclusively =
focused on deploying / maintaining a Ceph cluster ? It looks like we ar=
e at a point in time where the fragmentation of the work created a desi=
re for a central place. And the https://github.com/ceph/ seems agreeabl=
e to everyone involved.
>>
>> The discussion initialy started on Ceph + OpenStack + puppet but it =
seems sensible to separate the OpenStack specific part and host it on h=
ttps://github.com/stackforge/
>>
>> The full thread that leads to this proposal is at:
>>
>> https://groups.google.com/a/puppetlabs.com/d/msg/puppet-openstack/ib=
nrmXBAxVg/Y3Z3e6sZoa4J
>>
>> Cheers
>>
>> --
>> Lo=C4=8Fc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
If google has done it, Google did it right!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
