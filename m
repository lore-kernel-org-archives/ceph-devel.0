From: Owen Synge <osynge@suse.com>
Subject: Re: Fedora 22 systemd and ceph-deploy
Date: Tue, 04 Aug 2015 12:13:30 +0200
Message-ID: <55C0904A.8010902@suse.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <55BFBA99.4070205@suse.com> <alpine.DEB.2.00.1508031205360.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:38554 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752407AbbHDKP0 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 4 Aug 2015 06:15:26 -0400
In-Reply-To: <alpine.DEB.2.00.1508031205360.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 08/03/2015 09:07 PM, Sage Weil wrote:
> On Mon, 3 Aug 2015, Owen Synge wrote:
>> Dear all,
>>
>> My plan is to make a fedora22-systemd branch. I will leave fedora 20=
 as
>> sysvinit.
>>
>> Ok just done my first proper install of systemd ceph branch on fedor=
a22.
>>
>> I can confirm most of the issues.
>>
>> I am giving up for the day, but so far applying SUSE/opensuse code t=
o
>> Fedora ceph-deploy code in ceph-deploy has helped a lot.
>>
>>     cp /usr/lib/python2.7/site-packages/ceph_deploy/hosts/suse/mon/*=
 \
>>       /usr/lib/python2.7/site-packages/ceph_deploy/hosts/fedora/mon/
>>
>> (Running on suse version patched release)
>>
>> It can now set up the mon daemons correctly its self.
>>
>> I will look into the udev rules, tomorrow morning, and remove some m=
ore
>> fedora hard coding to "sysvinit".

I made a mistake, just doing the copy is enough to deploy mon and osd's
I had made a typo to make me believe osd deployment was not.

I will check the rgw.

> There is a wip-systemd branch ceph-deploy that has enough ceph-deploy=
=20
> changes for me to successfully do the deployment of mon, osd, mds, an=
d=20
> rgw. =20

So can we merge the wip-systemd branch of ceph?

This would then allow us to fix ceph-detect-init.

This would also make it clearer to ceph-deploy developers what they nee=
d
to do.

> The main thing it doesn't do is figure out which version of Ceph
> you're installing to decide whether to do systemd (post-hammer) or=20
> sysvinit (hammer and earlier).  That's going to be annoying, I'm afra=
id...

I have not looked at the  wip-systemd branch ceph-deploy, as I knew the
SUSE version supported systemd, and knew their is no SUSE magic in the
code as I wrote it, except supporting systemd.

In principle, I agree it is a nice to have release version of ceph,
changes in behaviour for ceph-deploy. I have great fears under the
existing code style that adding an extra dimension will cause an
explosion of branching code, in ceph-deploy which is in my opinion
already far too large in terms of LOC/functionality.

> I suspect what we really want to do is abstract out the systemd behav=
ior=20
> into something that the distros opt in to so that we aren't duplicati=
ng=20
> code across the suse, centos, rhel, and fedora host types...

Adding command line options to override "default" behaviour (or having =
a
model as in MVC design pattern) might be a good way to start improving
ceph-deploy to this objective.

My opinion is better use of fa=E7ade pattern to contain the explosion o=
f
conditionals and duplication that this would cause if the code is using
current coding style, but moving toward MVC will also help.

These 2 patches go a long way to solve the issues of duplicating code
across the suse, centos, rhel, and fedora host types:

https://github.com/ceph/ceph-deploy/pull/317
https://github.com/ceph/ceph-deploy/pull/318

Pull request #317 is how I should like to see the new code base evolve.
Pull request #318 is within the current ceph-deploy code structure to
see variables derived on a per distribution way.

Combined these two patches show how I would move forward on ceph-deploy=
=2E

This sort of fa=E7ade pattern seems to avoid code duplication, already
present all over the ceph-deploy code base.

=46or now I suspect it is far easier to back port the option to use
systemd to supported releases of hammer and earlier.

To delay progress of ceph on ceph-deploy, is in my opinion the wrong
thing to do, and I get the impression it is being maintained rather tha=
n
pushing ceph or its self forward.

Best regards

Owen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
