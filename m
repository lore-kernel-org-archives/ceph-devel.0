From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 13:34:59 -0700
Message-ID: <BANLkTikgJ-gWAeJY6_+TspgDXjD+-iDDyg@mail.gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
	<1305056329-482-2-git-send-email-brchrisman@gmail.com>
	<BANLkTin=Pmsb2v5J+OPS_f5kW6ZCyN=xSQ@mail.gmail.com>
	<BANLkTinQA+rc4=UaknJopb+h3CG4diDskQ@mail.gmail.com>
	<BANLkTi=x7S1faQZMKLpRy1=bASWPRmq=1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61216 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1EJUfB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 16:35:01 -0400
Received: by bwz15 with SMTP id 15so5168058bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:35:00 -0700 (PDT)
In-Reply-To: <BANLkTi=x7S1faQZMKLpRy1=bASWPRmq=1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Tue, May 10, 2011 at 1:28 PM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
> On Tue, May 10, 2011 at 1:22 PM, Brian Chrisman <brchrisman@gmail.com=
> wrote:
>> They differentiate between xattrs on symlinks or on the files at whi=
ch
>> they point.
>> If I recall, it's a slight difference internally to the Client class
>> whether a value is passed to path_walk as true/false, though I may b=
e
>> misinterpreting that. =A0I can look at that again.
>>
>> On Tue, May 10, 2011 at 12:44 PM, Gregory Farnum <gregf@hq.newdream.=
net> wrote:
>>> What are the 'l'-prefixed functions for? They look like they're jus=
t
>>> duplicates except for the prefix.
>>> -Greg
>
> Ah, right. I didn't notice the different flag values in the call to
> path_walk. :) I think you're right about what it means, though!
> Maybe we could give them more descriptive names or something?


lsetxattr and friends are known linux API functions, and have
corresponding system calls with the same name. I say let's keep them
as is.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
