From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: how to run ceph on top of other local file system
Date: Thu, 3 Nov 2011 13:30:29 -0500
Message-ID: <CAB7xdimWE3bw1ZCjfZH-1md8Kpwp=uHSy8c63JZKuhAzW1Z=kA@mail.gmail.com>
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
	<CAB7xdin+KhKNEO7sGEgJ9YOpyzVHQZ91CLYW7n95xDJypENNwQ@mail.gmail.com>
	<CAORUGqB+h4T3CwSVJB0HRw8s8MmfFrnD--OgcrhbfbFiY5traA@mail.gmail.com>
	<CAB7xdi=n6Y7w=GonMfMN168m8bFjkQSbOR0Q=afz5hGpjUG3nA@mail.gmail.com>
	<CAORUGqAxvQih9UaQfpKxvLhb1fov6bz=W2+0anUSs1-2XcFtrA@mail.gmail.com>
	<CAB7xdikFfxLe7Yy9s43oabVeh+7G6FE=Le6yy2=LNqBBryQT1A@mail.gmail.com>
	<CAORUGqDF4sKCYuzVANd0u_x+oBoV_-Wj_DPH=kuf=UxzBR3b-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39641 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933797Ab1KCSaa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 14:30:30 -0400
Received: by qyk2 with SMTP id 2so1145050qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 11:30:30 -0700 (PDT)
In-Reply-To: <CAORUGqDF4sKCYuzVANd0u_x+oBoV_-Wj_DPH=kuf=UxzBR3b-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

hi Tommi,

Thanks for the reply. one more question, what does the rbd pool mean?
how will it affect the ceph?

Thanks,
Sheng

On Thu, Nov 3, 2011 at 12:55 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Nov 3, 2011 at 10:20, sheng qiu <herbert1984106@gmail.com> wrote:
>> Hi,
>>
>> is there a way to set ceph to have 0 replicas, and only have the
>> original data on osd? i just want to see how much the cost is to have
>> replicas.
>> i tried to ceph osd pool set metadata size 0, ceph osd pool set data
>> size 0. but not allowed.
>
> It's the number of copies, not the number of replicas. 0 copies is an
> interesting paradox. Try 1.
>



-- 
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
