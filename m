From: Tim Serong <tserong@suse.com>
Subject: Re: ceph-mgr is in master
Date: Tue, 4 Oct 2016 17:29:44 +0200
Message-ID: <73f6cf9e-59f3-44d7-d31f-a1cd79f873d6@suse.com>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
 <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:43372 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbcJDP3w (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 4 Oct 2016 11:29:52 -0400
In-Reply-To: <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10/04/2016 08:07 AM, John Spray wrote:
> On Mon, Oct 3, 2016 at 6:45 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Fri, Sep 30, 2016 at 4:24 AM, John Spray <jspray@redhat.com> wrote:
>>> Hi all,
>>>
>>> A big thank you to everyone who helped with the reviews, packaging and
>>> design discussions.  This will be included in forthcoming Kraken
>>> (11.2.x) release.
>>>
>>> There is a new section in the documentation:
>>> http://docs.ceph.com/docs/master/mgr/
>>>
>>> There is a new sub-project on tracker.ceph.com, populated with some
>>> issues by me:
>>> http://tracker.ceph.com/projects/mgr/issues
>>>
>>> Pull requests are of course welcome.
>>>
>>> At some point before Kraken I'll try to remember to send out a message
>>> to ceph-users to give people a heads up about this mysterious new
>>> daemon that's appearing on their systems.
>>
>> Awesome, this is going to be great. :) A few questions just from going
>> over the admin guide:
>>
>> 1) It says to run a ceph-mgr on each monitor host. Does this mean
>> admins need to do this manually when setting up a cluster?
> 
> The systemd units will automatically set up a mgr instance in Kraken.
> I haven't personally tested that though.

If you want a little more detail:

https://github.com/ceph/ceph/commit/61d7793 added
Wants=ceph-mgr@%i.service to ceph-mon@.service, so when the mon starts,
it will try to start mgr with the same instance ID, but because it's
"Wants" (not "Requires"), if mgr for some reason fails to start, the mon
will still run.

Additionally, ceph-mgr@.service will autogenerate a key for mgr if you
didn't already create one manually (see
https://github.com/ceph/ceph/commit/082199f).

This seemed the safest way to get the mgr daemon *running* automatically
with zero setup effort on the part of the user.

One kink ATM -- ceph-mgr will run, but if you want to *use* the included
REST API module, you additionally need to `pip2 install django==1.8
python-dateutil gevent djangorestframework`, because that module has
those dependencies.

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
