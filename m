From: Sage Weil <sage@newdream.net>
Subject: Re: Consul
Date: Wed, 5 Nov 2014 00:55:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411042353130.15135@cobra.newdream.net>
References: <54597169.2040006@dachary.org> <CAGRK8cwq0WkSG98mavGRe4vFzwyK9dqTrgc9knQaE2n0e-YGjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57242 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaKEIzP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 03:55:15 -0500
In-Reply-To: <CAGRK8cwq0WkSG98mavGRe4vFzwyK9dqTrgc9knQaE2n0e-YGjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hunter Nield <hunter@acale.ph>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 5 Nov 2014, Hunter Nield wrote:
> I concur with Dan on Consul. It's a great tool.
> 
> We use Consul in our Ceph environments but only as a layer above an
> installed Ceph installation. Health checks (for the mons/osds
> processes and ceph health) and service discovery (for the
> apps/services that run in Docker containers on top). We've started on
> an alerting tool if anyone has use for it -
> https://github.com/AcalephStorage/consul-alerts
> 
> There is definitely some overlap on the cluster consensus side (Paxos
> vs Raft) and would be nice to reduce another moving part in our
> cluster but I would imagine the projects are too different internally
> to really combine the two of them.
> 
> The one thing that we'd wished for in Ceph before Consul existed was
> an easily accessible distributed KV store. Ceph has parts of it but
> exposing something like that with an easy CLI/REST API might provide
> the primitives for building higher level functionality that Consul
> provides. More than likely a distraction though since Consul does such
> a good job now.

Have you seen the kv storage service provided by the mons?  It's pretty 
basic but is intended for stashing arbitrary config data.  The original 
use-case we wanted it for was storing the encryption keys for dm-cypt (you 
can restrict individual ceph entities to a subset of the config-key 
namespace), but we never got around to finishing that work (dm-crypt keys 
are still stored in /etc/ceph/keys/ on the local node until we find a 
vocal user with clear requirements).

config-key del <key>                     delete <key>
config-key exists <key>                  check for <key>'s existence
config-key get <key>                     get <key>
config-key list                          list keys
config-key put <key> {<val>}             put <key>, value <val>

sage
