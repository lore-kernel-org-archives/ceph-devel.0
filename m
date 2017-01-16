From: caifeng.zhu@uniswdc.com
Subject: Re: bad crc in data caused by a race condtion in
 write_partial_message_data
Date: Mon, 16 Jan 2017 18:09:04 +0800
Message-ID: <20170116100904.GA38449@T530I>
References: <20170115074525.GA35305@T530I>
 <CAOi1vP9KzamvwLa5BtqXYdvKWM=fGqZqXX_6aEbdEsOxFfMW0Q@mail.gmail.com>
 <20170116032412.GB37679@T530I>
 <CAOi1vP9-Rwo5Mc-DzogTQSBFy3Hbcy=gKehG-xsYDP5fFm3PBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbg65.qq.com ([103.7.28.233]:58331 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750901AbdAPKNA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 16 Jan 2017 05:13:00 -0500
Content-Disposition: inline
In-Reply-To: <CAOi1vP9-Rwo5Mc-DzogTQSBFy3Hbcy=gKehG-xsYDP5fFm3PBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 16, 2017 at 09:42:25AM +0100, Ilya Dryomov wrote:
> On Mon, Jan 16, 2017 at 4:24 AM,  <caifeng.zhu@uniswdc.com> wrote:
> > On Sun, Jan 15, 2017 at 06:01:05PM +0100, Ilya Dryomov wrote:
> >> On Sun, Jan 15, 2017 at 8:45 AM,  <caifeng.zhu@uniswdc.com> wrote:
> >> > Hi, all
> >> >
> >> > Let's look at the problem first. We have a lot of 'bad crc in data'
> >> > warnings at OSDs, like below:
> >> >     2017-01-14 23:25:54.671599 7f67201b3700  0 bad crc in data 1480547403 != exp 3751318843
> >> >     2017-01-14 23:25:54.681146 7f67201b3700  0 bad crc in data 3044715775 != exp 3018112170
> >> >     2017-01-14 23:25:54.681822 7f67201b3700  0 bad crc in data 2815383560 != exp 1455746011
> >> >     2017-01-14 23:25:54.686106 7f67205da700  0 bad crc in data 1781929234 != exp 498105391
> >> >     2017-01-14 23:25:54.688092 7f67205da700  0 bad crc in data 1845054835 != exp 3337474350
> >> >     2017-01-14 23:25:54.693225 7f67205da700  0 bad crc in data 1518733907 != exp 3781627678
> >> >     2017-01-14 23:25:54.755653 7f6724115700  0 bad crc in data 1173337243 != exp 3759627242
> >> >     ...
> >> > This problem occurs when we are testing(by fio) an NFS client, whose NFS server is
> >> > built on an XFS + RBD combination. The bad effect of the problem is that: OSD will close
> >> > the connection of crc error and drop all reply messages sent through the connection.
> >> > But the kernel rbd client will hold the requests and wait for the already dropped
> >> > replies which will never come. A deadlock occurs.
> >> >
> >> > After some analysis, we suspect write_partial_message_data may have a race condtion.
> >> > (Code below is got from gitbub.)
> >> >     1562                page = ceph_msg_data_next(cursor, &page_offset, &length,
> >> >     1563                                          &last_piece);
> >> >     1564                ret = ceph_tcp_sendpage(con->sock, page, page_offset,
> >> >     1565                                        length, !last_piece);
> >> >     ...
> >> >     1572                if (do_datacrc && cursor->need_crc)
> >> >     1573                        crc = ceph_crc32c_page(crc, page, page_offset, length);
> >> > At line 1564 ~ 1572, a worker thread of libceph workquue may send the page out by TCP
> >> > and compute the CRC. But simultaneously, at the VFS/XFS level, there may be another thread
> >> > writing to file position cached by the sending-out page. If page sending and crc compution
> >> > is interleaved by data writing, bad CRC will be complained by the receiving OSD.
> >> >
> >> > To verify our suspection, we add the debug patch below:
> >> > (Code below is based on our linux version.)
> >>
> >> ... which is based on?  This should be fixed in 4.3+ and all recent stable
> >> kernels.
> >>
> >
> > We are using CentOS 7.1, with kernel as
> > kernel.osrelease = 3.10.0-229.14.1.el7.1.x86_64.
> > With patches added by CentOS, the ceph kernel client is roughly about 4.0~.
> 
> No, it's not ~4.0.  A lot of important fixes are missing from that
> kernel and I'd strognly encourage you to upgrade to the 7.3 kernel.
> 

Thanks for your suggestion. We'll try it.

> >
> > Is there any info or doc about the fixes in 4.3+?
> 
> This is the fix, trivial to cherry-pick and try out:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bae818ee1577c27356093901a0ea48f672eda514
> 

This patch makes sense for me. It is the elegant soltuion, 
much (much ...) better than my proposal. Thanks for your help!

> Thanks,
> 
>                 Ilya
> 


