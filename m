From: Min Zhou <coderplay@gmail.com>
Subject: Question on ceph deployment
Date: Tue, 31 Aug 2010 10:34:49 +0800
Message-ID: <AANLkTi=AP6E7GEZdAkjbnL4=ghiXZFgJWUyzgrVGAHaJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34246 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab0HaCeu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Aug 2010 22:34:50 -0400
Received: by qyk33 with SMTP id 33so5925160qyk.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Aug 2010 19:34:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
After creating a new file system followed by the wiki, I entered a
command to start ceph, but came across a failure

# ceph -c /home/ceph/ceph_conf/ceph.conf start
10.07.30_10:27:52.183028 42640940 -- :/31251 >> 192.168.0.3:6789/0
pipe(0x1c015ff0 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:27:55.184319 42741940 -- :/31251 >> 192.168.0.2:6789/0
pipe(0x1c014c90 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:27:58.186492 42842940 -- :/31251 >> 192.168.0.3:6789/0
pipe(0x1c015b40 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:28:01.188484 42943940 -- :/31251 >> 192.168.0.2:6789/0
pipe(0x1c015860 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:28:04.190674 42a44940 -- :/31251 >> 192.168.0.3:6789/0
pipe(0x1c011060 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:28:07.192592 42b45940 -- :/31251 >> 192.168.0.2:6789/0
pipe(0x1c01a200 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:28:10.194772 42c46940 -- :/31251 >> 192.168.0.3:6789/0
pipe(0x1c01a660 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:28:13.196713 42d47940 -- :/31251 >> 192.168.0.2:6789/0
pipe(0x1c01c010 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.07.30_10:28:16.198918 42e48940 -- :/31251 >> 192.168.0.3:6789/0
pipe(0x1c01c8d0 sd=-1 pgs=0 cs=0 l=0).fault first fault

Can anyone help me with this?

Thanks,
Min
--
My research interests are distributed systems, parallel computing and
bytecode based virtual machine.

My profile:
http://www.linkedin.com/in/coderplay
My blog:
http://coderplay.javaeye.com
