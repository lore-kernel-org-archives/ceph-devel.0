From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: LTTng tracing: ReplicatedPG::log_operation
Date: Wed, 3 Dec 2014 09:58:03 +0100
Message-ID: <20141203095803.1276de6e@doppio>
References: <20141202191758.5eded52c@doppio>
	<CAC6JEv-ZcvKCLMMecTw-4d2UagOz2AHMtCadahDghV5h4ei3OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:57247 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbaLCOz4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 09:55:56 -0500
In-Reply-To: <CAC6JEv-ZcvKCLMMecTw-4d2UagOz2AHMtCadahDghV5h4ei3OA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Gregory,

On Tue, 2 Dec 2014 10:32:50 -0800
Gregory Farnum <greg@gregs42.com> wrote:

> On Tue, Dec 2, 2014 at 10:17 AM, Andreas Bluemle
> <andreas.bluemle@itxperts.de> wrote:
> > Hi,
> >
> > during code profiling using LTTng, I encounter that during
> > processing of write requests to the cluster, the ceph-osd
> > spends a lot of time in the ReplicatedPG::log_operation
> > before the the actual writes to journal and object
> > in the FileStore are triggered.
> >
> > This happens in ReplicatedBackend::submit_transaction.
> >
> > What I wonder is
> >   - what is the purpose of the log_operation?
> >     If I am not mistaken, then it is neither the write-to-journal
> >     nor the write-to-object; both of these are triggered from
> >     the queue_operation following that log_operation.
> 
> This is setting up the changes to the pg log, and encoding them into
> the transaction.
> 
> >   - can the sequence between the log_operation and
> >     the actual queue_operation be reversed in
> >     ReplicatedBackend::submit_transaction?
> 
> Nope, it needs to go into the transaction and get journaled.
> I'm kind of surprised this is a big time sink, but there is a lot of
> encoding so if you're running against a fast system I suppose it could
> be relatively large.

From what I see on my test system, adding the pg log entry consumes
about 60 microseconds - which is about 12 % of the overall time spent
for a write request on a replicating OSD, which is sth. like 460
microseconds between receipt of the MSG_OSD_SUBOP at the messenger
until the corresponding MSG_OSD_SUBOPREPLY is sent back to the primary
OSD.

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
