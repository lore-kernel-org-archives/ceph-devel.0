From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 19:09:36 +0100
Message-ID: <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
	<8366806.170.1357747859058.JavaMail.dspano@it1>
	<CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:50620 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab3AISJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 13:09:37 -0500
Received: by mail-ob0-f172.google.com with SMTP id za17so2517034obc.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 10:09:37 -0800 (PST)
In-Reply-To: <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Just fyi, I also have growing memory on OSD, and I have the same logs:

"libceph: osd4 172.20.11.32:6801 socket closed" in the RBD clients


I traced that problem and correlated it to some cephx issue in the OSD
some time ago in this thread

http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg10634.html

but the thread kind of died without a solution ...

Cheers,

   Sylvain
