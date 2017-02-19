From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Client test suite
Date: Sat, 18 Feb 2017 17:19:09 -0800
Message-ID: <CAJ4mKGZH8zgYVfo+fuL7v5jzU8A-pc2KfcuiGa8i0dvpqbggkQ@mail.gmail.com>
References: <c53ba163-a424-de03-040b-70ff381001ba@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:35951 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdBSBTb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Feb 2017 20:19:31 -0500
Received: by mail-ot0-f181.google.com with SMTP id 32so51437711oth.3
        for <ceph-devel@vger.kernel.org>; Sat, 18 Feb 2017 17:19:10 -0800 (PST)
In-Reply-To: <c53ba163-a424-de03-040b-70ff381001ba@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Feb 18, 2017 at 1:29 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> I'm preparing the beginnings of a sketch of a possible design for a Ceph
> client integration test suite.
>
> The need for a way to test different versions/platforms/architectures of
> clients against different versions/platforms/architectures of server is, I
> think, obvious.
>
> Such a client test suite could be run by teuthology within a conventional
> teuthology cluster like Sepia, but it would also need to be runnable outside
> of a such an environment. (For example, think of how one would test an
> aarch64 client against a Ceph cluster running on x86_64, or vice versa.)

I don't understand. Why do you think teuthology couldn't handle
multiple architectures within a test lab? We already allow scheduling
based on OS restrictions, and although they're not in the test running
database I think we have some ARM machines in sepia.
-Greg

>
> This got me thinking about how teuthology could be leveraged to implement a
> client integration test suite.
>
> First, the test suite itself could (optionally) take a set of monitor
> hostnames/IP addresses and a cephx key as an input, so it could (again,
> optionally) run against a Ceph cluster running outside of teuthology.
>
> Second, teuthology could be modified to allow it to run a test suite on a
> single machine by creating VMs (libvirt) or containers for the tests, and
> running the tests in series instead of in parallel.
>
> Any thoughts on this?
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
