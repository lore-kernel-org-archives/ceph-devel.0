From: Wido den Hollander <wido@widodh.nl>
Subject: Links to various language bindings
Date: Fri, 08 Feb 2013 10:06:05 +0100
Message-ID: <5114BFFD.1060807@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46417 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946045Ab3BHJGJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 04:06:09 -0500
Received: from [IPv6:2a00:f10:113:0:f944:6048:3793:55af] (unknown [IPv6:2a00:f10:113:0:f944:6048:3793:55af])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 2B52CDEE73
	for <ceph-devel@vger.kernel.org>; Fri,  8 Feb 2013 10:06:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I knew that there were Java bindings for RADOS, but they weren't linked.

Well, some searching on Github lead me to Noah's bindings [0], but it 
was a bit of searching.

I expect new users to be less fortunate and end up searching endlessly 
for them.

The docs say this now: 
http://ceph.com/docs/master/api/#rados-object-store-apis

Only the libcephfs bindings are linked to, but they are part of the main 
repository (which still puzzles me..).

For what I know bindings exist for Java[0], PHP[1] and Python, but it's 
not to be found anywhere.

Shall I submit a patch to put this in the docs or should this go on 
ceph.com itself?

I'd go for the docs so we can also include some simple samples for 
people who are less experienced with Ceph/RADOS and just want to get 
started, maybe developers who's only task is just to work with RADOS.

Wido

[0]: https://github.com/noahdesu/java-rados
[1]: https://github.com/ceph/phprados
