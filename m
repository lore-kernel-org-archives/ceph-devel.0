From: Andras Pataki <apataki-0QEYAsm1mgjsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: Inconsistent PGs that ceph pg repair does not fix
Date: Mon, 3 Aug 2015 20:09:39 +0000
Message-ID: <D1E543BF.8DD2%apataki@simonsfoundation.org>
References: <D1E53A36.8DB6%apataki@simonsfoundation.org>
	<D1E53B6A.8DC6%apataki@simonsfoundation.org>
	<CAN=+7FUucyFUEm--jkGZWUULFGS7NHGApOG5x=wK7SM0OqTv=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN=+7FUucyFUEm--jkGZWUULFGS7NHGApOG5x=wK7SM0OqTv=g@mail.gmail.com>
Content-Language: en-US
Content-ID: <AB3639D11EE4804292CDB86FBFEBCC9F-zOaPsT6gHtfVnzwDEOJ4zg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Done: http://tracker.ceph.com/issues/12577
BTW, I=B9m using the latest release 0.94.2 on all machines.

Andras


On 8/3/15, 3:38 PM, "Samuel Just" <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>Hrm, that's certainly supposed to work.  Can you make a bug?  Be sure
>to note what version you are running (output of ceph-osd -v).
>-Sam
>
>On Mon, Aug 3, 2015 at 12:34 PM, Andras Pataki
><apataki-0QEYAsm1mgjsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
>> Summary: I am having problems with inconsistent PG's that the 'ceph pg
>> repair' command does not fix.  Below are the details.  Any help would be
>> appreciated.
>>
>> # Find the inconsistent PG's
>> ~# ceph pg dump | grep inconsistent
>> dumped all in format plain
>> 2.439 42080 00 017279507143 31033103 active+clean+inconsistent2015-08-03
>> 14:49:17.29288477323'2250145 77480:890566 [78,54]78 [78,54]78
>> 77323'22501452015-08-03 14:49:17.29253877323'2250145 2015-08-03
>> 14:49:17.292538
>> 2.8b9 40830 00 016669590823 30513051 active+clean+inconsistent2015-08-03
>> 14:46:05.14006377323'2249886 77473:897325 [7,72]7 [7,72]7
>> 77323'22498862015-08-03 14:22:47.83406377323'2249886 2015-08-03
>> 14:22:47.834063
>>
>> # Look at the first one:
>> ~# ceph pg deep-scrub 2.439
>> instructing pg 2.439 on osd.78 to deep-scrub
>>
>> # The logs of osd.78 show:
>> 2015-08-03 15:16:34.409738 7f09ec04a700  0 log_channel(cluster) log
>>[INF] :
>> 2.439 deep-scrub starts
>> 2015-08-03 15:16:51.364229 7f09ec04a700 -1 log_channel(cluster) log
>>[ERR] :
>> deep-scrub 2.439 b029e439/10000022d93.00000f0c/head//2 on disk data
>>digest
>> 0xb3d78a6e !=3D 0xa3944ad0
>> 2015-08-03 15:16:52.763977 7f09ec04a700 -1 log_channel(cluster) log
>>[ERR] :
>> 2.439 deep-scrub 1 errors
>>
>> # Finding the object in question:
>> ~# find ~ceph/osd/ceph-78/current/2.439_head -name
>>10000022d93.00000f0c* -ls
>> 21510412310 4100 -rw-r--r--   1 root     root      4194304 Jun 30 17:09
>> =

>>/var/lib/ceph/osd/ceph-78/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/1000
>>0022d93.00000f0c__head_B029E439__2
>> ~# md5sum
>> =

>>/var/lib/ceph/osd/ceph-78/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/1000
>>0022d93.00000f0c__head_B029E439__2
>> 4e4523244deec051cfe53dd48489a5db
>> =

>>/var/lib/ceph/osd/ceph-78/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/1000
>>0022d93.00000f0c__head_B029E439__2
>>
>> # The object on the backup osd:
>> ~# find ~ceph/osd/ceph-54/current/2.439_head -name
>>10000022d93.00000f0c* -ls
>> 6442614367 4100 -rw-r--r--   1 root     root      4194304 Jun 30 17:09
>> =

>>/var/lib/ceph/osd/ceph-54/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/1000
>>0022d93.00000f0c__head_B029E439__2
>> ~# md5sum
>> =

>>/var/lib/ceph/osd/ceph-54/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/1000
>>0022d93.00000f0c__head_B029E439__2
>> 4e4523244deec051cfe53dd48489a5db
>> =

>>/var/lib/ceph/osd/ceph-54/current/2.439_head/DIR_9/DIR_3/DIR_4/DIR_E/1000
>>0022d93.00000f0c__head_B029E439__2
>>
>> # They don't seem to be different.
>> # When I try repair:
>> ~# ceph pg repair 2.439
>> instructing pg 2.439 on osd.78 to repair
>>
>> # The osd.78 logs show:
>> 2015-08-03 15:19:21.775933 7f09ec04a700  0 log_channel(cluster) log
>>[INF] :
>> 2.439 repair starts
>> 2015-08-03 15:19:38.088673 7f09ec04a700 -1 log_channel(cluster) log
>>[ERR] :
>> repair 2.439 b029e439/10000022d93.00000f0c/head//2 on disk data digest
>> 0xb3d78a6e !=3D 0xa3944ad0
>> 2015-08-03 15:19:39.958019 7f09ec04a700 -1 log_channel(cluster) log
>>[ERR] :
>> 2.439 repair 1 errors, 0 fixed
>> 2015-08-03 15:19:39.962406 7f09ec04a700  0 log_channel(cluster) log
>>[INF] :
>> 2.439 deep-scrub starts
>> 2015-08-03 15:19:56.510874 7f09ec04a700 -1 log_channel(cluster) log
>>[ERR] :
>> deep-scrub 2.439 b029e439/10000022d93.00000f0c/head//2 on disk data
>>digest
>> 0xb3d78a6e !=3D 0xa3944ad0
>> 2015-08-03 15:19:58.348083 7f09ec04a700 -1 log_channel(cluster) log
>>[ERR] :
>> 2.439 deep-scrub 1 errors
>>
>> The inconsistency is not fixed.  Any hints of what should be done next?
>> I have tried  a few things:
>>  * Stop the primary osd, remove the object from the filesystem, restart
>>the
>> OSD and issue a repair.  It didn't work - it sais that one object is
>> missing, but did not copy it from the backup.
>>  * I tried the same on the backup (remove the file) - it also didn't get
>> copied back from the primary in a repair.
>>
>> Any help would be appreciated.
>>
>> Thanks,
>>
>> Andras
>> apataki-0QEYAsm1mgjsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
