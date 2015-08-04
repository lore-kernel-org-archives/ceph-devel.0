From: Owen Synge <osynge@suse.com>
Subject: Re: Fedora 22 systemd and rgw
Date: Tue, 04 Aug 2015 18:10:18 +0200
Message-ID: <55C0E3EA.3010607@suse.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <55BFBA99.4070205@suse.com> <alpine.DEB.2.00.1508031205360.22099@cobra.newdream.net> <55C0904A.8010902@suse.com> <55C0B0C7.7050907@suse.com> <alpine.DEB.2.00.1508040604310.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:60479 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752574AbbHDQL7 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 4 Aug 2015 12:11:59 -0400
In-Reply-To: <alpine.DEB.2.00.1508040604310.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 08/04/2015 03:07 PM, Sage Weil wrote:
> On Tue, 4 Aug 2015, Owen Synge wrote:
>> On 08/04/2015 12:13 PM, Owen Synge wrote:
>>> On 08/03/2015 09:07 PM, Sage Weil wrote:
>>>> On Mon, 3 Aug 2015, Owen Synge wrote:
>>
>>> I will check the rgw.
>>
>> It is not working due to missing:
>>
>> /usr/lib/ceph-radosgw/ceph-radosgw-prestart.sh
>>
>> which is a useful check tool, available in this commit:
>>
>> https://github.com/SUSE/ceph/commit/92ef2ecfe0c0c0b0df4c9349310f930057202305
> 
> I removed this reference from the unit file, see
> 
> 	https://github.com/ceph/ceph/commit/4d10dc134b817160bab6aecb9f5c08fb2d4f08e6
> 
> mainly because I didn't have a copy of the prestart script in my tree.  

Ah ok, I lost that during my merges.

> Looking at it now, though, it's not clear to me that any of those steps 
> are necessary.

You are correct, the code will run without the prestart script.

the prestart script is _only_ validating that the deamon should run
because the rgw often fails with confusing to end user errors.

The prestart code shoudl in my opinion be mostly implement in C++ in rgw.


> They might be useful in making a legacy install/config 
> continue functioning, 

No its just validation.

> but I don't think any of the complexity is needed
> for newly created rgw instances, and I'd prefer to make the upgrade 
> process look like
> 
>  - upgrade ceph
>  - killall radosgw
>  - [optional] rename and sanitize ceph.conf section if there are special 
> configs
>  - ceph-deploy rgw create $hostname
> 
> than worry about trying to keep supporting the kludgey way we used 
> to deploy rgw.

Yes, no objections at all.

> FWIW with the wip-systemd branch I was able to deploy new rgw instances 
> on fc22 without any issues...

Great news, I hope the wip-systemd branch of ceph-deploy adds hardly any
branching, like the SUSE version adds little, so it should have no
justification to do so, and could even reduce branching in ceph-deploy.

Best regards

Owen
