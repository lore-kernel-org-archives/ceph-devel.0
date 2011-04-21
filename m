From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: libceph API
Date: Thu, 21 Apr 2011 10:38:04 -0700
Message-ID: <BANLkTimtvE4JFMCz2cNhU+KZWiABfCNCrQ@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38534 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1DURiF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 13:38:05 -0400
Received: by fxm17 with SMTP id 17so1066714fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 10:38:04 -0700 (PDT)
In-Reply-To: <BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Brian Chrisman <brchrisman@gmail.com>

On Thu, Apr 21, 2011 at 10:35 AM, Colin McCabe <cmccabe@alumni.cmu.edu>=
 wrote:
> On Wed, Apr 20, 2011 at 10:03 PM, Sage Weil <sage@newdream.net> wrote=
:
>>
>> The (re/ab)use of DIR* was possibly not the wisest choice in the ori=
ginal
>> API (and Client.h for that matter?). =A0Now might be the time to use=
 a more
>> reasonably named typedef.
>
> Looking at client/Client.cc, it seems to be using DIR* as a kind of
> opaque pointer. Not a good call, because DIR is not opaque to anyone
> who has included dirent.h.

Hmm. Actually dirent does leave DIR* opaque. Anyway, we don't want
people passing this pointer to readdir or something, so it ought to
change.

C.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
