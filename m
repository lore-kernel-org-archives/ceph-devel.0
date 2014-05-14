From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: XioMessenger (RDMA) Status Update
Date: Tue, 13 May 2014 21:30:39 -0400 (EDT)
Message-ID: <731499372.186.1400031039363.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <774348207.178.1400024312462.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3525 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbaENBas (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 May 2014 21:30:48 -0400
In-Reply-To: <774348207.178.1400024312462.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi Greg,

1. there isn't support for for mark_down() yet (!), but we're working
on it.  I've had good discussions with the Accelio team regarding exposing
explicit channel and flow control interfaces, which round out that topic
as we were exploring it.

2. the big changes in this push are major cleanups and bug fixes, plus
much wider integration with the user space code.  my #1 action item from
our last convo was to first extend Xio coverage everywhere, and in particular,
add support for intra-cluster messaging over Xio.

2.1 on the cleanups and bugs front, starting with biggest, I finished support
for peer identification, using a small api change to Accelio (it's now on the
official Accelio for_next branch).  a Connection refcnt underrun is fixed.  then
I added a mechanism to bypass Accelio for intra-server messages, using a special
singleton connection.  I cleaned up, but didn't deepen, feature support, as a
temporary measure.  There's lot's of cleanup and various fixes in ceph_osd, too.

2.2 then, I did first cut integration with the MDS, and while at it, the Client
module as well.  I've only started verifying, but so far it looks like the
intra-cluster messaging paths work, and a client workload may work--more fixes
likely forthcoming.

I have a plan to get at least the starter policy interfaces like mark_down and
mark_down_all shorty.

Matt
 
----- "Gregory Farnum" <greg@inktank.com> wrote:

> On Tue, May 13, 2014 at 2:08 PM, Matt W. Benjamin <matt@cohortfs.com>
> wrote:
> > Hi Ceph Devs,
> >
> > I've pushed two Ceph+Accelio branches, xio-firefly and
> xio-firefly-cmake to our
> > public ceph repository
> https://github.com/linuxbox2/linuxbox-ceph.git .
> >
> > These branches are pulled up to the HEAD of ceph/firefly, and also
> have improvements
> > to XioMessenger which allow:
> >
> > 1. operation of (at least) a minimal Ceph Mon and OSD cluster over
> Xio messaging alone
> > 2. initial support for Accelio in the MDS server and
> Client/libcephfs (not formally tested)
> >
> > There are some new config options:
> >
> > (global addr) "rdma local" sets a local rdma interface address
> > (global bool) "cluster rdma" selects Accelio for intra-cluster
> communication
> > (global bool) "client rdma" selecs Accelio for libcephfs
> communications
> >
> > These changes haven't been strenuously tested, we'll expect to have
> additional information
> > and likely new, simple rados bench results against this code in the
> next several days,
> > at latest.
> 
> Can you talk about what structural changes you've made since the last
> branch? :) Is there support for mark_down or some of the other things
> we've discussed?
> -Greg

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
