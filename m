From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Inline dedup/compression
Date: Mon, 29 Jun 2015 12:01:01 +0100
Message-ID: <CAC6JEv-3K5UEzTrrgT_BPSPGg3gXxE0kXhh9fyOLRWF3oweFNw@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:33188 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbbF2LBF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 07:01:05 -0400
Received: by laar3 with SMTP id r3so58725778laa.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 04:01:04 -0700 (PDT)
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com. [209.85.215.45])
        by mx.google.com with ESMTPSA id ox10sm10674936lbc.30.2015.06.29.04.01.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 04:01:03 -0700 (PDT)
Received: by lagh6 with SMTP id h6so48880452lag.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 04:01:02 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

We discuss this periodically but not in any great depth. Compression
and dedupe are both best performed at a single point with some sort of
global knowledge, which is very antithetical to Ceph's design.
Blue-sky discussions for dedupe generally center around trying out
some kind of CAS system with redirects from named objects that are
just indexes of CAS-addressed objects which store the actual object
data, but that introduces the redirect latency and I'm not
super-confident that we'd get much saving outside of scenarios like
RBD where we already capture most of the benefit with the gold master
"parent" images. :/

Compression we discuss less often =E2=80=94 you can do it:
a) on the level of an OSD, in which case why would we bother
implementing it ourselves instead of just stacking on top of some
other compression system?
b) on the next level of clients (RBD, RGW, CephFS) ahead of the RADOS
object transition. But that means you generally can't do stuff like
reading portions of an object to satisfy partial reads, and ideas like
striping strategies stop making much sense.
-Greg

On Fri, Jun 26, 2015 at 7:03 PM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Haomai,
>   Thanks for your response as always. I agree compression is comparab=
le easier task but still very challenge in terms of implementation no m=
atter where we should implement . Client side like RBD, or RDBGW or Cep=
hFS, or PG should be a little bit better place to implementation in ter=
ms of efficiency and cost reduction before the data were duplicated to =
other OSDs. It has  two reasons :
> 1. Keep the data consistency among OSDs in one PG
> 2. Saving the computing resources
>
> IMHO , The compression should be accomplished before the replication =
come into play in pool level. However, we can also have second level of=
 compression in the local objectstore.  In term of unit size of compres=
sion , It really depends workload and in which layer we should implemen=
t.
>
> About inline deduplication, it will dramatically increase the complex=
ities if we bring in the replication and Erasure Coding for considerati=
on.
>
> However, Before we talk about implementation, It would be great if we=
 can understand the pros and cons to implement inline dedupe/compressio=
n. We all understand the benefits of dedupe/compression. However, the s=
ide effect is performance hurt and need more computing resources. It wo=
uld be great if we can understand the problems from 30,000 feet high fo=
r the whole picture about the Ceph. Please correct me if I were wrong.
>
> By the way, Both of software defined storage solution startups like H=
devig and Springpath provide inline dedupe/compression.  It is not appl=
e to apple comparison. But it is good reference. The datacenters need c=
ost effective solution.
>
> Regards,
> James
>
>
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Thursday, June 25, 2015 8:08 PM
> To: James (Fei) Liu-SSI
> Cc: ceph-devel
> Subject: Re: Inline dedup/compression
>
> On Fri, Jun 26, 2015 at 6:01 AM, James (Fei) Liu-SSI <james.liu@ssi.s=
amsung.com> wrote:
>> Hi Cephers,
>>     It is not easy to ask when Ceph is going to support inline dedup=
/compression across OSDs in RADOS because it is not easy task and answe=
red. Ceph is providing replication and EC for performance and failure r=
ecovery. But we also lose the efficiency  of storage store and cost ass=
ociate with it. It is kind of contradicted with each other. But I am cu=
rious how other Cephers think about this question.
>>    Any plan for Cephers to do anything regarding to inline dedupe/co=
mpression except the features brought by local node itself like BRTFS?
>
> Compression is easier to implement in rados than dedup. The most impo=
rtant thing about compression is where we begin to compress, client, pg=
 or objectstore. Then we need to decide how much the compress unit is. =
Of course, compress and dedup both like to use keyvalue-alike storage a=
pi to use, but I think it's not difficult to use existing objectstore a=
pi.
>
> Dedup is more possible to implement in local osd instead of the whole=
 pool or cluster, and if we want to do dedup for the pool level, we nee=
d to do dedup from client.
>
>>
>>   Regards,
>>   James
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards,
>
> Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
