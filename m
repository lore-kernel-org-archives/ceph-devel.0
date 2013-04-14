From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: osd stops
Date: Sun, 14 Apr 2013 07:07:17 +0200 (CEST)
Message-ID: <be5ef859-228b-4c98-a8a6-1870fface1ea@mail.linserv.se>
References: <ab2410b5-fe4c-4600-a2c0-f36a708fb6e2@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:38311 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3DNFSh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Apr 2013 01:18:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 0FA1E5E004
	for <ceph-devel@vger.kernel.org>; Sun, 14 Apr 2013 07:07:19 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWze4HhqHPlN for <ceph-devel@vger.kernel.org>;
	Sun, 14 Apr 2013 07:07:17 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id CD42C5E003
	for <ceph-devel@vger.kernel.org>; Sun, 14 Apr 2013 07:07:17 +0200 (CEST)
In-Reply-To: <ab2410b5-fe4c-4600-a2c0-f36a708fb6e2@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have a ceph cluster running bobtail 0.56.4

I have been playing with the rbd images and kvm.
The hardware for the osd,mon is 3 x HP G5 and 2 x SATA 2TB disk.
and 2xSAS for the journals. (Old hardware)

I have one host running kvm-rbd against the setup.
The network is 1GB network.

The scenario is as follows. I run my vm servers for some day/s
then it hangs the cluster starts to recover and 2 osd+mon are down.
And i have to restart that server.=20
Health goes to OK after recovering and I can continue.

I have noticed that i get high load related ceph-mon and osd
on one of the hosts. The host that get high load is not always the same=
=2E
I guess that=E2=80=99s the host that the kvm-host uses for mon.

What i can't figure out is why the osd's are stopping/crashing.
And all load is sent to only that server mon, if that's what is happeni=
ng ????
Is it's possible to limit something. It feels like i'm overloading the =
system ????

I have not turned on debug. Please let me know if any logs would be of =
any interest.

 /Best Regards Martin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
