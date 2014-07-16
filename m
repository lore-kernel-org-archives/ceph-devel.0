From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 10:26:23 -0700
Message-ID: <CAPYLRziqpnjHbViaFw2MtXcYKiCDE9wz8qaqiQjAJGDoUbG7cg@mail.gmail.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
	<20140716092226.GA23561@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:40043 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933237AbaGPR00 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 13:26:26 -0400
Received: by mail-qc0-f180.google.com with SMTP id l6so1053430qcy.39
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 10:26:25 -0700 (PDT)
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com [209.85.216.44])
        by mx.google.com with ESMTPSA id 97sm17917792qgl.45.2014.07.16.10.26.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 10:26:23 -0700 (PDT)
Received: by mail-qa0-f44.google.com with SMTP id f12so930937qad.17
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 10:26:23 -0700 (PDT)
In-Reply-To: <20140716092226.GA23561@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Samuel Just <sam.just@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, xfs@oss.sgi.com

On Wed, Jul 16, 2014 at 2:22 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jul 15, 2014 at 04:45:59PM -0700, Sage Weil wrote:
>> This Firefly point release fixes an potential data corruption problem
>> when ceph-osd daemons run on top of XFS and service Firefly librbd
>> clients.  A recently added allocation hint that RBD utilizes triggers
>> an XFS bug on some kernels (Linux 3.2, and likely others) that leads
>> to data corruption and deep-scrub errors (and inconsistent PGs).  This
>> release avoids the situation by disabling the allocation hint until we
>> can validate which kernels are affected and/or are known to be safe to
>> use the hint on.
>
> I've not really seen an report for that on the XFS list, could it be
> that you're running into the issue fixed by
>
>  "xfs: Use preallocation for inodes with extsz hints"
>
> (commit aff3a9edb7080f69f07fe76a8bd089b3dfa4cb5d)?

Sam reported the issue we're seeing in "consequences of
XFS_IOC_FSSETXATTR on non-empty file?", but didn't have it narrowed
down very far. I think he's trying to get a minimal reproducer and
identify as much as he can right now, but he's also trying to get out
the door for a vacation. :)

But yes, looking at the patch description that sounds about right.
-Greg
