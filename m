From: Kingsley Tart <ceph-Tk8N0zKFSFdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Wed, 06 Sep 2017 17:15:04 +0100
Message-ID: <1504714504.24259.187.camel@merry.middle-earth.co.uk>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 2017-09-06 at 15:23 +0000, Sage Weil wrote:
> Hi everyone,
> 
> Traditionally, we have done a major named "stable" release twice a year, 
> and every other such release has been an "LTS" release, with fixes 
> backported for 1-2 years.
> 
> With kraken and luminous we missed our schedule by a lot: instead of 
> releasing in October and April we released in January and August.
> 
> A few observations:
[snip]

Firstly, I'd like to qualify my comments by saying that I haven't yet
tried Ceph[1], though I have been loosely following its progress. This
is partly because I've been busy doing other things.

[1] OK, this is a slight fib - I had a very brief play with it a few
years back but didn't really get anywhere with it and then got diverted
onto other things.

Unless I absolutely have to deploy now, I find myself doing this:

10 not long for new release, wait a bit
20 new release is here, but there's talk of a new one
30 goto 10

Having frequent minor updates and fixes is reassuring, but having
frequent major update changes with the "L" in "LTS" not being
particularly long tends to put me off a bit, largely because I find the
thought of upgrading something so mission critical quite daunting. I
can't speak from any Ceph experience on this one, obviously, but if
there's an easy rollback (even if it's never needed) without having to
rebuild the entire cluster then that would make me more willing to do
it.

-- 
Cheers,
Kingsley.
