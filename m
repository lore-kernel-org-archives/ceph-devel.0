From: Tim Spriggs <tims@uahirise.org>
Subject: Re: /etc/init.d/ceph vs upstart
Date: Thu, 7 Nov 2013 15:06:05 -0700
Message-ID: <CAEUrXvySMMz=HiXTTPY+d1i50XYSayuguMz8tLGH+_Z4PvJ9uw@mail.gmail.com>
References: <CAEUrXvweJa50=ZVFvWOknCSzO9NKvvxikYhn7-Mmz4NgvYAkTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b3a88dade605204ea9d7830
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36046 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab3KGWGH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 17:06:07 -0500
Received: by mail-lb0-f171.google.com with SMTP id x18so955414lbi.2
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 14:06:05 -0800 (PST)
In-Reply-To: <CAEUrXvweJa50=ZVFvWOknCSzO9NKvvxikYhn7-Mmz4NgvYAkTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--047d7b3a88dade605204ea9d7830
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

  I am battling extraneous error messages from two sources:

  logrotate which is run in cron.daily and has a definition from the
ceph package in /etc/logrotate.d. The message I get in an email from
every node once a day is:

cat: /var/run/ceph/osd.3.pid: No such file or directory

This comes up because upstart is actually running ceph-osd while the
init.d script expects a pidfile.


  /var/log/ceph/ceph-osd.$id.log which complains:

ERROR: error converting store /var/lib/ceph/osd/ceph-3: (16) Device or
resource busy

This happens on boot as well as on log rotation.


After talking with dmick on irc.oftc.net#ceph, I was alerted to the
fact that there are bits in upstart as well as the sysvinit style
script that attempt to only use one scheme or the other. However, the
logic seems wrong. Inside of ceph_common.sh, there is a function named
check_host which looks for /var/lib/ceph/$type/ceph-$id/sysvinit and
if it exists, it returns. If it doesn't exist, it just goes on to the
next check (which passes in my environment.) Instead, it should return
a non-0 value. Attached is an example patch.

Thanks,
-Tim

--047d7b3a88dade605204ea9d7830
Content-Type: application/octet-stream; name="ceph_common.patch"
Content-Disposition: attachment; filename="ceph_common.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hnqjnone1

LS0tIC91c3IvbGliL2NlcGgvY2VwaF9jb21tb24uc2gJMjAxMy0xMS0wNyAxNDo1MDowMi4zMDU3
MjM0OTAgLTA3MDAKKysrIC91c3IvbGliL2NlcGgvY2VwaF9jb21tb24uc2gtb2xkCTIwMTMtMTEt
MDcgMTQ6NTM6MzQuNjU1MzAzMjY3IC0wNzAwCkBAIC01MywxMiArNTMsMTAgQEAKICAgICAjIHN5
c3Zpbml0IG1hbmFnZWQgaW5zdGFuY2UgaW4gc3RhbmRhcmQgbG9jYXRpb24/CiAgICAgaWYgWyAt
ZSAiL3Zhci9saWIvY2VwaC8kdHlwZS9jZXBoLSRpZC9zeXN2aW5pdCIgXTsgdGhlbgogCWhvc3Q9
IiRob3N0bmFtZSIKIAllY2hvICI9PT0gJHR5cGUuJGlkID09PSAiCiAJcmV0dXJuIDAKLSAgICBl
bHNlCi0gICAgICAgIHJldHVybiAxCiAgICAgZmkKIAogICAgICMgaWdub3JlIGFsbCBzZWN0aW9u
cyB3aXRob3V0ICdob3N0JyBkZWZpbmVkCiAgICAgaWYgWyAteiAiJGhvc3QiIF07IHRoZW4KIAly
ZXR1cm4gMQo=
--047d7b3a88dade605204ea9d7830--
