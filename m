From: Andrey Korolyov <andrey-5vqebrSIFTo@public.gmane.org>
Subject: Re: Ceph availability test & recovering question
Date: Mon, 18 Mar 2013 19:41:41 +0400
Message-ID: <CABYiri--o_5itaiO3fAmBCGP=xj1YeOoNkWrPWK9_WVqnwnhVA@mail.gmail.com>
References: <86F425174C7E4F418CCF4E62056152E593906F@GDC-CLDMBX-P01.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <86F425174C7E4F418CCF4E62056152E593906F-UIpX7S6nw9GOBoeAmZP4UcGhad3MGN0iN1zbfrtuF1Y@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Kelvin_Huang-Rut2I95wrJDQT0dZR+AlfA@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric_YH_Chen-Rut2I95wrJDQT0dZR+AlfA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello,

I`m experiencing same long-lasting problem - during recovery ops, some
percentage of read I/O remains in-flight for seconds, rendering
upper-level filesystem on the qemu client very slow and almost
unusable. Different striping has almost no effect on visible delays
and reads may be non-intensive at all but they still are very slow.

Here is some fio results on randread with small blocks, so it is not
affected by readahead as linear one:

Intensive reads during recovery:
    lat (msec) : 2=0.01%, 4=0.08%, 10=1.87%, 20=4.17%, 50=8.34%
    lat (msec) : 100=13.93%, 250=2.77%, 500=1.19%, 750=25.13%, 1000=0.41%
    lat (msec) : 2000=15.45%, >=2000=26.66%

same on healthy cluster:
    lat (msec) : 20=0.33%, 50=9.17%, 100=23.35%, 250=25.47%, 750=6.53%
    lat (msec) : 1000=0.42%, 2000=34.17%, >=2000=0.56%


On Sun, Mar 17, 2013 at 8:18 AM,  <Kelvin_Huang-Rut2I95wrJDQT0dZR+AlfA@public.gmane.org> wrote:
> Hi, all
>
> I have some problem after availability test
>
> Setup:
> Linux kernel: 3.2.0
> OS: Ubuntu 12.04
> Storage server : 11 HDD (each storage server has 11 osd, 7200 rpm, 1T) + 10GbE NIC
> RAID card: LSI MegaRAID SAS 9260-4i  For every HDD: RAID0, Write Policy: Write Back with BBU, Read Policy: ReadAhead, IO Policy: Direct
> Storage server number : 2
>
> Ceph version : 0.48.2
> Replicas : 2
> Monitor number:3
>
>
> We have two storage server as a cluter, then use ceph client create 1T RBD image for testing, the client also
> has 10GbE NIC , Linux kernel 3.2.0 , Ubuntu 12.04
>
> We also use FIO to produce workload
>
> fio command:
> [Sequencial Read]
> fio --iodepth = 32 --numjobs=1 --runtime=120  --bs = 65536 --rw = read --ioengine=libaio --group_reporting --direct=1 --eta=always  --ramp_time=10 --thinktime=10
>
> [Sequencial Write]
> fio --iodepth = 32 --numjobs=1 --runtime=120  --bs = 65536 --rw = write --ioengine=libaio --group_reporting --direct=1 --eta=always  --ramp_time=10 --thinktime=10
>
>
> Now I want observe to ceph state when one storage server is crash, so I turn off one storage server networking.
> We expect that data write and data read operation can be quickly resume or even not be suspended in ceph recovering time, but the experimental results show
> the data write and data read operation will pause for about 20~30 seconds in ceph recovering time.
>
> My question is:
> 1.The state of I/O pause is normal when ceph recovering ?
> 2.The pause time of I/O that can not be avoided when ceph recovering ?
> 3.How to reduce the I/O pause time ?
>
>
> Thanks!!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
