From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: Alibaba's work on async transaction
Date: Fri, 02 Jun 2017 05:46:43 +0800
Message-ID: <40089D05-25BA-4234-85DD-A705D596BEB4@alibaba-inc.com>
References: <C00F39E2-837F-4995-A7D8-1FD100C59E48@alibaba-inc.com>
 <alpine.DEB.2.11.1706012135210.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-218.mail.aliyun.com ([140.205.0.218]:56500 "EHLO
        out0-218.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAVrH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 17:47:07 -0400
In-Reply-To: <alpine.DEB.2.11.1706012135210.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sheng Qiu <sheng.qiu@alibaba-inc.com>


Hi Sage,

It make sense .  what you said in email is pretty much what you said in las=
t meeting. Don=E2=80=99t worry. You are pretty consistent. =E2=98=BA


Regards,
James


On 6/1/17, 2:42 PM, "Sage Weil" <sweil@redhat.com> wrote:

    Hi James,
   =20
    On Fri, 2 Jun 2017, LIU, Fei wrote:
    > Hi Sage,=20
    >    Here is the slides that I mentioned in morning conference call reg=
arding to async transaction implementation in the backend blustore
    >=20
    >   https://www.slideshare.net/jupiturliu/async-queuetransaction
    >=20
    >   We will modify the PR accordingly with your advice last time.
   =20
    This is the PR, right?
   =20
    	https://github.com/ceph/ceph/pull/15141
   =20
    I don't remember exactly what I said before :), but I think the more=20
    promising path forward is not to introduce a context switch but instead=
 to=20
    find a way to drop PG::lock once the operation is serialized on the=20
    sequencer, or to have a second PG lock just for submitting the=20
    transaction.  E.g.,
   =20
      pg->submit_lock.Lock();
      pg->unlock();
      store->submit_transaction(...);
      pg->submit_lock.Unlock();
   =20
    This will require a careful look at what is happening inside PG after=20
    PG::lock is dropped, though.  It probably makes sense to look at this i=
n=20
    conjuction with something like
   =20
    	https://github.com/ceph/ceph/pull/11188
   =20
    which never got finished (and has now gone very stale)...
   =20
    sage
   =20


