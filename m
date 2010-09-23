From: Leander Yu <leander.yu@gmail.com>
Subject: Re: corrupt pg logs
Date: Thu, 23 Sep 2010 23:46:16 +0800
Message-ID: <AANLkTimU5s3Ti32BZGjMo4japLVJ0=aDLy7DV6BnN=sX@mail.gmail.com>
References: <Pine.LNX.4.64.1009230757330.16100@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54068 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0IWPqT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 11:46:19 -0400
Received: by wyb28 with SMTP id 28so999846wyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Sep 2010 08:46:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009230757330.16100@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, henry_c_chang@tcloudcomputing.com

Hi Sage,
I have some high level idea about this but I haven't fully trace the
code so please forgive me if it's too naive

On Thu, Sep 23, 2010 at 11:05 PM, Sage Weil <sage@newdream.net> wrote:
> One problem that keeps popping up is corruption in the PG logs. =A0Th=
is
> usually manifests itself as a crash when the OSD restarts and is unab=
le to
> parse the log. =A0There are a couple of things to do here.
>
> First, we need to figure out where the corruption is coming from. =A0=
Dumps
> of the corrupt pglog files will help. =A0Are they zeroed out? =A0Enti=
rely? =A0Is
> there valid data at the end of the file? =A0etc.
>

I am thinking to have a checksum for each log entry, when osd restart
and parse the log it will be able to detect if the data is corrupt.

> Second, we need to come up with a reasonable way to start up even whe=
n
> some PGs are corrupt. =A0Deleting them is one option, but we want to =
avoid
> doing so unless we're sure we have a good copy elsewhere.
>

By implement the checksum for each log entry, we will be able to
ignore the corrupted log and hopefully it can be rebuilt.
This is the place I am not certain, we have deleted the single PGinfo
that cause the error manually and see that osd start successfully, but
due to the limited knowledge about current implementation we are not
sure if everything is rebuilt properly.

> Another option would be to make a 'corrupt' subdirectory on the OSD a=
nd
> move the log there. =A0Without the log, the OSD will need to rebuild =
the
> object list to recover/resync with other PG copies, but at least it w=
ill
> start and (eventually) recover.
>
> http://tracker.newdream.net/issues/169
>
> Thoughts?
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
