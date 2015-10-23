From: Howard Chu <hyc@symas.com>
Subject: Re: newstore direction
Date: Fri, 23 Oct 2015 22:23:30 +0100
Message-ID: <562AA552.702@symas.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
 <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
 <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
 <alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net>
 <5626BECA.7070306@redhat.com>
 <alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net>
 <5627981B.2040409@redhat.com> <loom.20151023T081245-920@post.gmane.org>
 <562A14D3.4070509@redhat.com> <562A1E69.2050704@redhat.com>
 <562A4B58.1030407@symas.com>
 <CAJ4mKGZ_Xg4hNrm-zjBCJwe4vV1CbALT+C_Ee7cmcpRf=VMKKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zill.ext.symas.net ([69.43.206.106]:56896 "EHLO
	zill.ext.symas.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbJWVXl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 17:23:41 -0400
In-Reply-To: <CAJ4mKGZ_Xg4hNrm-zjBCJwe4vV1CbALT+C_Ee7cmcpRf=VMKKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Gregory Farnum wrote:
> On Fri, Oct 23, 2015 at 7:59 AM, Howard Chu <hyc@symas.com> wrote:
>> If the stream of writes is large enough, you could omit fsync because
>> everything is being forced out of the cache to disk anyway. In that
>> scenario, the only thing that matters is that the writes get forced out in
>> the order you intended, so that an interruption or crash leaves you in a
>> known (or knowable) state vs unknown.
>
> The RADOS storage semantics actually require that we know it's durable
> on disk as well, unfortunately. But ordered writes would probably let
> us batch up commit points in ways that are a lot friendlier for the
> drives!

Ah, that's too bad. LMDB does fine with only ordering, but never mind.

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
