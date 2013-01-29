From: femi anjorin <femi.anjorin@gmail.com>
Subject: Ceph Production Environment Setup?
Date: Tue, 29 Jan 2013 03:56:07 +0100
Message-ID: <CAPhYxPxYfsWfY96OvSfzG9mNMphAY8z5U-zYDp3Vw2nZ1yWNjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44466 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3A2DBi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 22:01:38 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so65212qan.5
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 19:01:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
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
