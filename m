From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Status of ceph ITP?
Date: Fri, 3 Dec 2010 22:02:16 -0800
Message-ID: <AANLkTikz6y6qT4Oqe+GvmdBmsRH-KVe9L_4OK8Jsy4n1@mail.gmail.com>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	<Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	<1290436452.9821.5.camel@clint-MacBookPro>
	<Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
	<1291075213.14018.101.camel@julia.gcs.org.hu>
	<Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
	<1291221518.14018.564.camel@julia.gcs.org.hu>
	<Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
	<1291249852.14018.611.camel@julia.gcs.org.hu>
	<1291274357.20409.171.camel@clint-MacBookPro>
	<1291309051.14018.667.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53750 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab0LDGCS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Dec 2010 01:02:18 -0500
Received: by wyb28 with SMTP id 28so10224042wyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Dec 2010 22:02:17 -0800 (PST)
In-Reply-To: <1291309051.14018.667.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Clint Byrum <clint@ubuntu.com>, Sage Weil <sage@newdream.net>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

On Thu, Dec 2, 2010 at 8:57 AM, Laszlo Boszormenyi <gcs@debian.hu> wrot=
e:
> Hi Clint,
>
> On Wed, 2010-12-01 at 23:19 -0800, Clint Byrum wrote:
>> On Thu, 2010-12-02 at 01:30 +0100, Laszlo Boszormenyi wrote:
>> Essentially, as long as the files don't have a license that conflict=
s
>> with COPYING, then there's no need for a license header.
> =A0Got a confirmation from an FTP Assistant, Mike O'Connor; he says
> exactly the same. "Its not required, for instance, that every
> single .h .c file etc have a license information, as long as it can b=
e
> reasonably assumed that we know the copyright holders' intention. Whe=
n
> the upstream author says "i'm the copyright holder for everything in =
the
> src directory, and its distributable under the LGPL, we'll assume thi=
s
> to be correct unless there is something that indicates otherwise."
> I just have a memory that recently a package was rejected due to this=
,
> but I assume it neither had the license information in
> debian/copyright .
>
>> Laszlo, I did a thorough review of the licensing before working to g=
et
>> ceph uploaded to Ubuntu, but I wasn't aware of the incompatibility
>> between the GPL/LGPL and OpenSSL. This page details it pretty well:
>>
>> http://people.gnome.org/~markmc/openssl-and-the-gpl.html
> =A0Please note two things. First is the bottom line of the page which
> says: "Usual disclaimers apply, I've no legal background whatsoever,
> don't trust a word I say ... I'm quite probably completely wrong." an=
d
> it was written in 2004. More recently, three months ago a bug was
> filed[1] in Debian that states there's indeed a need for that license
> exception for a GPL programs.
> =A0On the other hand, yes, I do realize that ceph is mostly LGPL whic=
h may
> or may not need this exception. Just found a conversation on
> debian-legal, where the second message[2] states: "There is no need f=
or
> an OpenSSL exception for a LGPL-licensed work."; thus I'm ready to
> upload ceph as soon as the two missing manpages are written.
>
>> Also Sage, if the other authors (or you) are not comfortable with th=
e
>> OpenSSL advertising clause, there's always GNUTLS which exists in la=
rge
>> part to address this sort of thing.
> =A0Rewrite the SSL part may not be that easy, but see above that it s=
eems
> it's not needed for LGPL sources.

I removed all the openssl references in the ceph code and replaced it
with crypto++, so hopefully all this discussion is now moot. It's all
pushed to the ceph rc branch. I tried using gnutls, but it didn't
quite fit ceph's needs (only requires a few lower level crypto
functions and it seems that gnutls hasn't exported those up until
recently or at least I haven't found an easy way to do this).
IANAL but for my untrained eyes the crypto++ seems ok in terms of GPL
compatibility. Although most of ceph's code is LGPL, we do have a
couple of utilities that are licensed as GPL and might pose a license
conflict, so removing openssl seems the best road to choose.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
