From: Josh Durgin <josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Sun, 20 Oct 2013 11:21:24 -0700
Message-ID: <52641F24.6000406@inktank.com>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>	<20131017151828.GB28859@redhat.com>	<CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>	<alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
	<CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-lvm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 10/20/2013 08:18 AM, Ugis wrote:
>>> output follows:
>>> #pvs -o pe_start /dev/rbd1p1
>>>    1st PE
>>>      4.00m
>>> # cat /sys/block/rbd1/queue/minimum_io_size
>>> 4194304
>>> # cat /sys/block/rbd1/queue/optimal_io_size
>>> 4194304
>>
>> Well, the parameters are being set at least.  Mike, is it possible that
>> having minimum_io_size set to 4m is causing some read amplification
>> in LVM, translating a small read into a complete fetch of the PE (or
>> somethinga long those lines)?
>>
>> Ugis, if your cluster is on the small side, it might be interesting to see
>> what requests the client is generated in the LVM and non-LVM case by
>> setting 'debug ms = 1' on the osds (e.g., ceph tell osd.* injectargs
>> '--debug-ms 1') and then looking at the osd_op messages that appear in
>> /var/log/ceph/ceph-osd*.log.  It may be obvious that the IO pattern is
>> different.
>>
> Sage, here follows debug output. I am no pro in reading this, but
> seems read block size differ(or what is that number following ~ sign)?

Yes, that's the I/O length. LVM is sending requests for 4k at a time,
while plain kernel rbd is sending 128k.

<request logs showing this>

> How to proceed with tuning read performance on LVM? Is there some
> chanage needed in code of ceph/LVM or my config needs to be tuned?
> If what is shown in logs means 4k read block in LVM case - then it
> seems I need to tell LVM(or xfs on top of LVM dictates read block
> side?) that io block should be rather 4m?

It's a client side issue of sending much smaller requests than it needs
to. Check the queue minimum and optimal sizes for the lvm device - it
sounds like they might be getting set to 4k for some reason.

Josh
