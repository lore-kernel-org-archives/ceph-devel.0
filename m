From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD memory leaks?
Date: Thu, 10 Jan 2013 13:43:08 -0800
Message-ID: <CAPYLRzg-tUo47JEzO+evmAOs4uFw4hJCwuN0+4OYo_W0CMXCsQ@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
	<8366806.170.1357747859058.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:33130 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab3AJVnJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 16:43:09 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so1000759qab.9
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 13:43:08 -0800 (PST)
In-Reply-To: <8366806.170.1357747859058.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Wed, Jan 9, 2013 at 8:10 AM, Dave Spano <dspano@optogenics.com> wrot=
e:
> Yes, I'm using argonaut.
>
> I've got 38 heap files from yesterday. Currently, the OSD in question=
 is using 91.2% of memory according to top, and staying there. I initia=
lly thought it would go until the OOM killer started killing processes,=
 but I don't see anything funny in the system logs that indicate that.
>
> On the other hand, the ceph-osd process on osd.1 is using far less me=
mory.

Is osd.1 using the heap profiler as well? Keep in mind that active use
of the memory profiler will itself cause memory usage to increase =97
this sounds a bit like that to me since it's staying stable at a large
but finite portion of total memory.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
