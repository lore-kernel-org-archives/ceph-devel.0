From: Sage Weil <sweil@redhat.com>
Subject: Re: Hammer incompat bits and ceph-objectstore-tool
Date: Wed, 18 Mar 2015 06:50:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503180647280.7043@cobra.newdream.net>
References: <5508DB26.5000706@redhat.com> <CAC6JEv-LO=_AW8KA5_=RPLarnVYdHpvg-8b8a7Fgf_4bgOww2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48870 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbbCRNu1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Mar 2015 09:50:27 -0400
In-Reply-To: <CAC6JEv-LO=_AW8KA5_=RPLarnVYdHpvg-8b8a7Fgf_4bgOww2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: David Zafman <dzafman@redhat.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 17 Mar 2015, Gregory Farnum wrote:
> On Tue, Mar 17, 2015 at 6:55 PM, David Zafman <dzafman@redhat.com> wrote:
> >
> > During upgrade testing an error occurred because ceph-objectstore-tool found
> > during import on a Firefly node the compat_features from a export from
> > Hammer.
> >
> > There are 2 new feature bits set as shown in the error message:
> >
> > Export has incompatible features set
> > compat={},rocompat={},incompat={12=transaction hints,13=pg meta object}
> >
> > In this case as far as I can tell these osd incompatible changes wouldn't
> > make the export data in any way incompatible.  So we may have to check
> > compatibility bits on a case by case basis, if we want to allow the tool to
> > work in the most cases possible.
> >
> > During upgrade testing it is interesting that one node has the transaction
> > hints feature, but other nodes still running firefly don't.  Is this a case
> > where we don't have to wait for all  OSDs to update before the cluster can
> > start handling OP_COLL_HINT operations?
> 
> Mmm, I wasn't much involved in any of it but I think the tricky bit
> about transaction hints are that they get encoded into the journal.
> I'm not sure this handling is quite right though ? if they're not
> recognized can't they just get skipped in the decoding stages?
> In any case, hammer OSDs are supposed to make use of hints without
> upgrading all OSDs, IIRC by checking with their peers on every
> interval to decide if everybody supports the needed encoding or not
> (since during backfill they just transfer objects, it's not a problem
> to later include an old OSD). But it looks from a distance like there
> may still be some design work to do here.

This was added in ad6a2be402665215a19708f55b719112096da3f4, a bit 
before giant.  It covers the create-collection-with-size-hint operation 
from Yahoo that prehashes the filestore, and it's just about the encoded 
transactions in the journal.  It won't have any effect on the 
ceph-objectstore-tool (unless we care about preserving the hashing hint 
across export/import... I don't think we care!).

The pg meta object feature is about how the pg log is stored on import.  
It won't effect export, but clearly effects how the data is imported.

We could segregate these out in the compat structure somehow to make 
an export vs import compat distinction, but it is probably simpler to 
just encode those lists in the tool itself...?

sage
