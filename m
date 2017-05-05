From: Tim Serong <tserong@suse.com>
Subject: Re: multiple cherrypys in ceph-mgr modules stomp on each other
Date: Fri, 5 May 2017 22:15:22 +1000
Message-ID: <89657989-f33b-ffab-18c9-e8fe66ff12c8@suse.com>
References: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
 <CALe9h7cT5z8-gAszW5e+xoFJbv42+D=-UW=uveqFHaY+LUAbCA@mail.gmail.com>
 <c93b59d3-f7f5-fe18-20dc-324be4e0331e@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51586 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbdEEMPc (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 5 May 2017 08:15:32 -0400
In-Reply-To: <c93b59d3-f7f5-fe18-20dc-324be4e0331e@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/13/2017 11:21 PM, Tim Serong wrote:
> On 04/11/2017 09:17 PM, John Spray wrote:
>> Doing separate sub-interpreters would also be an option that would
>> give us more robustness generally in the face of python modules that
>> do global things.  I don't think there was any fundamental reason I
>> didn't use sub-interpreters when writing this stuff originally,
>> they're just a comparatively sparesely documented part of CPython.
> 
> I think I'm liking the second option for general robustness.  My best
> guess right now is that's probably adding a Py_NewInterpreter() call to
> MgrPyModule's constructor, and PyThreadState_Swap()s in its methods so
> the right thread state is active at the right time.  I reckon this'll
> require some other rejigging in various places though -- note how
> https://docs.python.org/2/c-api/init.html#bugs-and-caveats says that
> combining sub-interpreters with the PyGILState_*() APIs "is delicate",
> and further up it flat out states "The following functions use
> thread-local storage, and are not compatible with sub-interpreters:
> PyGILState_Ensure() ... PyGILState_Release()..." etc.
> 
> Given the sparseness of the docs it's probably best to just try it and
> see what catches on fire.  I'll keep you posted.

Coming back to this again, just for the record I've got something that
seems to work:

  https://github.com/ceph/ceph/pull/14971

Note that this should be considered experimental until further notice
:-) but is hopefully promising.

Cheers,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
