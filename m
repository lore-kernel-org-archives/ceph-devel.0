From: Sage Weil <sweil@redhat.com>
Subject: Re: [RFC]About ImageIndex
Date: Wed, 13 Aug 2014 06:12:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408130605000.18917@cobra.newdream.net>
References: <CACJqLybDC95NH36mux9jQcA5abqSxa8k1eMgTXKdqDWG0yjD-Q@mail.gmail.com> <53EACA0E.5050506@inktank.com> <CACJqLyaJr_4vXrZ415W=xesZ514pP=VzjRSRb3Bv2rqH5buspw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53689 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbaHMNMp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 09:12:45 -0400
In-Reply-To: <CACJqLyaJr_4vXrZ415W=xesZ514pP=VzjRSRb3Bv2rqH5buspw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 13 Aug 2014, Haomai Wang wrote:
> On Wed, Aug 13, 2014 at 10:14 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> > On 08/11/2014 07:50 PM, Haomai Wang wrote:
> >>
> >> Hi Sage, Josh:
> >>
> >> ImageIndex is aimed to hold each object's location info which avoid
> >> extra checking for none-existing object. It's only used when image flags
> >> exists LIBRBD_CREATE_NONSHARED. Otherwise, ImageIndex will become gawp and
> >> has no effect.
> >
> >
> > I like the general structure of the code, and it's great to hear you've
> > been testing it with test_librbd_fsx. Some thoughts on the design:
> >
> >
> >> Each object has three state:
> >> 1. UNKNOWN: default value, it will follow origin path
> >> 2. LOCAL: imply this object is local, don't need to lookup parent image
> >> 3. PARENT: imply this object is in the parent image, don't need to read
> >> from local image
> >
> >
> > What about calling these unknown, exists, and nonexistent instead?
> > This information can be used for non-clone use cases too. Internally
> > there's another ImageCtx for each parent, which can have its own
> > index, so I don't think there's a need to keep track of any objects
> > from different images in one ImageCtx.
> 
> The names seemed better. But what's mean of latter sentences?
> Now a image's ImageIndex only track own objects.

Just that we should stay away from using the term "parent" as a state name 
because we should not reflect the parent's allocation state (the parent 
ImageCtx does that), only our own.  Your definition really means 
NONEXISTENT (object doesn't exist), and it useful/meaningful even if 
cloning is not used (for example, rbd_remove() or rbd_discard() can skip 
this object).  Similarly, s/LOCAL/EXISTS/.

Cheers-
sage

