From: Haomai Wang <haomai@xsky.com>
Subject: Re: ceph issue
Date: Fri, 2 Dec 2016 11:12:05 +0800
Message-ID: <CACJqLyaw8Oag6XN-HSyrRPonMhMxqpbXuQei6cFE0LdBaNxUqw@mail.gmail.com>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
 <alpine.DEB.2.11.1611171448450.15311@piezo.us.to> <CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA98284250E8@ddsm-mbx01.digdes.com>
 <CACJqLyZRDpinsMZtDbM_zZHfi87FzC1HrCP0KRFEgAxgzGpjYQ@mail.gmail.com>
 <DB3PR05MB0793F7194A5C64F018E61012A9B20@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <CACJqLyaCJdK+G6V3_Cm36PRYrwQCoRZ02MyJCnDudSUmC=O4Tg@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9E133@DDSM-MBX2.digdes.com>
 <DB3PR05MB0793FB50C98346C4983E3ABBA9B40@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9F1CC@DDSM-MBX2.digdes.com> <DB3PR05MB079316AC35562CC422E44DC0A9B70@DB3PR05MB0793.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0116.outbound.protection.outlook.com ([104.47.124.116]:7225
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755246AbcLBDMP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 22:12:15 -0500
Received: by mail-ua0-f173.google.com with SMTP id 12so269234405uas.2
        for <ceph-devel@vger.kernel.org>; Thu, 01 Dec 2016 19:12:09 -0800 (PST)
In-Reply-To: <DB3PR05MB079316AC35562CC422E44DC0A9B70@DB3PR05MB0793.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Marov Aleksey <Marov.A@raidix.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 23, 2016 at 5:30 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
>
> I guess that like the rest of ceph, the new rdma code must also support multiple applications in parallel.
>
> I am also reproducing your error => 2 instances of fio can't run in parallel with ceph rdma.
>
> * with ceph -s shows HEALTH_WARN (with "9 requests are blocked > 32 sec")
>
> * and with all osds printing messages like " heartbeat_check: no reply from ..."
>
> * And with log files contains errors:
>   $ grep error ceph-osd.0.log
>   2016-11-23 09:20:46.988154 7f9b26260700 -1 Fail to open '/proc/0/cmdline' error = (2) No such file or directory
>   2016-11-23 09:20:54.090388 7f9b43951700  1 -- 36.0.0.2:6802/10634 >> 36.0.0.4:0/19587 conn(0x7f9b256a8000 :6802 s=STATE_OPEN pgs=1 cs=1 l=1).read_bulk reading from fd=139 : Unknown error -104
>   2016-11-23 09:20:58.411912 7f9b44953700  1 RDMAStack polling work request returned error for buffer(0x7f9b1fee21b0) status(12:RETRY_EXC_ERR
>   2016-11-23 09:20:58.411934 7f9b44953700  1 RDMAStack polling work request returned error for buffer(0x7f9b553d20d0) status(12:RETRY_EXC_ERR

error is "IBV_WC_RETRY_EXC_ERR (12) - Transport Retry Counter
Exceeded: The local transport timeout retry counter was exceeded while
trying to send this message. This means that the remote side didn't
send any Ack or Nack. If this happens when sending the first message,
usually this mean that the connection attributes are wrong or the
remote side isn't in a state that it can respond to messages. If this
happens after sending the first message, usually it means that the
remote QP isn't available anymore. Relevant for RC QPs."

we set qp retry_cnt to 7 and timeout is 14

  // How long to wait before retrying if packet lost or server dead.
  // Supposedly the timeout is 4.096us*2^timeout.  However, the actual
  // timeout appears to be 4.096us*2^(timeout+1), so the setting
  // below creates a 135ms timeout.
  qpa.timeout = 14;

  // How many times to retry after timeouts before giving up.
  qpa.retry_cnt = 7;

is this means the receiver side lack of memory or not polling work request ASAP?

>
>
>
> Command lines that I used:
>   ./fio --ioengine=rbd --invalidate=0 --rw=write --bs=128K --numjobs=1 --clientname=admin --pool=rbd --iodepth=128 --rbdname=img2g --name=1
>   ./fio --ioengine=rbd --invalidate=0 --rw=write --bs=128K --numjobs=1 --clientname=admin --pool=rbd --iodepth=128 --rbdname=img2g2 --name=1
>
> > -----Original Message-----
> > From: Marov Aleksey
> > Sent: Tuesday, November 22, 2016 17:59
> >
> > I didn't try this blocksize. But in my case fio crushed if I use more than one
> > job. With one job everything works fine. Is it worth more deep investigating?
