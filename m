From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: Re: RBD image name constraints
Date: Tue, 12 Apr 2016 14:32:10 +0200
Message-ID: <570CEACA.9020104@corp.ovh.com>
References: <5707A2C4.3030102@corp.ovh.com> <20160408202919.GA8043@gmail.com>
 <570B6436.9040109@corp.ovh.com> <20160411093703.GA17959@gmail.com>
 <1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com>
 <CAOi1vP9a1qtB0RjbEuoj=Lwy99h32KRh6OArGQO-xzAZpOndUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo174.mail-out.ovh.net ([46.105.58.75]:42064 "EHLO
	10.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685AbcDLMi3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 08:38:29 -0400
In-Reply-To: <CAOi1vP9a1qtB0RjbEuoj=Lwy99h32KRh6OArGQO-xzAZpOndUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>


On 04/11/2016 05:08 PM, Ilya Dryomov wrote:
> On Mon, Apr 11, 2016 at 4:29 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>
>> It would probably make sense to relax it for non-create operations and use a strict regex for create/clone/import/rename operations.
> I think it would also make sense to start enforcing a limit on the
> length of the image name on create/clone/etc.  I'm not pushing for it
> to be 96 chars (although I do believe it'd be sensible), just that we
> don't want it to be RADOS - strlen("rbd_id.").
>
> Thanks,
>
>                  Ilya
Sounds like a good plan to me, maybe we should also consider allowed 
character set? Non-ascii or control characters make little sense here too.

Regards,
Bartek
