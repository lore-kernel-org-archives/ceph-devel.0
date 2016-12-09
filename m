From: Amitay Isaacs <amitay@gmail.com>
Subject: Re: [PATCH] Ceph RADOS cluster mutex helper for Samba CTDB
Date: Fri, 9 Dec 2016 14:11:06 +1100
Message-ID: <CAJ+X7mQYAgO8Uc-kuc2Nmb4K-q+_pv=GyZX2ajST=BMZSjTj2w@mail.gmail.com>
References: <20161201151715.019228c1@suse.de>
 <CAJ+X7mTkBLQDYb+r9LELQe-sqfG_4YkQ9HbkDFAp70cPp7V8zA@mail.gmail.com>
 <20161206131404.38f737d0@suse.de> <20161206131827.273bd9b8@suse.de>
 <CAJ+X7mRh04D+Yvtf0xx3dT6rTa=9KvJagyK=1PJQC=1R+u++7w@mail.gmail.com>
 <20161208193954.7ce6b896@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <samba-technical-bounces@lists.samba.org>
In-Reply-To: <20161208193954.7ce6b896@suse.de>
List-Unsubscribe: <https://lists.samba.org/mailman/options/samba-technical>,
 <mailto:samba-technical-request@lists.samba.org?subject=unsubscribe>
List-Archive: <http://lists.samba.org/pipermail/samba-technical/>
List-Post: <mailto:samba-technical@lists.samba.org>
List-Help: <mailto:samba-technical-request@lists.samba.org?subject=help>
List-Subscribe: <https://lists.samba.org/mailman/listinfo/samba-technical>,
 <mailto:samba-technical-request@lists.samba.org?subject=subscribe>
Errors-To: samba-technical-bounces@lists.samba.org
Sender: "samba-technical" <samba-technical-bounces@lists.samba.org>
To: David Disseldorp <ddiss@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samba Technical <samba-technical@lists.samba.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Dec 9, 2016 at 5:39 AM, David Disseldorp <ddiss@suse.de> wrote:

> Hi Amitay,
>
> On Wed, 7 Dec 2016 13:32:34 +1100, Amitay Isaacs wrote:
>
> > Hi David,
> >
> > On Tue, Dec 6, 2016 at 11:18 PM, David Disseldorp <ddiss@suse.de> wrote:
> >
> > > This time with the patch-set attached...
> > >
> > > >  ctdb/doc/Makefile                             |   3 +-
> > > >  ctdb/doc/ctdb_mutex_ceph_rados_helper.7.xml   |  90 +++++
> > > >  .../utils/ceph/ctdb_mutex_ceph_rados_helper.c | 334
> ++++++++++++++++++
> > > >  ctdb/utils/ceph/test_ceph_rados_reclock.sh    | 151 ++++++++
> > > >  ctdb/wscript                                  |  19 +
> > > >  5 files changed, 596 insertions(+), 1 deletion(-)
> > >
> >
> > In patch 1, why do you need to include any of the CTDB files
> > (protocol/protocol.h and common/system.h) and have dependency on
> > ctdb-system?  I don't see you are using any of the functions defined in
> > common/system.h.
> >
> > Please include the manpage in SAMBA_BINARY() definition. Also include it
> in
> > manpages[] list.  It might be better to merge patch 1 and patch 2.
>
> Thanks for the feedback. Please find a new version attached (atop the
> etcd changes), attempting to address your points above:
> - drop unnecessary includes and ctdb-system dependency
>   + add separate talloc and tevent deps
>   + use tevent_timeval_current_ofs() instead of timeval_current_ofs()
> - conditionally generate the man page
>
> Cheers, David


Looks good.  Pushed to autobuild with following minor fixups.

- In manpage, replace ctdb_mutex_ceph_rados_helper_lock with
ctdb_mutex_ceph_rados_helper
- In wscript, add missing manpages_ceph in the dist target

Amitay.
