From: Dan Mick <dan.mick@inktank.com>
Subject: Re: 0.55 init script Issue?
Date: Fri, 07 Dec 2012 13:38:43 -0800
Message-ID: <50C261E3.4000007@inktank.com>
References: <50BF7314.2020809@gammacode.com> <50BFA354.7040308@inktank.com> <50BFABE5.1020904@ubuntu.com> <CAPYLRzjme=UxScsKDXdKPAWJyfxB1hNQGRJWT7QyJk+ET3dFHQ@mail.gmail.com> <alpine.DEB.2.00.1212051610560.16078@cobra.newdream.net> <alpine.DEB.2.00.1212060534110.13653@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:49380 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab2LGVir (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 16:38:47 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so359909dak.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Dec 2012 13:38:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212060534110.13653@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, James Page <james.page@ubuntu.com>, Mike Dawson <mdawson@gammacode.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It did not delete the previously-installed /etc/init/ceph.conf; I'm 
guessing we need a postinstall fragment to do that fixup?

On 12/06/2012 05:35 AM, Sage Weil wrote:
> On Wed, 5 Dec 2012, Sage Weil wrote:
>> On Wed, 5 Dec 2012, Gregory Farnum wrote:
>>> On Wed, Dec 5, 2012 at 12:17 PM, James Page <james.page@ubuntu.com> wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA256
>>>>
>>>> On 05/12/12 19:41, Dan Mick wrote:
>>>>> The story as best I know it is that we're trying to transition to
>>>>> and use upstart where possible, but that the upstart config does
>>>>> not (yet?) try to do what the init.d config did.  That is, it
>>>>> doesn't support options to the one script, but rather separates
>>>>> daemons into separate services, and does not reach out to remote
>>>>> machines to start daemons, etc.
>>>>>
>>>>> The intent is that init.d/ceph is left for non-Upstart distros,
>>>>> AFAICT.
>>>>>
>>>>> Tv had some design notes here:
>>>>>
>>>>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09314.html
>>>>>
>>>>>   We need better documentation/rationale here at least.
>>>>
>>>> Maybe it might be better if the ceph init script and the ceph upstart
>>>> configuration did not namespace clash; how about shifting the name of
>>>> the ceph upstart configuration to ceph-all?
>>>
>>> Yeah, this or something very similar is definitely the correct
>>> solution. Sage recently added the "ceph" upstart job, and we didn't
>>> put it through sufficient verification prior to release in order to
>>> notice this issue. Users who aren't using upstart (I expect that's all
>>> of them) should just delete the job after running the package install.
>>> We'll certainly sort this out prior to the next release; I'm not sure
>>> if we want to roll a v0.55.1 right away or not.
>>
>> Let's push it to the testing branch, but make sure any other fixes are
>> there before rolling a .1.. maybe tomorrow?
>
> I've pushed this to the testing branch.  If someone wants to verify the
> packages built at
>
> 	http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/testing/
>
> are fixed, that would be fabulous!
>
> sage
>
>
>> Thanks!
>> sage
>>
>>
>>> -Greg
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
