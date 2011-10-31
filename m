From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how to run ceph on top of other local file system
Date: Mon, 31 Oct 2011 15:43:08 -0700
Message-ID: <CAORUGqDKd1y3ro5tnfNwSXQjV0wYbhifa6XrPUgc5eWs_TMNiA@mail.gmail.com>
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
 <CAORUGqD3R8cho4W0_QpSf2Fwpt+9NagP0edhJNdFLc4oLaGyJw@mail.gmail.com> <CAB7xdikDt4e7AjRQOKow+p2P4tD9M8yinrgnMxVGFrhu_NsYSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40684 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934441Ab1JaWna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2011 18:43:30 -0400
Received: by wyg36 with SMTP id 36so6334845wyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Oct 2011 15:43:29 -0700 (PDT)
In-Reply-To: <CAB7xdikDt4e7AjRQOKow+p2P4tD9M8yinrgnMxVGFrhu_NsYSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Oct 31, 2011 at 15:27, sheng qiu <herbert1984106@gmail.com> wrote:
> Thanks a lot for your help.
> i am trying to read the codes of ceph and get a deep understand of how
> it works with its components. but i find it very hard to get into it,
> can you give me some hint on how to read the codes efficiently?

I'm afraid it comes down to reading, trying, failing, re-reading, and
repeating that a lot.

I wrote a "big picture" overview of the architecture of Ceph (while
still trying to keep it very very short) over here:
http://ceph.newdream.net/docs/latest/architecture/

For me personally, knowledge of other network/distributed filesystems,
including things like HDFS, was pretty helpful in getting a grasp of
what's where. I still don't know much of the details of the messaging
etc, but I think one can get a good overview understanding of Ceph's
internals in a few weeks.

I'm personally putting my time into making Ceph conceptually simpler,
not toward trying to explain the complexities. Hopefully that'll be
more useful, in the long run.
