From: Samuel Just <sam.just@inktank.com>
Subject: Re: tracing objectstore virtual methods
Date: Mon, 30 Jun 2014 11:32:33 -0700
Message-ID: <CA+4uBUbaoenm8J-asRNdsn8oDdHd7B9y4tXN0kQ2r9N0YYYYfw@mail.gmail.com>
References: <CA+Hcz58+Sc3048EyGQ27a_Res+BAw6T-Qca2uCstfHPJ6sJHOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39113 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbaF3Sce (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 14:32:34 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so7270190qcv.5
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 11:32:33 -0700 (PDT)
In-Reply-To: <CA+Hcz58+Sc3048EyGQ27a_Res+BAw6T-Qca2uCstfHPJ6sJHOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hmm.  You could replace do a s/method/_method/ kind of thing on the
read methods and have method in ObjectStore ping the trace point and
then call _method.  The writes are slightly trickier/simpler.  I
suggest you add ObjectStore level _start_transaction(uint64_t seq,
Transaction*) and _end_transaction(uint64_t seq, Transaction*) methods
to allow the implementation to tag the beginning and end of a
transaction.  You can then iterate through the transaction and emit
appropriate events perhaps?
-Sam

On Mon, Jun 30, 2014 at 11:22 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
> Hey Sam,
>
> I'm starting to add tracepoints to the ObjectStore. Any suggestions on
> C++ magic that can be used to create an interposition layer so we
> don't have to add tracepoints to each ObjectStore implementation?
