From: Wido den Hollander <wido@42on.com>
Subject: Libvirt patch for Ubuntu 14.04 to create image format 2 by default
Date: Fri, 17 Jan 2014 14:39:50 +0100
Message-ID: <52D932A6.90808@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:48463 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbaAQNjx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jan 2014 08:39:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>

Hi James (CC to devel),

I've been trying to get a patch [0] into libvirt for the last couple of 
months to have libvirt create RBD images format 2 by default.

The response from the RedHat people has been zero until thus far. Since 
this would be great for both OpenStack and CloudStack I'm thinking about 
Ubuntu 14.04.

If the patch makes it into Libvirt in let's say 6 weeks it will probably 
not make it into 14.04 since that has been feature frozen.

Is there a way we can get this patch into Libvirt for Ubuntu 14.04? I'm 
confident it will make it into Libvirt upstream, I just need somebody to 
look at it.

[0]: https://www.redhat.com/archives/libvir-list/2013-December/msg00645.html

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
