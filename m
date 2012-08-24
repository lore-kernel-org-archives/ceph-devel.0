From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RBD kernel: Weird messages about "connect authorization failure" or
 "socket closed"
Date: Fri, 24 Aug 2012 09:45:33 +0200
Message-ID: <CAF6-1L4q5PsDjE=393oOjRZ56n-=7XjdQQu0i+1KhOeWc7KsGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55666 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab2HXHpe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 03:45:34 -0400
Received: by vbbff1 with SMTP id ff1so1757076vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 00:45:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm running RBD kernel client on two machine. One is running 3.6-rc2
and the other is running Ubuntu's 3.2.0.
Ceph is 0.48.1 running on Ubuntu precise.


The 3.6.2-rc gives this :

[145442.041999] libceph: osd2 10.208.3.71:6800 socket error on read
[146343.040635] libceph: osd2 10.208.3.71:6800 socket closed
[146343.042026] libceph: osd2 10.208.3.71:6800 socket error on read
[147244.040626] libceph: osd2 10.208.3.71:6800 socket closed
[147244.042035] libceph: osd2 10.208.3.71:6800 socket error on read
[148145.040622] libceph: osd2 10.208.3.71:6800 socket closed
[148145.041960] libceph: osd2 10.208.3.71:6800 socket error on read

Ubuntu is spitting out :

[137386.490990] libceph: osd1 10.208.3.70:6803 socket closed
[137386.491730] libceph: osd1 10.208.3.70:6803 connect authorization failure
[138287.151376] libceph: osd1 10.208.3.70:6803 socket closed
[139187.486980] libceph: osd1 10.208.3.70:6803 socket closed
[139187.487720] libceph: osd1 10.208.3.70:6803 connect authorization failure
[140088.141914] libceph: osd1 10.208.3.70:6803 socket closed
[140988.478992] libceph: osd1 10.208.3.70:6803 socket closed
[140988.480565] libceph: osd1 10.208.3.70:6803 connect authorization failure
[141889.155024] libceph: osd1 10.208.3.70:6803 socket closed
[141889.156123] libceph: osd1 10.208.3.70:6803 connect authorization failure


This doesn't seem to affect operation at all AFAICT. Also the osd is
_always_ the same in the message (but different between machines.)

I also don't think it's a connectivity issue because osd0/1 are on one
box and osd2/3 on another. So any connectivity issue hitting osd2
should hit 3 as well, same for 0&1.


Any idea of what to look for ?

Cheers,

     Sylvain
