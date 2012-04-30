From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Re-replicated data does not seem to get uniformly
 redistributed after OSD failure
Date: Mon, 30 Apr 2012 12:02:46 -0600
Message-ID: <4F9ED3C6.6010708@sandia.gov>
References: <4F987D40.8040101@sandia.gov>
 <CACLRD_2ddyK_GCM24fiTcyQGigJMJLD=8x-XwDb0wYcNDH-1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:60284 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2D3SDZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 14:03:25 -0400
In-Reply-To: <CACLRD_2ddyK_GCM24fiTcyQGigJMJLD=8x-XwDb0wYcNDH-1Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/30/2012 11:12 AM, Samuel Just wrote:
> There is a (unfortunately non-optional at the moment) feature in crush
> where we retry in the same bucket a few times before restarting the
> descent when hitting an out leaf.  The result of this is to localise
> recovery at the expense of inadequately redistributing data on node
> failure.

Ah, OK.

> We will most likely remove this behaviour in the next crush
> version.

That would really be great!

-- Jim

> -Sam
>
> On Wed, Apr 25, 2012 at 3:40 PM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> Hi,
>>
>> I've been experimenting with failure scenarios to make sure
>> I understand what happens when an OSD drops out.  In particular,
>> I've been using "ceph osd out<n>" and watching my all my OSD
>> servers to see where the data from the removed OSD ends up
>> after recovery.  I've been doing this testing with 12 servers,
>> 24 OSDs/server.
>>
>> What I see is that all the data from the removed OSD seem to
>> end up distributed across the other OSDs on the host holding
>> the removed OSD.
>>
>> It works this way if I use the default CRUSH map generated
>> for just host buckets and devices, i.e. a map using the
>> straw algorithm for the root and host buckets.  It also
>> works this way if I generate my own map using the uniform
>> algorithm for the root and host buckets.
>>
>> For example, using my map based on the uniform algorithm,
>> after successively taking out osd.0 thru osd.9 (all on
>> host cs32), here's the top 24 OSD data store usage:
>>
>> Host           1K-blocks      Used Available Use% Mounted on
>>
>> cs39:          942180120  33379144 871114904   4% /ram/mnt/ceph/data.osd.174
>> cs39:          942180120  33386420 871106604   4% /ram/mnt/ceph/data.osd.186
>> cs43:          942180120  33484704 871008448   4% /ram/mnt/ceph/data.osd.270
>> cs43:          942180120  33563912 870930616   4% /ram/mnt/ceph/data.osd.267
>> cs38:          942180120  33637652 870856876   4% /ram/mnt/ceph/data.osd.162
>> cs34:          942180120  33773780 870721740   4% /ram/mnt/ceph/data.osd.67
>> cs37:          942180120  33834584 870660136   4% /ram/mnt/ceph/data.osd.123
>> cs40:          942180120  33936696 870557928   4% /ram/mnt/ceph/data.osd.203
>> cs38:          942180120  34212020 870283404   4% /ram/mnt/ceph/data.osd.165
>> cs42:          942180120  34402852 870095036   4% /ram/mnt/ceph/data.osd.259
>> cs32:          942180120  45969104 858567088   6% /ram/mnt/ceph/data.osd.17
>> cs32:          942180120  49694156 854854196   6% /ram/mnt/ceph/data.osd.16
>> cs32:          942180120  50182636 854370356   6% /ram/mnt/ceph/data.osd.15
>> cs32:          942180120  50520484 854030460   6% /ram/mnt/ceph/data.osd.12
>> cs32:          942180120  50669280 853882848   6% /ram/mnt/ceph/data.osd.10
>> cs32:          942180120  51234372 853319452   6% /ram/mnt/ceph/data.osd.14
>> cs32:          942180120  51277080 853276808   6% /ram/mnt/ceph/data.osd.22
>> cs32:          942180120  51279984 853273392   6% /ram/mnt/ceph/data.osd.13
>> cs32:          942180120  52364512 852192000   6% /ram/mnt/ceph/data.osd.23
>> cs32:          942180120  52376512 852180384   6% /ram/mnt/ceph/data.osd.21
>> cs32:          942180120  53026724 851531228   6% /ram/mnt/ceph/data.osd.18
>> cs32:          942180120  53217832 851343128   6% /ram/mnt/ceph/data.osd.20
>> cs32:          942180120  53723152 850838768   6% /ram/mnt/ceph/data.osd.19
>> cs32:          942180120  56159652 848410460   7% /ram/mnt/ceph/data.osd.11
>>
>> I was thinking that CRUSH would re-replicate considering all
>> buckets, subject to preventing multiple replicas in the same
>> bucket, based on this from Sage's thesis, section 5.2.2.1:
>>
>>    For failed or overloaded devices, CRUSH uniformly
>>    redistributes items across the storage cluster by
>>    restarting the recursion at the beginning of the
>>    select(n,t) (see Algorithm 1 line 11).
>>
>> So my question is, what am I missing?  Maybe the above doesn't
>> mean what I think it does?  Or, is there some configuration
>> that I should be using but don't know about?
>>
>> Thanks -- Jim
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


