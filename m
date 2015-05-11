From: John Spray <john.spray@redhat.com>
Subject: Re: autodetecting init system.
Date: Mon, 11 May 2015 17:37:30 +0100
Message-ID: <5550DACA.4070504@redhat.com>
References: <5550D903.8000802@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbbEKQhf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 May 2015 12:37:35 -0400
In-Reply-To: <5550D903.8000802@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

On 11/05/2015 17:29, Owen Synge wrote:
> Dear all,
>
> Many init systems are used in linux now. Some ceph code needs to know
> the init system. (I must admit I have not looked into Solaris, MacOS and
> BSD and probably should have)
>
> It would be nice to have one function that detects the init system
>
> Since the init system can be specified in ceph and ceph-deploy
> explicitly it seems to be its reasonable to fail clearly to detect init
> system.
I think I'm missing some background here.  I was under the impression 
that distros generally had a preferred init system (even if they let you 
switch), and if another is in use then compatibility links are usually 
provided (e.g. sysv-style calling through to systemd or vice versa).  
Given that, the distro packaging then uses whatever the "right" way to 
start a service is for that distro, and it's up to the distro to make 
sure that command is available.

Otherwise don't we descend into a kind of madness where a package 
post-install script can't start a service, because it doesn't know what 
command to run?

Cheers,
John

