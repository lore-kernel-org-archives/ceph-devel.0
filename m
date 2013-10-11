From: Andrew Woodward <xarses@gmail.com>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Fri, 11 Oct 2013 12:02:04 -0700
Message-ID: <CACEfbZjpOhDSTnRKWy6H5z3-9B1_WWP_Yxydepr+Gt-5BDRBng@mail.gmail.com>
References: <52580F9B.3080607@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:43262 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3JKTCG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 15:02:06 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so3718803lbd.40
        for <ceph-devel@vger.kernel.org>; Fri, 11 Oct 2013 12:02:05 -0700 (PDT)
In-Reply-To: <52580F9B.3080607@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

will try to attend. have a hard stop at 1000

On Fri, Oct 11, 2013 at 7:47 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> What about we discuss the state of Ceph deployment in the context of =
puppet and / or OpenStack ? If nothing else, it will be a good opportun=
ity for all people actively working in this area to touch base. The pro=
posed agenda is to list and possibly clarify the existing methods and m=
aybe find ways to share the effort.
>
> The conference call details are a the end of the mail and it will be =
timeboxed to 30 minutes. There are a number of projects and I made a sh=
ort list below to avoid confusion during the call. Feel free to edit / =
add if I misreprensented you or the project you're associated with ;-)
>
> Cheers
>
> * deploy ceph : ceph-deploy
>
>   for test / POC purposes
>   https://github.com/ceph/ceph-deploy
>
>   maintainer: Alfredo Deza
>
> * deploy ceph with puppet : puppet-cephdeploy
>
>   relies on ceph-deploy
>   https://github.com/dontalton/puppet-cephdeploy/
>
>   maintainer: Don Talton
>
> * deploy ceph with puppet : puppet-ceph
>
>   developped in 2012 but still useful
>   https://github.com/enovance/puppet-ceph
>
>   maintainer: community
>
> * ceph + openstack : ceph docs
>
>   manual integration
>   http://ceph.com/docs/next/rbd/rbd-openstack/
>    maintainer: John Wilkins + Josh Durgin
>
> * ceph + openstack with puppet : stackforge
>
>   https://github.com/stackforge/puppet-glance/blob/stable/grizzly/man=
ifests/backend/rbd.pp
>   https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/man=
ifests/volume/rbd.pp
>
>   maintainer: community
>
> * ceph + openstack with puppet : COI
>
>   targeting Cisco use case
>   https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/c=
eph
>   http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation
>
>   maintainer : Don Talton + Robert Starmer
>
> * ceph + openstack with puppet : mirantis
>
>   in the context of Fuel
>   https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cind=
er/manifests/volume/ceph.pp
>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glan=
ce/manifests/backend/ceph.pp
>
>   maintainer : Andrew Woodward
>
> * openstack with puppet : openstack-installer
>
>   data driven approach to deploy OpenStack
>   https://github.com/CiscoSystems/openstack-installer/
>
>   maintainer: Robert Starmer + Dan Bode
>
>
> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09=
:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>
> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.=
432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germa=
ny: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>
> Room code: 208324756
> Access code: 208324756
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
>
>
>



--=20
If google has done it, Google did it right!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
