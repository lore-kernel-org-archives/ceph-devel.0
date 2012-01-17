From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH] check for valid filehandler, before using in next calls
Date: Tue, 17 Jan 2012 13:19:34 -0800
Message-ID: <CAF3hT9Cs6NDcC77p-=aubMD2VByta5YUXpXkmQUEYpVd+x+dMQ@mail.gmail.com>
References: <1326455916-28463-1-git-send-email-octo@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60317 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab2AQVTe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 16:19:34 -0500
Received: by iagf6 with SMTP id f6so4816716iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 13:19:34 -0800 (PST)
In-Reply-To: <1326455916-28463-1-git-send-email-octo@yandex-team.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo@yandex-team.ru>
Cc: ceph-devel@vger.kernel.org

Merged this to master; thanks!
-Greg

On Fri, Jan 13, 2012 at 3:58 AM, Andrey Stepachev <octo@yandex-team.ru>=
 wrote:
> In case of nonexistent file, calling Client::replication()
> triggers assert.
>
> Signed-off-by: Andrey Stepachev <octo@yandex-team.ru>
> ---
> =A0src/client/hadoop/CephFSInterface.cc | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/src/client/hadoop/CephFSInterface.cc b/src/client/hadoop=
/CephFSInterface.cc
> index 4a050f2..5ffca64 100644
> --- a/src/client/hadoop/CephFSInterface.cc
> +++ b/src/client/hadoop/CephFSInterface.cc
> @@ -750,9 +750,12 @@ JNIEXPORT jint JNICALL Java_org_apache_hadoop_fs=
_ceph_CephTalker_ceph_1replicati
> =A0 ceph_mount_info *cmount =3D get_ceph_mount_t(env, obj);
> =A0 int fh =3D 0;
> =A0 fh =3D ceph_open(cmount, c_path, O_RDONLY, 0);
> + =A0env->ReleaseStringUTFChars(j_path, c_path);
> + =A0if (fh < 0) {
> + =A0 =A0 =A0 =A0 return fh;
> + =A0}
> =A0 int replication =3D ceph_get_file_replication(cmount, fh);
> =A0 ceph_close(cmount, fh);
> - =A0env->ReleaseStringUTFChars(j_path, c_path);
> =A0 return replication;
> =A0}
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
