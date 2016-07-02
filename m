From: kefu chai <tchaikov@gmail.com>
Subject: Re: The newbie questions
Date: Sat, 2 Jul 2016 20:32:42 +0800
Message-ID: <CAJE9aONBXQaw=+wpfUWtSrOv8UxFDe+DQPcaDZeg-CBiyKkCxQ@mail.gmail.com>
References: <CALBCzHe0gCiv_YR-2k5ywk24+pHKiunHbjvKrLV9EwsqZsxT3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36728 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbcGBMcn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Jul 2016 08:32:43 -0400
Received: by mail-yw0-f173.google.com with SMTP id b72so8215483ywa.3
        for <ceph-devel@vger.kernel.org>; Sat, 02 Jul 2016 05:32:43 -0700 (PDT)
In-Reply-To: <CALBCzHe0gCiv_YR-2k5ywk24+pHKiunHbjvKrLV9EwsqZsxT3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: RomanS <execooler@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jul 1, 2016 at 5:15 AM, RomanS <execooler@gmail.com> wrote:
> Hello.
>
> I'm not sure that this list is correct to ask the following question.
> It would be nice to understand the architecture of Ceph. To do this i
> want to find answers for the following questions:
>
> 1. Ceph supports 2 types of scrubbing. To do check need to calculate
> something and compare the result and the previously stored value. If i
> understand correctly Ceph uses crc32. Where the value is stored?

the previously stored values are stored in memory. and we scrub the objects
in batch/chunk, see PG::chunky_scrub().

>
> 2. Where can i read (in details) about data placement (structure)? only sources?

source, and we have some document for explaining the internals of
Ceph, see http://docs.ceph.com/docs/master/dev/. and you might want to
checkout the Ceph over youtube, see
 https://www.youtube.com/channel/UCno-Fry25FJ7B4RycCxOtfw. and
papers on Ceph and CRUSH, see http://ceph.com/resources/.

>
> 3. I tried to find information about behavior of Ceph in case of
> failures?  For example I put a data to Ceph. Placement logic has done
> its work and we know where need to place the data. We send data to
> primary OSD and it resend the data to the secondary OSDs. At some
> point a primary OSD fails. What next? Need to call CRUSH again?

see http://docs.ceph.com/docs/master/dev/peering/.

>
> 4. What is the minimal structure of data in Ceph? object or object-chunk?

i think it's object. as RADOS operations are object centric.

>
> 5. Where object-metadata is stored? as a separate metadata-object or
> as a part of object structure?

regarding to FileStore, xattr is stored in the xattr of the file where
the object
is stored in. and omap is stored in the KV store on that OSD.


>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
