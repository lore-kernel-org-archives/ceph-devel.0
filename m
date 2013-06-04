From: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph killed by OS because of OOM under high load
Date: Tue, 4 Jun 2013 16:08:05 +0800
Message-ID: <CAAM7YAkUertwE_zpJ+rwAKKa9MUVFwnjn6x2TmqtmGd2xDPmCw@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E0E095@SHSMSX102.ccr.corp.intel.com>
	<CAPYLRzgmPEkzGBYW31XzSAjm44MBK6jNct-QjpJnVWXUXJR1gw@mail.gmail.com>
	<6F3FA899187F0043BA1827A69DA2F7CC01E0E96C@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E0E96C-0J0gbvR4kTiiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jun 4, 2013 at 2:20 PM, Chen, Xiaoxi <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi Greg,
>         Yes, Thanks for your advice ,we do turn down the osd_client_message_size_cap to 100MB/OSD ,both Journal queue and filestore queue are set to 100MB also.
>         That's 300MB/OSD in total, but from TOP we see:
>                 16527     1  14:49.01     0  7.1  20   0 S 1147m    0 532m     0 ceph-osd
>                 17505     1  10:54.32     0  6.5  20   0 S 1111m    0 482m     0 ceph-osd
>                 18015     1  12:21.79     0  6.0  20   0 S 1041m    0 449m     0 ceph-osd
>                 17799     1  13:29.92     0  5.9  20   0 S 1085m    0 437m     0 ceph-osd
>                 17320     1  12:19.25     0  5.8  20   0 S 1079m    0 434m     0 ceph-osd
>                 18946     1  12:38.01     0  5.7  20   0 S 1082m    0 428m     0 ceph-osd
>                 16983     1  12:04.97     0  5.1  20   0 S 1045m    0 383m     0 ceph-osd
>                 19120     1  12:57.84     0  4.9  20   0 S 1003m    0 367m     0 ceph-osd
>                 16300     1  12:17.18     0  4.8  20   0 S  979m    0 361m     0 ceph-osd
>                 18494     1  13:13.04     0  4.5  20   0 S  950m    0 339m     0 ceph-osd
>                 16662     1  13:14.84     0  4.3  20   0 S  964m    0 318m     0 ceph-osd
>                 18285     1  11:07.79     0  3.7  20   0 S  895m    0 276m     0 ceph-os
>
>         Most of the OSD daemons are slightly exceed 300MB, , so what part of code/modules take out these memory?
>         Or in another word, a more general question, is it able to draw out a pie chart, showing percentages of memory used by each modules in OSD?
>

http://google-perftools.googlecode.com/svn/trunk/doc/heapprofile.html

Regards
Yan, Zheng
