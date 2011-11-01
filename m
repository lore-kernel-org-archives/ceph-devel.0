From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: how to run ceph on top of other local file system
Date: Tue, 1 Nov 2011 16:56:09 -0500
Message-ID: <CAB7xdin+KhKNEO7sGEgJ9YOpyzVHQZ91CLYW7n95xDJypENNwQ@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
	<CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
	<CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
	<CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com>
	<CAB7xdin1rNSi6zMQcnOviu2GVwnu3iNX46qh51vSviXZquhiRA@mail.gmail.com>
	<CAORUGqAwJwzOe1g8JMoHduTenau5uQT6fwWJYQ2pixNnLZ3cmw@mail.gmail.com>
	<CAB7xdinFBP1r-PuebjEXh1Rdwge-iEYNQpJmhCM88xuyEmqZhw@mail.gmail.com>
	<CAB7xdikHKc_EixAujGpkMzysO_7+0FipKhvyzZz7QELUV2d00A@mail.gmail.com>
	<Pine.LNX.4.64.1110260936030.18909@cobra.newdream.net>
	<CAB7xdikG2BuQiKiwVrFmzzPTDqyMLbObuy1GbyoQ=vkzGPa2Yw@mail.gmail.com>
	<Pine.LNX.4.64.1110261123560.18909@cobra.newdream.net>
	<CAB7xdinQ8uVDxX5R5bGF1mvGG_RLANNQ8A9Lweu4hDtGjnQ_HA@mail.gmail.com>
	<CAORUGqD3R8cho4W0_QpSf2Fwpt+9NagP0edhJNdFLc4oLaGyJw@mail.gmail.com>
	<CAB7xdikDt4e7AjRQOKow+p2P4tD9M8yinrgnMxVGFrhu_NsYSg@mail.gmail.com>
	<CAORUGqDKd1y3ro5tnfNwSXQjV0wYbhifa6XrPUgc5eWs_TMNiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47225 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab1KAV4L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2011 17:56:11 -0400
Received: by ggnb1 with SMTP id b1so7494315ggn.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2011 14:56:10 -0700 (PDT)
In-Reply-To: <CAORUGqDKd1y3ro5tnfNwSXQjV0wYbhifa6XrPUgc5eWs_TMNiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

hi Tommi,

Thanks for your reply. i am sorry for bothering you frequently.
i see there are several daemons to handle the requests.  i.e. client
to osd, can you tell me what exactly source file will handle
write/read request from client to/from osd?
i am not clear with the structure of the source codes.

Thanks,
Sheng

On Mon, Oct 31, 2011 at 5:43 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Mon, Oct 31, 2011 at 15:27, sheng qiu <herbert1984106@gmail.com> wrote:
>> Thanks a lot for your help.
>> i am trying to read the codes of ceph and get a deep understand of how
>> it works with its components. but i find it very hard to get into it,
>> can you give me some hint on how to read the codes efficiently?
>
> I'm afraid it comes down to reading, trying, failing, re-reading, and
> repeating that a lot.
>
> I wrote a "big picture" overview of the architecture of Ceph (while
> still trying to keep it very very short) over here:
> http://ceph.newdream.net/docs/latest/architecture/
>
> For me personally, knowledge of other network/distributed filesystems,
> including things like HDFS, was pretty helpful in getting a grasp of
> what's where. I still don't know much of the details of the messaging
> etc, but I think one can get a good overview understanding of Ceph's
> internals in a few weeks.
>
> I'm personally putting my time into making Ceph conceptually simpler,
> not toward trying to explain the complexities. Hopefully that'll be
> more useful, in the long run.
>



-- 
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
