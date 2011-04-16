From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: raid40?
Date: Fri, 15 Apr 2011 18:13:46 -0700
Message-ID: <BANLkTinTnxmRw0JKWyeqiggLeY3GE7CxwQ@mail.gmail.com>
References: <4DA8EC9C.8070605@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37993 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab1DPBNs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 21:13:48 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 57FC6C069
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 18:13:48 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 06F41C065
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 18:13:47 -0700 (PDT)
Received: by ewy4 with SMTP id 4so898752ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 18:13:46 -0700 (PDT)
In-Reply-To: <4DA8EC9C.8070605@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 15, 2011 at 6:10 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi.
>
> Looking the sources I noticed that the "rule" in CRUSH may be type "r=
aid4".
>
> Because of this, I have a question: Is it possible to organize the 20=
 OSD
> servers in the scheme 4 * (4+1)? I.e. like a stripe from 4 of raid4 s=
ets?
>
> Plain "replication level =3D 2" is too expensive by "used space".
>
> WBR,
> =A0 =A0Fyodor.

Unfortunately, no. CRUSH and some of the other auxiliary bits can do
the mappings required to support RAID, but none of the core code
required to do that is implemented. It's in mind as something that
would be nice to have in the future, but is much more complicated than
simple replication schemes.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
