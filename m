From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 2/9] libceph: support crush tunables
Date: Mon, 30 Jul 2012 16:45:13 -0700
Message-ID: <CAC-hyiE766iAXMDA0W=pg7i=hZc-TqOtYDm-xGod1NVE_wSbzg@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-3-git-send-email-sage@inktank.com>
	<CAC-hyiGu--5SUgbexOM-8o-kzRzXLV+5Mve+P-6dYcfo-AX78w@mail.gmail.com>
	<alpine.DEB.2.00.1207301613430.31602@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44816 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2G3XpO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:45:14 -0400
Received: by bkwj10 with SMTP id j10so3047596bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:45:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207301613430.31602@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, caleb miles <caleb.miles@inktank.com>

On Mon, Jul 30, 2012 at 4:14 PM, Sage Weil <sage@inktank.com> wrote:
>
> On Tue, 24 Jul 2012, Yehuda Sadeh wrote:
> > On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> > > From: caleb miles <caleb.miles@inktank.com>
> > >
> > > The server side recently added support for tuning some magic
> > > crush variables. Decode these variables if they are present, or use
> > > the
> > > default values if they are not present.
> > >
> > > Corresponds to ceph.git commit
> > > 89af369c25f274fe62ef730e5e8aad0c54f1e5a5.
> > >
> > > Signed-off-by: caleb miles <caleb.miles@inktank.com>
> > > Reviewed-by: Sage Weil <sage@inktank.com>
> > > ---
> > >  include/linux/ceph/ceph_features.h |    4 ++-
> > >  include/linux/crush/crush.h        |    8 +++++++
> > >  net/ceph/crush/mapper.c            |   13 ++++++-----
> > >  net/ceph/osdmap.c                  |   39
> > > ++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 57 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/ceph/ceph_features.h
> > > b/include/linux/ceph/ceph_features.h
> > > index 342f93d..df25dcf 100644
> > > --- a/include/linux/ceph/ceph_features.h
> > > +++ b/include/linux/ceph/ceph_features.h
> > > @@ -12,12 +12,14 @@
> > >  #define CEPH_FEATURE_MONNAMES       (1<<5)
> > >  #define CEPH_FEATURE_RECONNECT_SEQ  (1<<6)
> > >  #define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
> > > +#define CEPH_FEATURE_CRUSH_TUNABLES (1<<18)
> >
> > any reason why this is 18 and not 8?
>
> 9-17 are used.. just not implemented/used by the kernel code.
>

Maybe mention it somewhere in a comment, to avoid future confusion?
