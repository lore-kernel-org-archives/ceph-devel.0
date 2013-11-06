From: Malcolm Haak <malcolm@sgi.com>
Subject: Re: CephFS use cases + MDS limitations
Date: Wed, 6 Nov 2013 15:40:30 +1000
Message-ID: <5279D64E.7090603@sgi.com>
References: <CAD=PzHJTOnSw24egLutyGEFUZFEo6brcurpwyjmYZabvU_1aMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3.sgi.com ([192.48.152.1]:55613 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750780Ab3KFFkg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Nov 2013 00:40:36 -0500
In-Reply-To: <CAD=PzHJTOnSw24egLutyGEFUZFEo6brcurpwyjmYZabvU_1aMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>, ceph-devel@vger.kernel.org

Michael,

I haven't seen any on-list replies yet, so I wasn't sure if this was th=
e=20
right place. But I'll just reply and somebody will let me know if I am=20
wrong.

The use cases I have encountered, in my clustered computing universe,=20
were implemented with a different proprietary clustered file system.=20
These file-systems were being used as home folders or "shared scratch"=20
space. And the specific issues occur when you have users who 'misbehave=
'=20
or have code that, by way of function create(and destroy) large numbers=
=20
of files. And in the process bog down file-system access for everybody.=
=20
I have not yet implemented ceph in production in this role but base=20
testing shows it will encounter the same issues.

While it is ideal to not do such things to a clustered file system, it=20
would be nice to be able to dedicate an MDS to specific sub folders=20
without having to create a whole separate sub-file-system/mount-point=20
(as is the current procedure with other solutions).

It would be really AWESOME to do this 'on the fly'. Having more than on=
e=20
MDS look after the whole file-system in an ACTIVE/ACTIVE fashion would=20
be nice/ideal (as long as latency is not too negativity impacted), but=20
really just being able to 'shard' the file-system up would be more than=
=20
sufficient to solve most of the issues I usually encounter. Having this=
=20
kind of functionality would be a 'killer feature' for this kind of work=
load.

I hope my wall of text makes sense. Please feel free to ping me with=20
questions.

Regards

Malcolm Haak




On 04/11/13 09:53, Michael Sevilla wrote:
> Hi Ceph community,
>
> I=92d like to get a feel for some of the problems that CephFS users a=
re
> encountering with single MDS deployments. There were requests for
> stable distributed metadata/MDS services [1] and I=92m guessing its
> because your workloads exhibit many, many metadata operations. Some o=
f
> you mentioned opening many files in a directory for checkpointing,
> recursive stats on a directory, etc. [2] and I=92d like more details,
> such as:
> - workloads/applications that stress the MDS service that would cause
> you to call for multi-MDS support
> - use cases for the Ceph file system (I=92m not really too interested=
 in
> users using CephFS to host VMs, since many of these use cases are
> migrating to RBD)
>
> I=92m just trying to get an idea of what=92s out there and the proble=
ms
> CephFS users encounter as a result of a bottlenecked MDS (single node
> or cluster).
>
> Thanks!
>
> Michael
>
> [1] CephFS MDS Status Discussion,
> http://ceph.com/dev-notes/cephfs-mds-status-discussion/
> [2] CephFS First Product Release Discussion,
> http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/13524
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
