From: Dan Mick <dmick@redhat.com>
Subject: Re: Would it make sense to require ntp
Date: Wed, 20 Jan 2016 18:45:01 -0800
Message-ID: <56A0462D.4040101@redhat.com>
References: <563C7BB1.7030500@suse.cz>
 <CALe9h7eP-vabaMCYuLuEUO2pME-cRfUHVrOFgkzRcZNqxL2ZbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbcAUCpB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jan 2016 21:45:01 -0500
In-Reply-To: <CALe9h7eP-vabaMCYuLuEUO2pME-cRfUHVrOFgkzRcZNqxL2ZbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/06/2015 04:26 AM, John Spray wrote:
>> If the answer is "no", would it make sense to make NTP a runtime
>> > dependency and tell the ceph-mon systemd service to wait for
>> > ntpd.service before it starts?
> Just waiting for the service is quick, but it doesn't achieve any
> effect on the clock other than promising that it will be synced at
> some point in the future.  Wouldn't we have to wait for time sync
> rather than just waiting for the service?  That could take a while.

For teuthology we have an optional task to stop ntpd, run ntpdate to
slam-sync the clocks, and restart ntpd; by default ntpd can take a
minimum of five minutes to adjust the clock, assuming it's got good sync
data from its servers.  I've wondered whether we ought to try to
distribute that technique for users, but it's pretty half-baked in
teuthology right now (the code exists but we're not running it as a
matter of course).

One wonders if there is a service that could be a sync point for "actual
time update from ntpd/chronyd".
