From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: OSD->ReplicaOSD->OSD questions
Date: Thu, 3 Dec 2015 12:28:10 -0800
Message-ID: <CAJ4mKGbo-QNOMAtBcLYPbL7+kW6NL-CTtQ8YVYKOVRQetjQdrA@mail.gmail.com>
References: <90EABA838E32E141BC06296A2C40520A1A6562D5@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38453 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbbLCU2M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 15:28:12 -0500
Received: by wmec201 with SMTP id c201so38426423wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 12:28:11 -0800 (PST)
In-Reply-To: <90EABA838E32E141BC06296A2C40520A1A6562D5@IRSMSX108.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lakis, Jacek" <jacek.lakis@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Dec 3, 2015 at 1:30 AM, Lakis, Jacek <jacek.lakis@intel.com> wr=
ote:
> Hi cephers!
> I got two questions about "client->osd->replica osd->osd->client" pat=
h that appears during my deep dive into this part.
>         1. eval_repop() is called twice [in C_OSD_RepopCommit and C_O=
SD_RepopApplied context finish] in primary OSD, after receiving MOSDOpR=
epopReply message from replica OSD. It's called twice with different fl=
ags (ondisk, onack) and sends reply to the client two times. Do the cli=
ent really need to receive two replies, why? Maybe single reply after o=
peration is applied and committed is enough?

In common deployments the client is actually only getting sent the
ondisk response, but yes, we need to maintain both of those paths.
It's part of the protocol that if the data is made readable before
it's committed, we tell the client that it's happened.

>         2. MOSDOpRepopReply, caught by Pipe::reader() need to go thro=
ugh all the dispatching->enq->deq->shards->workers path just to call fi=
nish() in contexts mentioned before. Since the number of checks for thi=
s kind of message is smaller than for the OSD ops, maybe it's good to c=
onsider another, faster way to execute it, e.g. another simple queue wi=
th single thread consuming and executing it, without whole enqueueing-d=
equeueing-shards stuff? Ordering and PrioritizedQueue features are real=
ly important for this kind of message?

That's an interesting question. Off the top of my head, maybe these
are important. The priority stuff probably isn't, but we do need to
maintain ordering within each PG =E2=80=94 and I'm not sure if we can e=
asily
identify which messages are "just" client data requests versus more
complicated things like returning data?
It's really a question of which particular pieces of the system we
could skip over, and whether those specific ones are worth the time
investment of doing so. I tend to assume it's not worth the effort =E2=80=
=94
the edge case handling would be hard to replace separately (eg, what
happens when we get a reply for a PG which we no longer have?).
-Greg

>
> Thank you.
>
> Best regards,
> JJ
>
> --------------------------------------------------------------------
>
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VI=
I Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 95=
7-07-52-316 | Kapital zakladowy 200.000 PLN.
>
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego ad=
resata i moze zawierac informacje poufne. W razie przypadkowego otrzyma=
nia tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usu=
niecie; jakiekolwiek
> przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for=
 the sole use of the intended recipient(s). If you are not the intended=
 recipient, please contact the sender and delete all copies; any review=
 or distribution by
> others is strictly prohibited.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
