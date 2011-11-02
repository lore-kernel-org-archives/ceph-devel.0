From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: how to run ceph on top of other local file system
Date: Tue, 1 Nov 2011 20:09:50 -0500
Message-ID: <CAB7xdi=n6Y7w=GonMfMN168m8bFjkQSbOR0Q=afz5hGpjUG3nA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42502 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab1KBBJv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2011 21:09:51 -0400
Received: by iage36 with SMTP id e36so465039iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2011 18:09:50 -0700 (PDT)
In-Reply-To: <CAORUGqB+h4T3CwSVJB0HRw8s8MmfFrnD--OgcrhbfbFiY5traA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

hi Tommi,

Thanks for your reply.
by now i just get a very abstract understand on the codes. i just
describe how the ceph work by my current understanding.
in the client/fuse_ll.cc, there defines the client interface for file
system operations.
 i.e. for write->ceph_ll_write, then it invoke client->ll_write which
may finally invoke writex(). here seems it only write to the client
buffer and mark it as dirty. and the real write to the osd happens
when invoke ObjectCacher->flush() (in fact, i did not know when will
this function be invoked, or if my understanding is correct), which
will invoke the  objecter->write_trunc(). inside this function it
invoke op_submit which actually send out the write request to the OSD.
is the above logic correct?

i see there are four messengers client, cluster, messenger_hbin,
messenger_hbout in the ceph_osd.cc. will one of the messengers
responsible to handle the receiving request from client? i do not know
how the OSD handle the received messages from client or mds.

Thanks,
Sheng

On Tue, Nov 1, 2011 at 5:07 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Tue, Nov 1, 2011 at 14:56, sheng qiu <herbert1984106@gmail.com> wr=
ote:
>> Thanks for your reply. i am sorry for bothering you frequently.
>> i see there are several daemons to handle the requests. =A0i.e. clie=
nt
>> to osd, can you tell me what exactly source file will handle
>> write/read request from client to/from osd?
>> i am not clear with the structure of the source codes.
>
> Ignoring file metadata and the interaction with MDS, you might get
> going by reading src/osd/OSD.cc OSD::handle_op.
>



--=20
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
