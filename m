From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Proposing strategies for debuginfo size reduction
Date: Mon, 6 Mar 2017 12:37:01 +0100
Message-ID: <ab890167-1612-6975-8925-1adfbd90c5d5@suse.cz>
References: <CAF-wwdHTkEAGchaPD=qV0tuVNtrevhG0=ny1SdDz7-vbTXE3BQ@mail.gmail.com>
 <CAJE9aOPBkXETOTW6QgZTJVuW65wLv=UrENHADvd_r6VNwvHqHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49927 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753596AbdCFLiY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Mar 2017 06:38:24 -0500
In-Reply-To: <CAJE9aOPBkXETOTW6QgZTJVuW65wLv=UrENHADvd_r6VNwvHqHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>> First I went looking for an easy win and I believe there may be one to
>> be had in the fact that we include debuginfo for the ceph_test_*
>> binaries. Do we need to produce debuginfo for them? They currently
>> represent about 800+M on disk so could represent a quick and easy way
>> to reduce the size of the debuginfo we ship.
>
> we do, so we can perform post-mortem debugging with the coredump if any
> of them crashes in the qa run. but maybe their debuginfo is not necessary
> for the builds intended be used by our users. but we still need to patch
> rpm[1]. and looks like the upstream does not like this idea[2]. as discussed
> over IRC, maybe we need to understand the "underlying problem", i.e.
> who/what is the biggest contributor of the 800+M debuginfo before going
> any further.

We looked into this some time ago with the conclusion that the ceph-test 
package contains a rather large number of binaries (like 50), each of 
which have a lot of the same library code statically linked. This, IIRC, 
is the single biggest cause of the debuginfo bloat.

Kefu recently converted libcommon (statically linked) into the 
libceph-common shared object (dynamically linked). That brought a major 
reduction in the ceph-test debuginfo size (and build time/resource 
utilization) but I guess there's still room for improvement in this area.

Regards,
Nathan
