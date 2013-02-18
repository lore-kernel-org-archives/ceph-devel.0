From: Christopher Kunz <chrislist@de-punkt.de>
Subject: 0.56 scrub OSD memleaks, WAS Re: [0.48.3] OSD memory leak when scrubbing
Date: Mon, 18 Feb 2013 17:46:15 +0100
Message-ID: <51225AD7.8080606@de-punkt.de>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com> <CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com> <alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net> <CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com> <alpine.DEB.2.00.1301311141240.807@cobra.newdream.net> <510EA9A1.6070505@dachary.org> <CAOLwVUkUFvLihb6KbxG9Et7R_-ZTZpLQJYTjXm9TEe40V_ZRHg@mail.gmail.com> <CAOLwVUmYm0shGzdxfyg6LXSDgxa1hxF_Kh1oRDZXKtupvGB3VQ@mail.gmail.com> <CAOLwVUmNc_kZgbuKO4VY2mTBAV4FkwrLT=YdK1qJZhsK=sjbMQ@mail.gmail.com> <alpine.DEB.2.00.1302040930540.27333@cobra.newdream.net> <51102210.2040300@inktank.com> <CAOLwVUknsZnGeT8dT8KcjNy4OQ2V5j9sg0Ry_SCq+YDb8ctSdw@mail.gmail.com> <CAPYLRziYOHRVeT5ZbDWjn2K3q=pVc8=fTQqcfGMnmVd9UOLnyA@mail.gmail.com> <CAOL
 wVUn3o=RKci50jVEPvNmkGrzpi_43M=Cp_HGNYL6ye_68VA@mail.gmail.com> <CABYiri8C9pSCW0a+ZZhLHGWL3+Eh1=8Y6brsPc2S1fvB1G1dYQ@mail.gmail.com> <511F4CAC.6020405@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:47034 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3BRQqX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 11:46:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-2.de-punkt.de (Postfix) with ESMTP id C8DEC3A332
	for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 17:46:20 +0100 (CET)
Received: from mail-2.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l19zuZZvsbKb for <ceph-devel@vger.kernel.org>;
	Mon, 18 Feb 2013 17:46:15 +0100 (CET)
Received: from Christophers-MacBook-Pro.local (p4FD073EB.dip.t-dialin.net [79.208.115.235])
	(Authenticated sender: chris@de-punkt.de)
	by mail-2.de-punkt.de (Postfix) with ESMTPA id C69DA3A32D
	for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 17:46:15 +0100 (CET)
In-Reply-To: <511F4CAC.6020405@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Am 16.02.13 10:09, schrieb Wido den Hollander:
> On 02/16/2013 08:09 AM, Andrey Korolyov wrote:
>> Can anyone who hit this bug please confirm that your system contains
>> libc 2.15+?
>>
> 
Hello,

when we started a deep scrub on our 0.56.2 cluster today, we saw a
massive memleak about 1 hour into the scrub. One OSD claimed over
53GByte within 10 minutes. We had to restart the OSD to keep the cluster
stable.

Another OSD is currently claiming about 27GByte and will be restarted
soon. All circumstantial evidence points to the deep scrub as the source
of the leak.

One affected node is running libc 2.15 (Ubuntu 12.04 LTS), the other one
is using libc 2.11.3 (Debian Squeeze). So it seems this is not a
libc-dependant issue.

We have disabled scrub completely.

Regards,

--ck

PS: Do we have any idea when this will be fixed?
