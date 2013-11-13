From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Mourning the demise of mkcephfs
Date: Wed, 13 Nov 2013 16:33:29 +1300
Message-ID: <5282F309.2030104@catalyst.net.nz>
References: <5281192D.4090707@bob-the-boat.me.uk> <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37888 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867Ab3KMDdg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 22:33:36 -0500
In-Reply-To: <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <alfredo.deza@inktank.com>, "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 13/11/13 04:53, Alfredo Deza wrote:
> On Mon, Nov 11, 2013 at 12:51 PM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
>
>> It is unuseable for me at present, because it reports:
>>
>> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>>
> That looks like a bug. For the past few months the log output of
> ceph-deploy has tried to improve to give as much useful information
> as possible.
>
> To get to the bottom of this it would be super helpful to know what
> distro you were attempting to connect to, what the actual command was,
> and what version of ceph-deploy you were using.
>
> Hopefully, with that information and the (possible) bug fix, it will
> mean that more and more people find ceph-deploy as a robust solution
> to get
> a Ceph cluster up and running.
>
>

I believe he is using a self built (or heavily customized) Linux 
installation - so distribution detection is not going to work in this 
case. I'm wondering if there could be some sensible fall back for that, e.g:

- refuse to install or purge
- assume sysv init

so that ceph-deploy can 'do the best it can' in these situations. Thoughts?

Cheers

Mark
