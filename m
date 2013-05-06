From: Wido den Hollander <wido@42on.com>
Subject: Java bindings for RADOS and RBD
Date: Mon, 06 May 2013 17:21:34 +0200
Message-ID: <5187CA7E.2050508@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:51326 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306Ab3EFPVg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 May 2013 11:21:36 -0400
Received: from [IPv6:2a00:f10:11c:ab:b0f1:3750:60f3:b514] (unknown [IPv6:2a00:f10:11c:ab:b0f1:3750:60f3:b514])
	by websrv.42on.com (Postfix) with ESMTPSA id E0A63BFA4B
	for <ceph-devel@vger.kernel.org>; Mon,  6 May 2013 17:21:34 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

For the Apache CloudStack project I'm working on implementing the 
snapshotting and cloning features for RBD.

We (the project) want to stay away from invoking binaries like 'rbd' or 
'qemu-img' in the background since parsing the output and handling exit 
statuses can be hard to deal with.

So work around this I started working on Java JNA [0] bindings for 
librados and librbd [1]

The reason to use JNA is that it allows us to simply drop the bindings 
and run them without having them compiled against the librados or librbd 
headers.

The bindings are currently aimed at providing the functionality which 
CloudStack needs, which is mainly focused at RBD, but I've also 
implemented multiple RADOS operations.

I've chosen to implement both RADOS and RBD into the same package and 
using com.ceph.rados and com.ceph.rbd for as the package name. It could 
be splitted into different projects, but I think that won't benefit 
anybody. Having it all in one package seem easy, since RBD needs a RADOS 
IoCTX to work anyway.

I'd like to get some feedback on the bindings about the way they are 
now. They are still work-in-progress, but my Unit Testing shows me they 
are in a reasonable shape already.

Once the bindings reach a more mature state (which probably isn't that 
far away) I'd like to donate them to the Ceph project so they can live 
on Ceph's Github page instead of my personal one.

Getting them into Maven Central [2] won't be that easy, so I'd like to 
request space for that on ceph.com, for example ceph.com/download/maven 
and users will have to manually add that to their pom.xml configuration.

The request for a Maven repository is a bit selfish, since CloudStack 
uses Maven to build and during building it will need some place where it 
can fetch the artifacts.

So that's it for now, feedback and suggestions are more then welcome! 
(Patches / pull requests ditto!)

Related issues in the tracker:
- #4231
- #4232

[0]: https://github.com/twall/jna
[1]: https://github.com/wido/rados-java
[2]: 
http://maven.apache.org/guides/mini/guide-central-repository-upload.html

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
