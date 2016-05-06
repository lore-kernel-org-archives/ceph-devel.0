From: Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: removing 'rados cppool' command
Date: Fri, 6 May 2016 14:18:00 -0700
Message-ID: <CADRKj5TO=TwyGqVC4wVfhN-09+SXwzeBftY7+HbtSgBRZwhuhw@mail.gmail.com>
References: <alpine.DEB.2.11.1605061538160.1841@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1605061538160.1841-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, May 6, 2016 at 12:41 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> This PR
>
>         https://github.com/ceph/ceph/pull/8975
>
> removes the 'rados cppool' command.  The main problem is that the command
> does not make a faithful copy of all data because it doesn't preserve the
> snapshots (and snapshot related metadata).  That means if you copy an RBD
> pool it will render the images somewhat broken (snaps won't be present and
> won't work properly).  It also doesn't preserve the user_version field
> that some librados users may rely on.
>
> Since it's obscure and of limited use, this PR just removes it.
>
> Alternatively, we could add safeguards so that it refuses to make a copy
> if there are any selfmanaged_snaps, and/or generate some warnings.
>
> Any objections?

I prefer the alternative. I found this command pretty useful for
testing config upgrade scenarios with rgw. After generating config
scenarios in older versions, I used this command to store the config
on another pool, and then I could get the different config whenever
needed.

Yehuda
