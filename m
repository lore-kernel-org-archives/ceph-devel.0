From: Loic Dachary <loic@dachary.org>
Subject: Re: Client test suite
Date: Sun, 19 Feb 2017 00:31:53 +0100
Message-ID: <50057c86-363f-eb77-a325-74e018502be4@dachary.org>
References: <c53ba163-a424-de03-040b-70ff381001ba@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40608 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdBRXb7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Feb 2017 18:31:59 -0500
In-Reply-To: <c53ba163-a424-de03-040b-70ff381001ba@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

My first thought is that it should be enough to run the client on qemu to target the desired architecture. A few rbd tests already do that (spawn qemu). I'm not sure there is a need to do things outside of teuthology. Ideally we would have an OpenStack tenant able to provision both arm & x86 but this is not going to happen. However, spawning a x86 vm that runs an arm qemu should be more than enough to address architecture concerns.

Cheers

On 02/18/2017 10:29 PM, Nathan Cutler wrote:
> I'm preparing the beginnings of a sketch of a possible design for a Ceph client integration test suite.
> 
> The need for a way to test different versions/platforms/architectures of clients against different versions/platforms/architectures of server is, I think, obvious.
> 
> Such a client test suite could be run by teuthology within a conventional teuthology cluster like Sepia, but it would also need to be runnable outside of a such an environment. (For example, think of how one would test an aarch64 client against a Ceph cluster running on x86_64, or vice versa.)
> 
> This got me thinking about how teuthology could be leveraged to implement a client integration test suite.
> 
> First, the test suite itself could (optionally) take a set of monitor hostnames/IP addresses and a cephx key as an input, so it could (again, optionally) run against a Ceph cluster running outside of teuthology.
> 
> Second, teuthology could be modified to allow it to run a test suite on a single machine by creating VMs (libvirt) or containers for the tests, and running the tests in series instead of in parallel.
> 
> Any thoughts on this?
> 
> Nathan
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
