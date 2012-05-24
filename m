From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Thu, 24 May 2012 21:05:06 +0200
Message-ID: <4FBE8662.1070801@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <CAJCPpW+SKnnVUaDEAsCkKyZwMVrHCRJF2C8zqB4eORgwW5p=1Q@mail.gmail.com> <4FBE7ABC.5020502@profihost.ag> <4FBE838D.4000303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44655 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab2EXTFH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 15:05:07 -0400
In-Reply-To: <4FBE838D.4000303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.05.2012 20:53, schrieb Mark Nelson:
> Hi Stefan,
>
> Thanks for the info! I've been testing on 3.4 for the last couple of
> days but haven't run into that problem here. It looks like your journal
> has writes going to it quickly and then things stall as it tries to
> write out to your data disk.
That's a good point. Right now while testing i'm using a tmpfs ramdisk 
for the journal and have set journal dio = false in ceph.conf? Might 
this be the difference / problem?

3.2.18 works fine too.

 > I wonder if any of the data actually makes
> it to the disk... Can you run iostat or collectl or something and see
> what kind of write throughput you get to the OSD data disks?
none... so it seems get's never transferred from journal to disk.

Stefan
