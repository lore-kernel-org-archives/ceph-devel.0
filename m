From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: v0.56 released
Date: Thu, 03 Jan 2013 05:00:03 +0100
Message-ID: <50E50243.6060301@conversis.de>
References: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net> <50E39A4E.1060700@conversis.de> <50E39B68.40800@inktank.com> <CAOLwVUnYP1HTfimBf2PKBW5TA7gSuKRhsB1u6YPwUQGs633mvg@mail.gmail.com> <alpine.DEB.2.00.1301020935270.13956@cobra.newdream.net> <CAOLwVU=3W-QQ2tsdCGU4zq2OUiiTv7tFE20z20k2dgXQL7WknQ@mail.gmail.com> <alpine.DEB.2.00.1301021010310.13956@cobra.newdream.net> <50E49814.9000904@conversis.de> <alpine.DEB.2.00.1301021245410.13956@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:53789 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab3ACEAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 23:00:06 -0500
In-Reply-To: <alpine.DEB.2.00.1301021245410.13956@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 01/02/2013 09:46 PM, Sage Weil wrote:
> On Wed, 2 Jan 2013, Dennis Jacobfeuerborn wrote:
>> On 01/02/2013 07:11 PM, Sage Weil wrote:
>>> On Wed, 2 Jan 2013, S?bastien Han wrote:
>>>> Debian-testing shows the version 0.56-1, maybe I misunderstood but I
>>>> thought that 0.56-1 bobtail was the new version of the stable branch.
>>>> So I was expecting to see it here
>>>> http://ceph.com/debian/dists/precise/main/binary-amd64/Packages
>>>>
>>>> Correct me if I'm wrong :)
>>>
>>> It will be soon, but we're doing some additional validation before calling 
>>> it bobtail.  We may also move the URLs around a bit... more on that soon!
>>
>> What happens if you find a problem that needs a small update? Will the
>> bobtail version be bumped to v0.57?
> 
> v0.56.1, v0.56.2, etc., will follow in this series and bugs are found and 
> backported.

That sound like an odd and potentially confusing versioning policy because
v0.56 now is apparently a sort-of-stable-but-not-really version. I think if
would be better to either go with something like v0.56rc1 until the release
is actually declared stable or as some other projects do it use something
like v0.55.99 as a pre-release version. That way you know if someone refers
to v0.56 they actually mean the stable release.
Right now if you find a problem and have to release v0.56.1 as bobtail then
every time someone refers to v0.56 you have to ask them if they mean
pre-bobtail v0.56 or post-bobtail v0.56. This kind of ambiguity should be
avoided if possible.

Regards,
  Dennis

