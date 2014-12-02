From: Gregory Farnum <greg@gregs42.com>
Subject: Re: LTTng tracing: ReplicatedPG::log_operation
Date: Tue, 2 Dec 2014 10:32:50 -0800
Message-ID: <CAC6JEv-ZcvKCLMMecTw-4d2UagOz2AHMtCadahDghV5h4ei3OA@mail.gmail.com>
References: <20141202191758.5eded52c@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:57776 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbaLBScv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 13:32:51 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so15420420igb.5
        for <ceph-devel@vger.kernel.org>; Tue, 02 Dec 2014 10:32:51 -0800 (PST)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by mx.google.com with ESMTPSA id c1sm17263153igo.17.2014.12.02.10.32.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 10:32:50 -0800 (PST)
Received: by mail-ig0-f176.google.com with SMTP id l13so16519062iga.3
        for <ceph-devel@vger.kernel.org>; Tue, 02 Dec 2014 10:32:50 -0800 (PST)
In-Reply-To: <20141202191758.5eded52c@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 2, 2014 at 10:17 AM, Andreas Bluemle
<andreas.bluemle@itxperts.de> wrote:
> Hi,
>
> during code profiling using LTTng, I encounter that during
> processing of write requests to the cluster, the ceph-osd
> spends a lot of time in the ReplicatedPG::log_operation
> before the the actual writes to journal and object
> in the FileStore are triggered.
>
> This happens in ReplicatedBackend::submit_transaction.
>
> What I wonder is
>   - what is the purpose of the log_operation?
>     If I am not mistaken, then it is neither the write-to-journal
>     nor the write-to-object; both of these are triggered from
>     the queue_operation following that log_operation.

This is setting up the changes to the pg log, and encoding them into
the transaction.

>   - can the sequence between the log_operation and
>     the actual queue_operation be reversed in
>     ReplicatedBackend::submit_transaction?

Nope, it needs to go into the transaction and get journaled.
I'm kind of surprised this is a big time sink, but there is a lot of
encoding so if you're running against a fast system I suppose it could
be relatively large.
-Greg
