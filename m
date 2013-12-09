From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: many meta files in osd
Date: Tue, 10 Dec 2013 00:29:08 +0100
Message-ID: <CAMNMNTzUA-xbGrQnw_aq2XtUhpQcvo4qf1YBJrqk=sP1zKzMDw@mail.gmail.com>
References: <CAMNMNTw3OM-aoUAOAEJcN5BqsrL+4S79Ha20=xt5wE_56Jd5_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTw3OM-aoUAOAEJcN5BqsrL+4S79Ha20=xt5wE_56Jd5_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Is there any posibility to remove this meta files? (whithout recreate cluster)
Files names:
{path}.bucket.meta.test1:default.4110.{sequence number}__head_...

--
Regards
Dominik

2013/12/8 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi,
> My api app to put files to s3/ceph checks if bucket exists by create
> this bucket.
> Each bucket create command adds 2 meta files.
>
> -----
> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
> 44
> root@vm-1:/vol0/ceph/osd# s3 -u create test1
> Bucket successfully created.
> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
> 46
> -----
>
> Unfortunately:
> -----
> root@vm-1:/vol0/ceph/osd# s3 -u delete test1
> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
> 46
> -----
>
> Is there some way to remove this meta files from ceph?
>
> --
> Regards
> Dominik



-- 
Pozdrawiam
Dominik
