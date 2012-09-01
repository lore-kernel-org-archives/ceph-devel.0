From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: Very unbalanced storage
Date: Sat, 01 Sep 2012 10:52:14 +0800
Message-ID: <5041785E.3040707@gmail.com>
References: <50409BDC.5010006@gmail.com> <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46142 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab2IACwA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 22:52:00 -0400
Received: by pbbrr13 with SMTP id rr13so5724007pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 19:52:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/01/2012 12:05 AM, Sage Weil wrote:
> On Fri, 31 Aug 2012, Xiaopong Tran wrote:
>> Hi,
>>
>> Ceph storage on each disk in the cluster is very unbalanced. On each
>> node, the data seems to go to one or two disks, while other disks
>> are almost empty.
>>
>> I can't find anything wrong from the crush map, it's just the
>> default for now. Attached is the crush map.
>
> This is usually a problem with the pg_num for the pool you are using.  Can
> you include the output from 'ceph osd dump | grep ^pool'?  By default,
> pools get 8 pgs, which will distribute poorly.
>
> sage
>
>
Here is the pool I'm interested in:

pool 9 'yunio2' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 8 
pgp_num 8 last_change 216 owner 0

So, ok, by default, the pg_num is really small. That's a very dumb
mistake I made. Is there any easy way to change this?

I looked at the tunables, if I upgrade to v0.48.1 or v0.49,
then would I be able to tune the pg_num value?

Thanks for any help, this is quite a serious issue.

Xiaopong
