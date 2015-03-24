From: Joao Eduardo Luis <jecluis@gmail.com>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Tue, 24 Mar 2015 10:11:36 +0000
Message-ID: <55113858.50301@gmail.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com> <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net> <550FE53B.9050407@gmail.com> <550FEC6A.1030208@redhat.com> <alpine.DEB.2.00.1503230656560.6964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:35649 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbCXKLj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 06:11:39 -0400
Received: by weoy45 with SMTP id y45so9495937weo.2
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2015 03:11:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503230656560.6964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, John Spray <john.spray@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/23/2015 01:58 PM, Sage Weil wrote:
> On Mon, 23 Mar 2015, John Spray wrote:
>> On 23/03/2015 10:04, Joao Eduardo Luis wrote:
>>> I agree.  And I don't think we need a new service for this, and I also don't
>>> think we need to write stuff to the store.  We can generate this information
>>> when the monitor hits 'bootstrap()' and share it with the rest of the quorum
>>> once an election finishes, and always keep it in memory (unless there's some
>>> information that needs to be persisted, but I was under the impression that
>>> was not the case).
>>
>> Just to clarify, you mean we don't need to write the mon metadata to the
>> store, but we'd still want to persist the MDS/OSD metadata - right?
>
> I think we definitely still want to persist those (as we already do
> persist the OSD metadata).
>
> Since we're reporting on running daemons we could get that without
> persisting the mon metadata.  I think the question is whether we want to
> report on the last known running instance.  I forget whether 'osd
> metadata' includes OSDs that are down... if so, we may as well do
> the same for mons too and persist that.
>

Yeah, we may persist the info if we intend on reporting on down/out of 
quorum monitors.  In that case, I don't think we need anything 
particularly fancy.  Something like:

1. on finish_election() send metadata info to leader
2. leader coalesces all quorum participants info
3. leader gets last known metadata:
   last_metadata = store->get(MONITOR_STORE_PREFIX, "last_metadata");
4. Fill whatever is missing on the this quorum's metadata (down mons and 
what not):
   new_metadata.fill_gaps_and_stuff(last_metada);
5. leader creates a store transaction:
   MonitorDBStore::TransactionRef t = paxos->get_pending_transaction();
   t->put(Monitor::MONITOR_STORE_PREFIX, "last_metadata", new_metadata);
   paxos->trigger_propose();

This should do nicely, and it will only take adding a new message type 
and a few functions to the Monitor class that will handle that message 
type.  I don't think we need to enforce the same restrictions that 
PaxosService does, so that will simplify things a lot.

Also, just thought that a good way to version the metadata struct would 
be to use the election epoch.

Anyway, on reporting it would be nice if we were to clearly state that 
the hostname may not be current, if the mon is not in quorum.  I don't 
think people change hostnames for sport, but I can imagine an instance 
in which someone changed a given hostname, kept the IP just the same, 
and then got confused seeing the old hostname being reported by ceph mon 
metadata (or wtv).

   -Joao


-- 
Joao Eduardo Luis | github.com/jecluis
