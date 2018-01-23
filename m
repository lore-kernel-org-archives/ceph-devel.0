From: John Spray <jspray@redhat.com>
Subject: Re: debugging mgr python modules
Date: Tue, 23 Jan 2018 10:03:48 +0000
Message-ID: <CALe9h7dmT=npWKNN7F+304DHpW-E5ZQqczBrHYo67aJYe3bfXg@mail.gmail.com>
References: <822b6122-c866-f6b6-42e5-6913dbef0744@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38916 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeAWKEJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jan 2018 05:04:09 -0500
Received: by mail-wm0-f48.google.com with SMTP id b21so664280wme.4
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 02:04:09 -0800 (PST)
In-Reply-To: <822b6122-c866-f6b6-42e5-6913dbef0744@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 23, 2018 at 12:38 AM, Tim Serong <tserong@suse.com> wrote:
>
> Hi All,
>
> Right now, if you want to debug an mgr python module, you're pretty much
> restricted to dumping interesting stuff to log files, right?
>
> What about if you wanted to run an interactive python debugger?
>
> I had two half-formed ideas for this.  One is that apparently there's
> something called prdb, which could theoretically be loaded in an mgr
> module to enable remote debugging over a socket (although
> https://pypi.python.org/pypi/rpdb/ says it reroutes stdout and stdin,
> which I assume might not work given mgr is already eating those -- not
> sure, haven't had a chance to try it yet).


This kind of remote interface would be the way to go -- another option
would be https://pypi.python.org/pypi/manhole


>
>
> The second idea was to create a python wrapper which provides a stub
> implementation of the pieces that ceph-mgr exposes from C++ land
> (ceph_state, etc.).  This would expose some fake cluster state, much as
> the minion sim thing did in calamari.  Then you could (somehow) load/run
> a mgr python module completely outside mgr to experimentally poke at it.
>  Having typed all that out  now, I suspect this might be a PITA to
> maintain and be ultimately less useful for live debugging that the first
> half-formed idea, although it might be interesting for unit testing.


PITA to maintain is correct, but even more than that, it's important
that the mgr tests are using the real data structures.  The primary
motivation for the self test functions in modules today is to quickly
detect any changes in underlying structures that violate module
expectations -- if we started using mocks then well-meaning developers
would end up writing unit tests that gave a false sense of security.

However, if there are classes in python modules that don't directly
talk to Ceph, and those classes need out-of-cluster unit tests, then
obviously that's much easier.

Tangentially related: I'm gradually trying to raise awareness of
qa/tasks/vstart_runner.py -- writing tests against running clusters
(like those in qa/tasks/mgr) can still be quick and convenient.

Cheers,
John

>
>
> Any thoughts on whether any of the above is worth pursuing?
>
> Thanks,
>
> Tim
> --
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
