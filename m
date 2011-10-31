From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how to run ceph on top of other local file system
Date: Mon, 31 Oct 2011 11:05:03 -0700
Message-ID: <CAORUGqD3R8cho4W0_QpSf2Fwpt+9NagP0edhJNdFLc4oLaGyJw@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
 <CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
 <CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
 <CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com>
 <CAB7xdin1rNSi6zMQcnOviu2GVwnu3iNX46qh51vSviXZquhiRA@mail.gmail.com>
 <CAORUGqAwJwzOe1g8JMoHduTenau5uQT6fwWJYQ2pixNnLZ3cmw@mail.gmail.com>
 <CAB7xdinFBP1r-PuebjEXh1Rdwge-iEYNQpJmhCM88xuyEmqZhw@mail.gmail.com>
 <CAB7xdikHKc_EixAujGpkMzysO_7+0FipKhvyzZz7QELUV2d00A@mail.gmail.com>
 <Pine.LNX.4.64.1110260936030.18909@cobra.newdream.net> <CAB7xdikG2BuQiKiwVrFmzzPTDqyMLbObuy1GbyoQ=vkzGPa2Yw@mail.gmail.com>
 <Pine.LNX.4.64.1110261123560.18909@cobra.newdream.net> <CAB7xdinQ8uVDxX5R5bGF1mvGG_RLANNQ8A9Lweu4hDtGjnQ_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37146 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697Ab1JaSF0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2011 14:05:26 -0400
Received: by wyg36 with SMTP id 36so6117418wyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Oct 2011 11:05:24 -0700 (PDT)
In-Reply-To: <CAB7xdinQ8uVDxX5R5bGF1mvGG_RLANNQ8A9Lweu4hDtGjnQ_HA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Fri, Oct 28, 2011 at 12:12, sheng qiu <herbert1984106@gmail.com> wrote:
> thanks for your help. i have built up the system and run postmark and
> iozone to get some performance data. my system contains two machine,
> one is set as monitor, mds and osd. another is set as mds and osd.
> each osd is a SSD with ext3.

At this point, I would advise against running multiple active MDSes.
That configuration is not tested well enough, and might be the source
of all your troubles.

Unfortunately, we do not currently have benchmarks we could share. Our
QA work is still currently focused on correctness under heavy stress,
not performance.
