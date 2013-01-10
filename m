From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD memory leaks?
Date: Thu, 10 Jan 2013 13:44:44 -0800
Message-ID: <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
	<8366806.170.1357747859058.JavaMail.dspano@it1>
	<CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
	<CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:53375 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab3AJVop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 16:44:45 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so693768qco.21
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 13:44:45 -0800 (PST)
In-Reply-To: <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Wed, Jan 9, 2013 at 10:09 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Just fyi, I also have growing memory on OSD, and I have the same logs:
>
> "libceph: osd4 172.20.11.32:6801 socket closed" in the RBD clients

That message is not an error; it just happens if the RBD client
doesn't talk to that OSD for a while. I believe its volume has been
turned down quite a lot in the latest kernels/our git tree.
-Greg
