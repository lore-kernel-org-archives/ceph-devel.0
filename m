From: Sage Weil <sage@inktank.com>
Subject: Re: running without cephx
Date: Tue, 23 Oct 2012 14:53:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210231451580.6264@cobra.newdream.net>
References: <5086FAC1.3030706@inktank.com> <CAC-hyiGDzPGMUjoRJH5A1eX1C_yia0LnT2r9JeJNSCSiE2o_4Q@mail.gmail.com> <CAC-hyiGq1hX_CdhgnMOnT-6D3g3PrPE5XXA+v_dKyqWhdM9AXA@mail.gmail.com> <5087033F.4050802@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42653 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab2JWVxW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 17:53:22 -0400
In-Reply-To: <5087033F.4050802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 23 Oct 2012, Joao Eduardo Luis wrote:
> On 10/23/2012 09:24 PM, Yehuda Sadeh wrote:
> > On Tue, Oct 23, 2012 at 1:22 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> >> On Tue, Oct 23, 2012 at 1:14 PM, Dan Mick <dan.mick@inktank.com> wrote:
> >>> So, I've discovered that to make "no cephx" work, you need to explicitly set
> >>> "none" for the three options (thanks to Yehuda for the tip):
> >>>
> >>>         auth cluster required = none
> >>>         auth service required = none
> >>>         auth supported = none
> >>>
> >>> Since "blank" is not an error, but leads to a disagreement about
> >>> authentication that's fairly hard to diagnose, should we make it an error to
> >>> specify a blank entry for those items?
> >>>
> >> Maybe fix it so that blank entries would be equivalent to 'none'?
> >>
> >> Yehuda
> > 
> > That should do it:
> > 
> > diff --git a/src/auth/AuthMethodList.cc b/src/auth/AuthMethodList.cc
> > index e23ac40..53c8d66 100644
> > --- a/src/auth/AuthMethodList.cc
> > +++ b/src/auth/AuthMethodList.cc
> > @@ -35,6 +35,8 @@ AuthMethodList::AuthMethodList(CephContext *cct, string str)
> >        lderr(cct) << "WARNING: unknown auth protocol defined: " <<
> > *iter << dendl;
> >      }
> >    }
> > +  if (auth_supported.empty())
> > +    auth_supported.push_back(CEPH_AUTH_NONE);
> >  }
> > 
> >  bool AuthMethodList::is_supported_auth(int auth_type)
> 
> I, for one, believe that when it comes to configuration files, leaving
> blank values defaulting to something is not the best idea. I would
> rather have a blank value spitting out an error, as it gives room for
> someone leaving it blank assuming it will use 'none', as others may
> assume it will default to 'cephx'.

The situation before 66bda162e1acad34d37fa97e3a91e277df174f42 was

	auth cluster required = 
	auth service required =
	auth supported = none

Now it is

	auth cluster required = cephx
	auth service required = cephx
	auth supported =

(auth support is the deprecated option that kicks in if 'auth * required' 
is blank).

Perhaps just documenting the first above block as the way to disable cephx 
is the way to go.

sage
