From: Owen Synge <osynge@suse.com>
Subject: Re: autodetecting init system.
Date: Tue, 12 May 2015 09:25:47 +0200
Message-ID: <5551AAFB.5070307@suse.com>
References: <5550D903.8000802@suse.com> <5550DACA.4070504@redhat.com> <alpine.DEB.2.00.1505111032530.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:47201 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbELH0w (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 12 May 2015 03:26:52 -0400
In-Reply-To: <alpine.DEB.2.00.1505111032530.28239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 05/11/2015 07:34 PM, Sage Weil wrote:
> On Mon, 11 May 2015, John Spray wrote:
>> On 11/05/2015 17:29, Owen Synge wrote:
>>> Dear all,
>>>
>>> Many init systems are used in linux now. Some ceph code needs to know
>>> the init system. (I must admit I have not looked into Solaris, MacOS and
>>> BSD and probably should have)
>>>
>>> It would be nice to have one function that detects the init system
>>>
>>> Since the init system can be specified in ceph and ceph-deploy
>>> explicitly it seems to be its reasonable to fail clearly to detect init
>>> system.
>>
>> I think I'm missing some background here.  I was under the impression that
>> distros generally had a preferred init system (even if they let you switch),
>> and if another is in use then compatibility links are usually provided (e.g.
>> sysv-style calling through to systemd or vice versa).  Given that, the distro
>> packaging then uses whatever the "right" way to start a service is for that
>> distro, and it's up to the distro to make sure that command is available.
>>
>> Otherwise don't we descend into a kind of madness where a package post-install
>> script can't start a service, because it doesn't know what command to run?
> 
> Ceph daemons are marked with a file like 
> /var/lib/ceph/$type/.../{upstart,systemd,sysvinit} indicating which init 
> system is responsible for starting/stopping them.  This is necesary mainly 
> because on most systems they *do* coexist--at least with sysvinit scripts.
> 
> Owen, this is basically what ceph-detect-init is doing now, right?

ceph-detect-init detects the init system and is intended to be used for
marking the init system. Once marked the init system will not need to be
detected a second time.

> IIRC the users are:
> 
>  - ceph-disk, when creating a new osd
>  - ceph-deploy, when deploying a mon or mds or rgw

Yes though maybe it will be used by other services such as mon and mds
if needed in the future.

Best regards

Owen
