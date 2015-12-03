From: "Lakis, Jacek" <jacek.lakis@intel.com>
Subject: OSD->ReplicaOSD->OSD questions
Date: Thu, 3 Dec 2015 09:30:49 +0000
Message-ID: <90EABA838E32E141BC06296A2C40520A1A6562D5@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57303 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbbLCJc0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 04:32:26 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cephers!
I got two questions about "client->osd->replica osd->osd->client" path that appears during my deep dive into this part. 
	1. eval_repop() is called twice [in C_OSD_RepopCommit and C_OSD_RepopApplied context finish] in primary OSD, after receiving MOSDOpRepopReply message from replica OSD. It's called twice with different flags (ondisk, onack) and sends reply to the client two times. Do the client really need to receive two replies, why? Maybe single reply after operation is applied and committed is enough? 
	2. MOSDOpRepopReply, caught by Pipe::reader() need to go through all the dispatching->enq->deq->shards->workers path just to call finish() in contexts mentioned before. Since the number of checks for this kind of message is smaller than for the OSD ops, maybe it's good to consider another, faster way to execute it, e.g. another simple queue with single thread consuming and executing it, without whole enqueueing-dequeueing-shards stuff? Ordering and PrioritizedQueue features are really important for this kind of message?

Thank you.

Best regards,
JJ

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

