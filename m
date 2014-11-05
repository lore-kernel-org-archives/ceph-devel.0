From: Hunter Nield <hunter@acale.ph>
Subject: Re: Consul
Date: Wed, 5 Nov 2014 11:05:34 +0800
Message-ID: <CAGRK8cwq0WkSG98mavGRe4vFzwyK9dqTrgc9knQaE2n0e-YGjg@mail.gmail.com>
References: <54597169.2040006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:40589 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbaKEDFz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 22:05:55 -0500
Received: by mail-qg0-f41.google.com with SMTP id q107so11523918qgd.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 19:05:55 -0800 (PST)
In-Reply-To: <54597169.2040006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I concur with Dan on Consul. It's a great tool.

We use Consul in our Ceph environments but only as a layer above an
installed Ceph installation. Health checks (for the mons/osds
processes and ceph health) and service discovery (for the
apps/services that run in Docker containers on top). We've started on
an alerting tool if anyone has use for it -
https://github.com/AcalephStorage/consul-alerts

There is definitely some overlap on the cluster consensus side (Paxos
vs Raft) and would be nice to reduce another moving part in our
cluster but I would imagine the projects are too different internally
to really combine the two of them.

The one thing that we'd wished for in Ceph before Consul existed was
an easily accessible distributed KV store. Ceph has parts of it but
exposing something like that with an easy CLI/REST API might provide
the primitives for building higher level functionality that Consul
provides. More than likely a distraction though since Consul does such
a good job now.

On a side note, I haven't spoken to Dan in a while but curious on his
thoughts on the overlap on Consul in config management land. Service
discovery, remote execution, etc have some overlap in Puppet, Chef,
etc. Related to Ceph we're pondering it as alternative for deploying
mons/osds (larger scale ceph-deploy perhaps)

On Wed, Nov 5, 2014 at 8:38 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> While at the OpenStack summit Dan Bode spoke highly of Consul ( https=
://consul.io/intro/index.html ). Its scope is new to me. Each individua=
l feature is familiar but I'm not entirely sure if combining them into =
a single software is necessary. And I wonder how it could relate to Cep=
h. It is entirely possible that it does not even make sense to ask thes=
es questions ;-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
