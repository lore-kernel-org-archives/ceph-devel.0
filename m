From: femi anjorin <femi.anjorin@gmail.com>
Subject: Fwd: Ceph Production Environment Setup and Configurations?
Date: Tue, 29 Jan 2013 04:30:00 +0100
Message-ID: <CAPhYxPwrqS9ahnn+D2JgjO8HKdorQaOeo6teEP5=+K23iNodKg@mail.gmail.com>
References: <CAPhYxPwK+wM1pBpaf7zXM-L6PagcKiQ_v07MXypRGrxj4oQZtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:54600 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab3A2DaB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 22:30:01 -0500
Received: by mail-qc0-f179.google.com with SMTP id b40so1663072qcq.10
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 19:30:00 -0800 (PST)
In-Reply-To: <CAPhYxPwK+wM1pBpaf7zXM-L6PagcKiQ_v07MXypRGrxj4oQZtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Ross Turk <ross@inktank.com>

Hi,

Please with regards to my questions on Ceph Production Environment ...
I like to give u these details.

i like to test a write, read and delete operation on ceph storage
cluster in a production environment.

i also like to check the self healing and managing functionalities.

i like to know in the production setup , are gateways required for any of the
three methods of accessing ceph cluster? or should the setup just be like
all the servers should be storage nodes with mon,mds and osd running
on each of them ...while i access these storage nodes through a single
computer which one can call a client just like you described in the 5
mins setup?


---------- Forwarded message ----------
Date: Tue, Jan 29, 2013 at 2:56 AM
Subject: Ceph Production Environment Setup and Configurations?
To: ceph-devel@vger.kernel.org


Please can anyone  an advise  on how exactly a CEPH production
environment should look like? and what the configuration files should
be. My hardwares include the following:



Server A, B, C configuration

CPU - Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz

RAM - 16GB

Hard drive -  500GB

SSD - 120GB



Server D,E,F,G,H,J configuration

CPU - Intel(R) Atom(TM) CPU D525   @ 1.80GHz

RAM - 4 GB

Boot drive -  320gb

SSD - 120 GB

Storage drives - 16 X 2 TB



I am thinking of these configurations but i am not sure.

Server A - MDS and MON

Server B - MON

Server C - MON

Server D, E,F,G,H,J - OSD



Regards.
