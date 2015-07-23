From: John Spray <john.spray@redhat.com>
Subject: Re: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 13:34:15 +0100
Message-ID: <55B0DF47.3040704@redhat.com>
References: <55B0BB59.7010806@redhat.com> <55B0CEA0.80008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbbGWMeR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 08:34:17 -0400
In-Reply-To: <55B0CEA0.80008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org



On 23/07/15 12:23, Loic Dachary wrote:
> You may be interested by
>
> https://github.com/ceph/ceph/blob/master/src/test/ceph-disk-root.sh
>
> which is conditionally included
>
> https://github.com/ceph/ceph/blob/master/src/test/Makefile.am#L86
>
> by --enable-root-make-check
>
> https://github.com/ceph/ceph/blob/master/configure.ac#L414
>
> If you're reckless and trust the tests not to break (a crazy proposition by definition IMHO ;-), you can
>
> make TESTS=test/ceph-disk-root.sh check
>
> If you want protection, you do the same in a docker container with
>
> test/docker-test.sh --os-type centos --os-version 7 --dev make TESTS=test/ceph-disk-root.sh check
>
> I tried various strategies to make tests requiring root access more accessible and less scary and that's the best compromise I found. test/docker-test.sh is what the make check bot uses.

Interesting, I didn't realise we already had root-ish tests in there.

At some stage the need for root may go away in ceph-fuse, as in 
principle fuse mount/unmounts shouldn't require root.  If not then 
putting an outer docker wrapper around this could make sense, if we 
publish the built binaries into the docker container via a volume or 
somesuch.  I am behind on familiarizing myself with the dockerised tests.

> When a test can be used both from sources and from teuthology, I found it more convenient to have it in the qa/workunits directory which is available in both environments. Who knows, maybe you will want a vstart based cephfs test to run as part of make check, in the same way
>
> https://github.com/ceph/ceph/blob/master/src/test/cephtool-test-mds.sh
>
> does.

Yes, this crossed my mind.  At the moment, even many of the "quick" 
tests/cephfs tests take tens of seconds, so they are probably a bit too 
big to go in a default make check, but for some of the really simple 
things that are currently done in cephtool/test.sh, I would be temped to 
move them into the python world to make them a bit less fiddly.

The test location is a bit challenging, because we essentially have two 
not-completely-stable interfaces here, vstart and teuthology. Because 
teuthology is the more complicated, for the moment it makes sense for 
the tests to live in that git repo.  Long term it would be nice if 
fine-grained functional tests lived in the same git repo as the code 
they're testing, but I don't really have a plan for that right now 
outside of the probably-too-radical step of merging ceph-qa-suite into 
the ceph repo.

John
