From: James Page <james.page@ubuntu.com>
Subject: Re: [Openstack] Ceph/OpenStack integration on Ubuntu precise: horribly
 broken, or am I doing something wrong?
Date: Thu, 21 Jun 2012 20:43:10 +0100
Message-ID: <4FE3794E.8000700@ubuntu.com>
References: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com> <4FD21ECC.7040906@inktank.com> <4FD2217F.8040804@ubuntu.com> <CAPUexz9WtA3K8SN=vau1q0BwLW3bP3qU-SMWQt2yktR6_aVSPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35580 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2FUTnP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 15:43:15 -0400
In-Reply-To: <CAPUexz9WtA3K8SN=vau1q0BwLW3bP3qU-SMWQt2yktR6_aVSPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: openstack@lists.launchpad.net, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Florian

On 08/06/12 17:11, Florian Haas wrote:
>>> Hi Josh
>>> 
>>> On 08/06/12 16:48, Josh Durgin wrote:
>>>>> There's an Ubuntu bug already:
>>>>> 
>>>>> https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/981130
>>>>> 
>>>>> librgw was not complete, and wasn't actually used by
>>>>> radosgw, so it was dropped. The Ubuntu package just needs
>>>>> to be updated to remove the dependency and rgw.py, like
>>>>> upstream did.
>>> 
>>> You can type faster than I can... I'm working on getting this
>>> resolved in the current dev release of Ubuntu in the next few
>>> days after which it will go through the normal SRU process for
>>> Ubuntu 12.04.
> Sweet, thanks!

The SRU to resolve the install-ability of python-ceph have just
complete verification and should be available in Ubuntu 12.04 updates
in the next few hours (depending on which mirror you use).

Cheers

James

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJP43lOAAoJEL/srsug59jDDJIP/2D19BaGN04rycrPHfIzlApX
r8Tb0Du2B1pskRyN+cPZ6fW7ygjgbM/ZWFd3g1ozg1cpWCiTK6w2Y0NmMQqe/f0G
nCVewI5bhvPFD2roGPJx6LqfK8qHA53CVjJUeqlhKbsUajNCybr6Fpgi3Nknt5u/
kZ0CVu3BQKhR2x6hZkwxMm87gGRAz/Z2rD+BkmErVcYfMHEdA8BajABz9CePexeB
1tlN5/PeAMbC5mNQTsx+QtpGd64KJNx/oRBzJxyUCEP07rPbNI7a3ZmQsvhXiNtc
EoZPhd/JoL/RKHJRB13e8NIc7jPqtqfHy1Un5nqCIDZurtlLnAT4Qo0m0wh70Xv8
rSShpRMe9n6ob/7T1n2iu4XYWdXNFoAaggZ6lrNkJLSMCr+NOhYwjdk4qVlP5oQJ
39aPcribmnEYymf6eVqqGGxpvHwUHvI6zdLm58zTwMpkymdtZdhC12W6O5rT3AG7
B0wXtvmUK23rtA0RdAIT8/gSTdMQ8cLcMqqLxEx0VQQ/Ma0LEBQhGy3zUuPElEZC
SGnqSmKif7LENQr+hAAsOYNIo3uqPamqStzHuWnh0sa2mStOM9LaFife6pWbJizt
MvwKNzTftiWc8LwkM+VvjYuhnMjTXo9XbXxKkT5sadGj+THG+RZTdizqKIywL9vX
+ZvnnBKr3+M00jJqjX0J
=ID+V
-----END PGP SIGNATURE-----
