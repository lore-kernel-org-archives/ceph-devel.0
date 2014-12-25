From: Wido den Hollander <wido@42on.com>
Subject: Re: RFC: new rados whereis command
Date: Thu, 25 Dec 2014 13:52:49 +0100
Message-ID: <549C08A1.1020500@42on.com>
References: <5499EB3C.2040602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:45416 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbaLYMwx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Dec 2014 07:52:53 -0500
In-Reply-To: <5499EB3C.2040602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 12/23/2014 11:22 PM, Loic Dachary wrote:
> Hi Andreas,
> 
> I took a closer look at https://github.com/ceph/ceph/pull/2730 implementing rados whereis [--dns] and I think it deserves a discussion here. If I understand correctly, it relies on a new function of the rados API:
> 
>   typedef struct whereis {
>     int64_t osd_id;                              //< ID of the OSD hosting this object
>     std::string osd_state;                       //< state of the OSD - either 'active' or 'inactive'
>     int64_t pg_seed;                             //< Seed of the PG hosting this object
>     std::string ip_string;                       //< Ip as string
>     std::vector<std::string> host_names;         //< optional reverse DNS HostNames
>     std::map<std::string, std::string> user_map; //< optional user KV map
>     void resolve();                              //< reverse DNS OSD IPs and store in HostNames
>   } whereis_t;
> 

Looking at this, will it return the public or cluster IP? I think the
public, which seems the right thing, but shouldn't the struct already
facilitate also returning the cluster IP?

The rados tool doesn't have to, but you never know what people want in
the future?

Great idea though! Very helpful!

>   static int whereis(IoCtx &ioctx, const std::string &oid, std::vector<whereis_t> &locations);
> 
> which needs to be added there because the rados API does not expose some details that are needed to fill the fields of the whereis_t structure.
> 
> It looks fine to me but ... I'm not used to maintaining or developing the rados API and someone else may have a more informed opinion.
> 
> There is a technical detail that also needs to be sorted out : the current implementation exposes the RadosWhereis class (for dump) and this should either be moved to rados.cc or be part of the rados API (which probably is not the best option because it would also expose Formatter as a consequence).
> 
> Cheers
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
