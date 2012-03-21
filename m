From: ruslan usifov <ruslan.usifov@gmail.com>
Subject: periodically delays when one of mons dies
Date: Wed, 21 Mar 2012 19:30:14 +0400
Message-ID: <CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
References: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:32919 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab2CUPaP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 11:30:15 -0400
Received: by gghe5 with SMTP id e5so1027762ggh.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 08:30:15 -0700 (PDT)
In-Reply-To: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello

I'm new to ceph, and perhaps misunderstand some things.

I have test configuration with 3 wmvare machines (i test RBD). My setup
consist of:

3: mons
3: osd


When i kill one mon (simulate fail), time to time (periodicaly) i got little
delays when work with RBD device, perhaps this happens when client try
failed mon, is it possible switch off this failed mon until it fully
restore. perhaps pacemaker will help in this case + failover ip + somthing
like proxy which known about mon configuration (i try haproxy but without
success: 1 first of all haproxy doesn't know about live or fail mons sof
delays will happens also ceph doesn't allow this scheme - ie ceph client
check ip address on which it connect and what send to hip mon, and in schem
with proxy this values doesn't coincide)
