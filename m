From: Jeff Darcy <jdarcy@redhat.com>
Subject: =?utf-8?Q?Re:_=D0=9D=D0=90:_Official_Ceph_RPM_build_flags_needed?=
Date: Tue, 3 Jun 2014 20:31:20 -0400 (EDT)
Message-ID: <519892673.16229977.1401841880940.JavaMail.zimbra@redhat.com>
References: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com> <CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com> <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:37343 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535AbaFDAbZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 20:31:25 -0400
In-Reply-To: <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: Daniel Sterling <sterling.daniel@gmail.com>, ceph-devel@vger.kernel.org

> So it seems, that this is up to packager what to put to RPM_OPT_FLAGS
> environment variable on packaging. Maybe someone knows what particular value
> is used?

You might want to look at __global_cflags in /usr/lib/rpm/redhat/macros for
more flags.  I spent way too much time yesterday dealing with an issue that
had its root there, and ended up overriding all sorts of stuff in my own
~/.rpmmacros to work around it.
