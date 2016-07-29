From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: scoping daemon-helper replacement effort
Date: Fri, 29 Jul 2016 09:55:18 -0700
Message-ID: <579B8A76.7020606@redhat.com>
References: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbcG2QzT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jul 2016 12:55:19 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BAF23B3C2
	for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 16:55:19 +0000 (UTC)
In-Reply-To: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 07/29/2016 09:40 AM, Ken Dreyer wrote:
> daemon-helper predates a lot of things in Ceph, and the further we go
> into systemd-land with things like unprivilged daemons, SELinux, and
> cgroups, the further Teuthology diverges from what our users do. To
> remedy this, I want to retire daemon-helper and have Teuthology tests
> use the normal init system, particularly now that our main supported
> distros are unified around systemd.
>
>  From what I understand, we use daemon-helper in Teuthology to:
>
>    1) start a daemon and eventually stop it with either SIGTERM or
> SIGKILL, depending on whether the Teuthology task has enabled the
> coverage or valgrind options,
>
>    2) send data via STDIN
>
>    3) print some messages when the child crashes
>
> I think we could run the services using the systemd unit files and
> still accomplish #1 and #3.
>
> For #2 (communicating to the daemons via STDIN), how could we
> accomplish this? What sort of things are we writing to the daemons'
> STDIN? I'm having trouble finding examples in ceph-qa-suite.git.

We're not using it to write data to the daemons, but as a way to kill 
them automatically if our ssh connection dies.

With fast reimaging in the works, this will be irrelevant. Even now,
it's not really useful for the usual scheduled jobs where the nodes are
rebooted on failure. So I wouldn't worry about (2).

Josh
