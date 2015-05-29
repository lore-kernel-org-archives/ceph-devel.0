From: Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Discuss: New default recovery config settings
Date: Fri, 29 May 2015 16:17:52 -0700
Message-ID: <CAC6JEv8LyM1SRsOszDCj6tLxhZ=hvrEkinDARW8BvyQHDCz+LQ@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1394947829.9758745.1432936033017.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, May 29, 2015 at 2:47 PM, Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Many people have reported that they need to lower the osd recovery config options to minimize the impact of recovery on client io.  We are talking about changing the defaults as follows:
>
> osd_max_backfills to 1 (from 10)
> osd_recovery_max_active to 3 (from 15)
> osd_recovery_op_priority to 1 (from 10)
> osd_recovery_max_single_start to 1 (from 5)

I'm under the (possibly erroneous) impression that reducing the number
of max backfills doesn't actually reduce recovery speed much (but will
reduce memory use), but that dropping the op priority can. I'd rather
we make users manually adjust values which can have a material impact
on their data safety, even if most of them choose to do so.

After all, even under our worst behavior we're still doing a lot
better than a resilvering RAID array. ;)
-Greg
