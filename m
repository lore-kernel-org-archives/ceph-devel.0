From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 20:11:53 +0100
Message-ID: <CAOLwVUmnadRWG4gnu=TUj91jpnXCR81_vtAKT4XHfYkfd+6GNQ@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:59305 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302Ab3AITMQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 14:12:16 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so2268602lab.29
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 11:12:14 -0800 (PST)
In-Reply-To: <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Hi,

Thanks for the input.

I also have tons of "socket closed", I recall that this message is
harmless. Anyway Cephx is disable on my platform from the beginning...
Anyone to approve or disapprove my "scrub theory"?
--
Regards,
S=E9bastien Han.


On Wed, Jan 9, 2013 at 7:09 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Just fyi, I also have growing memory on OSD, and I have the same logs=
:
>
> "libceph: osd4 172.20.11.32:6801 socket closed" in the RBD clients
>
>
> I traced that problem and correlated it to some cephx issue in the OS=
D
> some time ago in this thread
>
> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg10634.html
>
> but the thread kind of died without a solution ...
>
> Cheers,
>
>    Sylvain
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
