From: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Sun, 20 Oct 2013 18:18:12 +0300
Message-ID: <CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw@mail.gmail.com>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
	<20131017151828.GB28859@redhat.com>
	<CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
	<alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1310181657151.19763-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-lvm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

>> output follows:
>> #pvs -o pe_start /dev/rbd1p1
>>   1st PE
>>     4.00m
>> # cat /sys/block/rbd1/queue/minimum_io_size
>> 4194304
>> # cat /sys/block/rbd1/queue/optimal_io_size
>> 4194304
>
> Well, the parameters are being set at least.  Mike, is it possible that
> having minimum_io_size set to 4m is causing some read amplification
> in LVM, translating a small read into a complete fetch of the PE (or
> somethinga long those lines)?
>
> Ugis, if your cluster is on the small side, it might be interesting to see
> what requests the client is generated in the LVM and non-LVM case by
> setting 'debug ms = 1' on the osds (e.g., ceph tell osd.* injectargs
> '--debug-ms 1') and then looking at the osd_op messages that appear in
> /var/log/ceph/ceph-osd*.log.  It may be obvious that the IO pattern is
> different.
>
Sage, here follows debug output. I am no pro in reading this, but
seems read block size differ(or what is that number following ~ sign)?

OSD.2 read with LVM:
2013-10-20 16:59:05.307159 7f95acfa5700  1 -- x.x.x.x:6804/1944 -->
x.x.x.y:0/269199468 -- osd_op_reply(176566434
rbd_data.3ad974b0dc51.0000000000007cef [read 4083712~4096] ondisk = 0)
v4 -- ?+0 0xdc35c00 con 0xd9e4840
2013-10-20 16:59:05.307655 7f95b27b0700  1 -- x.x.x.x:6804/1944 <==
client.38069 x.x.x.y:0/269199468 5548 ====
osd_op(client.38069.1:176566435 rbd_data.3ad974b0dc51.0000000000007cef
[read 4087808~4096] 4.5672f053 e6870) v4 ==== 177+0+0 (1554835253 0 0)
0x12593d80 con 0xd9e4840
2013-10-20 16:59:05.307824 7f95ac7a4700  1 -- x.x.x.x:6804/1944 -->
x.x.x.y:0/269199468 -- osd_op_reply(176566435
rbd_data.3ad974b0dc51.0000000000007cef [read 4087808~4096] ondisk = 0)
v4 -- ?+0 0xe24fc00 con 0xd9e4840
2013-10-20 16:59:05.308316 7f95b27b0700  1 -- x.x.x.x:6804/1944 <==
client.38069 x.x.x.y:0/269199468 5549 ====
osd_op(client.38069.1:176566436 rbd_data.3ad974b0dc51.0000000000007cef
[read 4091904~4096] 4.5672f053 e6870) v4 ==== 177+0+0 (3467296840 0 0)
0xe28f6c0 con 0xd9e4840
2013-10-20 16:59:05.308499 7f95acfa5700  1 -- x.x.x.x:6804/1944 -->
x.x.x.y:0/269199468 -- osd_op_reply(176566436
rbd_data.3ad974b0dc51.0000000000007cef [read 4091904~4096] ondisk = 0)
v4 -- ?+0 0xdc35a00 con 0xd9e4840
2013-10-20 16:59:05.308985 7f95b27b0700  1 -- x.x.x.x:6804/1944 <==
client.38069 x.x.x.y:0/269199468 5550 ====
osd_op(client.38069.1:176566437 rbd_data.3ad974b0dc51.0000000000007cef
[read 4096000~4096] 4.5672f053 e6870) v4 ==== 177+0+0 (3104591620 0 0)
0xe0b46c0 con 0xd9e4840

OSD.2 read without LVM
2013-10-20 17:03:13.730881 7f95ac7a4700  1 -- x.x.x.x:6804/1944 -->
x.x.x.y:0/269199468 -- osd_op_reply(176708854
rb.0.967b.238e1f29.000000000071 [read 2359296~131072] ondisk = 0) v4
-- ?+0 0x1019d200 con 0xd9e4840
2013-10-20 17:03:13.731318 7f95b27b0700  1 -- x.x.x.x:6804/1944 <==
client.38069 x.x.x.y:0/269199468 18232 ====
osd_op(client.38069.1:176708855 rb.0.967b.238e1f29.000000000071 [read
2490368~131072] 4.c0d1e4cb e6870) v4 ==== 170+0+0 (1987168552 0 0)
0x171a7480 con 0xd9e4840
2013-10-20 17:03:13.731664 7f95acfa5700  1 -- x.x.x.x:6804/1944 -->
x.x.x.y:0/269199468 -- osd_op_reply(176708855
rb.0.967b.238e1f29.000000000071 [read 2490368~131072] ondisk = 0) v4
-- ?+0 0x12b81200 con 0xd9e4840
2013-10-20 17:03:13.733112 7f95b27b0700  1 -- x.x.x.x:6804/1944 <==
client.38069 x.x.x.y:0/269199468 18233 ====
osd_op(client.38069.1:176708856 rb.0.967b.238e1f29.000000000071 [read
2621440~131072] 4.c0d1e4cb e6870) v4 ==== 170+0+0 (527551382 0 0)
0x12593d80 con 0xd9e4840
2013-10-20 17:03:13.733393 7f95ac7a4700  1 -- x.x.x.x:6804/1944 -->
x.x.x.y:0/269199468 -- osd_op_reply(176708856
rb.0.967b.238e1f29.000000000071 [read 2621440~131072] ondisk = 0) v4
-- ?+0 0xeba9000 con 0xd9e4840
2013-10-20 17:03:13.733741 7f95b27b0700  1 -- x.x.x.x:6804/1944 <==
client.38069 x.x.x.y:0/269199468 18234 ====
osd_op(client.38069.1:176708857 rb.0.967b.238e1f29.000000000071 [read
2752512~131072] 4.c0d1e4cb e6870) v4 ==== 170+0+0 (178955972 0 0)
0xe0b4d80 con 0xd9e4840

How to proceed with tuning read performance on LVM? Is there some
chanage needed in code of ceph/LVM or my config needs to be tuned?
If what is shown in logs means 4k read block in LVM case - then it
seems I need to tell LVM(or xfs on top of LVM dictates read block
side?) that io block should be rather 4m?

Ugis
