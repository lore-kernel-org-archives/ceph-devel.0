From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 10:55:52 -0700
Message-ID: <CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>
References: <5437A6C0.3000005@dachary.org>
	<alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>
	<5438134E.7050009@dachary.org>
	<alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:47363 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbaJJRzy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 13:55:54 -0400
Received: by mail-qc0-f177.google.com with SMTP id c9so2327669qcz.36
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 10:55:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Sandon Van Ness <sandon@inktank.com>, Janne Grunau <j@jannau.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 10, 2014 at 10:14 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 10 Oct 2014, Loic Dachary wrote:
>> On 10/10/2014 17:11, Sage Weil wrote:
>> > On Fri, 10 Oct 2014, Loic Dachary wrote:
>> >> Hi Sandon,
>> >>
>> >> Would it be possible to resurect / create an arm7 gitbuilder for
>> >> whatever distribution is more convenient ? Janne made a great
>> >> contribution to erasure code optimization on NEON (
>> >> https://bitbucket.org/jannau/gf-complete/branch/neon ) and it would make
>> >> it easier to have a gitbuilder to run it throught teuthology and torture
>> >> it ;-) If that's complicated or there is another way to run teuthology
>> >> jobs for this purpose, I'm open to suggestions.
>> >
>> > We have a bunch of armv7l nodes that used to run distcc and a gitbuilder.
>> > It's a bit of a time suck to maintain, though.  Is there an interested
>> > party we can set up with lab access that can help administer these on an
>> > ongoing basis?  Sandon is a highly contended resource.  :)
>>
>> Long term I'm not sure. I'll try to setup something temporary and see
>> where it goes. Is there a risk that these machines go away in the next 6
>> months ? 3 months ?

I am an interested party, and at least in the short term would
dedicate some time to getting arm7 builds working too.
