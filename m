From: Owen Synge <osynge@suse.com>
Subject: Re: autodetecting init system.
Date: Mon, 11 May 2015 19:26:48 +0200
Message-ID: <5550E658.3010806@suse.com>
References: <5550D903.8000802@suse.com> <5550DACA.4070504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:37965 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbEKR1w (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 11 May 2015 13:27:52 -0400
In-Reply-To: <5550DACA.4070504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org

On 05/11/2015 06:37 PM, John Spray wrote:
> On 11/05/2015 17:29, Owen Synge wrote:
>> Dear all,
>>
>> Many init systems are used in linux now. Some ceph code needs to know
>> the init system. (I must admit I have not looked into Solaris, MacOS and
>> BSD and probably should have)
>>
>> It would be nice to have one function that detects the init system
>>
>> Since the init system can be specified in ceph and ceph-deploy
>> explicitly it seems to be its reasonable to fail clearly to detect init
>> system.
> I think I'm missing some background here.  I was under the impression
> that distros generally had a preferred init system (even if they let you
> switch), and if another is in use then compatibility links are usually
> provided (e.g. sysv-style calling through to systemd or vice versa). 
> Given that, the distro packaging then uses whatever the "right" way to
> start a service is for that distro, and it's up to the distro to make
> sure that command is available.

I am not sure that sysV can emulate systemd, but systemd can and does
emulate sysV by default on SUSE and I think also debian .

> Otherwise don't we descend into a kind of madness where a package
> post-install script can't start a service, because it doesn't know what
> command to run?

I have not yet tested converting ubuntu or debian latest releases with
non standard init systems (anything other than systemd).

The main reason is I do expect the exact "madness" you predict, that
said they claim support for this.

best regards

Owen
