From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: why not add (offset,len) to pglog
Date: Fri, 25 Dec 2015 12:30:38 +0800
Message-ID: <CANE=7sUenL8oO_8CWP_VJJ_qWPWM2pLF6UxpFb-9AGFePT46oA@mail.gmail.com>
References: <CAAL-TMddLQ-fxNnPcZZhtd8Evk6j+h6PiNTu+KapyPsRCeW9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAL-TMddLQ-fxNnPcZZhtd8Evk6j+h6PiNTu+KapyPsRCeW9bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dong Wu <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?B?5aea5a6BKOeglOWFrSDnpo/lt54p?= <yaoning-BACTKzvjvLCPt1CcHtbs0g@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Yeah, This is good idea for recovery, but not for backfill.
@YaoNing have pull a request about this
https://github.com/ceph/ceph/pull/3837 this year.

2015-12-25 11:16 GMT+08:00 Dong Wu <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi,
> I have doubt about pglog, the pglog contains (op,object,version) etc.
> when peering, use pglog to construct missing list,then recover the
> whole object in missing list even if different data among replicas is
> less then a whole object data(eg,4MB).
> why not add (offset,len) to pglog? If so, the missing list can contain
> (object, offset, len), then we can reduce recover data.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Regards,
Xinze Chi
