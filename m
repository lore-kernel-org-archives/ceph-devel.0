From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: ceph versions
Date: Thu, 26 Feb 2015 16:54:32 -0800
Message-ID: <mcof88$vo0$1@ger.gmane.org>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net> <54EFAE77.3020101@dachary.org> <567942662.11970131.1424995195896.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57441 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbbB0Ayj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 19:54:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YR9CP-0000v4-N8
	for ceph-devel@vger.kernel.org; Fri, 27 Feb 2015 01:54:37 +0100
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 01:54:37 +0100
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 01:54:37 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh-Weinraub wrote:

> 
> 
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>> Sent: Thursday, February 26, 2015 3:38:31 PM
>> Subject: Re: ceph versions
>> 
>> Hi Sage,
>> 
>> I prefer Option D because it's self explanatory. We could also drop the
>> names. I became attached to them but they are confusing to the new users
>> who is required to remember that firefly is 0.80, giant is 0.87 etc.
>> 
>> Cheers
>> 
>> On 27/02/2015 00:12, Sage Weil wrote:
>> > -- Option D -- "labeled"
>> > 
>> > X.Y-{dev,rc,release}Z
>> > 
>> >  - Increment Y on each major named release
>> >  - Increment X if it's a major major named release (bigger change
>> > than usual)
>> >  - Use dev, rc, or release prefix to clearly label what type of release
>> > this is
>> >  - Increment Z for stable updates
>> > 
>> >  1.0-dev1 first infernalis dev release
>> >  1.0-dev2 another dev release
>> >  ...
>> >  1.0-rc1 first rc
>> >  1.0-rc2 next rc
>> >  1.0-release1 final release
>> >  1.0-release2 stable update
>> >  1.0-release3 stable update
>> >  1.1-dev1 first cut for j-release
>> >  1.1-dev2 ...
>> >  ...
>> >  1.1-rc1
>> >  1.1-release1 stable
>> >  1.1-release2 stable
>> >  1.1-release3 stable
>> > 
>> > Q: How do I tell what kind of release this is?
>> > A: Look at the string embedded in the version
>> > 
>> > Q: Will these funny strings confuse things that sort by version?
>> > A: I don't think so.
>> 
>> dev < rc < release : good pick ;-)
>> 
> 
> This is the one I lean towards, with one slight variation. I'd drop the
> 'release' tag and have X.Y[.Z] format for the formal releases, e.g.,
> 2.0-dev1 first infernalis dev release 2.0-dev2
> ..
> 2.0-rc1
> 2.0-rc2
> ...
> 2.0 # infarnalis
> 2.0.1 # first dot release
> ...
> 2.1-dev1 # first j dev release
> ...
> 2.1 # j release
> 
> Then after a few release move to 3.0 to avoid the dreadful big numbers.
> 
> Sage did mention that this might have some issues in certain environments
> to sort correctly. Possibly replacing the dash with a tilde solves this?

Sorting correctly isn't the issue - the issue is that you either need 
separate "channels" (which from experience has been a real pain with 
packaging Chrome in Exherbo), or you need to manually rewrite the download 
URL and such because it's an outright invalid version string from the 
package manager's perspective.


