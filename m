From: Tim Serong <tserong@suse.com>
Subject: Re: multiple cherrypys in ceph-mgr modules stomp on each other
Date: Thu, 13 Apr 2017 23:21:12 +1000
Message-ID: <c93b59d3-f7f5-fe18-20dc-324be4e0331e@suse.com>
References: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
 <CALe9h7cT5z8-gAszW5e+xoFJbv42+D=-UW=uveqFHaY+LUAbCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53430 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbdDMNVV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 13 Apr 2017 09:21:21 -0400
In-Reply-To: <CALe9h7cT5z8-gAszW5e+xoFJbv42+D=-UW=uveqFHaY+LUAbCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/11/2017 09:17 PM, John Spray wrote:
> On Tue, Apr 11, 2017 at 11:41 AM, Tim Serong <tserong@suse.com> wrote:
>> [...]
>> cherrypy.engine.start() call or they have no effect.  One way to do that
>> would be to have some magic cherrypy module which is always loaded last
>> to start the engine, but that might be ugly.
>>
>> Another option might be to have a separate python interpreter per module
>> (can't stomp on each other then, right?) but that might be too resource
>> intensive.
> 
> My assumption has been that the global cherrypy stuff was a
> convenience that could be un-wrapped into something simpler as and
> when, but that may not be the case...
> 
> We could have a small shared python module next to mgr_module.py that
> modules could use to cooperate nicely on the global cherrypy bits.  It
> wouldn't be a total hack, as it would make some of "make me a
> webserver" code less repetitive between modules that want to do that.
> 
> Doing separate sub-interpreters would also be an option that would
> give us more robustness generally in the face of python modules that
> do global things.  I don't think there was any fundamental reason I
> didn't use sub-interpreters when writing this stuff originally,
> they're just a comparatively sparesely documented part of CPython.

I think I'm liking the second option for general robustness.  My best
guess right now is that's probably adding a Py_NewInterpreter() call to
MgrPyModule's constructor, and PyThreadState_Swap()s in its methods so
the right thread state is active at the right time.  I reckon this'll
require some other rejigging in various places though -- note how
https://docs.python.org/2/c-api/init.html#bugs-and-caveats says that
combining sub-interpreters with the PyGILState_*() APIs "is delicate",
and further up it flat out states "The following functions use
thread-local storage, and are not compatible with sub-interpreters:
PyGILState_Ensure() ... PyGILState_Release()..." etc.

Given the sparseness of the docs it's probably best to just try it and
see what catches on fire.  I'll keep you posted.

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
