From: Sage Weil <sage@newdream.net>
Subject: Re: RFC: new rados whereis command
Date: Mon, 29 Dec 2014 12:08:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412291203020.5967@cobra.newdream.net>
References: <5499EB3C.2040602@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42211 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbaL2UIe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Dec 2014 15:08:34 -0500
In-Reply-To: <5499EB3C.2040602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

Sorry I've been slow to review this!

On Tue, 23 Dec 2014, Loic Dachary wrote:
> Hi Andreas,
> 
> I took a closer look at https://github.com/ceph/ceph/pull/2730 implementing rados whereis [--dns] and I think it deserves a discussion here. If I understand correctly, it relies on a new function of the rados API:
> 
>   typedef struct whereis {
>     int64_t osd_id;                              //< ID of the OSD hosting this object

Perhaps it would be better to have

 int32_t primary_osd;
 vector<int32_t> acting_osds;

>     std::string osd_state;                       //< state of the OSD - either 'active' or 'inactive'

I don't think this makes here.  Only 'up' OSDs are eligible for 
the acting set (or the primary).

>     int64_t pg_seed;                             //< Seed of the PG hosting this object

Yes

>     std::string ip_string;                       //< Ip as string

I think we should use sockaddr_storage here, if we include the address at 
all.  But perhaps it makes more sense to get the address for a given OSD 
id with a separate call...

>     std::vector<std::string> host_names;         //< optional reverse DNS HostNames
>     std::map<std::string, std::string> user_map; //< optional user KV map
>     void resolve();                              //< reverse DNS OSD IPs and store in HostNames

I don't think these belong in the interface at all.

>   } whereis_t;
> 
>   static int whereis(IoCtx &ioctx, const std::string &oid, std::vector<whereis_t> &locations);

get_object_location?  map_object_location?  and return a single struct.

sage


> which needs to be added there because the rados API does not expose some details that are needed to fill the fields of the whereis_t structure.
> 
> It looks fine to me but ... I'm not used to maintaining or developing the rados API and someone else may have a more informed opinion.
> 
> There is a technical detail that also needs to be sorted out : the current implementation exposes the RadosWhereis class (for dump) and this should either be moved to rados.cc or be part of the rados API (which probably is not the best option because it would also expose Formatter as a consequence).
> 
> Cheers
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
