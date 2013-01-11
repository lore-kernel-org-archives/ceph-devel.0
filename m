From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Fri, 11 Jan 2013 15:57:07 +0100
Message-ID: <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com> <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:38531 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035Ab3AKO53 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jan 2013 09:57:29 -0500
Received: by mail-lb0-f178.google.com with SMTP id l5so1381948lbo.37
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jan 2013 06:57:27 -0800 (PST)
In-Reply-To: <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

> Is osd.1 using the heap profiler as well? Keep in mind that active us=
e
> of the memory profiler will itself cause memory usage to increase =97
> this sounds a bit like that to me since it's staying stable at a larg=
e
> but finite portion of total memory.

Well, the memory consumption was already high before the profiler was
started. So yes with the memory profiler enable an OSD might consume
more memory but this doesn't cause the memory leaks.

Any ideas? Nothing to say about my scrumbing theory?

Thanks!
--
Regards,
S=E9bastien Han.


On Thu, Jan 10, 2013 at 10:44 PM, Gregory Farnum <greg@inktank.com> wro=
te:
> On Wed, Jan 9, 2013 at 10:09 AM, Sylvain Munaut
> <s.munaut@whatever-company.com> wrote:
>> Just fyi, I also have growing memory on OSD, and I have the same log=
s:
>>
>> "libceph: osd4 172.20.11.32:6801 socket closed" in the RBD clients
>
> That message is not an error; it just happens if the RBD client
> doesn't talk to that OSD for a while. I believe its volume has been
> turned down quite a lot in the latest kernels/our git tree.
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
