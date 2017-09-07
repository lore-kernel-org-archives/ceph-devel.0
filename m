From: Henrik Korkuc <lists@kirneh.eu>
Subject: Re: [ceph-users] Ceph release cadence
Date: Thu, 7 Sep 2017 08:50:15 +0300
Message-ID: <bc27f4c8-759d-ab92-ef09-968c1a1fd715@kirneh.eu>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <73eff37a76814913880ff5d3795144cc@HQMAIL105.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.syseng.pro ([37.48.90.241]:51532 "EHLO alpha.syseng.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754031AbdIGFuU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 7 Sep 2017 01:50:20 -0400
In-Reply-To: <73eff37a76814913880ff5d3795144cc@HQMAIL105.nvidia.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepak Naidu <dnaidu@nvidia.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On 17-09-07 02:42, Deepak Naidu wrote:
> Hope collective feedback helps. So here's one.
>
>>> - Not a lot of people seem to run the "odd" releases (e.g., infernalis, kraken).
> I think the more obvious reason companies/users wanting to use CEPH will stick with LTS versions as it models the 3yr  support cycle.
Maybe I missed something, but I think Ceph does not support LTS releases 
for 3 years.

>>> * Drop the odd releases, and aim for a ~9 month cadence. This splits the difference between the current even/odd pattern we've been doing.
> Yes, provided an easy upgrade process.
>
>
> --
> Deepak
>
>
>
>
> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf Of Sage Weil
> Sent: Wednesday, September 06, 2017 8:24 AM
> To: ceph-devel@vger.kernel.org; ceph-maintainers@ceph.com; ceph-users@ceph.com
> Subject: [ceph-users] Ceph release cadence
>
> Hi everyone,
>
> Traditionally, we have done a major named "stable" release twice a year, and every other such release has been an "LTS" release, with fixes backported for 1-2 years.
>
> With kraken and luminous we missed our schedule by a lot: instead of releasing in October and April we released in January and August.
>
> A few observations:
>
> - Not a lot of people seem to run the "odd" releases (e.g., infernalis, kraken).  This limits the value of actually making them.  It also means that those who *do* run them are running riskier code (fewer users -> more bugs).
>
> - The more recent requirement that upgrading clusters must make a stop at each LTS (e.g., hammer -> luminous not supported, must go hammer -> jewel
> -> lumninous) has been hugely helpful on the development side by
> -> reducing
> the amount of cross-version compatibility code to maintain and reducing the number of upgrade combinations to test.
>
> - When we try to do a time-based "train" release cadence, there always seems to be some "must-have" thing that delays the release a bit.  This doesn't happen as much with the odd releases, but it definitely happens with the LTS releases.  When the next LTS is a year away, it is hard to suck it up and wait that long.
>
> A couple of options:
>
> * Keep even/odd pattern, and continue being flexible with release dates
>
>    + flexible
>    - unpredictable
>    - odd releases of dubious value
>
> * Keep even/odd pattern, but force a 'train' model with a more regular cadence
>
>    + predictable schedule
>    - some features will miss the target and be delayed a year
>
> * Drop the odd releases but change nothing else (i.e., 12-month release
> cadence)
>
>    + eliminate the confusing odd releases with dubious value
>   
> * Drop the odd releases, and aim for a ~9 month cadence. This splits the difference between the current even/odd pattern we've been doing.
>
>    + eliminate the confusing odd releases with dubious value
>    + waiting for the next release isn't quite as bad
>    - required upgrades every 9 months instead of ever 12 months
>
> * Drop the odd releases, but relax the "must upgrade through every LTS" to allow upgrades across 2 versions (e.g., luminous -> mimic or luminous -> nautilus).  Shorten release cycle (~6-9 months).
>
>    + more flexibility for users
>    + downstreams have greater choice in adopting an upstrema release
>    - more LTS branches to maintain
>    - more upgrade paths to consider
>
> Other options we should consider?  Other thoughts?
>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


