From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hammer vs Jewel librbd performance testing and git
 bisection results
Date: Wed, 11 May 2016 09:24:43 -0500
Message-ID: <dcf84153-4c04-5122-d5e1-c5bb0f3c4862@redhat.com>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
	<CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
	<bcf1b2db-b7c7-7ffe-1970-7469f7ff7cb4@redhat.com>
	<CA+aFP1DRcM5AwKpo6sU_14-YA764e9ZOHq=qtJWYkFN983O+kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1DRcM5AwKpo6sU_14-YA764e9ZOHq=qtJWYkFN983O+kQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On 05/11/2016 09:19 AM, Jason Dillaman wrote:
> On Wed, May 11, 2016 at 10:07 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Perhaps 0024677 or 3ad19ae introduced another regression that was being
>> masked by c474e4 and when 66e7464 improved the situation, the other
>> regression appeared?
>
> 0024677 is in Hammer as 7004149 and 3ad19ae is in Hammer as b38da480.
> I opened two tickets [1] [2] to investigate further.  Can you attach
> the fio job you used?
>
> [1] http://tracker.ceph.com/issues/15847
> [2] http://tracker.ceph.com/issues/15848

I can't give you a job file, but I can give you the command line 
parameters used in the test:

/home/ubuntu/src/fio/fio --ioengine=rbd --clientname=admin 
--pool=cbt-librbdfio --rbdname=cbt-librbdfio-`hostname -f`-0 
--invalidate=0 --rw=read --runtime=300 --ramp_time=None --numjobs=1 
--direct=1 --bs=131072B --iodepth=32 --end_fsync=0 
--write_iops_log=/tmp/cbt/00000000/LibrbdFio/osd_ra-00004096/op_size-00131072/concurrent_procs-008/iodepth-032/read/output.0 
--write_bw_log=/tmp/cbt/00000000/LibrbdFio/osd_ra-00004096/op_size-00131072/concurrent_procs-008/iodepth-032/read/output.0 
--write_lat_log=/tmp/cbt/00000000/LibrbdFio/osd_ra-00004096/op_size-00131072/concurrent_procs-008/iodepth-032/read/output.0 
--log_avg_msec=100 --name=librbdfio-`hostname -f`-0  > 
/tmp/cbt/00000000/LibrbdFio/osd_ra-00004096/op_size-00131072/concurrent_procs-008/iodepth-032/read/output.0

Two of these were run concurrently on 4 clients (8 volumes total).

>
> Thanks,
>
