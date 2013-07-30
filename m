From: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Subject: Re: Fwd:  Small fix for ceph.spec
Date: Tue, 30 Jul 2013 09:29:07 +0200
Message-ID: <51F76B43.4020801@bisect.de>
References: <51F6F595.605@logtenberg.eu>
	<CAP8Oy=KD4au7aaOqo1t6zvWP1JFnTtQELd8YunxXqyBaE4+wpg@mail.gmail.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAP8Oy=KD4au7aaOqo1t6zvWP1JFnTtQELd8YunxXqyBaE4+wpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Patrick McGarry <patrick-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I think this is a bug in packaging of the leveldb package in this case
since the spec-file already sets dependencies on on leveldb-devel.

leveldb depends on snappy, therefore the leveldb package should set a
dependency on snappy-devel for leveldb-devel (check the SUSE spec file
for leveldb:
https://build.opensuse.org/package/view_file/home:dalgaaf:ceph:extra/leveldb/leveldb.spec?expand=1).
This way the RPM build process will pick up the correct packages needed
to build ceph.

Which distro do you use?

Danny

Am 30.07.2013 01:33, schrieb Patrick McGarry:
> ---------- Forwarded message ----------
> From: Erik Logtenberg <erik-nLcryBYLV+bMkAkIaI5Geg@public.gmane.org>
> Date: Mon, Jul 29, 2013 at 7:07 PM
> Subject: [ceph-users] Small fix for ceph.spec
> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> 
> 
> Hi,
> 
> The spec file used for building rpm's misses a build time dependency on
> snappy-devel. Please see attached patch to fix.
> 
> Kind regards,
> 
> Erik.
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
