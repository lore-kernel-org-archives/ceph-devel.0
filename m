From: =?utf-8?Q?S=C3=A9bastien_Han?= <sebastien.han@enovance.com>
Subject: Re: Ceph puppet module
Date: Wed, 16 Oct 2013 13:22:27 +0200
Message-ID: <etPan.525e76f3.8edbdab.d059@leseb-mba.local>
References: <525E47AA.8060006@dachary.org>
 <CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:36893 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760492Ab3JPLW3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 07:22:29 -0400
In-Reply-To: <CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>, Loic Dachary <loic@dachary.org>
Cc: Dan Bode <bodepd@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Dan,

During the cephdays you mentioned that you were about to redistribute a=
ll the changes you=E2=80=99ve made on puppet-ceph to the enovance repo.
It would be great to merge both before starting anything.

What=E2=80=99s the progress?

Thanks :)

=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood.=E2=80=9D

Phone:=C2=A0+33 (0)1 49 70 99 72
Mail:=C2=A0sebastien.han@enovance.com
Address :=C2=A010, rue de la Victoire - 75009 Paris
Web :=C2=A0www.enovance.com=C2=A0-=C2=A0Twitter :=C2=A0@enovance

On October 16, 2013 at 11:37:44 AM, Dan van der Ster (dan@vanderster.co=
m) wrote:
>
>Hi,
>We would support this. The enovance module is a good starting point if
>you will accept something that doesn't yet use all the udev magic.
>Cheers, Dan
>CERN IT
>
>On Wed, Oct 16, 2013 at 10:00 AM, Loic Dachary wrote:
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
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
