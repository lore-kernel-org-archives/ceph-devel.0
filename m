From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph-fuse on os x
Date: Sat, 3 Nov 2012 17:34:36 +0100
Message-ID: <CAPYLRzjxq3-NPXsHy=dSAp=VP2MXAcDMVg+pjaK7oARO6p-zgQ@mail.gmail.com>
References: <sfid-H20121030-161342-+023.00-1@marduk.tchpc.tcd.ie>
	<alpine.DEB.2.00.1210300912250.13553@cobra.newdream.net>
	<69920515-C310-44EB-8891-5AE452D2FA83@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39310 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182Ab2KCQeh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 12:34:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6322989iea.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 09:34:37 -0700 (PDT)
In-Reply-To: <69920515-C310-44EB-8891-5AE452D2FA83@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 2, 2012 at 5:35 PM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
>
> On 30 Oct 2012, at 16:13, Sage Weil wrote:
>
>> It is probably a relatively straighforward porting job (fixing up
>> #includes, etc.) to get ceph-fuse working under OS X with macfuse or
>> osxfuse or whatever the latest and greatest is.
>>
>> Any Mac users out there interested?
>>
>
> I would be interested both the client and server side being ported, I=
 started looking at the dependancies needed but I can't dedicate much t=
ime to it myself. Just from a workflow point of view for some use cases=
 having a native OSX client or a fuse client on OSX would be nice.

The server side isn't very likely (or at least is unlikely to be
useful) =97 I haven't looked into it myself but from what I hear HFS+
just ignores stuff like fsync().
All that said, I'd love it if the entire system would build on OS X;
I'd like to experiment with developing in XCode. I spent a little time
on it at one point but it was a pretty big mess trying to get all the
dependencies over. Now that I think about it, just trying to get
ceph-fuse building would probably be a better way to start since it
won't have so many of the package dependencies.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
