From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH 3/4] cconf: Update manpage with correct examples
Date: Sun, 17 Apr 2011 17:38:39 -0700
Message-ID: <BANLkTinkcCge8UMG9pB1FQEk8YHW8wgAJw@mail.gmail.com>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
	<1303032724-13456-3-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47994 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1DRAil convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 20:38:41 -0400
Received: by fxm17 with SMTP id 17so2699485fxm.19
        for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2011 17:38:39 -0700 (PDT)
In-Reply-To: <1303032724-13456-3-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Take a look at a6f0ce4294e60dc6d6737c921bdda9111dbc7209, which I did
on Friday. Hopefully that is a lot clearer?

Colin


On Sun, Apr 17, 2011 at 2:32 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
> =A0man/cconf.8 | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/man/cconf.8 b/man/cconf.8
> index a6c7b02..0f678d2 100644
> --- a/man/cconf.8
> +++ b/man/cconf.8
> @@ -25,14 +25,14 @@ of type \fItype\fR.
> =A0\fIconffile\fP, an optional \fIdefault\fP value may be output inst=
ead.
> =A0.PP
> =A0.SH EXAMPLES
> -To extract the value of the "osd data" option for the \fIosd0\fP dae=
mon,
> +To extract the value of the "osd data" option for the \fIosd.0\fP da=
emon,
> =A0.IP
> -cconf -c foo.conf "osd data" -i 0 -t osd
> +cconf -c foo.conf -n osd.0 "osd data"
> =A0.PP
> -This is equivalent to doing specifying sections \fI[osd0]\fP, \fI[os=
d.0]\fP,
> +This is equivalent to doing specifying sections \fI[osd.0]\fP,
> =A0\fI[osd]\fP, or \fI[global]\fP, in that order of preference:
> =A0.IP
> -cconf -c foo.conf "osd data" -s osd0 -s osd.0 -s osd -s global
> +cconf -c foo.conf -n osd.0 "osd data" -s osd.0 -s osd -s global
> =A0.PP
> =A0To list all sections that begin with \fIosd\fP:
> =A0.IP
> --
> 1.7.0.4
>
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
