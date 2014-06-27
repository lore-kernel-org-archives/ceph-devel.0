From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Fri, 27 Jun 2014 08:49:53 +0200
Message-ID: <53AD1411.101@profihost.ag>
References: <539B11C4.1010400@profihost.ag>
	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Greg,

Am 26.06.2014 02:17, schrieb Gregory Farnum:
> Sorry we let this drop; we've all been busy traveling and things.
> 
> There have been a lot of changes to librados between Dumpling and
> Firefly, but we have no idea what would have made it slower. Can you
> provide more details about how you were running these tests?

it's just a normal fio run:
fio --ioengine=rbd --bs=4k --name=foo --invalidate=0
--readwrite=randwrite --iodepth=32 --rbdname=fio_test2 --pool=teststor
--runtime=90 --numjobs=32 --direct=1 --group

Running one time with firefly libs and one time with dumpling libs.
Traget is always the same pool on a firefly ceph storage.

Stefan

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
> 
> On Fri, Jun 13, 2014 at 7:59 AM, Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>> Hi,
>>
>> while testint firefly i cam into the sitation where i had a client where the
>> latest dumpling packages where installed (0.67.9).
>>
>> As my pool has hashppool false and the tunables are set to default it can
>> talk to my firefly ceph sotrage.
>>
>> For random 4k writes using fio with librbd and 32 jobs and an iodepth of 32.
>>
>> I get these results:
>>
>> librbd / librados2 from dumpling:
>>   write: io=3020.9MB, bw=103083KB/s, iops=25770, runt= 30008msec
>>   WRITE: io=3020.9MB, aggrb=103082KB/s, minb=103082KB/s, maxb=103082KB/s,
>> mint=30008msec, maxt=30008msec
>>
>> librbd / librados2 from firefly:
>>   write: io=7344.3MB, bw=83537KB/s, iops=20884, runt= 90026msec
>>   WRITE: io=7344.3MB, aggrb=83537KB/s, minb=83537KB/s, maxb=83537KB/s,
>> mint=90026msec, maxt=90026msec
>>
>> Stefan
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
