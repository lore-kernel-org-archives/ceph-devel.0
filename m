From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: packaging for ceph-gui
Date: Tue, 14 Dec 2010 12:43:20 -0800
Message-ID: <AANLkTi=g1a8hrVUQwpkkXeBwV6e1RZSHXxhKW2xw9tnp@mail.gmail.com>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	<1292358476.25794.88.camel@julia.gcs.org.hu>
	<Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
	<AANLkTinJeVDfk0Sh8vd5uc7h6iw-U5NxY2m=NoyzYZb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:61411 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758310Ab0LNUnW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Dec 2010 15:43:22 -0500
Received: by fxm18 with SMTP id 18so1216868fxm.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Dec 2010 12:43:21 -0800 (PST)
In-Reply-To: <AANLkTinJeVDfk0Sh8vd5uc7h6iw-U5NxY2m=NoyzYZb9@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org

On Tue, Dec 14, 2010 at 12:35 PM, Colin McCabe <cmccabe@alumni.cmu.edu>=
 wrote:
> On Tue, Dec 14, 2010 at 12:37 PM, Sage Weil <sage@newdream.net> wrote=
:
>> On Tue, 14 Dec 2010, Laszlo Boszormenyi wrote:
>>> Hi Sage,
>>>
>>> On Tue, 2010-12-14 at 11:56 -0800, Sage Weil wrote:
>>> > Colin separated out the gui from the 'ceph' binary (it's gceph) i=
n the
>>> > unstable branch of git, which means we can break it into a separa=
te
>>> > package and eliminate all the gtk dependencies for the other stuf=
f.
>>> =A0Yes, I've seen that, which was a very good decision. ceph is for=
 every
>>> kind of machines, mostly servers. There's no need other binaries (G=
TK+
>>> or others) that not strictly necessary to operate a service. They o=
ccupy
>>> space and may expose security problems. On the other hand, I don't =
like
>>> running GUIs when I'm on a slow connection (maybe just to fix a con=
fig
>>> file from a PDA).
>>>
>>> > Maybe a ceph-gui, recommended by ceph?
>>> =A0It's up to you how to name it. As for the rule of thumb, package=
s named
>>> after the binary they contain. So it should be gceph, but can be
>>> ceph-gui if you want.
>>
>> I'm inclined to rename gceph to ceph-gui, actually, unless anyone ha=
s any
>> strong opinions about it...
>
> I'll rename gceph -> ceph_gui to avoid any confusion.

Er, that should read ceph-gui. Anyway, I'll push it to unstable in a li=
ttle bit.

Colin

>
>>
>>> I was a bit lazy to check out, is ceph mandatory for using gceph? A=
s
>>> I've seen no, the logic remained in ceph.cc , the command line and =
gui
>>> tool went to cmd.cc and gceph.cc respectively.
>>> The question is, when do you want to merge these changes to rc? The=
re
>>> are unstable and gceph trees available, but are they for v0.24 or n=
ot?
>>
>> The binary is standalone. =A0They should just recommend each other, =
I think.
>> And this is all in the unstable branch (for v0.25), so we can just c=
hange
>> it there.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
