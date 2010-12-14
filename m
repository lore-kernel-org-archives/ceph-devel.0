From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: packaging for ceph-gui
Date: Tue, 14 Dec 2010 12:35:26 -0800
Message-ID: <AANLkTinJeVDfk0Sh8vd5uc7h6iw-U5NxY2m=NoyzYZb9@mail.gmail.com>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	<1292358476.25794.88.camel@julia.gcs.org.hu>
	<Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:44524 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760039Ab0LNUf2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Dec 2010 15:35:28 -0500
Received: by fxm18 with SMTP id 18so1206196fxm.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Dec 2010 12:35:26 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org

On Tue, Dec 14, 2010 at 12:37 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 14 Dec 2010, Laszlo Boszormenyi wrote:
>> Hi Sage,
>>
>> On Tue, 2010-12-14 at 11:56 -0800, Sage Weil wrote:
>> > Colin separated out the gui from the 'ceph' binary (it's gceph) in=
 the
>> > unstable branch of git, which means we can break it into a separat=
e
>> > package and eliminate all the gtk dependencies for the other stuff=
=2E
>> =A0Yes, I've seen that, which was a very good decision. ceph is for =
every
>> kind of machines, mostly servers. There's no need other binaries (GT=
K+
>> or others) that not strictly necessary to operate a service. They oc=
cupy
>> space and may expose security problems. On the other hand, I don't l=
ike
>> running GUIs when I'm on a slow connection (maybe just to fix a conf=
ig
>> file from a PDA).
>>
>> > Maybe a ceph-gui, recommended by ceph?
>> =A0It's up to you how to name it. As for the rule of thumb, packages=
 named
>> after the binary they contain. So it should be gceph, but can be
>> ceph-gui if you want.
>
> I'm inclined to rename gceph to ceph-gui, actually, unless anyone has=
 any
> strong opinions about it...

I'll rename gceph -> ceph_gui to avoid any confusion.

C.

>
>> I was a bit lazy to check out, is ceph mandatory for using gceph? As
>> I've seen no, the logic remained in ceph.cc , the command line and g=
ui
>> tool went to cmd.cc and gceph.cc respectively.
>> The question is, when do you want to merge these changes to rc? Ther=
e
>> are unstable and gceph trees available, but are they for v0.24 or no=
t?
>
> The binary is standalone. =A0They should just recommend each other, I=
 think.
> And this is all in the unstable branch (for v0.25), so we can just ch=
ange
> it there.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
