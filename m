From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 13:28:41 -0700
Message-ID: <BANLkTi=x7S1faQZMKLpRy1=bASWPRmq=1A@mail.gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
	<1305056329-482-2-git-send-email-brchrisman@gmail.com>
	<BANLkTin=Pmsb2v5J+OPS_f5kW6ZCyN=xSQ@mail.gmail.com>
	<BANLkTinQA+rc4=UaknJopb+h3CG4diDskQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34904 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab1EJU2o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 16:28:44 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DD241C066
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:28:43 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8A777C064
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:28:43 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1943238ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:28:42 -0700 (PDT)
In-Reply-To: <BANLkTinQA+rc4=UaknJopb+h3CG4diDskQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 10, 2011 at 1:22 PM, Brian Chrisman <brchrisman@gmail.com> =
wrote:
> They differentiate between xattrs on symlinks or on the files at whic=
h
> they point.
> If I recall, it's a slight difference internally to the Client class
> whether a value is passed to path_walk as true/false, though I may be
> misinterpreting that. =A0I can look at that again.
>
> On Tue, May 10, 2011 at 12:44 PM, Gregory Farnum <gregf@hq.newdream.n=
et> wrote:
>> What are the 'l'-prefixed functions for? They look like they're just
>> duplicates except for the prefix.
>> -Greg

Ah, right. I didn't notice the different flag values in the call to
path_walk. :) I think you're right about what it means, though!
Maybe we could give them more descriptive names or something?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
