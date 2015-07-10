From: icq2206241@gmail.com
Subject: Re: RADOS + deep scrubbing performance issues in production
 environment
Date: Fri, 10 Jul 2015 06:52:35 -0700 (PDT)
Message-ID: <452198cc-4ed9-4d72-8daf-d70405c41ac8@googlegroups.com>
References: <20140127151321.GD26390@philipgian-mac> <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com> <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net> <20140128181306.GC11532@philipgian-mac> <066498EC-D137-472A-85DB-93751E85C753@yahoo.com>
 <ECAD21C4-A342-48ED-BE40-9562B8CCDA08@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2031_1137473278.1436536355267"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f183.google.com ([209.85.160.183]:33046 "EHLO
	mail-yk0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbbGJPay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 11:30:54 -0400
Received: by ykuu83 with SMTP id u83so17176786yku.0
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 08:30:52 -0700 (PDT)
In-Reply-To: <ECAD21C4-A342-48ED-BE40-9562B8CCDA08@yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: synnefo-devel@googlegroups.com
Cc: ceph-users@lists.ceph.com, kyle.bader@gmail.com, sage@inktank.com, guangyy@gmail.com, ceph-devel@vger.kernel.org, philipgian@grnet.gr

------=_Part_2031_1137473278.1436536355267
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All IO drops to ZERO IOPS for 1-15 minutes during the deep-scrub on my cluster. There is clearly a locking bug! 

I have VMs - every day, several times, sometime on all of them disk IO _completely_ stops. Disk queue is growing, 0 IOPS are performed, services are dying with timeouts... At the same time the CEPH (where the VM images are stored) is doing a deep scrub. No fiddling with priorities and number of different threads are helping. Actually, making the scrub slower makes those delays longer - so there is clearly a bug with locking. 

I am experiencing this for two years already, since then we tried everything and upgraded our cluster several times! Nothing helps!
------=_Part_2031_1137473278.1436536355267--
