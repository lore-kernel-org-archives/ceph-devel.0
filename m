From: Samuel Just <sjust@redhat.com>
Subject: Re: rados and the next hammer release v0.94.4
Date: Tue, 6 Oct 2015 10:32:50 -0700
Message-ID: <CAN=+7FVmONRAWjHhS3FJ4mVRbeVrCrr4s0xKgAirVvDJnCVYdg@mail.gmail.com>
References: <560EEA82.7060503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36234 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbbJFRcv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2015 13:32:51 -0400
Received: by ioii196 with SMTP id i196so229553503ioi.3
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2015 10:32:50 -0700 (PDT)
In-Reply-To: <560EEA82.7060503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

The failure labeled 'sudo adjust-ulimits ceph-coverage
/home/ubuntu/cephtest/archive/coverage daemon-helper kill ceph-osd -f
-i 5' is a bit odd, the osd crashed due to

     0> 2015-10-03 05:21:10.776554 7fce619f0700 -1
common/HeartbeatMap.cc: In function 'bool
ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
time_t)' thread 7fce619f0700 time 2015-10-03 05:21:10.735055

on thread 7fce49cec700, which was last seen processing a copy_from on p=
g 1.3s0.

I created http://tracker.ceph.com/issues/13386.

I don't think this holds up the release, and it's probably not due to
any of the recent backports, but keep an eye out for anything that
looks similar.

Looks good to me for qe to start their round of testing.
-Sam

On Fri, Oct 2, 2015 at 1:35 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer passed the rados suite (http://tracker.ceph.com/issues/12701#no=
te-62). Do you think the hammer branch is ready for QE to start their o=
wn round of testing ?
>
> Cheers
>
> P.S. http://tracker.ceph.com/issues/12701#Release-information has dir=
ect links to the pull requests merged into hammer since v0.94.3 in case=
 you need more context about one of them.
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
