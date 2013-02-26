From: Andrey Korolyov <andrey-5vqebrSIFTo@public.gmane.org>
Subject: Re: maintanance on osd host
Date: Tue, 26 Feb 2013 18:09:31 +0300
Message-ID: <CABYiri_t7zWYDqW64pcnJbkVH+OvqjogAkU041uey1w84KpcWw@mail.gmail.com>
References: <512CCD19.7010509@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <512CCD19.7010509-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Feb 26, 2013 at 6:56 PM, Stefan Priebe - Profihost AG
<s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
> Hi list,
>
> how can i do a short maintanance like a kernel upgrade on an osd host?
> Right now ceph starts to backfill immediatly if i say:
> ceph osd out 41
> ...
>
> Without ceph osd out command all clients hang for the time ceph does not
> know that the host was rebootet.
>
> I tried
> ceph osd set nodown and ceph osd set noout
> but this doesn't result in any difference
>

Hi Stefan,

in my practice nodown will freeze all I/O for sure until OSD will
return, killing osd process and setting ``mon osd down out interval''
large enough will do the trick - you`ll get only two small freezes on
the peering process at start and at the end. Also it is very strange
that your clients hanging for a long time - I have set non-optimal
values for purpose and was not able to observe re-peering process
longer than a minute.
