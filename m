From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: deep-scrubbing
Date: Mon, 3 Apr 2017 18:23:52 +0530
Message-ID: <CANA9Uk55ca+U1LFxmrSF_ZBqiH1ifi9kaUpDUoarR10+B-6EPQ@mail.gmail.com>
References: <CANA9Uk5W8AhOjRnxmdQXQL1g5KmP6_eDLYuhMEL_=50npW=x4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5W8AhOjRnxmdQXQL1g5KmP6_eDLYuhMEL_=50npW=x4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

+ ceph-devel

On Mon, Feb 27, 2017 at 3:54 PM, M Ranga Swami Reddy
<swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello,
> I use a ceph cluster and its show the deeps scrub's PG distribution as below
> from "ceph pg dump" command:
>
>   ====
>    2000 Friday
>    1000 Saturday
>    4000  Sunday
> ==
>
> On Friday, I have disabled the deep-scrub due to some reason. If this case,
> all Friday's PG deep-scrub will be performed on Saturday or is it will be
> done on Next Friday?
>
> Thanks
> Swami
