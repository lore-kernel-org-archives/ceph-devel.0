From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Thu, 8 Sep 2016 16:49:54 -0400
Message-ID: <d1335f1c-26ce-5d46-8cc3-af806be25822@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
 <45ac8340-c6eb-8cdc-9c83-3db6f7f3fcd6@redhat.com>
 <CA+H5UW3J3XtMeqhH7FjRCe-ocep-ZidLSpNX=1y=sX6GmcamRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33819 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbcIHUt4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 16:49:56 -0400
Received: by mail-yw0-f179.google.com with SMTP id g192so36433502ywh.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 13:49:56 -0700 (PDT)
In-Reply-To: <CA+H5UW3J3XtMeqhH7FjRCe-ocep-ZidLSpNX=1y=sX6GmcamRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 09/08/2016 11:46 AM, Radoslaw Zarzynski wrote:
> On Wed, Sep 7, 2016 at 11:09 PM, Casey Bodley <cbodley@redhat.com> wrote:
>> AWS v4 is a good example to look at, yeah. It's a special case, because
>> there's a separate 'complete' step after reading the body of the request, so
>> we need to track auth state between the calls to authorize() and complete().
>> The current implementation stores this stuff in a 'struct rgw_aws4_auth'
>> member of req_state.
> Yup, AWS v4 was a game changer - not only from the perspective
> of auth subsystem but for RGWOps as well. Before its introduction
> the flow was pretty straightforward:
>
>    1. authenticate - currently RGWHandler::authorize
>    2. authorize - RGWOp::verify_permissions
>    3. execute - RGWOp::execute
>
> As you mentioned, in such situation AuthEngines can be truly
> stateless. In the post-AWSv4 era things are more complicated,
> unfortunately. This is the cost we're paying for assuring data
> integrity without in-memory buffering on the application level.
> Now the flow does look like:
>
>    A. authenticate - RGWHandler::authorize
>    B. authorize - RGWOp::verify_permissions
>    C. execute_prepare - some parts of RGWOp::execute
>    D. authenticate_complete - some parts of RGWOp::execute
>    E. execute_commit - some parts of RGWOp::execute
>
> The typical example is RGWPutObj::execute that actually does
> point C, D, E. I can fully understand why we have this actually.
> Though, in the future I would like to restore the clear separation
> of concerns (the single responsibility principle). The new auth
> infrastructure was designed to accommodate v4 as well.
>
>> So far, all of the AuthEngine instances have been constructed on the stack
>> in their handler's authorize() method, so their state has been limited to
>> that scope. If a new AWS4AuthEngine were to encapsulate v4 auth this state,
>> the engine would have to live somewhere outside of the authorize() method -
>> most likely in req_state. But we could just as easily have a stateless
>> AWS4AuthEngine that accessed the existing rgw_aws4_auth via req_state.
>> Encapsulation of rgw_aws4_auth could be improved by making everything
>> private except for a complete() method (and call it  AWS4AuthCompletion, for
>> example).
> I don't want to treat AWSv4 in any special way. I would prefer
> to have simply an reference to AuthEngine in RGWHandler or
> req_state if we want to make the first one stateless. The specific
> implementation would encapsulate all required state inside.
> Of course, the AuthEngine interface needs to be extended with
> something like complete_authentication() but this was expected.
> Moreover, AWSv4 was the main factor behind making AuthEngine
> state-full.
>
> Regards,
> Radek

Thanks for the extra background! You've convinced me that it makes sense 
to extend the auth interfaces to support this instead of treating it as 
a special case. But I still don't think that AuthEngine is the right 
place to manage that state - mainly because each request will be trying 
to authenticate against multiple different engines, and only one of them 
will be successful. So with stateful AuthEngines, we'll have to 
construct and destruct instances for all of the engines that fail, and 
then once we find one that succeeds, we have to move or copy that 
instance to extend its lifetime to that of the req_state. I don't see a 
generic way to do that without an extra allocation.

I pointed out AuthApplier (which is what we return from a successful 
call to AuthEngine::authorize()) earlier, because it's an existing 
example of auth state that we store with req_state for later access. 
That seems like a much better pattern for something like AuthCompletion. 
I suggested combining this with AuthApplier, because a) then we don't 
have to allocate the completion state separately, and b) the completion 
is a noop for most auth engines.
