From: Tim Spriggs <tims@uahirise.org>
Subject: Re: /etc/init.d/ceph vs upstart
Date: Thu, 7 Nov 2013 15:31:36 -0700
Message-ID: <CAEUrXvyVN0y1WTAP5HeM2EEnONJu2UgHBdvQtENQzCELkhRvPA@mail.gmail.com>
References: <CAEUrXvweJa50=ZVFvWOknCSzO9NKvvxikYhn7-Mmz4NgvYAkTA@mail.gmail.com>
	<CAEUrXvySMMz=HiXTTPY+d1i50XYSayuguMz8tLGH+_Z4PvJ9uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e011766e52a2cca04ea9dd403
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:55950 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab3KGWbi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 17:31:38 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so988629lbv.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 14:31:37 -0800 (PST)
In-Reply-To: <CAEUrXvySMMz=HiXTTPY+d1i50XYSayuguMz8tLGH+_Z4PvJ9uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--089e011766e52a2cca04ea9dd403
Content-Type: text/plain; charset=ISO-8859-1

Oops, I just realized I did the patch in the wrong direction :)

On Thu, Nov 7, 2013 at 3:06 PM, Tim Spriggs <tims@uahirise.org> wrote:
> Hi All,
>
>   I am battling extraneous error messages from two sources:
>
>   logrotate which is run in cron.daily and has a definition from the
> ceph package in /etc/logrotate.d. The message I get in an email from
> every node once a day is:
>
> cat: /var/run/ceph/osd.3.pid: No such file or directory
>
> This comes up because upstart is actually running ceph-osd while the
> init.d script expects a pidfile.
>
>
>   /var/log/ceph/ceph-osd.$id.log which complains:
>
> ERROR: error converting store /var/lib/ceph/osd/ceph-3: (16) Device or
> resource busy
>
> This happens on boot as well as on log rotation.
>
>
> After talking with dmick on irc.oftc.net#ceph, I was alerted to the
> fact that there are bits in upstart as well as the sysvinit style
> script that attempt to only use one scheme or the other. However, the
> logic seems wrong. Inside of ceph_common.sh, there is a function named
> check_host which looks for /var/lib/ceph/$type/ceph-$id/sysvinit and
> if it exists, it returns. If it doesn't exist, it just goes on to the
> next check (which passes in my environment.) Instead, it should return
> a non-0 value. Attached is an example patch.
>
> Thanks,
> -Tim

--089e011766e52a2cca04ea9dd403
Content-Type: application/octet-stream; name="ceph_common.patch"
Content-Disposition: attachment; filename="ceph_common.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hnqkl8nq1

LS0tIC91c3IvbGliL2NlcGgvY2VwaF9jb21tb24uc2gtb2xkCTIwMTMtMTEtMDcgMTQ6NTM6MzQu
NjU1MzAzMjY3IC0wNzAwCisrKyAvdXNyL2xpYi9jZXBoL2NlcGhfY29tbW9uLnNoCTIwMTMtMTEt
MDcgMTQ6NTA6MDIuMzA1NzIzNDkwIC0wNzAwCkBAIC01MywxMCArNTMsMTIgQEAKICAgICAjIHN5
c3Zpbml0IG1hbmFnZWQgaW5zdGFuY2UgaW4gc3RhbmRhcmQgbG9jYXRpb24/CiAgICAgaWYgWyAt
ZSAiL3Zhci9saWIvY2VwaC8kdHlwZS9jZXBoLSRpZC9zeXN2aW5pdCIgXTsgdGhlbgogCWhvc3Q9
IiRob3N0bmFtZSIKIAllY2hvICI9PT0gJHR5cGUuJGlkID09PSAiCiAJcmV0dXJuIDAKKyAgICBl
bHNlCisgICAgICAgIHJldHVybiAxCiAgICAgZmkKIAogICAgICMgaWdub3JlIGFsbCBzZWN0aW9u
cyB3aXRob3V0ICdob3N0JyBkZWZpbmVkCiAgICAgaWYgWyAteiAiJGhvc3QiIF07IHRoZW4KIAly
ZXR1cm4gMQo=
--089e011766e52a2cca04ea9dd403--
