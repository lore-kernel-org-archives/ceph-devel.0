From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 1 Dec 2015 17:24:52 +0100
Message-ID: <565DC9D4.7060701@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:24902 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbbLARDb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 12:03:31 -0500
In-Reply-To: <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mykola Golub <mgolub@mirantis.com>, "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 1-12-2015 15:35, Sage Weil wrote:
> On Tue, 1 Dec 2015, Willem Jan Withagen wrote:
>> On 1-12-2015 14:30, Sage Weil wrote:
>>> On Tue, 1 Dec 2015, Willem Jan Withagen wrote:
>>>> On 30-11-2015 14:21, Sage Weil wrote:
>>>>> The problem with all of the porting code in general is that it is doomed
>>>>> to break later on if we don't have (at least) ongoing build tests.  In
>>>>> order for a FreeBSD or OSX port to continue working we need VMs that run
>>>>> either gitbuilder or a jenkins job or similar so that we can tell when
>>>>> it
>>>>> breaks.
>>>>>
>>>>> If someone is willing to run a VM somewhere to do this we can pretty
>>>>> easily stick it on the gitbuilder page at
>>>>>
>>>>> 	http://ceph.com/gitbuilder.cgi
>>>>
>>>>
>>>> Hi Sage,
>>>>
>>>> Could you give some pointers as to where to start running the tests.
>>>> I see a lot of "basic" tests to see if the platform is actually
>>>> conformant.
>>>>
>>>> So before plunging into running ceph-mon and stuff, it would perhaps be
>>>> better to actually run (parts of) the basic required tests..
>>>
>>> I would start with 'make check' from src/... that's what we'd actually
>>> want the gitbuilder to do.
>>
>> I was running that at the moment....
>> Found the suggestion on the developers pages, in the manual section.
>> Sort of hidden at the bottom. :)
>>
>> Did kill it in between, but now when I run it, it just only generates the
>> report.
>> So I just went make clean, which is rather too much...
>> But could not really figure out the makefiles in test (yet)
>>
>> How do I reset the test results?
>
> I don't think there is anything to reset... just re-ru make check.  The
> exception is probably just if you hit control-c but it left running
> processes behind (./stop.sh should clean those up).
>

'mmm,
Strange I had it generate tests.... at one point.
And now just plain nothing....

Server has rebooted, so there should have nothing been left.

> At least, that's the case on Linux.. maybe the (auto)tools are a bit
> different on *BSD?

I think in the short run it will not be the code that is going to be a
major porting pain. But getting the run-time environment ironed out is
just plain (hard) work. Things where /bin/sh expects certain bash-isms.
Where paths have not been setup to the fullest all the way back into
./configure: like ${initrddir} => /etc/init.d versus /usr/local/etc/rc.d.
Probably plenty more like these.

I've also seen calls in the code to things like:
	arch
	hdparm
things that just are not there in (basic) FreeBSD....
But we'll get around al of that.

I survived porting Unix tools (including UUCP) to Win95 and OS/2. So
until we get to kernel things I just keep pushing along.

Just for clarity:
Gitbuilder just runs:
	make check
and collects the output?
So that would be the way to tackle this, get complete (successful) output
from:
	gmake clean && gmake test


--WjW
