From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: trying to get osd-scrub-repair to work on my jenkins builder
Date: Mon, 7 Nov 2016 13:40:03 +0100
Message-ID: <8b02c406-1413-5678-2d42-cda6111e8230@digiware.nl>
References: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:21333 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbcKGMkR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Nov 2016 07:40:17 -0500
Received: from [192.168.101.51] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 640F727CF3
        for <ceph-devel@vger.kernel.org>; Mon,  7 Nov 2016 13:40:13 +0100 (CET)
In-Reply-To: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 4-11-2016 18:09, Willem Jan Withagen wrote:
> Hi,
> 
> On my workstation if have this tst completing just fine. But on my
> Jenkins-builder it keeps running into this state where it does not make
> any progress.
> Any particulars I should look for? I can let this run for an hour, but
> pg 2.0 stays active+degrades, and the script requires it to be clean.
> and the pgmap version is steadily incrementing.

And as a side-track to this, it is not where things go wrong. But it is
nog right either...

ceph -c ./build/src/test/osd/testdir/osd-scrub-repair/ceph.conf --format
xml status 2>/dev/null | \
        xml sel \
        -t -m "//pgmap/recovering_keys_per_sec" -v . -o ' ' \
        -t -m "//pgmap/recovering_bytes_per_sec" -v . -o ' ' \
        -t -m "//pgmap/recovering_objects_per_sec" -v .)
    test -n "$progress"

Does not seem to work because the output does not contain any of the xml
fields...
Now I've been beating myself over the head, but I cannot find the
request that does have these fields.

So a suggestion is welcom, and I'll submit a patch.

thanx,
--WjW

