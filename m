From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: formatting bytes and object counts in ceph status ouput
Date: Tue, 9 Jan 2018 10:45:09 +0100
Message-ID: <20180109094508.e3uyo6h2towppph6@jf_suse_laptop>
References: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
 <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:36004 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbeAIJpR (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 9 Jan 2018 04:45:17 -0500
Content-Disposition: inline
In-Reply-To: <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-Users <ceph-users@ceph.com>

On Tue, Jan 02, 2018 at 04:54:55PM +0000, John Spray wrote:
>On Tue, Jan 2, 2018 at 10:43 AM, Jan Fajerski <jfajerski@suse.com> wrote:
>> Hi lists,
>> Currently the ceph status output formats all numbers with binary unit
>> prefixes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals
>> 1048576 objects.  I received a bug report from a user that printing object
>> counts with a base 2 multiplier is confusing (I agree) so I opened a bug and
>> https://github.com/ceph/ceph/pull/19117.
>> In the PR discussion a couple of questions arose that I'd like to get some
>> opinions on:
>
>> - Should we print binary unit prefixes (MiB, GiB, ...) since that would be
>> technically correct?
>
>I'm not a fan of the technically correct base 2 units -- they're still
>relatively rarely used, and I've spent most of my life using kB to
>mean 1024, not 1000.
We could start changing the "rarely used" part ;) But I can certainly live with 
keeping the old units.
>
>> - Should counters (like object counts) be formatted with a base 10
>> multiplier or  a multiplier woth base 2?
>
>I prefer base 2 for any dimensionless quantities (or rates thereof) in
>computing.  Metres and kilograms go in base 10, bytes go in base 2.
>
>It's all very subjective and a matter of opinion of course, and my
>feelings aren't particularly strong :-)
As far as I understand the standards regarding this (IEC 60027, ISO/IEC 80000, 
probably more) are talking about base 2 units for digital data related units 
only. I might of course misunderstand.
What is problematic I find is that other tools will (mostly?) use base 10 units 
for everything not data related. Say I plot the object count of ceph in Grafana.  
It'll use base 10 multipliers for a dimensionless number. Since Grafana (and I 
imagine other toolsllike this) consume raw numbers we'll end up with Grafana 
displaying a different object count then "ceph -s". Say 1.04M vs 1M. Now this is 
not terrible but it'll get worse with higher counts quickly.
In the original tracker issue it's noted that this was reported with cluster 
containing 7150896726 objects. The difference from grafana to "ceph -s" was 
7150M vs 6835M.
>
>John
>
>> My proposal would be to both use binary unit prefixes and use base 10
>> multipliers for counters. I think this aligns with user expectations as well
>> as the relevant standard(s?).
>>
>> Best,
>> Jan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
