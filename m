From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Thu, 17 Dec 2015 00:36:48 +0100
Message-ID: <5671F590.7070007@digiware.nl>
References: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
 <CADRKj5Ru75B=uNtb3OyaBBxYJVLrNXPhec77pnQddj88Jb05ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:44914 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbbLPXhB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 18:37:01 -0500
In-Reply-To: <CADRKj5Ru75B=uNtb3OyaBBxYJVLrNXPhec77pnQddj88Jb05ng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 16-12-2015 19:45, Yehuda Sadeh-Weinraub wrote:

> Is cmake a viable option in all environments we expect ceph (or any
> part of) to be compiled on? (e.g. aix, solaris, freebsd, different
> linux arm distros, etc.)

Hi,

For FreeBSD it does not really matter much. Recently the native builder
has become bmake (and is called as make).
To build things for Ceph I needed to install gmake and actually call it
like that, aka. gmake check....
It is easily installed as a package, and currently I've worked out most
required packages. The ports building platform allow for specifying the
required packages, as well as specifying which make to use. This
includes using Cmake. If a package requires {C,f,g}make and that make is
lacking, the package system first installs it.

It is not easy to actually to accommodate for FreeBSD in the autotools
with the current configure.ac and stuff. But I haven't looked at the
Cmake stuff to see if it gets any easier.

--WjW


