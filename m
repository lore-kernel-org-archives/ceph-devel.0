From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH 4/4] radosgw_admin: Update manpage to new syntax
Date: Sun, 17 Apr 2011 17:42:47 -0700
Message-ID: <BANLkTikz8g5FQie1drCFmHbaamH1HAXhgg@mail.gmail.com>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
	<1303032724-13456-4-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34940 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab1DRAms convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 20:42:48 -0400
Received: by fxm17 with SMTP id 17so2700428fxm.19
        for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2011 17:42:47 -0700 (PDT)
In-Reply-To: <1303032724-13456-4-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

applied

C.

On Sun, Apr 17, 2011 at 2:32 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
> =A0man/radosgw_admin.8 | =A0 70 ++++++++++++++++++++++++++++++++++---=
-------------
> =A01 files changed, 47 insertions(+), 23 deletions(-)
>
> diff --git a/man/radosgw_admin.8 b/man/radosgw_admin.8
> index f85685a..702474a 100644
> --- a/man/radosgw_admin.8
> +++ b/man/radosgw_admin.8
> @@ -2,14 +2,23 @@
> =A0.SH NAME
> =A0radosgw_admin \- rados REST gateway user administration utility
> =A0.SH SYNOPSIS
> -.B radosgw_admin
> -[ \fB\-\-user\-gen\fR ]
> -[ \fB\-\-user\-modify\fR ]
> -[ \fB\-\-read\-policy\fR ]
> -[ \fB\-\-list\-buckets\fR ] [ options ... ]
> +.B radosgw_admin <cmd> [options..]
> =A0.SH DESCRIPTION
> =A0.B radosgw_admin
> =A0is a RADOS gateway user administration utility. It allows creating=
 and modifying users.
> +.SH COMMANDS
> +.TP
> +\fBcmd\fR can be one of the following options:
> +.IP
> + user create =A0 =A0Create a new user
> + user modify =A0 =A0Modify a user
> + user info =A0 =A0 =A0Display information of a user
> + user rm =A0 =A0 =A0 =A0Remove a user
> + bucket list =A0 =A0List all buckets
> + bucket unlink =A0Remove a bucket
> + policy =A0 =A0 =A0 =A0 Display bucket/object policy
> + log show =A0 =A0 =A0 Show the log of a bucket (with a specified dat=
e)
> +.PP
> =A0.SH OPTIONS
> =A0.TP
> =A0\fB\-c\fI ceph.conf\fR, \fB\-\-conf=3D\fIceph.conf\fR
> @@ -19,40 +28,55 @@ to determine monitor addresses during startup.
> =A0\fB\-m\fI monaddress[:port]\fR
> =A0Connect to specified monitor (instead of looking through \fIceph.c=
onf\fR).
> =A0.TP
> -\fB\-\-user\-gen\fR
> -Generate a new user.
> -.TP
> -\fB\-\-user\-modify\fR
> -Modify an existing user.
> +\fB\-\-uid=3D\fIuid\fR
> +The S3 user/access key.
> =A0.TP
> -\fB\-\-read\-policy\fR
> -Show the ACL policy of an bucket or object.
> -.TP
> -\fB\-\-list\-buckets\fR
> -Dump the list of buckets that belong to a specific user.
> -.TP
> -\fB\-\-uid=3D\fIid\fR
> -Specify the user id for this operation.
> -.TP
> -\fB\-\-secret=3D\fIkey\fR
> -Configure the secret key for this user.
> +\fB\-\-secret=3D\fIsecret\fR
> +The S3 secret.
> =A0.TP
> =A0\fB\-\-display\-name=3D\fIname\fR
> =A0Configure the display name of the user.
> =A0.TP
> +\fB\-\-email=3D\fIemail\fR
> +The e-mail address of the user
> +.TP
> =A0\fB\-\-bucket=3D\fIbucket\fR
> =A0Specify the bucket name.
> =A0.TP
> =A0\fB\-\-object=3D\fIobject\fR
> =A0Specify the object name.
> +.TP
> +\fB\-\-date=3D\fIyyyy-mm-dd\fR
> +The date need for some commands
> +.TP
> +\fB\-\-os\-user=3D\fIgroup:name\fR
> +The OpenStack user (only needed for use with OpenStack)
> +.TP
> +\fB\-\-os\-secret=3D\fIkey\fR
> +The OpenStack key
> +.TP
> +\fB\-\-auth\-uid=3D\fIauid\fR
> +The librados auid
> =A0.SH EXAMPLES
> -To generate a new user:
> +Generate a new user
> =A0.IP
> - $ ./radosgw_admin --user-gen --display-name=3D"johnny rotten" --ema=
il=3Djohnny@rotten.com
> + $ radosgw_admin user gen --display-name=3D"johnny rotten" --email=3D=
johnny@rotten.com
> =A0User ID: CHBQFRTG26I8DGJDGQLW
> =A0Secret Key: QR6cI/31N+J0VKVgHSpEGVSfEEsmf6PyXG040KCB
> =A0Display Name: johnny rotten
> =A0.PP
> +Remove a user
> +.IP
> + $ radosgw_admin user rm --uid=3DCHBQFRTG26I8DGJDGQLW
> +.PP
> +Remove a bucket
> +.IP
> + $ radosgw_admin bucket unlink --bucket=3Dfoo
> +.PP
> +Thow the logs of a bucket from April 1st 2011
> +.IP
> + $ radosgw_admin log show --bucket=3Dfoo --date=3D2011=3D04-01
> +.PP
> =A0.SH AVAILABILITY
> =A0.B radosgw_admin
> =A0is part of the Ceph distributed file system. =A0Please refer to th=
e Ceph wiki at
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
