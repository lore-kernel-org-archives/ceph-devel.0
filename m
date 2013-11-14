From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Mourning the demise of mkcephfs
Date: Fri, 15 Nov 2013 10:56:40 +1300
Message-ID: <52854718.7000804@catalyst.net.nz>
References: <5281192D.4090707@bob-the-boat.me.uk> <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com> <5282F309.2030104@catalyst.net.nz> <5282F7FB.4070803@catalyst.net.nz> <5284C1C0.2080909@bob-the-boat.me.uk> <5284DD4E.4080609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:57479 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641Ab3KNV4x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 16:56:53 -0500
In-Reply-To: <5284DD4E.4080609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>, "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: Alfredo Deza <alfredo.deza@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 15/11/13 03:25, Mark Nelson wrote:
> On 11/14/2013 06:27 AM, Dave (Bob) wrote:
>> I would suggest that it is always dangerous to make assumptions.
>> If ceph-deploy needs some information, then this should be explicit, and
>> configurable.
>> If it needs to know whether initialisation is done by systemd, upstart,
>> or sysv init, then what is wrong with requesting a config option?
>>
>> As it happens, ceph-deploy doesn't seem to be what I require as a
>> mkcephfs replacement.
>> An earlier exchange with Mark suggests that it wants to involve itself
>> with the installation of software, and the configuration of startup
>> mechanisms.
>
> I am not an expert on ceph-deploy by any means.  ceph-deploy can do 
> these thing (install software, startup, etc), but I don't think it 
> strictly has to.
>
>> This is not what I want, and it is not any part of what mkcephfs did.
>>
>> Given that I have ceph installed, and a bunch of disk drives, I need to
>> be able to drive the ceph applications appropriately to set up the
>> osd's, keys, and other required data so that I can start the
>> ceph-osd(s), the ceph-mon(s), and the ceph-mds(s) [which I can do by
>> typing! (and I can make systemd do it automatically if and when I find
>> that I'm ready for that)].
>>
>> This is what mkcephfs did.
>>

As Mark said, you can do that with ceph-deploy.  It *will* try to start 
the mon(s) and osd(s), but that is not usually a problem. I use 
ceph-deploy on systems where I've built ceph from source with no 
problems (actually once you get used to it, ceph-deploy is really very 
easy to use, and I *now* find it more convenient than mkcephfs ever was).

Cheers

Mark
