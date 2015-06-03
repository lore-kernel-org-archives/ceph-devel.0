From: Owen Synge <osynge@suse.com>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 03 Jun 2015 22:33:04 +0200
Message-ID: <556F6480.1090901@suse.com>
References: <556F1E19.6080704@suse.com> <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:60187 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbbFCUeb (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 3 Jun 2015 16:34:31 -0400
In-Reply-To: <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 06/03/2015 06:26 PM, Sage Weil wrote:
> On Wed, 3 Jun 2015, Owen Synge wrote:
>> Dear ceph-devel,
>>
>> Linux has more than one init systems.
>>
>> We in SUSE are in the process of up streaming our spec files, and all
>> our releases are systemd based.
>>
>> Ceph seems more tested with sysVinit upstream.
>>
>> We have 3 basic options for doing this in a packaged upstream system.
>>
>> 1) We dont install init scripts/config as part of "make install" and
>> "install all the init components via conditionals in the spec file.
>>
>> 2) We install all init scripts/config for all flavours of init using
>> make install and delete unwanted init systems via conditionals in the
>> spec file.
>>
>> 3) We add autotools an conditional for each init system, and only
>> install with make install enabled init systems scripts/config.

<snip/>

>>
>> Their are many ways to follow policy 3 so I would propose that when no
>> init system is followed, policy (1) and policy (3) should appear identical.
>>
>> -----
> 
> Let's do it!

Great :)

<snip/>


> I'm hoping that phase 3 can be avoided entirely.  The upgrade/conversion 
> path (at least for upstream packages) will be firefly -> infernalis; I'm 
> don't think it will be that useful to build infernalis packages that do 
> sysvinit for systemd distros.  (Maybe this situation gets more 
> complicated if we backport this transition to hammer or downstream does 
> the same, but even then the transition will be an upgrade one.)

Agreed,

<snip/>

> Also, I think we should do 1 and 2 basically at the same time.  I don't 
> think it's worth spending any effort trying to make things behave with 
> just 1 (and not 2).
> 
> Am I talking sense?  I can never tell with this stuff.  :)
> 
> sage

I think you speak sense,

If I underwstand right you favor the user interface as:

	--with-init=systemd
	--with-init=sysv
	--with-init=upstart
	--with-init=bsd

This is wiser when you start adding up all the possible init systems
that can exist.

Owen
