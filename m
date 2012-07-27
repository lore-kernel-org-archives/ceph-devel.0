From: Wido den Hollander <wido@widodh.nl>
Subject: RBD support in CloudStack 4.0
Date: Sat, 28 Jul 2012 00:28:26 +0200
Message-ID: <5013160A.5000509@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56146 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab2G0W20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jul 2012 18:28:26 -0400
Received: from [IPv6:2a00:f10:11c:ab:b86d:9128:f4ca:37f5] (unknown [IPv6:2a00:f10:11c:ab:b86d:9128:f4ca:37f5])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id 1E3FC40386
	for <ceph-devel@vger.kernel.org>; Sat, 28 Jul 2012 00:28:23 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

About 24 hours ago the RBD support for CloudStack got merged [0] into 
the master branch of CloudStack.

At the moment we're (I'm a CloudStack committer) planning the release 
for CloudStack 4.0. Right now it seems that CS 4.0 will be released in 
early september.

Since my last e-mail a couple of things have changed:
* libvirt 0.9.13 got released with RBD storage pool support [1]
* libvirt-java 0.4.8 with a couple of bugfixes got released [2]

To run CloudStack with RBD support you need:
* libvirt 0.9.13 with RBD enabled
* libvirt-java 0.4.8 (included with CloudStack)
* Qemu with RBD support enabled

In August there will be a release candidate (probably multiple) of 4.0 
before the final release in September goes out. Testing is needed! So if 
you got some spare hardware and time, please do test CS 4.0 and the RBD 
support.

Bugs can be reported on the CloudStack development list, via 
bugs.cloudstack.org or directly to me (while I prefer public).

The guys from Inktank are currently working on documentation which will 
hopefully be out before the CS 4.0 release.

If you have any problems with getting CloudStack and RBD running, please 
do ask!

Wido

[0]: 
https://git-wip-us.apache.org/repos/asf?p=incubator-cloudstack.git;a=commit;h=406fd95d87bfcdbb282d65589ab1fb6e9fd0018a
[1]: http://libvirt.org/sources/libvirt-0.9.13.tar.gz
[2]: http://libvirt.org/sources/java/libvirt-java-0.4.8.tar.gz
