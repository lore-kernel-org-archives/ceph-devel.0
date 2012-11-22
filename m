From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:49:48 +0100
Message-ID: <CAOLwVUm0QU07sHFrm-aWY709Dcm3d1V0uEbfmCrO+PB1ps93gw@mail.gmail.com>
References: <50AE44B9.7070804@profihost.ag> <824b8945-bd67-489d-9791-30804ef90d81@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:41745 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab2KVScy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:32:54 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so3840599lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:32:52 -0800 (PST)
In-Reply-To: <824b8945-bd67-489d-9791-30804ef90d81@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, Mark Nelson <mark.nelson@inktank.com>

>>But who cares? it's also on the 2nd node. or even on the 3rd if you have
>>replicas 3.

Yes but you could also suffer a crash while writing the first replica.
If the journal is in tmpfs, there is nothing to replay.



On Thu, Nov 22, 2012 at 4:35 PM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
>
> >>But who cares? it's also on the 2nd node. or even on the 3rd if you have
> >>replicas 3.
