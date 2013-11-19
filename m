From: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: Intel 520/530 SSD for ceph
Date: Tue, 19 Nov 2013 09:02:41 +0100
Message-ID: <528B1B21.1060203@profihost.ag>
References: <528A1862.7010601@profihost.ag>
	<20131118225146.GA1043@soma.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20131118225146.GA1043-Hsy7OnahZ0C224KT6AusD78MeWzc+u9DAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: mdw-Jp3n8lUXroRWk0Htik3J/w@public.gmane.org
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Marcus,

Am 18.11.2013 23:51, schrieb mdw-Jp3n8lUXroRWk0Htik3J/w@public.gmane.org:
> On Mon, Nov 18, 2013 at 02:38:42PM +0100, Stefan Priebe - Profihost AG wrote:
> You may actually be doing O_SYNC - recent kernels implement O_DSYNC,
> but glibc maps O_DSYNC into O_SYNC.  But since you're writing to the
> block device this won't matter much.

No difference regarding O_DSYNC or O_SYNC the values are the same. Also 
I'm using 3.10.19 as a kernel so it is recent enough.

> I believe the effect of O_DIRECT by itself is just to bypass the buffer
> cache, which is not going to make much difference for your dd case.
> (It will mainly affect other applications that are also using the
> buffer cache...)
 > O_SYNC should be causing the writes to block until a response
 > is received from the disk.  Without O_SYNC, the writes will
 > just queue operations and return - potentially very fast.
 > Your dd is probably writing enough data that there is some
 > throttling by the system as it runs out of disk buffers and
 > has to wait for some previous data to be written to the drive,
 > but the delay for any individual block is not likely to matter.
 > With O_SYNC, you are measuring the delay for each block directly,
 > and you have absolutely removed the ability for the disk to
 > perform any sort of parallism.

That's correct but ceph uses O_DSYNC for his journal and may be other 
stuff so it is important to have devices performing well with O_DSYNC.

> Sounds like the intel 530 is has a much larger block write latency,
> but can make up for it by performing more overlapped operations.
>
> You might be able to vary this behavior by experimenting with sdparm,
> smartctl or other tools, or possibly with different microcode in the drive.
Which values or which settings do you think of?

Greets
Stefan
