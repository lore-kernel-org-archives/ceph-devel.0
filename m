From: Kewaan Ejaz <kewaan.ejaz@office.nacamar.de>
Subject: Re: Ceph disk
Date: Tue, 07 Apr 2015 15:17:56 +0200
Message-ID: <1428412676.22152.101.camel@NAC>
References: <ruevn0vmi9p4p1m5biuhx7sc.1427804698773@email.android.com>
	 <1427827660.6486.7.camel@debian> <551AFD59.70209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.newmedia.nacamar.net ([62.27.60.172]:43627 "EHLO
	mail01.newmedia.nacamar.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756059AbbDGNXy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 09:23:54 -0400
In-Reply-To: <551AFD59.70209@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <loic@dachary.org>


Hi Folks,

Sorry for the lack of updates from my side. Actually, we had a few crashes in our openstack cluster (nothing out of the norm) but due to easter holidays, manpower has been quite tight. I am also working on recovering/setting up those lost compute nodes to make the resources available for our environment. I will update you all
once the pressure is gone. Thanks for your understanding!

Best Regards,
Kewaan.
On Tue, 2015-03-31 at 22:02 +0200, Loic Dachary wrote:
> [cc'ing ceph-devel public mailing list]
> 
> Hi,
> 
> On 31/03/2015 20:47, Kewaan Ejaz wrote:
> > Hello Loic,
> > 
> > Thank you again for the opportunity to contribute to ceph. I am not sure
> > how am I suppose to proceed but I have the following things in mind;
> 
> Thanks for proposing to help :-)
> 
> > 1) Fully understanding the ceph-disk code
> > 2) I would start using the ceph-disk in my sandbox environment
> > (Virtualbox)
> 
> You'll find that it's fairly straightforward: one file, all in it. There is room for improvement.
> 
> https://ceph.com/git/?p=ceph.git;a=blob;f=src/test/ceph-disk.sh are the tests that make check will run 
> https://ceph.com/git/?p=ceph.git;a=blob;f=src/test/ceph-disk-root.sh are the tests that make check will run if ./configure --enable-root-make-check is used but you can also run one manually with cd src ; sudo test/ceph-disk.sh test_activate_dev and it will use the /dev/loop device to simulate a disk. A few sanity checks were added recently to verify that the loop device has been loaded with the necessary loop.max_part=16 (or more) parameter and that /dev/disk/part-byuuid is populated as expected. 
> 
> > I think I would require a week to get back to you. But other than that,
> > let me know what kind of VM do you have in mind. For example,
> > 
> > 1) What kind of OS would you prefer from the Openstack cluster?
> 
> I feel more confortable with Debian or Ubuntu but CentOS or Fedora are also fine. What is required for test purposes is a dedicated tenant with the ability to run two virtual machines, 1GB RAM, 10GB disk, 1core. We would need a variety of images to test against (Ubuntu 12.04 + 14.04, Debian jessie, CentOS 7 + 6, Fedora 20 + 21, OpenSUSE 13.2).
> 
> > 2) We are not using Cinder or Swift in our Openstack cluster. Is that a
> > Problem?
> 
> That will be fine: the loop device can be used as a spare disk instead of provisioning one with cinder. 
> 
> As soon as you can have that OpenStack tenant ready, it can be used with https://github.com/osynge/whatenv to run tests for https://github.com/ceph/ceph/pull/4036 and verify that the detection system actually works as expected. 
> 
> And once it's done, we could make it so this test is run whenever a pull request is posted that modifies ceph-disk and ensure we're not risking a regression. It would be a very valuable service. Not too CPU intensive either since we're not seeing more than a few patches on ceph-disk every month.
> 
> Cheers
> 
> > Best Regards,
> > Kewaan.
> 
> 



