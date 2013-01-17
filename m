From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: ceph from poc to production
Date: Thu, 17 Jan 2013 17:24:28 +0100
Message-ID: <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com>
References: <50F6F471.7030108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:55498 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159Ab3AQQYu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:24:50 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so2887483lab.15
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 08:24:48 -0800 (PST)
In-Reply-To: <50F6F471.7030108@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stephan,

> - Increase the osdmax value

Well actually this doesn't seem to be necessary because when you issue
a "ceph osd create" the osdmax value is automatically incremented. It
just that a while ago I saw on the ML or IRC that it was a good
practice to do this. And this documentation
http://ceph.com/docs/master/rados/operations/control/ says:

"Set the max_osd parameter in the osd map. This is necessary when
expanding the storage cluster."

Maybe the doc is outdated on this option, I don't know.

> - Set =93filestore flusher=94 option to false, in your [osd] section

During my benchmarks sessions I noticed that disabling this option
brought way better performance, at least for old hardware. Fo recent
hardware I haven't seen any difference, but I kept the habit to
disable it. There are some discussions about this option on the ML. As
far as I can remember, it's harmless to disable it.
=46rom the doc here
http://ceph.com/docs/master/rados/configuration/filestore-config-ref/:

"The filestore flusher forces data from large writes to be written out
using sync file range before the sync in order to (hopefully) reduce
the cost of the eventual sync. In practice, disabling =91filestore
flusher=92 seems to improve performance in some cases."

Cheers,

--
Regards,
S=E9bastien Han.


On Wed, Jan 16, 2013 at 7:41 PM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
>
> Hello Sebastien,
>   hello list,
>
> first nice article sebastien ;-) thanks for contributing.
>
> I've two question regarding the tips:
>
> Can somebody explain me why i should do this?:
> - Increase the osdmax value
> - Set =93filestore flusher=94 option to false, in your [osd] section
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
