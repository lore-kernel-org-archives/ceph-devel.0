From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Sat, 10 Nov 2012 21:43:18 +0100
Message-ID: <509EBC66.9080804@profihost.ag>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag> <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net> <509BD38B.8090200@profihost.ag> <509BD87F.1010107@inktank.com> <509CD660.6050306@profihost.ag> <509CD940.1060400@profihost.ag> <CA+4uBUYJ_wNbm0Y4nMpb5QgS3kWe-4iazko5TT7O8LusPfrJww@mail.gmail.com> <6A7041AE-DE09-46E2-8AF6-68D2107995C5@profihost.ag> <CA+4uBUaCMTCo3VFvC7dy8w8wzbwDUH4wkm2GRcgypzbwMH3F3w@mail.gmail.com> <CA+4uBUYNHLkc42xGoR22=0rkN=9oak3YhNbPkrmovNC3hYKzuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54640 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2KJUnT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Nov 2012 15:43:19 -0500
In-Reply-To: <CA+4uBUYNHLkc42xGoR22=0rkN=9oak3YhNbPkrmovNC3hYKzuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 10.11.2012 21:37, schrieb Samuel Just:
> How are the 4 ssds per osd set up?  RAID 5?

no, one ssd per osd like suggested by inktank.

Greets Stefan
