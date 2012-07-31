From: Tommi Virtanen <tv@inktank.com>
Subject: Re: About teuthology
Date: Tue, 31 Jul 2012 10:55:19 -0700
Message-ID: <CADvuQRGC21xiUvdAV5W5+SuNbZB77e=RakLjNw6E4tLWLW_EdQ@mail.gmail.com>
References: <20120731135955.GA23001@mail.sileht.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47641 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab2GaRzk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 13:55:40 -0400
Received: by vcbfk26 with SMTP id fk26so6111601vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 10:55:39 -0700 (PDT)
In-Reply-To: <20120731135955.GA23001@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 31, 2012 at 6:59 AM, Mehdi Abaakouk <sileht@sileht.net> wrote:
> Hi,
>
> I have taken a look into teuthology, the automation of all this tests
> are good, but are they any way to run it into a already installed
> ceph clusters ?
>
> Thanks in advance.

Many of the actual tests being run are already independent
functionality or stress tests or benchmarks; for example, ffsb will
run against any filesystem.

The things that are specifically written for teuthology are currently
quite tied in details.

There is a longer-term plan to rework teuthology into using
package-based installation, and at that time I hope we will be able to
modularize the tests out of the teuthology core, and to make them
easier to run from just the command line.

This work depends on a bunch of internal changes to our testing lab
infrastructure -- package-based testing is not feasible until we have
lab machine reinstallation 100% automated, and currently it still
tends to need too much manual care.
