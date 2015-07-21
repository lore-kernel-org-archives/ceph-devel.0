From: David Casier AEVOO <david.casier@aevoo.fr>
Subject: Re: [Documentation] Hardware recommandation : RAM and PGLog
Date: Tue, 21 Jul 2015 17:00:14 +0200
Message-ID: <55AE5E7E.9050806@aevoo.fr>
References: <55ABC8E5.1030304@aevoo.fr> <55ABCB49.1080304@aevoo.fr> <alpine.DEB.2.00.1507200610310.8878@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 62-210-192-203.rev.poneytelecom.eu ([62.210.192.203]:41938 "EHLO
	aevoo.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbbGUPBM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jul 2015 11:01:12 -0400
In-Reply-To: <alpine.DEB.2.00.1507200610310.8878@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

OK,
I just understand the need of transactions for the trim takes place 
after changing settings.
What is the risk to have too low a value for the parameter 
osd_min_pg_log_entries (not osd_max_pg_log_entries in degraded 
environment) ?

David.

On 07/20/2015 03:13 PM, Sage Weil wrote:
> On Sun, 19 Jul 2015, David Casier AEVOO wrote:
>> Hi,
>> I have a question about PGLog and RAM consumption.
>>
>> In the documentation, we read "OSDs do not require as much RAM for regular
>> operations (e.g., 500MB of RAM per daemon instance); however, during recovery
>> they need significantly more RAM (e.g., ~1GB per 1TB of storage per daemon)"
>>
>> But in fact, all pg log are read in the start of ceph-osd daemon and put in
>> RAM ( pg->read_state(store, bl); )
>>
>> Is this normal behavior or I have a defect in my environment?
> There are two tunables that control how many pg log entries we keep
> around.  When teh PG is healthy, we keep ~1000, and when the PG is
> degraded, we keep more, to expand the time window over which a recovering
> OSD will be able to do regular log-based recovery instead of a more
> expensive backfill.  This is one source of additional memory.
>
> Others are the missing sets (lists of missing/degraded objects) and
> messages/data/state associated with objcts that are being
> recovered/copied.
>
> Note that the numbers in teh documentation are pretty rough rules of
> thumb.  At some point it would be great to build a model for how much RAM
> the osd consumes as a function of the various configurables (pg log size,
> pg count, avg object size, etc.).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

