From: Sage Weil <sweil@redhat.com>
Subject: Re: Caught the first erroneous translated errorcode
Date: Mon, 19 Jun 2017 14:31:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706191430290.32269@piezo.novalocal>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl> <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com> <5ca934f2-0f95-bb6c-0fce-267468cb59b4@digiware.nl> <028757af-a82b-d873-648d-294961984bbb@digiware.nl>
 <CA+aFP1BST9e4UV6kyxP=kLN0tN0=1EkV=41cBV2Y5d98hrED7A@mail.gmail.com> <95b2bd08-f38b-f5ff-ebfc-523dddb1398b@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdFSObL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Jun 2017 10:31:11 -0400
In-Reply-To: <95b2bd08-f38b-f5ff-ebfc-523dddb1398b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: dillaman@redhat.com, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 19 Jun 2017, Willem Jan Withagen wrote:
> On 19-6-2017 14:56, Jason Dillaman wrote:
> > On Sun, Jun 18, 2017 at 1:18 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> >> librbd/io/AioCompletion.cc:199:ssize_t AioCompletion::get_return_value() {
> > 
> > 
> > librbd just wraps librados, so I would think all the error codes
> > should have already been properly translated before it reaches this
> > level since otherwise any internal librbd error logging will output
> > the incorrect failure reason. I'd suspect most of the client-side
> > handling should probably be handled inside osdc/Objecter.h/cc..
> 
> Hi Jason,
> 
> Thanx for the pointer. Changing any of the librbd stuff did indeed not
> result in a working rados-stripper.sh
> 
> Objecter.{h,cc} already had the forward error rewrite. I added the
> reverse in the original patch. But obviously that is not enough (yet)
> So I'll start digging a bit more in the librados files as you suggested.

I think the place to do this is in MOSDOpReply.. that alone should be 
enough to do the translate as the value passes over the wire.

s
