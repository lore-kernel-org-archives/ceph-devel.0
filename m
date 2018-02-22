From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-volume broken in 12.2.3 for filestore
Date: Thu, 22 Feb 2018 08:26:56 -0500
Message-ID: <CAC-Np1zogE1e6GqU72SHA6mGw7qZKRTo2OET38c5ccWc64i3Jw@mail.gmail.com>
References: <CAC-Np1xqJWYb9Pp=AiV+FTF2fEXabOCVGE8u54QQ=CFBjoC5CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1xqJWYb9Pp=AiV+FTF2fEXabOCVGE8u54QQ=CFBjoC5CQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Feb 22, 2018 at 8:03 AM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> For the recent 12.2.3 Luminous release we've found that it is not
> possible to mount a device when using filestore [0]
>
> We are trying to find out how this was able to get pass our functional
> testing,

Our functional testing was not affected because we use ceph-ansible,
and ceph-ansible takes care of setting the
correct mount flags (by default) on the ceph.conf file.

We will add a scenario for using default mount flags, and we will
update our incorrect unit tests that checked for the function
in charge of creating the mount command.

This means that ceph-ansible users will not be immediately affected,
and the workaround in the ticket will work for anyone
not using ceph-ansible

> in the meantime the workaround for this problem is to add the
> mount options in ceph.conf (as explained in the tracker ticket).
>
> Hopefully we can get another release soon enough to get this properly
> fixed for everyone.
>
> Apologies for anyone affected.
>
> [0] https://tracker.ceph.com/issues/23080
