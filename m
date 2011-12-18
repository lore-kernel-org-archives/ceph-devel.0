From: Karoly Horvath <rhswdev@gmail.com>
Subject: how can I achieve HA with ceph?
Date: Sun, 18 Dec 2011 19:26:08 +0000
Message-ID: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58646 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1LRT0J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2011 14:26:09 -0500
Received: by wgbdr13 with SMTP id dr13so9479413wgb.1
        for <ceph-devel@vger.kernel.org>; Sun, 18 Dec 2011 11:26:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Guys,

two questions:

first one is short:
The documentation states for all the daemons that they have to be an
odd number to work correctly.
But what happens if one of the nodes is down? Then, by definition
there will be an even number of daemons.
Can the system tolerate this failure? If not, do I have to automate
the process of quickly bringing up a new node to achieve HA?

the second one:
I have a simple configuration:

ceph version 0.39 (commit:321ecdaba2ceeddb0789d8f4b7180a8ea5785d83)
xxx.xxx.xxx.31 alpha (mds, mon, osd)
xxx.xxx.xxx.33 beta  (mds, mon, osd)
xxx.xxx.xxx.35 gamma (     mon, osd)
ceph FS is mounted with listing the two mds-es.
I set 'data' and 'metadata' to 2, then tested with 3.

I've read the documentation and it suggests this should be enough to
achieve High Availability.
The data is replicated on all the osd-s (3), there is at least 1 mds
up all the time...yet:

Each time I remove the power plug from the primary mds node's host,
the system goes down and I cannot do a simple `ls`.
I can replicate this problem and send you any logfiles or ceph -w
outputs you need. Let me know what you need.
Here is an example session: http://pastebin.com/R4MgdhUy

I once saw the standby mds to wake up and then the FS worked but that
was after 20 minutes, which is way too long for a HA scenario.

There is hardly any data on the FS at the moment (400MB, lol..), and
hardly any writes...

I'm willing to sacrifice (a lot of) performance to achieve high availability.
Let me know if there are configuration settings to achieve this.

Thanks.

-- 
Karoly Horvath
rhswdev@gmail.com
