From: Pascal de Bruijn <pascal@unilogicnetworks.net>
Subject: RADOS extensions directory
Date: Mon, 05 Nov 2012 10:30:20 +0100
Message-ID: <5097872C.8030803@unilogicnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out118.unilogicnetworks.net ([62.133.206.118]:49404 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753877Ab2KEKEE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 05:04:04 -0500
Received: from corp-mail.unilogicnetworks.net (corp-mail.unilogicnetworks.net [62.133.206.96])
	by mail.unilogicnetworks.net (Postfix) with ESMTP id A86A64A028
	for <ceph-devel@vger.kernel.org>; Mon,  5 Nov 2012 10:30:20 +0100 (CET)
Received: from [10.0.11.124] (unilogic.cust.unilogicnetworks.net [62.133.193.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pascal)
	by corp-mail.unilogicnetworks.net (Postfix) with ESMTPSA id 696FD4BE0F
	for <ceph-devel@vger.kernel.org>; Mon,  5 Nov 2012 10:30:08 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

In light of #cephday I noticed something that struck me as odd. The 
presenation listed the following as the RADOS extensions directory (if I 
recall correctly):

/var/lib/rados/*.so

However, it's very atypical to have shared libraries in /var. As far as 
I know /var/lib is typically used for persistent (non-executable) 
storage (think dpkg for example).

So I'm guessing /usr/lib/rados/*.so would probably be a more suitable 
home for the RADOS extensions.

While this isn't the most important thing in the world, I guess it makes 
sense to change this now as it's not a commonly used feature yet (read 
there are no third party packages depending on this location yet).

In addition when submitting the code for inclusion into Debian/Fedora, I 
wouldn't be surprised if they had similar "objections".

At #cephday I briefly spoke to Wido about this, if I recall correctly he 
confirmed this was sortof a known issue. If that's correct please view 
this e-mail just as a reminder or something.

Regards,
Pascal de Bruijn
