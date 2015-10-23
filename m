From: Dan Mick <dmick@redhat.com>
Subject: Re: tracker.ceph.com downtime today
Date: Thu, 22 Oct 2015 19:33:31 -0700
Message-ID: <56299C7B.3040100@redhat.com>
References: <56296119.5040807@redhat.com> <56296C9B.70207@redhat.com>
 <56297692.3090004@redhat.com> <56298A4B.9030705@redhat.com>
 <CAMieVSc6Cx3j1i9vK4qVhBmRcvMX9NYE2j9ygCOHMwomPSrYcw@mail.gmail.com>
 <5629933C.1060901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbbJWCdb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Oct 2015 22:33:31 -0400
In-Reply-To: <5629933C.1060901@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kbader@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Found that issue; reverted the database to the non-backlog-plugin state,
created a test bug.  Retry?

On 10/22/2015 06:54 PM, Dan Mick wrote:
> I see that too.  I suspect this is because of leftover database columns
> from the backlogs plugin, which is removed.  Looking into it.
> 
> On 10/22/2015 06:43 PM, Kyle Bader wrote:
>> I tried to open a new issue and got this error:
>>
>> Internal error
>>
>> An error occurred on the page you were trying to access.
>> If you continue to experience problems please contact your Redmine
>> administrator for assistance.
>>
>> If you are the Redmine administrator, check your log files for details
>> about the error.
>>
>>
>> On Thu, Oct 22, 2015 at 6:15 PM, Dan Mick <dmick@redhat.com> wrote:
>>> Fixed a configuration problem preventing updating issues, and switched
>>> the mailer to use ipv4; if you updated and failed, or missed an email
>>> notification, that may have been why.
>>>
>>> On 10/22/2015 04:51 PM, Dan Mick wrote:
>>>> It's back.  New DNS info is propagating its way around.  If you
>>>> absolutely must get to it, newtracker.ceph.com is the new address, but
>>>> please don't bookmark that, as it will be going away after the transition.
>>>>
>>>> Please let me know of any problems you have.
>>>
>>> ---
>>> Note: This list is intended for discussions relating to Red Hat Storage products, customers and/or support. Discussions on GlusterFS and Ceph architecture, design and engineering should go to relevant upstream mailing lists.
>>
>>
>>
> 

