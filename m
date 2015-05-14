From: Tim Serong <tserong@suse.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Thu, 14 May 2015 22:16:06 +1000
Message-ID: <55549206.3040008@suse.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com> <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com> <87bnip2u10.fsf@meteor.durcheinandertal.bofh> <553E07C7.8030905@suse.com> <alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:60939 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932456AbbENMQ1 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 14 May 2015 08:16:27 -0400
In-Reply-To: <alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel@vger.kernel.org, cjwatson@debian.org, ceph-maintainers@ceph.com, timm@fnal.gov, Owen Synge <osynge@suse.com>

On 04/28/2015 02:02 AM, Sage Weil wrote:
>> much progress on the SUSE front.  I did suggest everyone just do what
>> Debian does ;) but both Fedora and SUSE people pointed out that the 64K
>> range isn't safe to claim, what with not being specifically reserved.
>>
>> I did make one small bit of progress - I've added the ceph user and
>> group to rpmlint on openSUSE Factory
>> (https://build.opensuse.org/request/show/303537) so at least the SUSE
>> build won't bitch if files specified in any of the packages are owned by
>> ceph:ceph.

It is my sad duty to report that I've been unable to get a static
UID/GID allocated for SLES or openSUSE.

TL;DR:

* There's nothing free in the reserved static range 0-99.
* We can't take something from the unreserved ranges (500-999,
60001-64K) and hope for the best due to potential conflicts with old
systems, LDAP users on those ranges, customers, etc. etc.

Consequently I would like to propose the following as a least-worst
fallback/workaround:

1) Add functionality to ceph-deploy to create the user and group during
`ceph-deploy install`.  This would happen iff new (optional) --ceph-uid
and --ceph-gid arguments[1] were passed to `ceph-deploy install`, and
would happen before any ceph packages are installed.  This would allow
individual sites to choose the UID/GID so they know it doesn't conflict
with anything already in use.

2) Add a guard to the %pre script in the RPM so it only invokes `useradd
and `groupadd` if the ceph user and group don't already exist.

If the UID and GID aren't specified during `ceph-deploy install`, then
it'll fall back to "next available" in the system range when
useradd/groupadd are invoked in the rpm %pre script.

The above should have no impact on other distros where a fixed UID/GID
is already set in the package.

Does this sound viable?

Regards,

Tim

[1] Or, possibly, it should force both UID and GID to the same number,
meaning we only need one argument, say --ceph-uidgid?
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
