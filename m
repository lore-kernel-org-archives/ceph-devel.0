From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Thu, 8 Sep 2016 17:46:45 +0200
Message-ID: <CA+H5UW3J3XtMeqhH7FjRCe-ocep-ZidLSpNX=1y=sX6GmcamRQ@mail.gmail.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com> <45ac8340-c6eb-8cdc-9c83-3db6f7f3fcd6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34870 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbcIHPqq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 11:46:46 -0400
Received: by mail-qk0-f182.google.com with SMTP id v123so52307469qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 08:46:46 -0700 (PDT)
In-Reply-To: <45ac8340-c6eb-8cdc-9c83-3db6f7f3fcd6@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Sep 7, 2016 at 11:09 PM, Casey Bodley <cbodley@redhat.com> wrote:
>
> AWS v4 is a good example to look at, yeah. It's a special case, because
> there's a separate 'complete' step after reading the body of the request, so
> we need to track auth state between the calls to authorize() and complete().
> The current implementation stores this stuff in a 'struct rgw_aws4_auth'
> member of req_state.

Yup, AWS v4 was a game changer - not only from the perspective
of auth subsystem but for RGWOps as well. Before its introduction
the flow was pretty straightforward:

  1. authenticate - currently RGWHandler::authorize
  2. authorize - RGWOp::verify_permissions
  3. execute - RGWOp::execute

As you mentioned, in such situation AuthEngines can be truly
stateless. In the post-AWSv4 era things are more complicated,
unfortunately. This is the cost we're paying for assuring data
integrity without in-memory buffering on the application level.
Now the flow does look like:

  A. authenticate - RGWHandler::authorize
  B. authorize - RGWOp::verify_permissions
  C. execute_prepare - some parts of RGWOp::execute
  D. authenticate_complete - some parts of RGWOp::execute
  E. execute_commit - some parts of RGWOp::execute

The typical example is RGWPutObj::execute that actually does
point C, D, E. I can fully understand why we have this actually.
Though, in the future I would like to restore the clear separation
of concerns (the single responsibility principle). The new auth
infrastructure was designed to accommodate v4 as well.

> So far, all of the AuthEngine instances have been constructed on the stack
> in their handler's authorize() method, so their state has been limited to
> that scope. If a new AWS4AuthEngine were to encapsulate v4 auth this state,
> the engine would have to live somewhere outside of the authorize() method -
> most likely in req_state. But we could just as easily have a stateless
> AWS4AuthEngine that accessed the existing rgw_aws4_auth via req_state.
> Encapsulation of rgw_aws4_auth could be improved by making everything
> private except for a complete() method (and call it  AWS4AuthCompletion, for
> example).

I don't want to treat AWSv4 in any special way. I would prefer
to have simply an reference to AuthEngine in RGWHandler or
req_state if we want to make the first one stateless. The specific
implementation would encapsulate all required state inside.
Of course, the AuthEngine interface needs to be extended with
something like complete_authentication() but this was expected.
Moreover, AWSv4 was the main factor behind making AuthEngine
state-full.

Regards,
Radek
