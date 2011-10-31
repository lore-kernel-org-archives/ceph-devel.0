From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH] hadoop: fix contract for listStatus
Date: Mon, 31 Oct 2011 11:22:18 -0700
Message-ID: <CAF3hT9DL4k5ZrPMqDzeC9R980s8h7ti5i+YRbgbmFc1V+g4ozw@mail.gmail.com>
References: <975279467.13273.1319847928971.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52215 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933655Ab1JaSWT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2011 14:22:19 -0400
Received: by iaby12 with SMTP id y12so7444196iab.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Oct 2011 11:22:18 -0700 (PDT)
In-Reply-To: <975279467.13273.1319847928971.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Just pushed this to master in
commit:f9b7ecdb5bba1439dc4c13005a6213ddb6ecfcc5, with a minor change
to the patch description. :)
Thanks!

On Fri, Oct 28, 2011 at 5:25 PM, Noah Watkins <jayhawk@soe.ucsc.edu> wr=
ote:
> Return NULL when the path does not exist. Although
> unspecified in the declaration header, other file
> systems return a single result when the path is a file.
>
> This fixes tracker issue #1661
>
> Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
> ---
> =A0src/client/hadoop/ceph/CephFileSystem.java | =A0 14 +++++++-------
> =A01 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/src/client/hadoop/ceph/CephFileSystem.java b/src/client/=
hadoop/ceph/CephFileSystem.java
> index c697075..a7317b1 100644
> --- a/src/client/hadoop/ceph/CephFileSystem.java
> +++ b/src/client/hadoop/ceph/CephFileSystem.java
> @@ -435,9 +435,8 @@ public class CephFileSystem extends FileSystem {
> =A0 =A0* Get the FileStatus for each listing in a directory.
> =A0 =A0* @param path The directory to get listings from.
> =A0 =A0* @return FileStatus[] containing one FileStatus for each dire=
ctory listing;
> - =A0 * null if path is not a directory.
> + =A0 * =A0 =A0 =A0 =A0 null if path does not exist.
> =A0 =A0* @throws IOException if initialize() hasn't been called.
> - =A0 * @throws FileNotFoundException if the input path can't be foun=
d.
> =A0 =A0*/
> =A0 public FileStatus[] listStatus(Path path) throws IOException {
> =A0 =A0 if (!initialized) {
> @@ -458,11 +457,12 @@ public class CephFileSystem extends FileSystem =
{
> =A0 =A0 =A0 ceph.debug("listStatus:exit", ceph.DEBUG);
> =A0 =A0 =A0 return statuses;
> =A0 =A0 }
> - =A0 =A0if (!isFile(path)) {
> - =A0 =A0 =A0throw new FileNotFoundException();
> - =A0 =A0} // if we get here, listPaths returned null
> - =A0 =A0// which means that the input wasn't a directory, so throw a=
n Exception if it's not a file
> - =A0 =A0return null; // or return null if it's a file
> +
> + =A0 =A0if (isFile(path)) {
> + =A0 =A0 =A0return new FileStatus[] { getFileStatus(path) };
> + =A0 =A0}
> +
> + =A0 =A0return null;
> =A0 }
>
> =A0 @Override
> --
> 1.7.5.4
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
