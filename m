From: mdw-Jp3n8lUXroRWk0Htik3J/w@public.gmane.org
Subject: Re: Intel 520/530 SSD for ceph
Date: Mon, 18 Nov 2013 17:51:46 -0500
Message-ID: <20131118225146.GA1043@soma.private.linuxbox.com>
References: <528A1862.7010601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528A1862.7010601-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Nov 18, 2013 at 02:38:42PM +0100, Stefan Priebe - Profihost AG wrote:
> Hi guys,
> 
> in the past we've used intel 520 ssds for ceph journal - this worked
> great and our experience was good.
> 
> Now they started to replace the 520 series with their new 530.
> 
> When we did we were supriced by the ugly performance and i need some
> days to reproduce.
> 
> While O_DIRECT works fine for both and the intel ssd 530 is even faster
> than the 520.
> 
> O_DSYNC... see the results:
> 
> ~# dd if=randfile.gz of=/dev/sda bs=350k count=10000 oflag=direct,dsync
> 3584000000 bytes (3,6 GB) copied, 22,287 s, 161 MB/s
> 
> ~# dd if=randfile.gz of=/dev/sdb bs=350k count=10000 oflag=direct,dsync
> 3584000000 bytes (3,6 GB) copied, 136,505 s, 26,3 MB/s
> 
> I used a blocksize of 350k as my graphes shows me that this is the
> average workload we have on the journal. But i also tried using fio,
> bigger blocksize, ... it stays the same.
> 
> Does anybody have an idea? Without dsync both devices have around the
> same performance of 260MB/s.
> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

You may actually be doing O_SYNC - recent kernels implement O_DSYNC,
but glibc maps O_DSYNC into O_SYNC.  But since you're writing to the
block device this won't matter much.

I believe the effect of O_DIRECT by itself is just to bypass the buffer
cache, which is not going to make much difference for your dd case.
(It will mainly affect other applications that are also using the
buffer cache...)

O_SYNC should be causing the writes to block until a response
is received from the disk.  Without O_SYNC, the writes will
just queue operations and return - potentially very fast.
Your dd is probably writing enough data that there is some
throttling by the system as it runs out of disk buffers and
has to wait for some previous data to be written to the drive,
but the delay for any individual block is not likely to matter.
With O_SYNC, you are measuring the delay for each block directly,
and you have absolutely removed the ability for the disk to
perform any sort of parallism.
	[It's also conceivable the kernel is sending some form of write
	barrier flag to the drive, which will slow it down further,
	but I can't find any kernel logic that does this at a quick glance.]
Sounds like the intel 530 is has a much larger block write latency,
but can make up for it by performing more overlapped operations.

You might be able to vary this behavior by experimenting with sdparm,
smartctl or other tools, or possibly with different microcode in the drive.

				-Marcus Watts
