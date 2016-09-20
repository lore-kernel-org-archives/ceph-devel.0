From: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Jewel Docs | error on mount.ceph page
Date: Tue, 20 Sep 2016 23:28:54 +0200
Message-ID: <CAOi1vP-OKZ60syLgMD1kUYi2CybD2Z+BUSk9LVHLRCbx_yOZaQ@mail.gmail.com>
References: <CAGxt-as_LjROO8=gAfDk+y1DsQvvmvfo78dCFH+pYBgx-wdzhA@mail.gmail.com>
	<CAGxt-avsxSa9BcD-E+YTB5OKpduy02s3=AoytDPqZ4370Rwyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGxt-avsxSa9BcD-E+YTB5OKpduy02s3=AoytDPqZ4370Rwyfg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David <dclistslinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Sep 20, 2016 at 7:48 PM, David <dclistslinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Sorry I don't know the correct way to report this.
>
> Potential error on this page:
>
> on http://docs.ceph.com/docs/jewel/man/8/mount.ceph/
>
> Currently:
>
> rsize
> int (bytes), max readahead, multiple of 1024, Default: 524288 (512*1024)
>
> Should it be something like the following?
>
> rsize
> int (bytes), max read size. Default: none
>
> rasize
> int (bytes), max readahead, multiple of 1024, Default: 8388608 (8192*1024)

This was fixed in master last week and can probably be added into the
next jewel point release.

Thanks,

                Ilya
