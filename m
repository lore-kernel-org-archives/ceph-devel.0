From: Gregory Farnum <greg@inktank.com>
Subject: Re: Cleaning up CephFS pool
Date: Tue, 6 Nov 2012 13:50:53 -0800
Message-ID: <CAPYLRzin=coL0-F4PWW=vFpQdFHTDtdC-=dW_o7xVx99ypBMjQ@mail.gmail.com>
References: <5099631F.6090802@ledeuns.net>
	<CAPYLRziv=4a-oETkSLnAkXV=oUjZ5vEZFmSr626Km-NbNBLdLw@mail.gmail.com>
	<50996526.2010100@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:44074 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab2KFVux convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 16:50:53 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so632496iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 13:50:53 -0800 (PST)
In-Reply-To: <50996526.2010100@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 6, 2012 at 11:29 AM, Denis Fondras <ceph@ledeuns.net> wrote=
:
>
> Le 06/11/2012 20:24, Gregory Farnum a =E9crit :
>
>> Deleting files on CephFS doesn't instantaneously remove the underlyi=
ng
>> objects because they could still be in use by other clients, and
>> removal takes time proportional to the size of the file. Instead the
>> MDS queues it up to be removed asynchronously. You should see the
>> number of objects counter going down over time.
>> -Greg
>>
>
> Thank you for that fast answer Greg.
> If I'm the only user,  is there a way to speedup this process ?

Hrm, I don't think so. Sorry.
It shouldn't actually take that long though once nobody's got the file =
open.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
