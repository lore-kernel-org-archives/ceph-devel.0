From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Accessing file layout information
Date: Mon, 15 Dec 2014 11:42:54 -0800
Message-ID: <CAC6JEv934fo6uR+vL05RDLtkS3-TNb9F8J_hDshgKeU593ivKA@mail.gmail.com>
References: <A22702E7-D4A3-43D0-AB43-ADF64A2AADDA@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39538 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbaLOTm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 14:42:56 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so11465617iec.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 11:42:55 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id sd6sm5326524igb.4.2014.12.15.11.42.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 11:42:54 -0800 (PST)
Received: by mail-ie0-f171.google.com with SMTP id rl12so11402801iec.16
        for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 11:42:54 -0800 (PST)
In-Reply-To: <A22702E7-D4A3-43D0-AB43-ADF64A2AADDA@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: ceph-devel Development <ceph-devel@vger.kernel.org>

On Mon, Dec 15, 2014 at 10:54 AM, Atchley, Scott <atchleyes@ornl.gov> wrote:
> Hi all,
>
> For a given file in cephfs, I would like to determine:
>
> 1) the number of PGs
> 2) the PG IDs
> 3) the offsets handles by each PG
> 4) the stripe unit (i.e. bytes per block of data)
>
> preferably using a C API.
>
> I found the getfattr command line tool which provides (1) and (4).
>
> It appears that cephfs command line tool provides some of the info, but the manpage is not clear as to what is provided by show_layout versus show_location. Does show_layout provide (1) and (4)? Does show_location include (2) and (3)?
>
> I found a Java CephFileExtent() that provides (1) and a list of OSDs for the stripe unit that contains the provided file extent.

What exactly are you trying to accomplish here? I can imagine some
limited scenarios where you want to map to PGs, but in general you're
a lot more interested in either the objects associated with the file,
or the OSDs that host them. I think you can get objects and OSDs out
of the latest libcephfs api.

>
> On the architecture page (http://ceph.com/docs/next/architecture/) under DATA STRIPING, does cephfs client use the same set of PGs used for Object Set 1 for Object Set 2 or does it use a different PGs?

Assuming you mean does it use the same PGs for each file's objects,
the answer is no, definitely not.
-Greg
