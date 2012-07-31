From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: About teuthology
Date: Tue, 31 Jul 2012 15:01:56 -0700
Message-ID: <501855D4.5070101@inktank.com>
References: <20120731135955.GA23001@mail.sileht.net> <5017EB6A.5040104@inktank.com> <20120731161633.GB23001@mail.sileht.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47401 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab2GaWB7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 18:01:59 -0400
Received: by pbbrp8 with SMTP id rp8so9492pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 15:01:59 -0700 (PDT)
In-Reply-To: <20120731161633.GB23001@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On 07/31/2012 09:16 AM, Mehdi Abaakouk wrote:
> On Tue, Jul 31, 2012 at 09:27:54AM -0500, Mark Nelson wrote:
>> On 7/31/12 8:59 AM, Mehdi Abaakouk wrote:
>> Hi Mehdi,
>>
>> I think a number of the test related tasks should run fine without
>> strictly requiring the ceph task.  You may have to change binary
>> locations for things like rados, but those should be pretty minor.
>>
>> Best way to find out is to give it a try!
>
> Thanks for your quick answer :)
>
> I have already tried, but the code massively refers to files in
> /tmp/cephtest/, it seems to me that changing the path of the
> binaries isn't enough, some of them are built by the ceph task.
>
> Perhaps a quicker (a bit dirty) way is to create a new task 'cephdist',
> that prepares the required files in /tmp/cephtest.
> ie:
> - link dist binary to /tmp/cephtest/binary/usr/local/bin/...
> - link /etc/ceph/ceph.conf to /tmp/cephtest/ceph.conf
> - ship cephtest tool in /tmp/cephtest (like ceph task)
> - make dummy script for coverage (because distributed ceph doesn't seem
>    to have ceph-coverage)
>
> What do you think about it ?

That's probably the easiest way to get it working right now, if you
want to use the teuthology-specific tests. As Tommi mentioned, the
/tmp/cephtest stuff will go away in the long term.

There may be a few more things needed to run some of the tests (e.g. the 
binaries built when configured --with-debug like test_librbd,
test_rados_api_io, etc.).

Josh
