From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: Ceph and puppet and OpenStack : open conference call
Date: Wed, 16 Oct 2013 21:18:52 +0200
Message-ID: <525EE69C.7090602@bisect.de>
References: <52580F9B.3080607@dachary.org> <525816D8.3000609@dachary.org> <525D61CD.5010707@dachary.org>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45560 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755246Ab3JPTsG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Oct 2013 15:48:06 -0400
In-Reply-To: <525D61CD.5010707@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I've overseen this call, sorry. Is there any meeting results or a log?

I asked because we (Deutsche Telekom AG) forked our puppet-ceph module
from the enovance puppet-ceph (deploying ceph without ceph-deploy) and
we plan to contribute our code back to the community into the source
project.

You can find our code here:
https://github.com/TelekomCloud/puppet-ceph/tree/rc/eisbrecher

Or the basic changes without RadosGW support in my repo:
https://github.com/dalgaaf/puppet-ceph/tree/feature/wip-da-rework-and-simplify

If you have any questions about the code, ask me since I didn't update
the documentation to reflect the new code yet.

Regards,

Danny

Am 15.10.2013 17:39, schrieb Loic Dachary:
> Hi,
> 
> The call was rescheduled one hour later. It is now:
> 
> 17:30-18:00 UTC / 13:30-14:00 US-Eastern / 11:30-12:00 US-Mountain 10:30-11:00 US-Pacific / 19:30-20:00 Europe-Central
> 
> Phone numbers : http://www.cisco.com/web/about/doing_business/conferencing/index.html
> 
> Room code: 208324756
> Access code: 208324756
> 
> Cheers
> 
> On 11/10/2013 17:18, Loic Dachary wrote:
>> Someone kindly pointed out that I did not mention the day :-) Here are the complete informations:
>>
>> Tuesday 15th October 2013
>>
>> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>>
>> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>>
>> Room code: 208324756
>> Access code: 208324756
>>
>> On 11/10/2013 16:47, Loic Dachary wrote:
>>> Hi Ceph,
>>>
>>> What about we discuss the state of Ceph deployment in the context of puppet and / or OpenStack ? If nothing else, it will be a good opportunity for all people actively working in this area to touch base. The proposed agenda is to list and possibly clarify the existing methods and maybe find ways to share the effort.
>>>
>>> The conference call details are a the end of the mail and it will be timeboxed to 30 minutes. There are a number of projects and I made a short list below to avoid confusion during the call. Feel free to edit / add if I misreprensented you or the project you're associated with ;-)
>>>
>>> Cheers
>>>
>>> * deploy ceph : ceph-deploy
>>>
>>>   for test / POC purposes
>>>   https://github.com/ceph/ceph-deploy
>>>
>>>   maintainer: Alfredo Deza
>>>
>>> * deploy ceph with puppet : puppet-cephdeploy
>>>
>>>   relies on ceph-deploy
>>>   https://github.com/dontalton/puppet-cephdeploy/
>>>
>>>   maintainer: Don Talton
>>>
>>> * deploy ceph with puppet : puppet-ceph
>>>
>>>   developped in 2012 but still useful
>>>   https://github.com/enovance/puppet-ceph
>>>
>>>   maintainer: community
>>>
>>> * ceph + openstack : ceph docs
>>>
>>>   manual integration
>>>   http://ceph.com/docs/next/rbd/rbd-openstack/
>>>    maintainer: John Wilkins + Josh Durgin
>>>
>>> * ceph + openstack with puppet : stackforge
>>>
>>>   https://github.com/stackforge/puppet-glance/blob/stable/grizzly/manifests/backend/rbd.pp
>>>   https://github.com/stackforge/puppet-cinder/blob/stable/grizzly/manifests/volume/rbd.pp
>>>
>>>   maintainer: community
>>>
>>> * ceph + openstack with puppet : COI
>>>
>>>   targeting Cisco use case
>>>   https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/ceph
>>>   http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation
>>>
>>>   maintainer : Don Talton + Robert Starmer
>>>
>>> * ceph + openstack with puppet : mirantis
>>>
>>>   in the context of Fuel
>>>   https://github.com/Mirantis/fuel/tree/master/deployment/puppet/ceph
>>>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/cinder/manifests/volume/ceph.pp
>>>   https://github.com/Mirantis/fuel/blob/master/deployment/puppet/glance/manifests/backend/ceph.pp
>>>
>>>   maintainer : Andrew Woodward
>>>
>>> * openstack with puppet : openstack-installer
>>>
>>>   data driven approach to deploy OpenStack
>>>   https://github.com/CiscoSystems/openstack-installer/
>>>
>>>   maintainer: Robert Starmer + Dan Bode
>>>
>>>
>>> 16:30-17:00 UTC / 12:30-13:00 US-Eastern / 10:30-11:00 US-Mountain 09:30-10:00 US-Pacific / 18:30-19:00 Europe-Central
>>>
>>> San Jose, CA: +1.408.525.6800 RTP: +1.919.392.3330 US/Canada: +1.866.432.9903 United Kingdom: +44.20.8824.0117 India: +91.80.4350.1111 Germany: +49.619.6773.9002 Japan: +81.3.5763.9394 China: +86.10.8515.5666
>>>
>>> Room code: 208324756
>>> Access code: 208324756
>>>
>>> Cheers
>>>
>>
> 

