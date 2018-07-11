From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Luminous 12.2.6 release date?
Date: Wed, 11 Jul 2018 17:48:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1807111747410.15688@piezo.novalocal>
References: <20180710080734.GG14320@PC-198>
 <CABZ+qq=zF-EfytsGr=FJCx8u3Q6jKwviE70onHWGdHi8ysxxWw@mail.gmail.com>
 <alpine.DEB.2.11.1807111458550.15696@piezo.novalocal>
 <CALqRxCwvbNA5YyBtMck399U2Wwa5rs-y7gwVj99wZt9sWmgtaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALqRxCwvbNA5YyBtMck399U2Wwa5rs-y7gwVj99wZt9sWmgtaw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 11 Jul 2018, Ken Dreyer wrote:
> Sage, does http://tracker.ceph.com/issues/24597 cover the full problem
> you're describing?

Yeah.  I've added some detail to that bug.  Working on fixing our rados 
test suite to reproduce the issue.

sage


> 
> - Ken
> 
> On Wed, Jul 11, 2018 at 9:40 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > Please hold off on upgrading.  We discovered a regression (in 12.2.5
> > actually) but the triggering event is OSD restarts or other peering
> > combined with RGW workloads on EC pools, so unnecessary OSD restarts
> > should be avoided with 12.2.5 until we have is sorted out.
> >
> > sage
> >
> >
> > On Wed, 11 Jul 2018, Dan van der Ster wrote:
> >
> >> And voila, I see the 12.2.6 rpms were released overnight.
> >>
> >> Waiting here for an announcement before upgrading.
> >>
> >> -- dan
> >>
> >> On Tue, Jul 10, 2018 at 10:08 AM Sean Purdy <s.purdy-jbg8n7S37wnmujpSeSYe3g@public.gmane.org> wrote:
> >> >
> >> > While we're at it, is there a release date for 12.2.6?  It fixes a reshard/versioning bug for us.
> >> >
> >> > Sean
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> >>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
