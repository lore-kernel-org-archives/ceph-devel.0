From: Sage Weil <sage@newdream.net>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Mon, 23 Mar 2015 06:58:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503230656560.6964@cobra.newdream.net>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com> <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net> <550FE53B.9050407@gmail.com> <550FEC6A.1030208@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40063 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbbCWN6R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 09:58:17 -0400
In-Reply-To: <550FEC6A.1030208@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Joao Eduardo Luis <jecluis@gmail.com>, kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 23 Mar 2015, John Spray wrote:
> On 23/03/2015 10:04, Joao Eduardo Luis wrote:
> > I agree.  And I don't think we need a new service for this, and I also don't
> > think we need to write stuff to the store.  We can generate this information
> > when the monitor hits 'bootstrap()' and share it with the rest of the quorum
> > once an election finishes, and always keep it in memory (unless there's some
> > information that needs to be persisted, but I was under the impression that
> > was not the case).
>
> Just to clarify, you mean we don't need to write the mon metadata to the
> store, but we'd still want to persist the MDS/OSD metadata - right?

I think we definitely still want to persist those (as we already do 
persist the OSD metadata).

Since we're reporting on running daemons we could get that without 
persisting the mon metadata.  I think the question is whether we want to 
report on the last known running instance.  I forget whether 'osd 
metadata' includes OSDs that are down... if so, we may as well do 
the same for mons too and persist that.

sage
