From: Florian Haas <florian@hastexo.com>
Subject: Re: rbd locking and handling broken clients
Date: Wed, 13 Jun 2012 22:37:39 +0200
Message-ID: <4FD8FA13.6070006@hastexo.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:63766 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab2FMUhq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 16:37:46 -0400
Received: by weyu7 with SMTP id u7so752950wey.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 13:37:45 -0700 (PDT)
In-Reply-To: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, mandell@pistoncloud.com

Greg,

My understanding of Ceph code internals is far too limited to comment on
your specific points, but allow me to ask a naive question.

Couldn't you be stealing a lot of ideas from SCSI-3 Persistent
Reservations? If you had server-side (OSD) persistence of information of
the "this device is in use by X" type (where anything other than X would
get an I/O error when attempting to access data), and you had a manual,
authenticated override akin to SCSI PR preemption, plus key
registration/exchange for that authentication, then you would at least
have to have the combination of a misbehaving OSD plus a malicious
client for data corruption. A non-malicious but just broken client
probably won't do.

Clearly I may be totally misguided, as Ceph is fundamentally
decentralized and SCSI isn't, but if PR-ish behavior comes even close to
what you're looking for, grabbing those ideas would look better to me
than designing your own wheel.

Just my $.02, of course.

Cheers,
Florian
