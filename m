From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Wed, 2 Jul 2014 12:36:43 -0700
Message-ID: <CAPYLRzgZyk_qHfuEANcbLYLHXX++Lj71t5xeTxbLf9ywy6s-ww@mail.gmail.com>
References: <539B11C4.1010400@profihost.ag>
	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
	<53AD1411.101@profihost.ag>
	<CAPYLRzhJ_3WkWSFUAx+w+gt5PTLD7SYmSyQ-xPRZ31ahN4a1Ag@mail.gmail.com>
	<53B40292.2000108@profihost.ag>
	<CACJqLyZYpEJYUn5m5B4LCGGfszY_xPjui5q7HShQuotBkVDt4Q@mail.gmail.com>
	<53B40526.7080907@profihost.ag>
	<CAPYLRziFqZYFn4E22oE+-HXXcRppzwY=h2TbDuCErSixzZ=eWQ@mail.gmail.com>
	<53B456E3.1060909@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <53B456E3.1060909-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jul 2, 2014 at 12:00 PM, Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>
> Am 02.07.2014 16:00, schrieb Gregory Farnum:
>
>> Yeah, it's fighting for attention with a lot of other urgent stuff. :(
>>
>> Anyway, even if you can't look up any details or reproduce at this
>> time, I'm sure you know what shape the cluster was (number of OSDs,
>> running on SSDs or hard drives, etc), and that would be useful
>> guidance. :)
>
>
> Sure
>
> Number of OSDs: 24
> Each OSD has an SSD capable of doing tested with fio before installing ceph
> (70.000 iop/s 4k write, 580MB/s seq. write 1MB blocks)
>
> Single Xeon E5-1620 v2 @ 3.70GHz
>
> 48GB RAM

Awesome, thanks.

I went through the changelogs on the librados/, osdc/, and msg/
directories to see if I could find any likely change candidates
between Dumpling and Firefly and couldn't see any issues. :( But I
suspect that the sharding changes coming will more than make up the
difference, so you might want to plan on checking that out when it
arrives, even if you don't want to deploy it to production.
-Greg
