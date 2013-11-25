From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: win32 build of librbd
Date: Mon, 25 Nov 2013 05:47:25 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B6660474A@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:42384 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3KYFra convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Nov 2013 00:47:30 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp1.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1Vkp1d-0003KK-RH
	for ceph-devel@vger.kernel.org; Mon, 25 Nov 2013 16:48:02 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Does this list block attachments? I sent this through yesterday with the patch as an attachment but it doesn't appear to have arrived.

> 
> With the attached patch I can use mingw32 on Debian, with a few extra bits
> (boost, cryptopp, libatomic-ops), and build librados.dll, librbd.dll, and
> rbd.exe, and do a 'rbd ls' on windows. Haven't tested more than that.
> 
> It's more a proof of concept, and is a bit of a mess. I've tried to do "#if
> defined(_WIN32)" for the windows specific changes, but will have missed a
> few places and/or inadvertently broken non-windows build in more than one
> place.
> 
> Anything not required for librados, librbd, and rbd to build isn't included, so
> libcommon is missing a heap of stuff.
> 
> To build, apply the patch, cd to win32, and make. Check INSTALL though as
> there are some prerequisites required.
> 
> Some observations/notes:
> 
> . code not used by rbd.exe is #ifdef'd out where it was preventing build (eg
> bind won't work)
> . cls_lock_types.h defines LOCK_EXCLUSIVE, but Windows already defines
> this for other purposes
> . a few other Windows names are used by ceph for other purposes
> . mingw doesn't provide poll
> . no unix sockets on windows. I've just omitted the admin socket stuff that
> uses this, but I guess they would be reimplemented using named pipes
> . #ifdef'd out anything to do with signals
> . #ifdef'd out anything to do with syslog
> . attempted to strip out dos newlines (\r) on the fly but didn't work.
> ceph.conf must be unix format
> . ceph.conf is searched for in /etc/ceph and current directory
> . some socket stuff has been replaced with windows specific
> implementations. Probably full of bugs.
> . removed libuuid and using boost uuid. Not really tested
> . probably lots of other stuff
> 
> James

