From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph.conf
Date: Thu, 10 Sep 2015 05:21:44 -0400 (EDT)
Message-ID: <1048259835.14823145.1441876904812.JavaMail.zimbra@redhat.com>
References: <719445511.14807548.1441873777873.JavaMail.zimbra@redhat.com>
	<945773049.14811634.1441874647066.JavaMail.zimbra@redhat.com>
	<CAJ4mKGbF1zME=hQxjk5SOxqxnYDxPeJZgsZ=Sf3m=TNW-9e=eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGbF1zME=hQxjk5SOxqxnYDxPeJZgsZ=Sf3m=TNW-9e=eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thank you for your really really quick reply, Greg.

 > Yes. A bunch shouldn't ever be set by users.

 Anyhow, this is one of my biggest concern right now -;

    rgw_keystone_admin_password = 
                       ^^^^^^^^

MUST not be there.

Shinobu

----- Original Message -----
From: "Gregory Farnum" <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: "Shinobu Kinjo" <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sent: Thursday, September 10, 2015 5:57:52 PM
Subject: Re: [ceph-users] Ceph.conf

On Thu, Sep 10, 2015 at 9:44 AM, Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hello,
>
> I'm seeing 859 parameters in the output of:
>
>     $ ./ceph --show-config | wc -l
>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>     859
>
> In:
>
>     $ ./ceph --version
>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>     ceph version 9.0.2-1454-g050e1c5 (050e1c5c7471f8f237d9fa119af98c1efa9a8479)
>
> Since I'm quite new to Ceph, so my question is:
>
>     Where can I know what each parameter exactly mean?
>
> I am probably right. Some parameters are just for tes-
> ting purpose.

Yes. A bunch shouldn't ever be set by users. A lot of the ones that
should be are described as part of various operations in
ceph.com/docs, but I don't know which ones of interest are missing
from there. It's not very discoverable right now, unfortunately.
-Greg

>
> Thank you for your help in advance.
>
> Shinobu
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
