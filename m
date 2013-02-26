From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash and strange things on MDS
Date: Tue, 26 Feb 2013 12:26:17 -0800
Message-ID: <CAPYLRziEUnD7SAipnUwF8gz=2ZvF3vKWyiv8xEcy1PP_Lhbw0w@mail.gmail.com>
References: <20130213114750.GC7399@kdecherf.com>
	<CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
	<20130216010217.GA26823@kdecherf.com>
	<CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
	<20130216182403.GB5313@kdecherf.com>
	<CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
	<20130220010052.GO7121@kdecherf.com>
	<CAPYLRzgkR61eFuGU_NdL88bJvOD2em+TMO7g1g+X3RTFAZvY5Q@mail.gmail.com>
	<20130226175742.GE16091@kdecherf.com>
	<CAPYLRziS4rTVWU8C1fDJ6W6jgk7s9SOVnRGOcdiH9YshqGNaww@mail.gmail.com>
	<20130226195837.GH16091@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:59324 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab3BZU0S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 15:26:18 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so3659425wgd.28
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 12:26:17 -0800 (PST)
In-Reply-To: <20130226195837.GH16091@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Decherf <kevin@kdecherf.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Tue, Feb 26, 2013 at 11:58 AM, Kevin Decherf <kevin@kdecherf.com> wrote:
> We have one folder per application (php, java, ruby). Every application has
> small (<1M) files. The folder is mounted by only one client by default.
>
> In case of overload, another clients spawn to mount the same folder and
> access the same files.
>
> In the following test, only one client was used to serve the
> application (a website using wordpress).
>
> I made the test with strace to see the time of each IO request (strace -T
> -e trace=file) and I noticed the same pattern:
>
> ...
> [pid  4378] stat("/data/wp-includes/user.php", {st_mode=S_IFREG|0750, st_size=28622, ...}) = 0 <0.033409>
> [pid  4378] lstat("/data/wp-includes/user.php", {st_mode=S_IFREG|0750, st_size=28622, ...}) = 0 <0.081642>
> [pid  4378] open("/data/wp-includes/user.php", O_RDONLY) = 5 <0.041138>
> [pid  4378] stat("/data/wp-includes/meta.php", {st_mode=S_IFREG|0750, st_size=10896, ...}) = 0 <0.082303>
> [pid  4378] lstat("/data/wp-includes/meta.php", {st_mode=S_IFREG|0750, st_size=10896, ...}) = 0 <0.004090>
> [pid  4378] open("/data/wp-includes/meta.php", O_RDONLY) = 5 <0.081929>
> ...
>
> ~250 files were accessed for only one request (thanks Wordpress.).

Okay, that is slower than I'd expect, even for an across-the-wire request...

> The fs is mounted with these options: rw,noatime,name=<hidden>,secret=<hidden>,nodcache.

What kernel and why are you using nodcache? Did you have problems
without that mount option? That's forcing an MDS access for most
operations, rather than using local data.

> I have a debug (debug_mds=20) log of the active mds during this test if you want.

Yeah, can you post it somewhere?
-Greg
