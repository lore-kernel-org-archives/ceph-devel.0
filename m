From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Fedora 21 packages
Date: Mon, 30 Mar 2015 10:30:31 +1000
Message-ID: <55189927.6040501@redhat.com>
References: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com> <alpine.DEB.2.00.1503281034470.18934@cobra.newdream.net> <551874D0.1090900@redhat.com> <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net>
Reply-To: bhubbard@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbbC3AbP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 Mar 2015 20:31:15 -0400
In-Reply-To: <alpine.DEB.2.00.1503291644260.8441@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 03/30/2015 09:45 AM, Sage Weil wrote:
> On Mon, 30 Mar 2015, Brad Hubbard wrote:
>> On 03/29/2015 03:36 AM, Sage Weil wrote:
>>> On Sat, 28 Mar 2015, Mustafa Muhammad wrote:
>>>> Hi,
>>>> I am trying to install ceph on Fedora 21, but I can't find the
>>>> packages, is there any?
>>>> If not, can you please provide packages? I think they are more
>>>> important than Fedora 20 packages since F21 has more support time
>>>> remaining.
>>>
>>> We don't have f21 packages yet; knee deep in other release issues.
>>>
>>> We are always looking for people interested in maintaining the upstream CI
>>> and build/release environment, though; it's a surprising amount of work
>>> keeping it all running!  There are other distros and architectures we're
>>> missing too (e.g. we have armv7l hardware but no time to resurrect the
>>> builds) for lack to time.
>>>
>>> sage
>>
>> They look like they are there to me. Am I missing something?
>>
>> $ cat /etc/redhat-release
>> Fedora release 21 (Twenty One)
>>
>> $ yum list ceph\* --showduplicates
>> Loaded plugins: langpacks
>> Installed Packages
>> ceph.x86_64
>> 1:0.80.9-1.fc21
>> @updates
>
> These packages are from downstream Fedora.  What's missing are more up
> to date packages built and published at ceph.com.  The distro only ships
> one version of Ceph (the most recent LTS), while ceph.com gets everything
> and ceph-deploy let's you choose which stable series or development branch
> to install.  We're also not doing any testing on f21.

Ah, okay, now I see what I was missing (I figured I *was* missing something :) ).

Cheers,
Brad
