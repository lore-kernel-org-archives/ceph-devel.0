From: Owen Synge <osynge@suse.com>
Subject: Re: wip-systemd
Date: Fri, 19 Jun 2015 14:40:56 +0200
Message-ID: <55840DD8.1000605@suse.com>
References: <alpine.DEB.2.00.1506181653300.15981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:51194 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFSMm0 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 19 Jun 2015 08:42:26 -0400
In-Reply-To: <alpine.DEB.2.00.1506181653300.15981@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Tim Serong <tserong@suse.com>

On 06/19/2015 02:10 AM, Sage Weil wrote:
> Hey Owen,

Hey Sage.

as of master merging

02ef5cf9b3ab1a4dbe13bdb3f036591f3ed0b6f7

you can finally build ceph as is master on opensuse 13.2 and SLE12 and
make an rpm.

Hopefully upstream can act on this news, and add this to their test suites.

At suse we have a great apprentice, joshua <jschmid> has an alpha (at
this moment) product for automating builds of ceph from git in OBS,
deploying them using ceph-deploy, on a open stack cloud with vm's
created by whatenv, and initially setup by chef.

We will use this to monitor master in future, hopefully spotting any
suse regressions quickly, enabling bisects.

This means I can put more effort into other less dull tasks, than tryign
to make opensuse build upstream master.

Such as what you propose:

> I suggest we create a wip-systemd branch where we pile in all of the fixes 
> around getting systemd working properly.  Right now we're super 
> conservative about merging into master to avoid breaking things but it'll 
> be easier to test everything all at once and it'll help me get packages 
> prepared that I can play with on this end.
> 
> What do you think?

I think this is a good idea.

The following pull requests:

pr 4763
pr 4790
pr 5029

Are a start of breaking down suse's systemd support for ceph and making
it work but they are not complete like ses:1 and ses:2 implementations
with ceph.

Of these pull requests pr 4763 is defiantly currently broken, and pr
5029 is now a fixed version of pr 4770, and 4790, seems to be fine too,
but getting these 3 pull requests get the bulk of this branch completed.

> The other pile is wip-user... I'm inclined to get systemd going 
> first before adding this complexity, though!

This would be to use systemd to handle non root operation of ceph ? I
carry on assuming so.

I actually think this will not be too much work.

I suspect different users its a lot more work for sysVinit.

The systemd part is I suspect trivial, I am most worried about the OSD's
and partitions with udev, but while I have not done it, I expect the
right answer is just a matter of hitting it with the right tiny patch to
what we have downstream.

Please let me know what I should do to best help?

Best regards

Owen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
